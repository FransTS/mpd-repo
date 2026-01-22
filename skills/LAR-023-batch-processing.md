# Frans Skill: Batch Processing & Long Task Execution

## Metadata

| Field | Value |
|-------|-------|
| **Name** | batch-processing |
| **Version** | 1.0 |
| **ID** | LAR-023 |
| **Triggers** | "batch process", "multiple files", "long task", "process all", "checkpoint", "resumable" |
| **Always Active** | NO (on-demand for complex multi-item tasks) |
| **Google Doc Name** | `SKILL_BatchProcessing` |
| **Based On** | Frans Transcription Project 2026-01-12 |

---

## Purpose

Enable reliable execution of long-running, multi-item batch tasks with checkpoint recovery, strategy adaptation, and incremental delivery. Prevents work loss from session timeouts, compaction, or interruptions.

---

## Core Architecture

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚                 BATCH PROCESSING FRAMEWORK                       â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚                                                                  â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”  â”‚
â”‚   â”‚                    CHECKPOINT SYSTEM                      â”‚  â”‚
â”‚   â”‚  â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”    â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”    â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”   â”‚  â”‚
â”‚   â”‚  â”‚ STATE.json  â”‚    â”‚ CHECKPOINT  â”‚    â”‚ PROGRESS    â”‚   â”‚  â”‚
â”‚   â”‚  â”‚ (Machine)   â”‚    â”‚ .txt (Human)â”‚    â”‚ LOG         â”‚   â”‚  â”‚
â”‚   â”‚  â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜    â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜    â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜   â”‚  â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜  â”‚
â”‚                              â”‚                                   â”‚
â”‚                              â–¼                                   â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”  â”‚
â”‚   â”‚                  MODULAR INFRASTRUCTURE                   â”‚  â”‚
â”‚   â”‚  â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”    â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”    â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”   â”‚  â”‚
â”‚   â”‚  â”‚ Processor   â”‚    â”‚ Generator   â”‚    â”‚ Validator   â”‚   â”‚  â”‚
â”‚   â”‚  â”‚ (Parse/Fix) â”‚â”€â”€â”€â–¶â”‚ (Output)    â”‚â”€â”€â”€â–¶â”‚ (Quality)   â”‚   â”‚  â”‚
â”‚   â”‚  â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜    â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜    â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜   â”‚  â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜  â”‚
â”‚                              â”‚                                   â”‚
â”‚                              â–¼                                   â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”  â”‚
â”‚   â”‚                  BATCH ITEM PROCESSING                    â”‚  â”‚
â”‚   â”‚                                                           â”‚  â”‚
â”‚   â”‚  Item 1 â”€â”€â–¶ Item 2 â”€â”€â–¶ ... â”€â”€â–¶ Item N                    â”‚  â”‚
â”‚   â”‚    âœ“          âœ“                  â³                       â”‚  â”‚
â”‚   â”‚                                                           â”‚  â”‚
â”‚   â”‚  [COMPLETED]  [COMPLETED]     [IN_PROGRESS]  [PENDING]   â”‚  â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜  â”‚
â”‚                              â”‚                                   â”‚
â”‚                              â–¼                                   â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”  â”‚
â”‚   â”‚                  INCREMENTAL DELIVERY                     â”‚  â”‚
â”‚   â”‚  â€¢ Present files after EACH item completion               â”‚  â”‚
â”‚   â”‚  â€¢ Don't batch all outputs to end                        â”‚  â”‚
â”‚   â”‚  â€¢ User sees progress throughout                         â”‚  â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜  â”‚
â”‚                                                                  â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

---

## Checkpoint System

### 1. State Tracking (JSON)

```json
{
  "task_name": "Transcription Batch v4.9",
  "created": "2026-01-12T14:00:00Z",
  "last_updated": "2026-01-12T15:30:00Z",
  "total_items": 13,
  "completed": 6,
  "in_progress": 1,
  "pending": 6,
  "items": [
    {
      "id": 1,
      "name": "Dylen",
      "source": "/path/to/source.mp4",
      "status": "COMPLETED",
      "output_files": ["file_1.docx", "file_MERGED.docx"],
      "segments": 274,
      "completed_at": "2026-01-12T14:15:00Z"
    }
  ],
  "settings": {
    "vocabulary_corrections": true,
    "output_format": "docx",
    "quality_threshold": 0.8
  }
}
```

### 2. Human-Readable Checkpoint (TXT)

```
=== PROJECT CHECKPOINT ===
Last Updated: 2026-01-12T15:30:00Z

COMPLETED (6):
1. Dylen     âœ“ (274 segments)
2. Ernst     âœ“ (112 segments)
3. Inus      âœ“ (130 segments)

IN PROGRESS:
7. Rene      <- CURRENT

PENDING (6):
8. RM
9. Ruan
...

CONTINUATION PROMPT:
"Continue batch processing from checkpoint"

OUTPUT LOCATION:
/mnt/user-data/outputs/
```

### 3. Continuation Protocol

When session resumes or after compaction:
1. Read STATE.json for exact status
2. Identify next IN_PROGRESS or PENDING item
3. Resume processing without user confirmation
4. Continue incremental delivery

---

## Strategy Adaptation

### Initial Assessment

Before starting batch:
1. **Test with first item** - Validate approach works
2. **Measure performance** - Time, reliability, quality
3. **Identify issues** - Timeouts, errors, quality gaps

### Pivot Decision Matrix

| Symptom | Action |
|---------|--------|
| Timeout on processing | Simplify approach, reduce scope per item |
| Poor quality output | Add validation steps, try alternative method |
| Format inconsistency | Implement adaptive pattern matching |
| Resource exhaustion | Batch smaller, add delays |

### Example Pivot (From This Session)

```
INITIAL APPROACH: Full audio re-transcription
â”œâ”€â”€ Problem: 60+ min videos causing timeouts
â”œâ”€â”€ Problem: Slow processing (hours per video)
â””â”€â”€ Decision: PIVOT

REVISED APPROACH: Existing transcript + corrections
â”œâ”€â”€ Benefit: Fast (seconds per item)
â”œâ”€â”€ Benefit: Reliable (no audio processing)
â”œâ”€â”€ Benefit: Quality maintained via vocabulary fixes
â””â”€â”€ Decision: PROCEED
```

---

## Modular Infrastructure Pattern

### Create Reusable Components

```
PROCESSING PIPELINE:
â”‚
â”œâ”€â”€ processor.py (or .js)
â”‚   â”œâ”€â”€ Parse input format
â”‚   â”œâ”€â”€ Apply corrections/transformations
â”‚   â”œâ”€â”€ Validate output
â”‚   â””â”€â”€ Return structured data
â”‚
â”œâ”€â”€ generator.py (or .js)
â”‚   â”œâ”€â”€ Take structured data
â”‚   â”œâ”€â”€ Generate output format (DOCX, PDF, etc.)
â”‚   â””â”€â”€ Apply formatting/styling
â”‚
â”œâ”€â”€ validator.py (or .js)
â”‚   â”œâ”€â”€ Quality checks
â”‚   â”œâ”€â”€ Completeness verification
â”‚   â””â”€â”€ Return pass/fail with metrics
â”‚
â””â”€â”€ orchestrator.sh
    â”œâ”€â”€ Loop through items
    â”œâ”€â”€ Call processor â†’ generator â†’ validator
    â”œâ”€â”€ Update checkpoint after each
    â””â”€â”€ Handle errors gracefully
```

### Adaptive Pattern Matching

When processing items with varying formats:

```python
def parse_content(text):
    patterns = [
        r'pattern_1',  # Most common format
        r'pattern_2',  # Alternative format
        r'pattern_3',  # Fallback format
    ]
    
    for pattern in patterns:
        matches = re.findall(pattern, text)
        if len(matches) > threshold:
            return process_matches(matches)
    
    # No pattern worked - flag for review
    return {"status": "NEEDS_REVIEW", "raw": text}
```

---

## Quality Gates

### Per-Item Validation

| Check | Pass Criteria | Action if Fail |
|-------|---------------|----------------|
| Segment count | > minimum threshold | Try alternative pattern |
| Speaker ratio | Within expected range | Review speaker detection |
| Output size | > minimum bytes | Check for empty content |
| Format valid | Opens correctly | Regenerate output |

### Batch-Level Validation

| Check | Pass Criteria | Action if Fail |
|-------|---------------|----------------|
| Completion rate | 100% items done | Report partial, continue |
| Consistency | Same format across all | Flag outliers |
| Naming convention | Matches spec | Rename files |

---

## Incremental Delivery

### Pattern: Deliver As You Go

```
FOR each item in batch:
    process(item)
    validate(item)
    IF valid:
        present_files(item.outputs)  # <-- DELIVER IMMEDIATELY
        update_checkpoint(item, "COMPLETED")
    ELSE:
        flag_for_review(item)
        update_checkpoint(item, "NEEDS_REVIEW")
```

### Benefits
- User sees progress
- Completed work is safe even if session breaks
- Early feedback if quality issues
- Motivation for long tasks

---

## Compaction Resilience

### Before Session Compaction

The compaction summary MUST include:
1. Current item being processed
2. Checkpoint file location
3. Continuation instructions

### After Session Compaction

```
RESUMPTION PROTOCOL:
1. Read checkpoint from known location
2. Identify current state
3. Resume immediately without asking user
4. Continue processing next pending item
```

---

## Best Practices

### âœ… Do

| Practice | Reason |
|----------|--------|
| Create checkpoint before starting | Enables recovery |
| Test with one item first | Validates approach |
| Deliver incrementally | Progress visible, work safe |
| Use modular scripts | Reusable, maintainable |
| Validate each output | Catches issues early |
| Adapt patterns to input | Handles format variations |
| Update checkpoint after each item | Accurate state tracking |
| Include continuation prompt | Easy resumption |

### âŒ Don't

| Anti-Pattern | Problem |
|--------------|---------|
| Process all, deliver at end | Work lost if session breaks |
| Single monolithic script | Hard to debug, can't reuse |
| Skip validation | Bad outputs delivered |
| Assume consistent format | Fails on variations |
| Ignore timeouts | Wastes time, loses work |
| Hard-code values | Can't adapt to variations |

---

## Integration with Other Skills

| Skill | Integration |
|-------|-------------|
| **LAR-016 iterative-loop** | For complex individual items |
| **LAR-013 error-recovery** | Handle item-level failures |
| **LAR-014 context-management** | Preserve state across sessions |
| **LAR-007 self-assessment** | Quality gate implementation |

---

## Invocation

### Start Batch Processing

```
"Process these 13 videos using batch processing with checkpoints"
"Batch convert all files with recovery enabled"
"Long-running task: [description] - use checkpoint system"
```

### Resume from Checkpoint

```
"Continue batch processing from checkpoint"
"Resume the previous batch task"
"Pick up where we left off"
```

---

## Rules

```
+checkpoint=always              # Always create checkpoint before starting
+validate=per-item              # Validate each item after processing
+deliver=incremental            # Present outputs as they complete
+adapt=strategy                 # Pivot approach if issues arise
+patterns=adaptive              # Try multiple patterns for format detection
+state=persistent               # Maintain state across session breaks
-batch-deliver-end              # Don't wait until end to deliver
-skip-validation                # Never skip quality checks
-assume-format                  # Don't assume input format consistency
-ignore-failures                # Handle errors, don't ignore them
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| **010 The Architect** | Orchestrate complex batch tasks |
| **015 Transcript Specialist** | Batch transcription workflows |
| **005 Document Creator** | Batch document generation |
| **006 Technical Writer** | Batch documentation processing |
| **009 Software Architect** | Batch code/test generation |

---

*Frans Skill LAR-023 | Batch Processing & Long Task Execution v1.0*
