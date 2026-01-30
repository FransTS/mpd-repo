# Session Persistence Protocol v1.2

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | SES-001 |
| **Version** | 1.2 |
| **Created** | 15 January 2026 |
| **Updated** | 29 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Priority** | HIGH - Prevents work loss from context limits |

---

## Purpose

Prevent work loss when Claude hits context window limits by:
1. Auto-checkpointing task progress to local memory
2. Enabling seamless task resumption in new sessions
3. Caching intermediate results locally
4. Proactive context management


---

## Context Compression Integration (CTX-001) - NEW v2.0

### Compression Thresholds

| Context Usage | State | Action |
|---------------|-------|--------|
| < 25% | GREEN | Normal operation |
| 25-50% | YELLOW | Monitor, prepare compression |
| 50-75% | ORANGE | **Tier 1 & 2 compression active** |
| 75-85% | RED | **Tier 3 summarisation + checkpoint** |
| > 85% | CRITICAL | **Final checkpoint + fresh session** |

### Three-Tier Compression

- **Tier 1:** Offload tool results > 15k tokens to `cache/offloaded/`
- **Tier 2:** Truncate persisted tool inputs at 50% context
- **Tier 3:** Summarise conversation at 75%, archive to `cache/conversations/`

### Goal Drift Detection

After Tier 3 summarisation:
1. Verify intent alignment with original objective
2. Check for drift indicators (clarification requests, premature completion)
3. Recover from archive if drift detected

See: CTX-001-context-compression.md, LAR-033-context-compression.md

---

## Memory Paths

```
G:\My Drive\Shared_Download\AI_Folder\Memory\
ÃƒÂ¢Ã¢â‚¬ÂÃ…â€œÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ Shared/
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡   ÃƒÂ¢Ã¢â‚¬ÂÃ…â€œÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ active_task.md          # Current task state (CRITICAL)
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡   ÃƒÂ¢Ã¢â‚¬ÂÃ…â€œÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ session_handoff.md      # Session summary
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡   ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬ÂÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ cache/
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡       ÃƒÂ¢Ã¢â‚¬ÂÃ…â€œÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ checkpoints/        # Task checkpoints
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡       ÃƒÂ¢Ã¢â‚¬ÂÃ…â€œÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ intermediate/       # Intermediate results
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡       ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬ÂÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ context/            # Compacted context
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡
ÃƒÂ¢Ã¢â‚¬ÂÃ…â€œÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ [Device]/
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡   ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬ÂÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ cache/
ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬Å¡       ÃƒÂ¢Ã¢â‚¬ÂÃ¢â‚¬ÂÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ÃƒÂ¢Ã¢â‚¬ÂÃ¢â€šÂ¬ temp/               # Session-specific temp data
```

---

## Checkpoint System

### CRITICAL: Never Restart From Scratch

```
âš ï¸ MANDATORY RULE (Added 28 Jan 2026)

WHEN a multi-step task is interrupted, fails, or session breaks:
1. NEVER restart the task from the beginning
2. ALWAYS check for existing checkpoints FIRST
3. READ the last checkpoint file
4. RESUME from the last completed item
5. INFORM user: "Resuming from item X of Y"

VIOLATION of this rule wastes user time and is unacceptable.
```

### Checkpoint Triggers (Auto-Save)

| Trigger | Action |
|---------|--------|
| Every 3-5 tool calls | Save progress checkpoint |
| Every 3-5 items in bulk task | Save progress to checkpoint file |
| After major milestone | Save named checkpoint |
| Before risky operation | Save safety checkpoint |
| User says "checkpoint" | Immediate checkpoint |
| Complex task started | Create task manifest |

### Checkpoint File Format

```markdown
# Checkpoint: [TASK_NAME]
**ID:** CKP-[timestamp]
**Created:** [datetime] SAST
**Device:** [PC|Laptop]
**Status:** [in_progress|completed|blocked]

## Task Definition
[Original user request]

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

## Next Actions
1. [Next step to take]
2. [Following step]

## Resume Command
"Continue task [TASK_NAME] from checkpoint CKP-[timestamp]"
```

---

## Active Task Management

### Starting a Complex Task

```
WHEN complex task detected:
1. CREATE active_task.md with:
   - Task definition
   - Expected steps
   - Success criteria
   - Estimated complexity

2. SAVE to: Memory/Shared/active_task.md

3. CREATE checkpoint folder:
   Memory/Shared/cache/checkpoints/[task-id]/
```

### During Task Execution

```
EVERY 3-5 operations:
1. UPDATE active_task.md progress
2. SAVE intermediate results to cache/intermediate/
3. LOG key decisions and data

AFTER each major step:
1. CREATE numbered checkpoint
2. SUMMARISE completed work
3. LIST remaining work
```

### Detecting Context Pressure

```
WARNING SIGNS (act immediately):
- Response mentions "context" or "limit"
- User reports slowdown
- Complex nested operations
- Large file content in context
- Long conversation history

WHEN detected:
1. IMMEDIATELY save checkpoint
2. SUMMARISE current state
3. SAVE all intermediate results
4. CREATE resume instructions
```

---

## Context Compaction Strategy

### Proactive Compaction

```
AFTER every major milestone:
1. SAVE detailed results to local file
2. KEEP only summary in context
3. REFERENCE: "Full details saved to [path]"

EXAMPLE:
Instead of keeping 500 lines of analysis in context:
- SAVE full analysis to: cache/intermediate/analysis_[date].md
- KEEP in context: "Analysis complete. 15 findings. See cache/intermediate/analysis_[date].md"
```

### What to Cache Locally

| Content Type | Cache Location | Keep in Context |
|--------------|----------------|-----------------|
| Research findings | `cache/intermediate/` | Summary only |
| Generated documents | `cache/intermediate/` | Filename + status |
| Code files | Output folder | Filename only |
| Large data | `cache/intermediate/` | Key metrics only |
| Decisions made | `Shared/decisions.md` | Brief reference |

---

## Session Resume Protocol

### Starting New Session After Limit

**User says:** "Continue from where we left off" or "Resume task"

**Claude does:**
```
1. READ Memory/Shared/active_task.md
2. READ latest checkpoint from cache/checkpoints/
3. READ session_handoff.md for context
4. SUMMARISE: "Resuming [task]. Last checkpoint: [description]. Next step: [action]"
5. CONTINUE from checkpoint
```

### Resume Command Examples

```
"Continue task"
"Resume from checkpoint"
"Pick up where we left off"
"What were we working on?"
"Load last task state"
```

---

## Implementation for All Personas

### Mandatory Behaviours

```yaml
all_personas:
  on_complex_task_start:
    - Create active_task.md
    - Create checkpoint folder
    - Estimate steps and save
    
  during_execution:
    - Checkpoint every 3-5 operations
    - Cache large outputs locally
    - Keep context lean
    
  on_milestone:
    - Save named checkpoint
    - Update active_task.md
    - Summarise progress
    
  on_warning_signs:
    - Immediate checkpoint
    - Save all state
    - Create resume instructions
    
  on_task_complete:
    - Final checkpoint (completed)
    - Update session_handoff.md
    - Clean up temp cache (optional)
```

---

## Quick Commands

| User Command | Claude Action |
|--------------|---------------|
| "checkpoint" | Save immediate checkpoint |
| "save state" | Save all current state |
| "resume" | Load last task state |
| "task status" | Show active_task.md |
| "clear task" | Archive and reset active_task |

---

## Example Workflow

### Task: "Process 20 documents"

```
1. START
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Create active_task.md: "Process 20 docs, extract summaries"
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Create checkpoint folder: checkpoints/doc_processing_20260115/

2. PROCESS docs 1-5
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Save checkpoint: CKP-001 (docs 1-5 complete)
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Cache summaries to: intermediate/doc_summaries_1-5.md

3. PROCESS docs 6-10
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Save checkpoint: CKP-002 (docs 1-10 complete)
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Cache summaries to: intermediate/doc_summaries_6-10.md

4. [CONTEXT LIMIT HIT]
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Auto-save: CKP-003 (docs 1-12 complete, 13 in progress)
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Save state: "Doc 13 partially processed. Next: complete 13, then 14-20"

5. NEW SESSION
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ User: "Continue task"
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Load CKP-003
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Resume from doc 13
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Continue through doc 20

6. COMPLETE
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Final checkpoint: CKP-FINAL (all 20 complete)
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Consolidate outputs
   ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Update session_handoff.md
```

---

## Integration with Existing Protocols

| Protocol | Integration |
|----------|-------------|
| DEV-001 | Device detection for correct paths |
| MEM-001 | Uses Memory folder structure |
| LAR-023 | Batch processing uses checkpoints |
| PR-017 | Long task protocol integration |
| Global | Session start loads active_task |

---

## Troubleshooting

### Task Not Resuming Properly
1. Check active_task.md exists
2. Verify checkpoint files present
3. Manually specify: "Resume from checkpoint CKP-XXX"

### Lost Progress
1. Check cache/checkpoints/ for saved states
2. Check cache/intermediate/ for outputs
3. Check session_handoff.md for summary

### Context Still Filling Fast
1. Increase local caching frequency
2. Reduce in-context data retention
3. Break task into smaller chunks

---

## Failure Recovery Protocol

### On Task Interruption/Failure

```
STEP 1: Check for checkpoint
  - READ: cache/checkpoints/[task-id]/
  - READ: active_task.md
  - IDENTIFY: Last completed item/step

STEP 2: Report to user
  - "Found checkpoint at item X of Y"
  - "Resuming from [last completed]"

STEP 3: Resume (NOT restart)
  - Continue from next incomplete item
  - DO NOT repeat completed work

NEVER:
  - Start from item 1 if checkpoint exists
  - Ask user "should I start again?"
  - Ignore previous progress
```

### Bulk Processing Checkpoint Format

```markdown
# Bulk Task Checkpoint
**Task:** [e.g., Catalogue 19 images]
**Updated:** [timestamp]
**Progress:** X of Y complete

## Completed Items
| Item | Status | Result/Notes |
|------|--------|-------------|
| 1.png | âœ… | Semantic Framework diagram |
| 2.png | âœ… | Kobliat features - 5 modules |
| 3.png | âœ… | AIForged full platform |
...

## Next Item
[First incomplete item]

## Resume Command
Continue from item [X+1]
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.2 | 29 January 2026 | Added CRITICAL never-restart rule, failure recovery protocol, bulk processing checkpoint format |
| 1.0 | 15 January 2026 | Initial Session Persistence Protocol |

---

*Frans Session Persistence Protocol v1.2*
