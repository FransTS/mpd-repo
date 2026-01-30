# Global Protocols v3.5

## MANDATORY: Device Detection Protocol (DEV-001) - Execute FIRST

```
STEP 1: DETECT DEVICE (ALWAYS FIRST)
â”‚
â”œâ”€â–º Check Windows-MCP Available?
â”‚   â”œâ”€â”€ YES â†’ Run PowerShell detection:
â”‚   â”‚         $env:USERPROFILE contains "Frans Vermaak" â†’ LAPTOP
â”‚   â”‚         $env:USERPROFILE contains "User" â†’ PC
â”‚   â””â”€â”€ NO â†’ Check other indicators
â”‚
â”œâ”€â–º Check Filesystem MCP paths:
â”‚   â”œâ”€â”€ C:\Users\Frans Vermaak\ â†’ LAPTOP
â”‚   â”œâ”€â”€ C:\Users\User\ â†’ PC
â”‚   â””â”€â”€ Neither â†’ Check cloud tools
â”‚
â”œâ”€â–º Check Google Drive only?
â”‚   â”œâ”€â”€ YES + No MCP â†’ WEB (claude.ai)
â”‚   â””â”€â”€ NO tools â†’ MOBILE
```

### Device Matrix

| Device | User Path | Git Repo | Memory |
|--------|-----------|----------|--------|
| **PC** | `C:\Users\User\` | `C:\GitHub\MPD` | `Memory\PC\` |
| **LAPTOP** | `C:\Users\Frans Vermaak\` | `~\GitHub\MPD` | `Memory\Laptop\` |
| **WEB/MOBILE** | N/A | N/A | Read-only |

### Shared Resources (All Devices)

| Resource | Path |
|----------|------|
| **API Keys** | `G:\My Drive\Shared_Download\AI_Folder\config\.env` |
| **Shared Memory** | `G:\My Drive\Shared_Download\AI_Folder\Memory\Shared\` |
| **MPD Skills** | `G:\My Drive\Shared_Download\AI_Folder\` (via Google Drive sync) |

**Loading API Keys:** Use LAR-038 (env-loader) - keys sync across all devices.

---

## Version Protocol

```
Master Prompts: v5.4
Skill Registry: v2.8
Memory Protocol: v1.1
Global Protocols: v3.5
Session Persistence: v2.0
Context Compression: CTX-001
Parallel Orchestration: PR-023
```

---

## Session Start Checklist

```
EVERY SESSION - EXECUTE IN ORDER:
â”‚
â”œâ”€â”€ 1. DETECT DEVICE (DEV-001)
â”œâ”€â”€ 2. DETECT ENVIRONMENT (MCP availability)
â”œâ”€â”€ 3. CHECK MEMORY (MEM-001 v1.1)
â”‚   â””â”€â”€ Read Shared/session_handoff.md
â”‚   â””â”€â”€ Read Shared/tasks.md
â”‚   â””â”€â”€ Check device cache
â”œâ”€â”€ 4. CHECK ACTIVE TASK (SES-001) â† NEW
â”‚   â””â”€â”€ Read Shared/active_task.md
â”‚   â””â”€â”€ If in_progress, offer to resume
â”‚   â””â”€â”€ Load relevant checkpoints
â”œâ”€â”€ 5. VERIFY TIMESTAMP
â””â”€â”€ 6. PROCEED WITH TASK (with checkpointing)
```

---

## Session Persistence Protocol (SES-001) - CRITICAL

**PURPOSE:** Prevent work loss from context limits

### Auto-Checkpoint Triggers
```
CHECKPOINT AUTOMATICALLY:
â”œâ”€â”€ Every 3-5 tool calls
â”œâ”€â”€ After major milestone completed
â”œâ”€â”€ Before risky/complex operation
â”œâ”€â”€ On user command "checkpoint"
â”œâ”€â”€ When context pressure detected
â””â”€â”€ Before any batch processing step
```

### Context Compaction (Keep Context Lean)
```
ALWAYS:
â”œâ”€â”€ SAVE large outputs to cache/intermediate/
â”œâ”€â”€ KEEP only summaries in context
â”œâ”€â”€ REFERENCE files by path, not content
â”œâ”€â”€ AVOID keeping full file contents
â””â”€â”€ CHECKPOINT before complex operations
```

### Resume Protocol
```
USER: "resume" / "continue" / "pick up where we left off"
â”‚
â”œâ”€â”€ READ Shared/active_task.md
â”œâ”€â”€ LOAD latest checkpoint from cache/checkpoints/
â”œâ”€â”€ SUMMARISE state to user
â””â”€â”€ CONTINUE from last checkpoint position
```

### Cache Paths
```
Memory/Shared/cache/
â”œâ”€â”€ checkpoints/     # Task state saves
â”œâ”€â”€ intermediate/    # Large outputs cached
â”œâ”€â”€ context/         # Compacted context data
â”œâ”€â”€ research/        # Research findings
â””â”€â”€ templates/       # Reusable templates
```

### Active Task File
```
Memory/Shared/active_task.md
â”œâ”€â”€ Current task definition
â”œâ”€â”€ Progress tracking
â”œâ”€â”€ Next actions
â””â”€â”€ Resume instructions
```

---

## Session End Checklist

```
BEFORE SESSION ENDS:
â”‚
â”œâ”€â”€ 1. UPDATE MEMORY
â”‚   â””â”€â”€ Write Shared/session_handoff.md
â”‚   â””â”€â”€ Update Shared/tasks.md if changed
â”‚   â””â”€â”€ Log decisions to Shared/decisions.md
â”‚
â”œâ”€â”€ 2. CACHE IMPORTANT DATA
â”‚   â””â”€â”€ Research â†’ Shared/cache/research/
â”‚   â””â”€â”€ Templates â†’ Shared/cache/templates/
â”‚   â””â”€â”€ Temp data â†’ {device}/cache/temp/
â”‚
â””â”€â”€ 3. LOG SESSION
    â””â”€â”€ Append to Memory/{device}/session_log.md
```

---

## Integration Points

| Protocol | Integration |
|----------|-------------|
| MEM-001 v1.1 | Memory read/write, caching |
| LAR-024 | Memory Integration Skill |
| LAR-006 | Autonomous routing with device awareness |
| SEC-001 | Browser security (PC/Laptop only) |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **3.5** | **30 Jan 2026** | **Centralised .env for API keys, LAR-038, updated versions** |
| 3.4 | 15 Jan 2026 | Session Persistence Protocol (SES-001) |
| 3.3 | 15 Jan 2026 | Memory integration, LAR-024, session end checklist |
| 3.2 | 14 Jan 2026 | Device Detection Protocol |
| 3.1 | 12 Jan 2026 | Browser Security Protocol |

---

*Frans Global Protocols v3.5 | Compatible with Master Prompts v5.4*
