# Claude Local Memory Protocol v2.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MEM-001 |
| **Version** | 2.0 |
| **Created** | 13 January 2026 |
| **Updated** | 28 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v5.0+, Skill Registry v2.4+ |

---

## Purpose

Provide persistent memory across Claude sessions using local filesystem storage via Google Drive sync. **Version 2.0 introduces strict project isolation** to prevent cross-contamination between different projects.

---

## CRITICAL: Project Isolation Rules

### Rule 1: Every Session Has a Project Scope
- Each Claude chat operates within a specific **PROJECT_ID**
- Project memory is isolated in `Memory/Projects/{PROJECT_ID}/`
- NEVER read/write session state from `Memory/Shared/` (deprecated for session state)

### Rule 2: Project Detection (Mandatory First Step)
Claude MUST detect the project scope at session start:

```
1. CHECK user's session starter prompt for PROJECT_ID
2. IF explicitly stated → Use that PROJECT_ID
3. IF not stated → Ask user: "Which project is this session for?"
4. VERIFY project folder exists in Memory/Projects/{PROJECT_ID}/
5. IF folder missing → Create from _Template
```

### Rule 3: Path Isolation
| Scope | Path Pattern | Used For |
|-------|--------------|----------|
| **Project** | `Memory/Projects/{PROJECT_ID}/` | ALL session state |
| **Global** | `Memory/_Global/` | Index, cross-project configs only |
| **Device** | `Memory/{PC\|Laptop}/` | Device-specific temp cache only |

### Rule 4: No Cross-Project Access
- NEVER read another project's session_handoff.md or active_task.md
- NEVER write to Shared/ folder for session state
- Shared/ folder is DEPRECATED for session management

---

## Folder Structure v2.0

```
G:\My Drive\Shared_Download\AI_Folder\Memory\
├── MEMORY_PROTOCOL.md          # This file
│
├── _Global/                    # Cross-project index only
│   ├── project_index.md        # List of all projects
│   └── session_starter_prompt.md  # Template for new projects
│
├── Projects/                   # PROJECT-ISOLATED MEMORY
│   ├── _Template/              # Template for new projects
│   │   ├── project_config.md
│   │   ├── session_handoff.md
│   │   ├── active_task.md
│   │   └── cache/
│   │       ├── checkpoints/
│   │       └── intermediate/
│   │
│   ├── MPD_Development/        # Example: MPD project
│   │   ├── project_config.md   # Project-specific config
│   │   ├── session_handoff.md  # Project session state
│   │   ├── active_task.md      # Project active task
│   │   └── cache/
│   │       ├── checkpoints/    # Project checkpoints
│   │       └── intermediate/   # Project intermediate files
│   │
│   └── [Other Projects]/
│
├── PC/                         # Device-specific (temp only)
│   ├── session_log.md          # Device session log
│   └── cache/temp/             # Temporary device cache
│
├── Laptop/                     # Device-specific (temp only)
│   ├── session_log.md
│   └── cache/temp/
│
└── Shared/                     # DEPRECATED for session state
    └── [Legacy files - READ ONLY, do not update]
```

---

## Session Start Protocol v2.0

```
STEP 1: DETECT PROJECT SCOPE (MANDATORY)
  ┌────────────────────────────────────────────┐
  │ Check session starter for PROJECT_ID       │
  │ OR ask user: "Which project is this for?"  │
  │ SET: PROJECT_PATH = Memory/Projects/{ID}/  │
  └────────────────────────────────────────────┘

STEP 2: DETECT DEVICE
  ┌────────────────────────────────────────────┐
  │ $env:USERPROFILE contains "Frans Vermaak"  │
  │   → DEVICE = LAPTOP                        │
  │ $env:USERPROFILE contains "User"           │
  │   → DEVICE = PC                            │
  │ No Filesystem MCP                          │
  │   → DEVICE = MOBILE                        │
  └────────────────────────────────────────────┘

STEP 3: LOAD PROJECT MEMORY
  ┌────────────────────────────────────────────┐
  │ READ: {PROJECT_PATH}/session_handoff.md    │
  │ READ: {PROJECT_PATH}/active_task.md        │
  │ READ: {PROJECT_PATH}/project_config.md     │
  └────────────────────────────────────────────┘

STEP 4: CHECK FOR RESUMABLE TASK
  ┌────────────────────────────────────────────┐
  │ IF active_task.md shows IN_PROGRESS:       │
  │   → Load latest checkpoint                 │
  │   → Offer to resume                        │
  └────────────────────────────────────────────┘

STEP 5: ACKNOWLEDGE CONTEXT
  ┌────────────────────────────────────────────┐
  │ "Project: {PROJECT_ID}"                    │
  │ "Device: {DEVICE}"                         │
  │ "Last session: {summary}"                  │
  └────────────────────────────────────────────┘
```

---

## Session End Protocol v2.0

```
STEP 1: UPDATE PROJECT MEMORY (PROJECT SCOPE ONLY)
  ┌────────────────────────────────────────────┐
  │ WRITE: {PROJECT_PATH}/session_handoff.md   │
  │   - Date/time (SAST)                       │
  │   - Device used                            │
  │   - Key activities                         │
  │   - Pending items                          │
  │   - Next steps                             │
  └────────────────────────────────────────────┘

STEP 2: UPDATE TASK STATUS
  ┌────────────────────────────────────────────┐
  │ WRITE: {PROJECT_PATH}/active_task.md       │
  │   - IDLE / IN_PROGRESS / COMPLETED         │
  │   - Checkpoint reference if applicable     │
  └────────────────────────────────────────────┘

STEP 3: CACHE INTERMEDIATE RESULTS
  ┌────────────────────────────────────────────┐
  │ WRITE TO: {PROJECT_PATH}/cache/            │
  │   - checkpoints/                           │
  │   - intermediate/                          │
  └────────────────────────────────────────────┘
```

---

## File Formats v2.0

### project_config.md (Required)
```markdown
# Project Configuration

**Project ID:** {PROJECT_ID}
**Project Name:** {Display Name}
**Created:** {Date}
**Owner:** Frans Vermaak

## Scope
{Brief description of project scope}

## Related Personas
- {Persona IDs relevant to this project}

## Key Paths
| Resource | Path |
|----------|------|
| Working Directory | {path} |
| Output Directory | {path} |

## Active Protocols
- {List of protocols active for this project}
```

### session_handoff.md (Project-Scoped)
```markdown
# Session Handoff - {PROJECT_ID}
## Last Updated: {DD Month YYYY} | {HH:MM} SAST

---

## Current State: {Version/Status}

### This Session
{Activities completed}

### Previous Session
{Previous activities for context}

---

## Pending
- [ ] {Pending items}

## Next Steps
- {Recommended next actions}
```

### active_task.md (Project-Scoped)
```markdown
# Active Task - {PROJECT_ID}

## Status: {IDLE | IN_PROGRESS | COMPLETED}

## Task Details
**Task:** {Description}
**Started:** {DateTime}
**Checkpoint:** {checkpoint reference or "N/A"}

## Progress
{Progress notes}

## Resume Instructions
{How to continue if interrupted}
```

---

## Session Starter Template

For each project, use this in Claude Project custom instructions:

```markdown
You have MCP filesystem access. On session start:

1. DETECT DEVICE:
   - $env:USERPROFILE contains "Frans Vermaak" → LAPTOP
   - $env:USERPROFILE contains "User" → PC

2. LOAD PROJECT MEMORY:
   Project: {PROJECT_ID}
   Path: G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\{PROJECT_ID}\
   
   Read: session_handoff.md, active_task.md

3. APPLY SES-001 (Session Persistence):
   - Checkpoint every 3-5 tool operations
   - Cache large outputs to cache/intermediate/
   - Update active_task.md for complex tasks

4. IF active_task shows IN_PROGRESS:
   - Load latest checkpoint
   - Offer to resume

Frans Vermaak, CTGO at LarcAI. British English, concise professional.
MPD v5.0 | Skill Registry v2.4 | Memory Protocol v2.0
```

---

## Migration from v1.x

### Deprecated Paths (DO NOT USE)
| Old Path | New Path |
|----------|----------|
| `Shared/session_handoff.md` | `Projects/{ID}/session_handoff.md` |
| `Shared/active_task.md` | `Projects/{ID}/active_task.md` |
| `Shared/cache/checkpoints/` | `Projects/{ID}/cache/checkpoints/` |
| `Shared/tasks.md` | REMOVED (use active_task.md per project) |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| **2.0** | **28 January 2026** | **Project isolation, deprecated Shared session state, mandatory PROJECT_ID** |
| 1.1 | 15 January 2026 | Added caching system |
| 1.0 | 13 January 2026 | Initial protocol |

---

*Memory Protocol v2.0 | MEM-001 | Strict Project Isolation*
