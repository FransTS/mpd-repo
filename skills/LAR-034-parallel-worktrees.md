# Frans Skill: Parallel Worktrees

## Metadata

| Field | Value |
|-------|-------|
| **Name** | parallel-worktrees |
| **Version** | 1.0 |
| **ID** | LAR-034 |
| **Triggers** | "parallel agents", "spawn agents", "worktrees", "conductor mode" |
| **Protocol** | PR-023 (Parallel Orchestration) |
| **Updated** | 30 January 2026 |

---

## Purpose

Manage git worktrees for parallel Claude Code agent execution. Enables Conductor-like orchestration on Windows by creating isolated working directories where multiple agents can work simultaneously.

---

## Quick Commands

| Command | Action |
|---------|--------|
| `spawn 3 agents for [feature]` | Create 3 worktrees for parallel work |
| `status agents` | Show all agent statuses |
| `sync agents` | Merge completed agent work |
| `cleanup [feature]` | Remove worktrees for feature |

---

## Core Operations

### 1. Spawn Parallel Worktrees

```powershell
# Create N worktrees for a feature
git worktree add .worktrees/feature-1 -b feature/feature-1 main
git worktree add .worktrees/feature-2 -b feature/feature-2 main
git worktree add .worktrees/feature-3 -b feature/feature-3 main
```

**Claude Response Format:**
```markdown
Created 3 parallel worktrees for feature [name]:

| Worktree | Branch | Status |
|----------|--------|--------|
| .worktrees/feature-1 | feature/feature-1 | PENDING |
| .worktrees/feature-2 | feature/feature-2 | PENDING |
| .worktrees/feature-3 | feature/feature-3 | PENDING |

**Next steps:**
1. Open terminal in each worktree
2. Run `claude` in each
3. Provide your task instructions
```

### 2. Check Agent Status

Read from `.agent-status/*.json`:

```markdown
## Agent Status

| Agent | Status | Started | Summary |
|-------|--------|---------|---------|
| feature-1 | RUNNING | 10:30 | Working on API endpoints |
| feature-2 | COMPLETE | 10:30 | Implemented 5 endpoints |
| feature-3 | BLOCKED | 10:35 | Waiting for DB schema |
```

### 3. Sync Completed Work

```powershell
# Merge completed branches
git merge feature/feature-1 --no-ff -m "Merge feature-1: [summary]"
git merge feature/feature-2 --no-ff -m "Merge feature-2: [summary]"
```

### 4. Cleanup Worktrees

```powershell
# Remove worktrees
git worktree remove .worktrees/feature-1 --force
git worktree remove .worktrees/feature-2 --force

# Prune stale metadata
git worktree prune

# Optionally delete branches
git branch -D feature/feature-1
git branch -D feature/feature-2
```

---

## Workflow Patterns

### Competitive Implementation

Same task, multiple solutions.

```markdown
## Spawning Competitive Agents

**Task:** Implement user authentication

**Agents:**
1. Agent 1: JWT-based approach
2. Agent 2: Session-based approach
3. Agent 3: OAuth-focused approach

**Selection Criteria:**
- Code quality and simplicity
- Test coverage
- Security best practices
```

### Divide and Conquer

Split feature into independent parts.

```markdown
## Feature Decomposition

**Feature:** E-commerce checkout

**Agent Assignments:**
1. Agent 1: Cart API endpoints
2. Agent 2: Payment processing
3. Agent 3: Order confirmation UI
4. Agent 4: Email notifications

**Dependencies:** None (parallel-safe)
```

### Test-First Parallel

Tests written first, implementations compete.

```markdown
## TDD Parallel Workflow

**Phase 1:** Agent 1 writes comprehensive tests
**Phase 2:** Agents 2-4 implement (first to pass wins)
```

---

## Background Agent Delegation

When using Claude Code's Task tool:

```markdown
## Background Agent Template

Launching background agent for: [TASK]

**Worktree:** .worktrees/[task-name]
**Branch:** feature/[task-name]-N

### Instructions
[Task details]

### Completion Requirements
1. Commit changes with descriptive message
2. Update status file: .agent-status/[task-name].json
3. Write RESULTS.md in worktree root
```

---

## Status File Schema

### Location

`.agent-status/<task-name>.json`

### Schema

```json
{
  "task": "string",
  "status": "PENDING|RUNNING|COMPLETE|FAILED|BLOCKED",
  "started": "ISO-8601 timestamp or null",
  "completed": "ISO-8601 timestamp or null",
  "summary": "string or null",
  "files_changed": ["array", "of", "paths"],
  "branch": "feature/branch-name",
  "worktree": ".worktrees/path"
}
```

---

## Git Worktree Commands Reference

| Command | Purpose |
|---------|---------|
| `git worktree add <path> -b <branch> <base>` | Create new worktree |
| `git worktree list` | Show all worktrees |
| `git worktree remove <path>` | Remove worktree |
| `git worktree prune` | Clean stale metadata |
| `git worktree lock <path>` | Prevent accidental removal |

---

## Integration Points

### With LAR-006 (Autonomous Routing)

```markdown
When detected:
- "parallel agents" in request
- Multiple independent tasks identified
- User requests "conductor mode"

Route to: PR-023 + LAR-034
```

### With PR-018 (Ralph Loop)

```markdown
Sequential vs Parallel Decision:

RALPH LOOP (Sequential):
- Tasks have dependencies
- Order matters
- Single-threaded execution

PARALLEL WORKTREES:
- Tasks are independent
- Order doesn't matter
- Multi-agent execution
```

---

## Resource Considerations

| Factor | Value |
|--------|-------|
| Token usage | ~15x sequential |
| Disk overhead | Minimal (shared .git) |
| Context per agent | Fresh start |
| Recommended agents | 2-5 |

---

## Troubleshooting

### Worktree Already Exists

```powershell
# Check existing worktrees
git worktree list

# Remove if stale
git worktree remove .worktrees/name --force
git worktree prune
```

### Branch Already Exists

```powershell
# Use existing branch
git worktree add .worktrees/name existing-branch

# Or delete and recreate
git branch -D feature/name
git worktree add .worktrees/name -b feature/name main
```

### Uncommitted Changes Block Removal

```powershell
# Check changes
cd .worktrees/name
git status

# Either commit or discard
git add . && git commit -m "WIP"
# or
git checkout -- .
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 30 Jan 2026 | Initial parallel worktrees skill |

---

*Frans Skill LAR-034 | Parallel Worktrees v1.0*
