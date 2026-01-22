# PR-018: Ralph Loop Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | PR-018 |
| **Version** | 1.0 |
| **Created** | 17 January 2026 |
| **Purpose** | Iterative task execution with fresh context |
| **Inspiration** | Ralph Loop technique (Chase AI) |

---

## Overview

The Ralph Loop ensures AI operates at peak performance by:
1. Breaking complex projects into discrete tasks
2. Starting fresh sessions for each sub-task
3. Tracking progress across iterations
4. Preventing context rot (degradation after ~100k tokens)

**Core Principle:** Fresh context = Smart AI

---

## When to Use

- Complex multi-step projects
- Tasks requiring multiple iterations
- Long-running development work
- When context window exceeds 50% capacity
- When AI responses degrade in quality

---

## Workflow

```
┌─────────────────────────────────────┐
│ 1. CREATE PRD                       │
│    Break project into discrete tasks│
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│ 2. INITIALIZE                       │
│    Create progress.md               │
│    Set max_attempts (default: 10)   │
└─────────────┬───────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│ 3. LOOP START                       │◄──────┐
│    Read PRD → Find first incomplete │       │
│    Start FRESH session              │       │
└─────────────┬───────────────────────┘       │
              │                               │
              ▼                               │
┌─────────────────────────────────────┐       │
│ 4. EXECUTE TASK                     │       │
│    Attempt current task             │       │
│    Log result to progress.md        │       │
└─────────────┬───────────────────────┘       │
              │                               │
              ▼                               │
┌─────────────────────────────────────┐       │
│ 5. EVALUATE                         │       │
│    Success? → Mark complete, next   │       │
│    Fail? → Increment attempt        │       │
│    Max attempts? → Flag for human   │       │
└─────────────┬───────────────────────┘       │
              │                               │
              ▼                               │
         ┌────┴────┐                          │
         │ More    │───── Yes ────────────────┘
         │ tasks?  │
         └────┬────┘
              │ No
              ▼
┌─────────────────────────────────────┐
│ 6. COMPLETE                         │
│    Generate final report            │
└─────────────────────────────────────┘
```

---

## File Structure

```
Project/
├── PRD.md              # Product Requirements Document
├── progress.md         # Iteration tracking
├── tasks/
│   ├── task-001.md     # Individual task details
│   ├── task-002.md
│   └── ...
└── output/             # Task outputs
```

---

## PRD Template

```markdown
# Project: [Name]

## Overview
[Brief description]

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Tasks

### Task 1: [Title]
- **Status:** pending | in_progress | complete | blocked
- **Priority:** high | medium | low
- **Dependencies:** none | task-X
- **Description:** [What needs to be done]
- **Acceptance:** [How to verify completion]

### Task 2: [Title]
...
```

---

## Progress.md Template

```markdown
# Progress Log

## Current Task
- **Task:** [ID and title]
- **Attempt:** [N] of [max]
- **Status:** attempting | success | failed

## History

### [Timestamp] - Task 1, Attempt 1
- **Action:** [What was tried]
- **Result:** success | error
- **Output:** [Summary or error message]
- **Next:** [What to try next if failed]

### [Timestamp] - Task 1, Attempt 2
...
```

---

## Context Rot Thresholds

| Token Count | % of 200k | Action |
|-------------|-----------|--------|
| < 50,000 | < 25% | Continue normally |
| 50-100,000 | 25-50% | Consider checkpoint |
| 100-150,000 | 50-75% | **Start fresh session** |
| > 150,000 | > 75% | **Mandatory fresh session** |

---

## Integration with Frans MPD

### With SES-001 (Session Persistence)
- Use checkpoints as iteration boundaries
- Progress.md supplements session_handoff.md

### With TDP-001 (Tool Discovery)
- Fresh sessions get clean tool context
- Use `mcpl verify` at session start

### With LAR-023 (Batch Processing)
- Ralph Loop is the outer orchestrator
- Batch processing handles within-task operations

---

## Manual vs Automated

### Manual (Claude.ai)
1. Create PRD.md and progress.md
2. Start new chat for each task
3. Paste context: "Continue from progress.md, execute next task"
4. Update progress.md after each attempt

### Automated (Claude Code + Script)
Use ralph.ps1 script for hands-off execution:
```powershell
.\ralph.ps1 -PrdFile "PRD.md" -MaxAttempts 10
```

---

## Commands

| Command | Action |
|---------|--------|
| "Ralph Loop this" | Initialize PR-018 for current project |
| "Fresh start" | Begin new session, load progress.md |
| "Log attempt" | Record current attempt to progress.md |
| "Next task" | Mark complete, move to next |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 17 Jan 2026 | Initial release |

---

*Frans Master Prompt Dictionary - Protocol PR-018 v1.0*
