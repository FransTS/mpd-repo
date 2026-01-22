# Protocol: Long Complex Task Execution

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | PR-017 |
| **Version** | 1.0 |
| **Created** | 2026-01-12 |
| **Triggers** | Multi-item tasks, batch operations, long-running processes, session-spanning work |
| **Related Skills** | LAR-023 (batch-processing), LAR-016 (iterative-loop), LAR-013 (error-recovery) |
| **Based On** | Frans Transcription Project learnings |

---

## Purpose

Define a reliable protocol for executing long, complex tasks that may span multiple session windows, require strategy pivots, or involve processing many items. Ensures work is never lost and can be resumed from any point.

---

## Protocol Phases

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚              LONG COMPLEX TASK EXECUTION PROTOCOL                â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚                                                                  â”‚
â”‚   PHASE 1: INITIALISATION                                       â”‚
â”‚   â”œâ”€â”€ Analyse scope and complexity                              â”‚
â”‚   â”œâ”€â”€ Detect environment capabilities                           â”‚
â”‚   â”œâ”€â”€ Create checkpoint infrastructure                          â”‚
â”‚   â”œâ”€â”€ Define success criteria per item                          â”‚
â”‚   â””â”€â”€ Identify required personas/skills/protocols               â”‚
â”‚                                                                  â”‚
â”‚   PHASE 2: PILOT                                                â”‚
â”‚   â”œâ”€â”€ Process first item as test                                â”‚
â”‚   â”œâ”€â”€ Validate approach works                                   â”‚
â”‚   â”œâ”€â”€ Measure: time, quality, reliability                       â”‚
â”‚   â”œâ”€â”€ Pivot strategy if needed                                  â”‚
â”‚   â””â”€â”€ Lock in final approach                                    â”‚
â”‚                                                                  â”‚
â”‚   PHASE 3: EXECUTION                                            â”‚
â”‚   â”œâ”€â”€ Process items sequentially                                â”‚
â”‚   â”œâ”€â”€ Validate each item                                        â”‚
â”‚   â”œâ”€â”€ Deliver incrementally                                     â”‚
â”‚   â”œâ”€â”€ Update checkpoint after each                              â”‚
â”‚   â””â”€â”€ Adapt patterns as needed                                  â”‚
â”‚                                                                  â”‚
â”‚   PHASE 4: COMPLETION                                           â”‚
â”‚   â”œâ”€â”€ Verify all items complete                                 â”‚
â”‚   â”œâ”€â”€ Final quality check                                       â”‚
â”‚   â”œâ”€â”€ Consolidate deliverables                                  â”‚
â”‚   â”œâ”€â”€ Generate summary report                                   â”‚
â”‚   â””â”€â”€ Archive checkpoint (success)                              â”‚
â”‚                                                                  â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

---

## Phase 1: Initialisation

### 1.1 Scope Analysis

```
ANALYSE REQUEST:
â”œâ”€â”€ Total items to process: [N]
â”œâ”€â”€ Estimated time per item: [T]
â”œâ”€â”€ Total estimated time: [N Ã— T]
â”œâ”€â”€ Risk of session timeout: [YES/NO]
â”œâ”€â”€ Complexity per item: [SIMPLE/MODERATE/COMPLEX]
â””â”€â”€ Decision: [STANDARD / BATCH-WITH-CHECKPOINT]

IF total_time > 30 minutes OR items > 5:
    â†’ Use checkpoint infrastructure
    â†’ Enable incremental delivery
    â†’ Create resumption protocol
```

### 1.2 Environment Detection

```
DETECT CAPABILITIES:
â”œâ”€â”€ File system access: [LOCAL MCP / CONTAINER / CLOUD]
â”œâ”€â”€ Code execution: [POWERSHELL / BASH / NONE]
â”œâ”€â”€ Output location: [PATH]
â”œâ”€â”€ Available tools: [LIST]
â””â”€â”€ Constraints: [TIMEOUTS / RATE LIMITS / SIZE LIMITS]
```

### 1.3 Checkpoint Infrastructure

Create before processing starts:

**STATE.json** (Machine-readable)
```json
{
  "task_id": "TASK-2026-01-12-001",
  "task_name": "Descriptive Name",
  "created": "ISO-TIMESTAMP",
  "total_items": N,
  "items": [],
  "settings": {}
}
```

**CHECKPOINT.txt** (Human-readable)
```
=== TASK CHECKPOINT ===
Task: [Name]
Created: [Date]
Items: 0 of N complete

CONTINUATION PROMPT:
"Continue from checkpoint"
```

### 1.4 Resource Identification

```
REQUIRED RESOURCES:
â”œâ”€â”€ Primary Persona: [ID + Name]
â”œâ”€â”€ Support Personas: [IDs if multi-domain]
â”œâ”€â”€ Skills to Load: [LAR-XXX list]
â”œâ”€â”€ Protocols to Follow: [PR-XXX list]
â”œâ”€â”€ Workflows to Use: [If applicable]
â””â”€â”€ Domain Knowledge: [SK-XXX vocabulary/patterns]
```

---

## Phase 2: Pilot

### 2.1 First Item Test

```
PILOT EXECUTION:
â”œâ”€â”€ Select first/representative item
â”œâ”€â”€ Process using planned approach
â”œâ”€â”€ Measure:
â”‚   â”œâ”€â”€ Time taken
â”‚   â”œâ”€â”€ Quality of output
â”‚   â”œâ”€â”€ Any errors or issues
â”‚   â””â”€â”€ Resource usage
â”œâ”€â”€ Validate output meets criteria
â””â”€â”€ Document findings
```

### 2.2 Strategy Validation

| Outcome | Action |
|---------|--------|
| Success, fast, high quality | PROCEED with approach |
| Success but slow | Consider optimisation or simpler approach |
| Partial success | Identify issue, adjust approach |
| Failure | PIVOT to alternative strategy |

### 2.3 Pivot Decision

```
PIVOT TRIGGERS:
â”œâ”€â”€ Timeout during processing
â”œâ”€â”€ Quality below threshold
â”œâ”€â”€ Excessive resource usage
â”œâ”€â”€ Format incompatibility
â””â”€â”€ Reliability issues

PIVOT ACTIONS:
â”œâ”€â”€ Document what didn't work
â”œâ”€â”€ Identify alternative approach
â”œâ”€â”€ Test alternative on same item
â”œâ”€â”€ Compare results
â””â”€â”€ Lock in better approach
```

### 2.4 Lock Approach

After successful pilot:
- Document final approach
- Create reusable scripts/templates
- Define quality gates
- Set up validation checks

---

## Phase 3: Execution

### 3.1 Processing Loop

```
FOR each item in queue:
    
    1. UPDATE checkpoint: status = "IN_PROGRESS"
    
    2. PROCESS item:
       â”œâ”€â”€ Apply established approach
       â”œâ”€â”€ Use adaptive patterns if format varies
       â””â”€â”€ Collect metrics
    
    3. VALIDATE output:
       â”œâ”€â”€ Quality gate checks
       â”œâ”€â”€ Completeness verification
       â””â”€â”€ Format validation
    
    4. IF valid:
       â”œâ”€â”€ DELIVER output immediately (present_files)
       â”œâ”€â”€ UPDATE checkpoint: status = "COMPLETED"
       â””â”€â”€ PROCEED to next item
    
    5. IF invalid:
       â”œâ”€â”€ TRY alternative pattern/approach
       â”œâ”€â”€ IF still invalid: FLAG for review
       â””â”€â”€ UPDATE checkpoint: status = "NEEDS_REVIEW"
    
    6. CONTINUE to next item
```

### 3.2 Incremental Delivery

**CRITICAL:** Deliver outputs as they complete, not in batch at end.

```
AFTER each successful item:
â”œâ”€â”€ present_files([output_files])
â”œâ”€â”€ Confirm delivery in response
â”œâ”€â”€ User can download immediately
â””â”€â”€ Work is safe even if session breaks
```

### 3.3 Checkpoint Updates

After EACH item:
```
UPDATE STATE.json:
â”œâ”€â”€ Item status: COMPLETED / NEEDS_REVIEW
â”œâ”€â”€ Output files: [paths]
â”œâ”€â”€ Metrics: segments, size, time
â”œâ”€â”€ Timestamp: completion time

UPDATE CHECKPOINT.txt:
â”œâ”€â”€ Move item from PENDING to COMPLETED
â”œâ”€â”€ Update current item pointer
â”œâ”€â”€ Update progress count
```

### 3.4 Adaptive Processing

When items have varying formats:

```
PATTERN ADAPTATION:
â”œâ”€â”€ Try primary pattern
â”œâ”€â”€ IF segments < threshold:
â”‚   â”œâ”€â”€ Analyse input format
â”‚   â”œâ”€â”€ Try alternative patterns
â”‚   â””â”€â”€ Use pattern that yields best results
â”œâ”€â”€ Document which pattern worked
â””â”€â”€ Apply learning to similar items
```

---

## Phase 4: Completion

### 4.1 Verification

```
FINAL CHECKS:
â”œâ”€â”€ All items processed: [X of N]
â”œâ”€â”€ All items delivered: [X of N]
â”œâ”€â”€ Items needing review: [List]
â”œâ”€â”€ Overall quality: [PASS/PARTIAL/FAIL]
â””â”€â”€ Missing outputs: [List if any]
```

### 4.2 Summary Report

```
=== TASK COMPLETION REPORT ===

Task: [Name]
Duration: [Start] to [End]
Items: [X] of [N] completed successfully

RESULTS:
| # | Item | Status | Output | Metrics |
|---|------|--------|--------|---------|
| 1 | Name | âœ“      | file   | data    |
...

ITEMS NEEDING ATTENTION: [List or "None"]

OUTPUT LOCATION: [Path]
```

### 4.3 Cleanup

```
ON SUCCESS:
â”œâ”€â”€ Archive checkpoint (keep for reference)
â”œâ”€â”€ Confirm all files delivered
â””â”€â”€ Offer to copy to permanent location

ON PARTIAL:
â”œâ”€â”€ Preserve checkpoint for resumption
â”œâ”€â”€ List incomplete items
â””â”€â”€ Offer to continue or close
```

---

## Session Handling

### Compaction Resilience

When session is compacted, the summary MUST include:
```
[CHECKPOINT LOCATION]: /path/to/CHECKPOINT.txt
[CURRENT ITEM]: Item N of M
[CONTINUATION]: "Resume from checkpoint"
```

### Resumption Protocol

When resuming (new session or after break):
```
1. CHECK for checkpoint file
2. READ current state
3. IDENTIFY next item to process
4. RESUME immediately (no user confirmation needed)
5. CONTINUE incremental delivery
```

---

## Dynamic Resource Loading

### Persona Swapping

During complex tasks, personas may need to change:

```
PERSONA SWAP TRIGGERS:
â”œâ”€â”€ Domain shift (e.g., technical â†’ marketing)
â”œâ”€â”€ Skill requirement change
â”œâ”€â”€ Quality issue requiring specialist
â””â”€â”€ User request

SWAP PROTOCOL:
â”œâ”€â”€ Save current state to checkpoint
â”œâ”€â”€ Document handoff context
â”œâ”€â”€ Load new persona
â”œâ”€â”€ Brief new persona on task state
â””â”€â”€ Continue processing
```

### Skill Loading

```
DYNAMIC SKILL LOAD:
â”œâ”€â”€ Identify skill gap during execution
â”œâ”€â”€ Load required skill (LAR-XXX)
â”œâ”€â”€ Apply skill knowledge to current item
â””â”€â”€ Continue with enhanced capability
```

### Protocol Chaining

```
PROTOCOL CHAIN EXAMPLE:
â”œâ”€â”€ PR-017 (this protocol) - Overall framework
â”œâ”€â”€ LAR-023 (batch-processing) - Item processing
â”œâ”€â”€ LAR-016 (iterative-loop) - Complex item refinement
â”œâ”€â”€ LAR-007 (self-assessment) - Quality validation
â””â”€â”€ LAR-013 (error-recovery) - Failure handling
```

---

## Integration Rules

```
+checkpoint=mandatory           # Always use for long tasks
+pilot=first-item               # Test approach before batch
+deliver=incremental            # Don't wait until end
+adapt=strategy                 # Pivot if approach fails
+validate=per-item              # Quality gate each item
+resume=automatic               # Continue without asking
+resource=dynamic               # Load personas/skills as needed
-batch-end-delivery             # Never batch all to end
-skip-pilot                     # Always test first
-ignore-checkpoint              # Always update state
-static-approach                # Adapt to variations
```

---

## Persona Authority

| Persona | Authority Level |
|---------|-----------------|
| **010 The Architect** | Can invoke this protocol, swap resources |
| **Any Specialist** | Can request resource swap via The Architect |
| **012 Prompt Engineer** | Can modify protocol/skill during execution |

---

*Protocol PR-017 | Long Complex Task Execution v1.0*
