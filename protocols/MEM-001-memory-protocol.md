# Memory Protocol v2.0 (MEM-001)

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MEM-001 |
| **Version** | 2.0 |
| **Created** | 13 January 2026 |
| **Updated** | 28 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v5.3+, Skill Registry v2.7+ |

---

## Purpose

Provide persistent memory across Claude sessions using local filesystem storage via Google Drive sync. **Version 2.0 introduces strict project isolation** to prevent cross-contamination between different projects.

---

## CRITICAL: Project Isolation Rules

### Rule 1: Every Session Has a Project Scope
- Each Claude chat operates within a specific **PROJECT_ID**
- Project memory is isolated in `Memory/Projects/{PROJECT_ID}/`
- NEVER read/write session state from `Memory/Shared/` (deprecated)

### Rule 2: Project Detection (Mandatory First Step)
```
1. CHECK session starter for PROJECT_ID
2. IF explicitly stated → Use that PROJECT_ID
3. IF not stated → Ask user: "Which project is this session for?"
4. VERIFY project folder exists
5. IF missing → Create from _Template
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

---

## Folder Structure v2.0

```
Memory/
├── MEMORY_PROTOCOL.md
├── _Global/
│   ├── project_index.md
│   └── session_starter_prompt.md
├── Projects/
│   ├── _Template/
│   ├── MPD_Development/
│   ├── Mascom_RFP/
│   ├── Transcription_Jobs/
│   └── [Other Projects]/
├── PC/
├── Laptop/
└── Shared/  ← DEPRECATED
```

---

## Session Start Protocol

```
1. IDENTIFY PROJECT SCOPE → PROJECT_ID
2. SET PROJECT_PATH = Memory/Projects/{PROJECT_ID}/
3. READ {PROJECT_PATH}/session_handoff.md
4. READ {PROJECT_PATH}/active_task.md
5. CHECK for resumable task
6. ACKNOWLEDGE context
```

---

## Session End Protocol

```
1. WRITE {PROJECT_PATH}/session_handoff.md
2. WRITE {PROJECT_PATH}/active_task.md
3. SAVE checkpoints to {PROJECT_PATH}/cache/
4. OPTIONAL: Append device log
```

---

## Migration from v1.x

| Old Path | New Path |
|----------|----------|
| `Shared/session_handoff.md` | `Projects/{ID}/session_handoff.md` |
| `Shared/active_task.md` | `Projects/{ID}/active_task.md` |
| `Shared/cache/` | `Projects/{ID}/cache/` |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **2.0** | **28 Jan 2026** | **Project isolation, deprecated Shared** |
| 1.1 | 15 Jan 2026 | Caching system |
| 1.0 | 13 Jan 2026 | Initial |

---

*Memory Protocol v2.0 | MEM-001 | Strict Project Isolation*
