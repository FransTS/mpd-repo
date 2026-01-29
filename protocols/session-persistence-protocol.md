# Session Persistence Protocol v2.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | SES-001 |
| **Version** | 2.0 |
| **Created** | 15 January 2026 |
| **Updated** | 29 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Priority** | HIGH - Prevents work loss from context limits |

---

> **NEW in v2.0:**
> - Integration with CTX-001 Context Compression Protocol
> - Three-tier compression triggers at defined thresholds
> - Goal drift detection post-compression
> - Enhanced recovery with offloaded content search
> - Based on LangChain Deep Agents methodology

---

## Purpose

Prevent work loss when Claude hits context window limits by:
1. Auto-checkpointing task progress to local memory
2. Enabling seamless task resumption in new sessions
3. Caching intermediate results locally
4. **Proactive context compression (NEW v2.0)**
5. **Goal drift prevention (NEW v2.0)**

---

## Memory Paths

`
G:\My Drive\Shared_Download\AI_Folder\Memory\
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Shared/
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª active_task.md          # Current task state (CRITICAL)
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª session_handoff.md      # Session summary
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª cache/
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­       ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª checkpoints/        # Task checkpoints
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­       ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª intermediate/       # Intermediate results
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­       ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª offloaded/          # (NEW) Tier 1 compressed content
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­       ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª conversations/      # (NEW) Tier 3 archived conversations
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª [Device]/
    ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª cache/temp/             # Session-specific temp data
`

---

## Context Compression Integration (NEW v2.0)

### Compression Thresholds (CTX-001)

| Context Usage | State | Action |
|---------------|-------|--------|
| < 25% | GREEN | Normal operation |
| 25-50% | YELLOW | Monitor, prepare compression |
| 50-75% | ORANGE | **Tier 1 & 2 compression active** |
| 75-85% | RED | **Tier 3 summarisation + checkpoint** |
| > 85% | CRITICAL | **Final checkpoint + fresh session** |

### Three-Tier Compression (Automatic)

**Tier 1 - Large Tool Results (Immediate)**
- Trigger: Tool result > 15,000 tokens
- Action: Offload to `cache/offloaded/{timestamp}_{tool}.md`
- Keep: File path + 10-line preview

**Tier 2 - Tool Input Truncation (At 50%)**
- Trigger: Context > 50%, old tool inputs exist
- Action: Truncate persisted content references
- Keep: File path + modification summary

**Tier 3 - Conversation Summarisation (At 75%)**
- Trigger: Context > 75%, Tiers 1-2 insufficient
- Action: Generate structured summary (see format below)
- Archive: Full conversation to `cache/conversations/`
- **Run goal drift detection**

---

## Checkpoint System

### CRITICAL: Never Restart From Scratch

`
ƒsÿ‹÷? MANDATORY RULE

WHEN a multi-step task is interrupted, fails, or session breaks:
1. NEVER restart the task from the beginning
2. ALWAYS check for existing checkpoints FIRST
3. READ the last checkpoint file
4. RESUME from the last completed item
5. INFORM user: "Resuming from item X of Y"

VIOLATION of this rule wastes user time and is unacceptable.
`

### Checkpoint Triggers (Auto-Save)

| Trigger | Action |
|---------|--------|
| Every 3-5 tool calls | Save progress checkpoint |
| Every 3-5 items in bulk task | Save progress to checkpoint file |
| After major milestone | Save named checkpoint |
| Before risky operation | Save safety checkpoint |
| User says "checkpoint" | Immediate checkpoint |
| Complex task started | Create task manifest |
| **Tier 3 compression (NEW)** | **Save checkpoint before summarisation** |
| **Context > 75% (NEW)** | **Auto-save with session state** |

### Checkpoint File Format

`markdown
# Checkpoint: [TASK_NAME]
**ID:** CKP-[timestamp]
**Created:** [datetime] SAST
**Device:** [PC|Laptop]
**Status:** [in_progress|completed|blocked]
**Context Level:** [GREEN|YELLOW|ORANGE|RED] (NEW)

## Task Definition
[Original user request]

## Session Intent (NEW - from CTX-001)
[The core objective being pursued]

## Progress
- [x] Step 1: [description] - [result summary]
- [x] Step 2: [description] - [result summary]
- [ ] Step 3: [description] - PENDING

## Current State
[What was being worked on when checkpoint created]

## Key Data
[Any important variables, paths, decisions]

## Files Modified
- [path]: [what was done]

## Compression State (NEW)
- **Offloaded files:** [list paths in cache/offloaded/]
- **Archived conversations:** [list paths in cache/conversations/]
- **Tokens saved:** [total tokens saved by compression]

## Next Actions
1. [Next step to take]
2. [Following step]

## Resume Command
"Continue task [TASK_NAME] from checkpoint CKP-[timestamp]"
`

---

## Summarisation Format (NEW v2.0)

When Tier 3 compression triggers:

`markdown
## Session Summary [{session_id}]
**Generated:** {timestamp} SAST
**Context Saved:** {tokens} tokens
**Archived To:** cache/conversations/{session_id}_full.md

### Session Intent
[Original user objective - CRITICAL to preserve]

### Artifacts Created
| Artifact | Path | Status |
|----------|------|--------|
| [Name] | [Path] | [Complete/Partial] |

### Key Decisions
1. [Decision + rationale]
2. [Decision + rationale]

### Current Progress
- **Phase:** [Current phase]
- **Completed:** [What's done]
- **Remaining:** [What's left]

### Critical Facts
- [Fact that must not be lost]
- [Constraint or requirement]

### Next Steps
1. [Immediate action required]
2. [Following actions]

### Recovery References
- Full conversation: cache/conversations/{session_id}_full.md
- Offloaded content: cache/offloaded/
- Checkpoints: cache/checkpoints/
`

---

## Goal Drift Detection (NEW v2.0)

### Post-Compression Verification

After ANY Tier 3 summarisation:

`
CHECK 1: Intent Alignment
- Does current action align with Session Intent?
- Would user recognise this as their task?

CHECK 2: Trajectory Continuity  
- Is progress toward original goal continuing?
- Are we not starting unrelated subtasks?

CHECK 3: Red Flags
- WARN if immediately asking user for clarification
- WARN if declaring task complete without deliverable
- WARN if context seems incomplete for task

ON DRIFT DETECTED:
1. Search cache/offloaded/ and cache/conversations/ for original context
2. Re-read relevant sections
3. Realign with original intent
4. Inform user if significant deviation prevented
`

---

## Session Resume Protocol (Enhanced v2.0)

### Starting New Session After Limit

**User says:** "Continue from where we left off" or "Resume task"

**Claude does:**
`
1. READ Memory/Shared/active_task.md
2. READ latest checkpoint from cache/checkpoints/
3. READ session_handoff.md for context
4. CHECK cache/offloaded/ for relevant offloaded content (NEW)
5. CHECK cache/conversations/ for archived history (NEW)
6. SUMMARISE: "Resuming [task]. Last checkpoint: [description]. Next step: [action]"
7. VERIFY intent alignment before continuing (NEW)
8. CONTINUE from checkpoint
`

### Recovery Operations (NEW v2.0)

**Search Offloaded Content:**
`
WHEN information needed but not in context:
1. Search cache/offloaded/ for relevant files
2. Read specific sections (not entire file)
3. Extract required information
4. Continue with recovered data
`

**Full Conversation Recovery:**
`
WHEN detailed history needed:
1. Read cache/conversations/{session_id}_full.md
2. Search for specific interaction
3. Extract relevant context
4. Apply to current task
`

---

## Implementation for All Personas

### Mandatory Behaviours (Updated v2.0)

`yaml
all_personas:
  on_complex_task_start:
    - Create active_task.md
    - Create checkpoint folder
    - Estimate steps and save
    - Capture session intent (NEW)
    
  during_execution:
    - Checkpoint every 3-5 operations
    - Cache large outputs locally
    - Keep context lean
    - Monitor context thresholds (NEW)
    - Apply Tier 1 offloading on large results (NEW)
    
  at_50_percent_context: # NEW
    - Apply Tier 2 truncation
    - Log compression event
    
  at_75_percent_context: # NEW
    - Create checkpoint BEFORE summarisation
    - Apply Tier 3 summarisation
    - Run goal drift detection
    - Update active_task.md
    
  at_85_percent_context: # NEW
    - Final checkpoint
    - Full state preservation
    - Recommend fresh session
    
  on_milestone:
    - Save named checkpoint
    - Update active_task.md
    - Summarise progress
    
  on_warning_signs:
    - Immediate checkpoint
    - Save all state
    - Create resume instructions
    - Check compression options (NEW)
    
  on_task_complete:
    - Final checkpoint (completed)
    - Update session_handoff.md
    - Clean up temp cache (optional)
    
  post_compression: # NEW
    - Verify intent alignment
    - Check for drift indicators
    - Recover if drift detected
`

---

## Quick Commands (Updated v2.0)

| User Command | Claude Action |
|--------------|---------------|
| "checkpoint" | Save immediate checkpoint |
| "save state" | Save all current state |
| "resume" | Load last task state |
| "task status" | Show active_task.md |
| "clear task" | Archive and reset active_task |
| **"context status"** | **Report current context usage (NEW)** |
| **"compress"** | **Force compression evaluation (NEW)** |
| **"recover [topic]"** | **Search offloaded content (NEW)** |
| **"show intent"** | **Display preserved session intent (NEW)** |

---

## Integration with Protocols

| Protocol | Integration |
|----------|-------------|
| **CTX-001** | **Context compression triggers (NEW)** |
| DEV-001 | Device detection for correct paths |
| MEM-001 | Uses Memory folder structure |
| LAR-023 | Batch processing uses checkpoints |
| LAR-033 | Context compression skill execution (NEW) |
| PR-017 | Long task protocol integration |
| PR-018 | Ralph Loop fresh context execution |
| PR-019 | RLM sub-calls with managed context |
| Global | Session start loads active_task |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| **2.0** | **29 January 2026** | **CTX-001 integration, three-tier compression, goal drift detection, enhanced recovery** |
| 1.2 | 28 January 2026 | Added never-restart rule, failure recovery protocol |
| 1.0 | 15 January 2026 | Initial Session Persistence Protocol |

---

*Frans Session Persistence Protocol v2.0 | SES-001*
