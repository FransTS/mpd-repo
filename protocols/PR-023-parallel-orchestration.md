# Parallel Orchestration Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | PR-023 |
| **Version** | 1.0 |
| **Last Updated** | 30 January 2026 \| SAST (UTC+2) |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v5.4, Claude Code |
| **Inspiration** | Conductor (macOS), parallel-worktrees, ccswarm |

---

## Purpose

Replicate Conductor's parallel development capabilities on Windows using git worktrees and Claude Code's native Task tool. Enable simultaneous execution of multiple development tasks across isolated workspaces.

---

## Core Concepts

### What This Protocol Enables

| Capability | Description |
|------------|-------------|
| **Parallel Execution** | Run N Claude agents simultaneously on different tasks |
| **Worktree Isolation** | Each agent works in its own git worktree |
| **Background Orchestration** | Main session delegates while continuing work |
| **Competitive Implementation** | Multiple agents solve same problem, pick best |
| **Divide and Conquer** | Split large features across agents |

### Key Benefits

- **5-8x productivity** for multi-task projects
- **LLM non-determinism as feature** - get N valid solutions
- **No merge conflicts** during parallel development
- **Shared .git database** - minimal disk overhead

---

## Architecture

```
Main Repository (Orchestrator)
├── .git/                     # Shared git database
├── .worktrees/               # Parallel working directories
│   ├── task-api/
│   │   ├── [full repo copy]
│   │   └── RESULTS.md
│   ├── task-ui/
│   │   ├── [full repo copy]
│   │   └── RESULTS.md
│   └── task-tests/
│       ├── [full repo copy]
│       └── RESULTS.md
├── .agent-status/            # Agent status tracking
│   ├── task-api.json
│   ├── task-ui.json
│   └── task-tests.json
└── scripts/
    ├── spawn-parallel.ps1
    ├── cleanup-worktrees.ps1
    └── sync-worktrees.ps1
```

---

## Workflow Patterns

### Pattern 1: Competitive Implementation

Multiple agents solve the same problem; select the best solution.

```
USE CASE: UI component, algorithm, architectural decision
AGENTS: 3 (minimum recommended)
PROCESS:
1. Create 3 worktrees for same feature
2. Give identical prompt to each agent
3. Compare implementations
4. Merge winner, delete others
```

### Pattern 2: Divide and Conquer

Split independent feature parts across agents.

```
USE CASE: Large feature with parallel-capable components
AGENTS: Based on component count
PROCESS:
1. Decompose feature into independent parts
2. Create worktree per component
3. Assign one agent per worktree
4. Merge all when complete
```

### Pattern 3: Test-First Parallel

One agent writes tests, others implement.

```
USE CASE: TDD workflows
AGENTS: 2+ (1 test writer, N implementers)
PROCESS:
1. Test agent writes comprehensive tests first
2. Implementation agents work in parallel
3. First to pass all tests wins
```

### Pattern 4: Exploration Sprint

Each agent tries different architectural approach.

```
USE CASE: Technology decisions (WebSocket vs SSE vs polling)
AGENTS: Based on options count
PROCESS:
1. Define approaches to explore
2. Each agent implements one approach
3. Evaluate and select best fit
```

---

## Orchestration Modes

### Mode 1: Interactive Parallel

Multiple terminal sessions, each running Claude Code.

```powershell
# Terminal 1: Orchestrator (main repo)
cd C:\GitHub\MyProject
claude

# Terminal 2: Agent 1
cd C:\GitHub\MyProject\.worktrees\task-api
claude

# Terminal 3: Agent 2
cd C:\GitHub\MyProject\.worktrees\task-ui
claude
```

### Mode 2: Background Orchestration

Main agent delegates via Task tool with `run_in_background: true`.

```markdown
## Orchestrator Process

1. Create worktrees for each task
2. Launch background agents via Task tool
3. Continue working on orchestrator tasks
4. Monitor .agent-status/*.json for completion
5. Sync and merge when all complete
```

---

## Agent Status Convention

### Status File Format

Location: `.agent-status/<task-name>.json`

```json
{
  "task": "task-api",
  "status": "RUNNING",
  "started": "2026-01-30T10:30:00Z",
  "completed": null,
  "summary": null,
  "files_changed": [],
  "branch": "feature/task-api-1",
  "worktree": ".worktrees/task-api"
}
```

### Valid Status Values

| Status | Meaning |
|--------|---------|
| `PENDING` | Worktree created, agent not started |
| `RUNNING` | Agent actively working |
| `COMPLETE` | Task finished successfully |
| `FAILED` | Task encountered errors |
| `BLOCKED` | Waiting for dependency or input |

### Completion Format

```json
{
  "task": "task-api",
  "status": "COMPLETE",
  "started": "2026-01-30T10:30:00Z",
  "completed": "2026-01-30T10:45:00Z",
  "summary": "Implemented 5 endpoints, 12 tests passing",
  "files_changed": [
    "src/api/users.ts",
    "src/api/auth.ts",
    "tests/api.test.ts"
  ],
  "branch": "feature/task-api-1",
  "worktree": ".worktrees/task-api"
}
```

---

## Windows Scripts

### spawn-parallel.ps1

Creates N parallel worktrees.

```powershell
# Usage: .\scripts\spawn-parallel.ps1 -FeatureName "auth" -NumAgents 3 -BaseBranch "main"

param(
    [Parameter(Mandatory=$true)]
    [string]$FeatureName,

    [int]$NumAgents = 3,

    [string]$BaseBranch = "main"
)

# Create directories
$worktreeDir = ".worktrees"
$statusDir = ".agent-status"

if (-not (Test-Path $worktreeDir)) { New-Item -ItemType Directory -Path $worktreeDir }
if (-not (Test-Path $statusDir)) { New-Item -ItemType Directory -Path $statusDir }

# Create worktrees
for ($i = 1; $i -le $NumAgents; $i++) {
    $branchName = "feature/$FeatureName-$i"
    $worktreePath = "$worktreeDir/$FeatureName-$i"

    Write-Host "Creating worktree: $worktreePath on branch: $branchName"
    git worktree add $worktreePath -b $branchName $BaseBranch

    # Create status file
    $status = @{
        task = "$FeatureName-$i"
        status = "PENDING"
        started = $null
        completed = $null
        summary = $null
        files_changed = @()
        branch = $branchName
        worktree = $worktreePath
    } | ConvertTo-Json

    $status | Out-File "$statusDir/$FeatureName-$i.json" -Encoding UTF8
}

Write-Host "`nCreated $NumAgents worktrees for feature: $FeatureName"
Write-Host "Launch Claude Code in each worktree to start agents"
git worktree list
```

### cleanup-worktrees.ps1

Removes worktrees and optionally deletes branches.

```powershell
# Usage: .\scripts\cleanup-worktrees.ps1 -FeatureName "auth" [-DeleteBranches]

param(
    [Parameter(Mandatory=$true)]
    [string]$FeatureName,

    [switch]$DeleteBranches
)

$worktreeDir = ".worktrees"
$statusDir = ".agent-status"

# Find matching worktrees
$worktrees = Get-ChildItem $worktreeDir -Directory | Where-Object { $_.Name -like "$FeatureName-*" }

foreach ($wt in $worktrees) {
    $wtPath = "$worktreeDir/$($wt.Name)"
    $statusFile = "$statusDir/$($wt.Name).json"

    # Check for uncommitted changes
    Push-Location $wtPath
    $changes = git status --porcelain
    Pop-Location

    if ($changes) {
        Write-Warning "Worktree $wtPath has uncommitted changes. Skipping."
        continue
    }

    # Remove worktree
    Write-Host "Removing worktree: $wtPath"
    git worktree remove $wtPath --force

    # Remove status file
    if (Test-Path $statusFile) {
        Remove-Item $statusFile
    }

    # Optionally delete branch
    if ($DeleteBranches) {
        $branchName = "feature/$($wt.Name)"
        Write-Host "Deleting branch: $branchName"
        git branch -D $branchName 2>$null
    }
}

# Prune stale worktree metadata
git worktree prune

Write-Host "`nCleanup complete. Remaining worktrees:"
git worktree list
```

### sync-worktrees.ps1

Reviews and merges completed work.

```powershell
# Usage: .\scripts\sync-worktrees.ps1 [-Status] [-Merge] [-Interactive]

param(
    [switch]$Status,
    [switch]$Merge,
    [switch]$Interactive
)

$statusDir = ".agent-status"

# Get all status files
$statusFiles = Get-ChildItem $statusDir -Filter "*.json"

if ($Status -or (-not $Merge -and -not $Interactive)) {
    Write-Host "`n=== Agent Status ===" -ForegroundColor Cyan
    foreach ($file in $statusFiles) {
        $data = Get-Content $file.FullName | ConvertFrom-Json
        $color = switch ($data.status) {
            "COMPLETE" { "Green" }
            "RUNNING" { "Yellow" }
            "FAILED" { "Red" }
            "BLOCKED" { "Magenta" }
            default { "White" }
        }
        Write-Host "$($data.task): $($data.status)" -ForegroundColor $color
        if ($data.summary) {
            Write-Host "  Summary: $($data.summary)"
        }
    }
    return
}

# Merge completed work
$completed = $statusFiles | ForEach-Object {
    Get-Content $_.FullName | ConvertFrom-Json
} | Where-Object { $_.status -eq "COMPLETE" }

foreach ($agent in $completed) {
    if ($Interactive) {
        Write-Host "`n=== $($agent.task) ===" -ForegroundColor Cyan
        Write-Host "Branch: $($agent.branch)"
        Write-Host "Summary: $($agent.summary)"
        Write-Host "Files: $($agent.files_changed -join ', ')"

        $confirm = Read-Host "Merge this branch? (y/n)"
        if ($confirm -ne 'y') { continue }
    }

    Write-Host "Merging: $($agent.branch)"
    git merge $agent.branch --no-ff -m "Merge $($agent.task): $($agent.summary)"
}

Write-Host "`nSync complete."
```

---

## Integration with Claude Code

### Spawning Background Agents

Use the Task tool with `run_in_background: true`:

```markdown
I'll spawn background agents for parallel execution:

1. Create worktrees: `.\scripts\spawn-parallel.ps1 -FeatureName "feature" -NumAgents 3`
2. Launch agents via Task tool (run_in_background: true)
3. Each agent works in its assigned worktree
4. Monitor progress via .agent-status/*.json
```

### Agent Instructions Template

When spawning a background agent:

```markdown
## Task: [TASK_NAME]

**Worktree:** .worktrees/[task-name]
**Branch:** feature/[task-name]-N

### Instructions
[Detailed task instructions]

### On Completion
1. Commit all changes with descriptive message
2. Update .agent-status/[task-name].json:
   - Set status to "COMPLETE"
   - Add completion timestamp
   - Write summary of work done
   - List files changed
3. Create RESULTS.md in worktree root with:
   - What was implemented
   - Key decisions made
   - Any issues encountered
   - Testing notes
```

---

## When to Use Parallel Orchestration

### Use When

| Scenario | Recommended Pattern |
|----------|---------------------|
| Multiple valid approaches exist | Competitive Implementation |
| Large feature with independent parts | Divide and Conquer |
| High-risk changes | Redundant Safety Net |
| Technology/architecture decision | Exploration Sprint |
| TDD workflow | Test-First Parallel |

### Avoid When

- Tightly coupled changes in same files
- Critical refactors requiring consistency
- Merge conflict cost exceeds benefit
- Simple, single-file changes

---

## Resource Considerations

| Factor | Impact |
|--------|--------|
| Token usage | ~15x higher than sequential |
| Disk space | Minimal (shared .git) |
| Context per agent | Fresh start, needs codebase orientation |
| Subscription | Plan for higher usage |

---

## Trigger Phrases

Auto-activate this protocol when user says:
- "parallel agents", "background agents"
- "worktrees", "agent coordination"
- "spawn agents", "parallel tasks"
- "multi-agent workflow"
- "conductor mode", "orchestrate"

---

## Related Skills and Protocols

| ID | Name | Integration |
|----|------|-------------|
| LAR-034 | parallel-worktrees | Worktree management skill |
| LAR-006 | autonomous-routing | Route to orchestration when detected |
| PR-018 | ralph-loop | Sequential fresh-context alternative |
| LAR-025 | ralph-loop | Fresh context per task |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 30 Jan 2026 | Initial Parallel Orchestration Protocol |

---

*Frans Protocol PR-023 | Parallel Orchestration v1.0 | Conductor-equivalent for Windows*
