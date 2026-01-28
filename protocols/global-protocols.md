# Global Protocols v3.5

## CRITICAL: Memory Protocol v2.0 - Project Isolation (MANDATORY)

```
⚠️ ALL SESSIONS MUST FOLLOW THESE RULES:

1. EVERY SESSION OPERATES WITHIN A PROJECT SCOPE
   - Project ID must be identified at session start
   - Memory path: Memory/Projects/{PROJECT_ID}/

2. NEVER ACCESS OTHER PROJECT MEMORY
   - Only read/write to YOUR project folder
   - Memory/Shared/ is DEPRECATED for session state

3. PROJECT MEMORY STRUCTURE
   Memory/Projects/{PROJECT_ID}/
   ├── session_handoff.md    ← Session state (THIS PROJECT ONLY)
   ├── active_task.md        ← Task tracking (THIS PROJECT ONLY)
   ├── project_config.md     ← Project settings
   └── cache/
       ├── checkpoints/      ← Task checkpoints
       └── intermediate/     ← Large output cache
```

---

## MANDATORY: Device Detection Protocol (DEV-001) - Execute FIRST

```
STEP 1: DETECT DEVICE (ALWAYS FIRST)
│
├─► Check Windows-MCP Available?
│   ├── YES → Run PowerShell detection:
│   │         $env:USERPROFILE contains "Frans Vermaak" → LAPTOP
│   │         $env:USERPROFILE contains "User" → PC
│   └── NO → Check other indicators
│
├─► Check Filesystem MCP paths:
│   ├── C:\Users\Frans Vermaak\ → LAPTOP
│   ├── C:\Users\User\ → PC
│   └── Neither → Check cloud tools
│
├─► Check Google Drive only?
│   ├── YES + No MCP → WEB (claude.ai)
│   └── NO tools → MOBILE
```

### Device Matrix

| Device | User Path | Git Repo | Memory Base |
|--------|-----------|----------|-------------|
| **PC** | `C:\Users\User\` | `C:\GitHub\MPD` | `Memory/Projects/{ID}/` |
| **LAPTOP** | `C:\Users\Frans Vermaak\` | `C:\GitHub\MPD` | `Memory/Projects/{ID}/` |
| **WEB/MOBILE** | N/A | N/A | Read-only |

---

## Version Protocol

```
Master Prompts: v5.3
Skill Registry: v2.7
Memory Protocol: v2.0 (Project Isolation)
Global Protocols: v3.5
Session Persistence: v1.1
```

---

## Session Start Checklist

```
EVERY SESSION - EXECUTE IN ORDER:
│
├── 1. IDENTIFY PROJECT SCOPE (MANDATORY FIRST)
│   └── Get PROJECT_ID from session starter or ask user
│   └── Set PROJECT_PATH = Memory/Projects/{PROJECT_ID}/
│
├── 2. DETECT DEVICE (DEV-001)
│
├── 3. DETECT ENVIRONMENT (MCP availability)
│
├── 4. CHECK PROJECT MEMORY (MEM-001 v2.0)
│   └── Read {PROJECT_PATH}/session_handoff.md
│   └── Read {PROJECT_PATH}/active_task.md
│   └── Read {PROJECT_PATH}/project_config.md
│   ⚠️ NEVER read Memory/Shared/ for session state
│
├── 5. CHECK ACTIVE TASK (SES-001)
│   └── If in_progress, offer to resume
│   └── Load checkpoints from {PROJECT_PATH}/cache/checkpoints/
│
├── 6. VERIFY TIMESTAMP
│
└── 7. PROCEED WITH TASK (with checkpointing to PROJECT_PATH)
```

---

## Session Persistence Protocol (SES-001 v1.1) - CRITICAL

**PURPOSE:** Prevent work loss from context limits with project isolation

### Auto-Checkpoint Triggers
```
CHECKPOINT AUTOMATICALLY TO {PROJECT_PATH}/cache/:
├── Every 3-5 tool calls
├── After major milestone completed
├── Before risky/complex operation
├── On user command "checkpoint"
├── When context pressure detected
└── Before any batch processing step
```

### Context Compaction (Keep Context Lean)
```
ALWAYS:
├── SAVE large outputs to {PROJECT_PATH}/cache/intermediate/
├── KEEP only summaries in context
├── REFERENCE files by path, not content
├── AVOID keeping full file contents
└── CHECKPOINT before complex operations
```

### Resume Protocol
```
USER: "resume" / "continue" / "pick up where we left off"
│
├── READ {PROJECT_PATH}/active_task.md
├── LOAD latest checkpoint from {PROJECT_PATH}/cache/checkpoints/
├── SUMMARISE state to user
└── CONTINUE from last checkpoint position
```

### Project-Isolated Cache Paths
```
Memory/Projects/{PROJECT_ID}/cache/
├── checkpoints/     # Task state saves
├── intermediate/    # Large outputs cached
└── (optional subdirectories as needed)
```

---

## Session End Checklist

```
BEFORE SESSION ENDS - WRITE TO PROJECT ONLY:
│
├── 1. UPDATE PROJECT MEMORY
│   └── Write {PROJECT_PATH}/session_handoff.md
│   └── Update {PROJECT_PATH}/active_task.md
│   ⚠️ NEVER write to Memory/Shared/ or other projects
│
├── 2. CACHE IMPORTANT DATA TO PROJECT
│   └── Checkpoints → {PROJECT_PATH}/cache/checkpoints/
│   └── Outputs → {PROJECT_PATH}/cache/intermediate/
│
└── 3. LOG SESSION (OPTIONAL)
    └── Append to Memory/{device}/session_log.md (device log only)
```

---

## Project Isolation Rules Summary

| Rule | Description |
|------|-------------|
| **1. Project Scope** | Every session must identify PROJECT_ID first |
| **2. Isolated Paths** | All session state in `Memory/Projects/{ID}/` |
| **3. No Cross-Access** | Never read/write other project folders |
| **4. Shared Deprecated** | `Memory/Shared/` not used for session state |
| **5. Device Logs OK** | Device session logs are the only cross-project writes |

---

## Integration Points

| Protocol | Integration |
|----------|-------------|
| MEM-001 v2.0 | Project-isolated memory read/write |
| LAR-024 | Memory Integration Skill (updated for v2.0) |
| LAR-006 v1.2 | Autonomous routing with RLM detection |
| SES-001 v1.1 | Session persistence with project isolation |
| SEC-001 | Browser security (PC/Laptop only) |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **3.5** | **28 Jan 2026** | **Memory Protocol v2.0 integration, project isolation, updated all checklists** |
| 3.4 | 15 Jan 2026 | Session Persistence Protocol (SES-001) |
| 3.3 | 15 Jan 2026 | Memory integration, LAR-024 |
| 3.2 | 14 Jan 2026 | Device Detection Protocol |
| 3.1 | 12 Jan 2026 | Browser Security Protocol |

---

*Frans Global Protocols v3.5 | Memory Protocol v2.0 | Project Isolation Active*
