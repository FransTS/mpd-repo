# LAR-025: Ralph Loop Skill

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | LAR-025 |
| **Version** | 1.0 |
| **Created** | 17 January 2026 |
| **Protocol** | PR-018 |
| **Trigger** | "Ralph Loop", "iterative task", "fresh context" |

---

## Purpose

Implement iterative task execution with fresh context windows to prevent context rot and maintain AI performance.

---

## Capabilities

1. **PRD Generation** - Break complex projects into discrete tasks
2. **Progress Tracking** - Log attempts, successes, and failures
3. **Context Management** - Monitor token usage, trigger fresh sessions
4. **Iteration Control** - Limit attempts, escalate blockers

---

## Quick Start

### Initialize Ralph Loop

```markdown
## Ralph Loop Initialization

**Project:** [Name]
**Max Attempts per Task:** 10
**Context Threshold:** 100,000 tokens

### Tasks (from PRD)
1. [ ] Task description
2. [ ] Task description
3. [ ] Task description

### Progress File
Created: progress.md
```

### Execute Task

```markdown
## Executing Task [N]

**Attempt:** [X] of 10
**Previous Result:** [success/error/none]
**Context Used:** ~[X]k tokens

### Action
[What I'm doing]

### Result
[Outcome]

### Next
[Continue/Retry/Escalate]
```

---

## PRD Creation Guide

When user says "Ralph Loop this project":

1. **Extract Requirements**
   - What is the end goal?
   - What are the success criteria?
   - What are the constraints?

2. **Break Into Tasks**
   - Each task should be completable in one session
   - Tasks should be independent where possible
   - Order by dependencies

3. **Define Acceptance**
   - How do we know each task is done?
   - What tests/checks apply?

4. **Estimate Complexity**
   - Simple: 1-2 attempts expected
   - Medium: 3-5 attempts expected
   - Complex: 5-10 attempts expected

---

## Progress Tracking Format

```markdown
# Progress: [Project Name]

## Status
- **Current Task:** 3 of 7
- **Overall:** 28% complete
- **Blocked:** None

## Task Log

### Task 1: [Title] ✅
- Attempts: 2
- Completed: 2026-01-17 10:30

### Task 2: [Title] ✅
- Attempts: 1
- Completed: 2026-01-17 11:15

### Task 3: [Title] 🔄
- Attempt 1: Error - missing dependency
- Attempt 2: In progress...
```

---

## Context Rot Detection

Signs of context rot:
- Repetitive responses
- Forgetting earlier instructions
- Declining code quality
- Ignoring constraints
- Hallucinating file contents

**Action:** Immediately checkpoint and recommend fresh session.

---

## Integration Points

| Component | Integration |
|-----------|-------------|
| SES-001 | Checkpoint at task boundaries |
| TDP-001 | Fresh `mcpl verify` each session |
| LAR-023 | Batch sub-operations within task |
| MEM-001 | Store progress in project memory |

---

## Automation Script

For Windows/Claude Code, use `ralph.ps1`:

```powershell
.\scripts\ralph.ps1 -PrdFile "PRD.md" -MaxAttempts 10
```

---

## Manual Workflow (Claude.ai)

1. **Session 1:** Create PRD.md
2. **Session 2:** Execute Task 1, update progress.md
3. **Session 3:** Execute Task 2, update progress.md
4. **...repeat...**
5. **Final Session:** Review and compile results

**Key:** Each numbered session = fresh chat window

---

## Example: Website Project

**PRD.md:**
```markdown
# Project: Portfolio Website

## Tasks

### Task 1: Setup
- Status: complete
- Create project structure, install dependencies

### Task 2: Homepage
- Status: pending
- Build responsive homepage with hero section

### Task 3: Projects Page
- Status: pending
- Grid layout with project cards

### Task 4: Contact Form
- Status: pending
- Form with validation and email integration
```

**Progress.md after Task 1:**
```markdown
# Progress: Portfolio Website

### Task 1: Setup ✅
- Attempt 1: Success
- Created: package.json, folder structure
- Installed: React, Tailwind, Vite
- Completed: 2026-01-17 14:00
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 17 Jan 2026 | Initial release |

---

*Frans MPD Skill LAR-025 v1.0*
