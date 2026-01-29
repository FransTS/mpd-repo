# Context Compression Protocol v1.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | CTX-001 |
| **Version** | 1.0 |
| **Created** | 29 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Priority** | HIGH - Prevents context rot and enables deep agents |
| **Source** | LangChain Deep Agents SDK (Jan 2026) |

---

## Purpose

Manage LLM context window limits through intelligent compression while preserving task-critical information. Implements three-tier compression architecture based on LangChain's Deep Agents methodology.

---

## Core Principles

1. **Compression preserves intent** - Session goals survive all compression events
2. **Recoverability** - Any compressed information can be retrieved on demand
3. **Progressive degradation** - Compress least critical first
4. **Goal drift prevention** - Monitor for deviation post-compression

---

## Context Thresholds

| Usage | State | Action |
|-------|-------|--------|
| < 25% | GREEN | Normal operation |
| 25-50% | YELLOW | Monitor, prepare for compression |
| 50-75% | ORANGE | **Activate Tier 1 & 2 compression** |
| 75-85% | RED | **Trigger Tier 3 summarisation** |
| > 85% | CRITICAL | **Checkpoint + recommend fresh session** |

---

## Three-Tier Compression Architecture

### Tier 1: Large Tool Result Offloading

**Trigger:** Tool response exceeds 15,000 tokens (immediate)

**Process:**
1. Detect large tool output
2. Write full content to: `cache/offloaded/{timestamp}_{tool_name}.md`
3. Replace in context with:
   - File path reference
   - First 10 lines preview
   - Token count saved
4. Agent can re-read or search content as needed

**Example:**
`markdown
## Offloaded Content Reference
**File:** cache/offloaded/20260129_142530_web_search.md
**Tokens Saved:** 18,500
**Preview:**
> [First 10 lines of content...]

*Full content available via file read*
`

### Tier 2: Large Tool Input Truncation

**Trigger:** Context exceeds 50% AND old write/edit operations exist

**Process:**
1. Identify tool calls with large input arguments (file writes, edits)
2. Since content is already persisted to filesystem, truncate from context
3. Replace with:
   - File path pointer
   - Brief modification summary
   - "Content persisted to disk"

**Priority order (truncate first):**
1. Oldest tool calls
2. Largest arguments
3. Already-persisted content

**Example:**
`markdown
## Truncated Tool Call
**Original:** create_file with 500 lines
**Path:** /output/report.md
**Summary:** Created market analysis report
**Status:** Content persisted to disk
`

### Tier 3: Conversation Summarisation

**Trigger:** Context exceeds 75% AND Tiers 1-2 insufficient

**Process:**
1. Generate structured summary (see format below)
2. Write full conversation to: `cache/conversations/{session_id}_full.md`
3. Replace conversation history with summary
4. Maintain file references for recovery

**Summary Format:**
`markdown
## Session Summary
**Session ID:** {session_id}
**Generated:** {timestamp} SAST
**Context Saved:** {tokens} tokens

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
- **Full conversation:** cache/conversations/{session_id}_full.md
- **Offloaded content:** cache/offloaded/
- **Checkpoints:** cache/checkpoints/
`

---

## Memory Paths for Compression

`
Memory/Shared/cache/
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª offloaded/              # Tier 1: Large tool results
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª conversations/          # Tier 3: Full conversation archives
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª checkpoints/            # Task checkpoints (SES-001)
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª intermediate/          # Intermediate results
`

---

## Goal Drift Detection

### Post-Compression Verification

After ANY Tier 3 summarisation:

`
CHECK 1: Intent Alignment
- Does current action align with Session Intent?
- Would user recognise this as their task?

CHECK 2: Trajectory Continuity  
- Is progress toward original goal continuing?
- Are we not starting unrelated subtasks?

CHECK 3: Clarification Red Flags
- WARN if immediately asking user for clarification
- WARN if declaring task complete without deliverable
- WARN if context seems incomplete for task

ON DRIFT DETECTED:
1. Search offloaded/conversations for original context
2. Re-read relevant sections
3. Realign with original intent
4. Inform user if significant deviation prevented
`

### Drift Indicators

| Indicator | Severity | Action |
|-----------|----------|--------|
| Asking clarification immediately after summary | HIGH | Check if summarisation lost critical info |
| Declaring complete without deliverable | CRITICAL | Verify against original intent |
| Working on unrelated subtask | HIGH | Re-read original request |
| Contradicting earlier decision | MEDIUM | Search for decision context |
| Missing stated constraint | HIGH | Recover constraints from archive |

---

## Recovery Operations

### Search Offloaded Content

`
WHEN information needed but not in context:
1. Search cache/offloaded/ for relevant files
2. Read specific sections (not entire file)
3. Extract required information
4. Continue with recovered data
`

### Full Conversation Recovery

`
WHEN detailed history needed:
1. Read cache/conversations/{session_id}_full.md
2. Search for specific interaction
3. Extract relevant context
4. Apply to current task
`

### Needle-in-Haystack Recovery

`
WHEN specific fact needed post-compression:
1. Identify what fact is needed
2. Search offloaded content and conversation archives
3. Locate the specific information
4. Recover without loading full history
`

---

## Integration Points

| Component | Integration |
|-----------|-------------|
| **SES-001** | Triggers compression at thresholds, uses same cache structure |
| **LAR-006** | Routes to compression when context high |
| **LAR-014** | Context tracking informs compression decisions |
| **LAR-033** | Skill for executing compression operations |
| **PR-019 RLM** | Uses sub-call pattern which inherently manages context |
| **PR-018 Ralph** | Fresh context per task = natural compression |

---

## Compression Event Logging

Every compression event should be logged:

`markdown
## Compression Event Log
**Timestamp:** {datetime} SAST
**Event Type:** TIER_1 | TIER_2 | TIER_3
**Trigger:** {what triggered compression}
**Tokens Before:** {count}
**Tokens After:** {count}
**Tokens Saved:** {count}
**Files Created:** {list of cache files}
**Intent Preserved:** YES | VERIFICATION_NEEDED
`

---

## Implementation for All Personas

### Mandatory Behaviours

`yaml
all_personas:
  on_large_tool_result:
    - Check if > 15,000 tokens
    - If yes, apply Tier 1 offloading
    
  at_50_percent_context:
    - Apply Tier 2 truncation
    - Log compression event
    
  at_75_percent_context:
    - Apply Tier 3 summarisation
    - Run goal drift check
    - Create checkpoint
    
  at_85_percent_context:
    - Final checkpoint
    - Recommend fresh session
    - Ensure complete state preservation
    
  post_any_compression:
    - Verify intent alignment
    - Check for drift indicators
    - Recover if needed
`

---

## Quick Commands

| User Command | Action |
|--------------|--------|
| "compress" | Force compression evaluation |
| "context status" | Report current context usage |
| "recover [topic]" | Search offloaded content for topic |
| "show session intent" | Display preserved session intent |
| "compression log" | Show recent compression events |

---

## Testing Recommendations

Per LangChain guidance:

1. **Stress Test** - Trigger compression at 25% to generate more events
2. **Recoverability** - Verify facts can be recovered post-compression
3. **Intent Preservation** - Confirm task continues after summarisation
4. **Drift Detection** - Monitor for deviation from original goal

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 29 January 2026 | Initial release based on LangChain Deep Agents methodology |

---

*Frans Context Compression Protocol v1.0 | CTX-001*
