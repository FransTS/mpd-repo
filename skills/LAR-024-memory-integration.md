# LAR-024: Memory Integration Skill

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | LAR-024 |
| **Name** | Memory Integration |
| **Version** | 1.0 |
| **Created** | 15 January 2026 |
| **Tier** | 1 (Core - Always Available) |
| **Trigger** | Automatic on PC/Laptop |

---

## Purpose

Provide persistent local memory capabilities for all personas and skills when operating on PC or Laptop. Enables storage, caching, and retrieval of session data, decisions, research, and context across Claude sessions.

---

## Memory Location

```
G:\My Drive\Shared_Download\AI_Folder\Memory\
â”œâ”€â”€ Shared/                     # Cross-device (syncs via Google Drive)
â”‚   â”œâ”€â”€ context.md              # Current project context
â”‚   â”œâ”€â”€ decisions.md            # Key decisions log
â”‚   â”œâ”€â”€ tasks.md                # Active tasks tracker
â”‚   â”œâ”€â”€ session_handoff.md      # Last session summary
â”‚   â””â”€â”€ cache/                  # Shared cache folder
â”‚       â”œâ”€â”€ research/           # Research findings
â”‚       â”œâ”€â”€ templates/          # Reusable templates
â”‚       â”œâ”€â”€ references/         # Reference data
â”‚       â””â”€â”€ projects/           # Project-specific data
â”‚
â”œâ”€â”€ PC/                         # PC-specific storage
â”‚   â”œâ”€â”€ session_log.md          # PC session history
â”‚   â””â”€â”€ cache/temp/             # PC temporary cache
â”‚
â”œâ”€â”€ Laptop/                     # Laptop-specific storage
â”‚   â”œâ”€â”€ session_log.md          # Laptop session history
â”‚   â””â”€â”€ cache/temp/             # Laptop temporary cache
â”‚
â””â”€â”€ Mobile/                     # Mobile notes (limited)
    â””â”€â”€ notes.md
```

---

## Memory Operations

### STORE Operation
```
STORE(key, content, scope):
â”œâ”€â”€ scope = "shared" â†’ Memory/Shared/cache/[category]/[key].md
â”œâ”€â”€ scope = "device" â†’ Memory/[PC|Laptop]/cache/[key].md
â””â”€â”€ scope = "session" â†’ Memory/[PC|Laptop]/cache/temp/[key].md
```

### RETRIEVE Operation
```
RETRIEVE(key, scope):
â”œâ”€â”€ Check device-specific cache first
â”œâ”€â”€ Then check shared cache
â””â”€â”€ Return content or null if not found
```

### CACHE Operation
```
CACHE(key, content, ttl):
â”œâ”€â”€ TTL options: session, day, week, permanent
â””â”€â”€ Auto-cleanup based on TTL
```

---

## Memory Commands

| Command | Action |
|---------|--------|
| "Save this to memory" | Store current output |
| "Remember this" | Store key information |
| "What do you remember about X?" | Retrieve from memory |
| "Clear cache" | Clean up temporary storage |
| "Show memory status" | List stored items |

---

## Session Actions

### At Session Start
```
1. Read Shared/session_handoff.md
2. Read Shared/tasks.md
3. Read device-specific session_log.md
4. Load relevant cached data
```

### At Session End
```
1. Update Shared/session_handoff.md
2. Update Shared/tasks.md if changed
3. Update Shared/decisions.md if decisions made
4. Append to device session_log.md
```

---

## Device-Specific Behaviour

| Environment | Memory Access |
|-------------|---------------|
| PC/Laptop (MCP) | Full read/write via Filesystem MCP |
| Mobile/Web | Read-only via Google Docs |

---

## Integration

| Protocol | Memory Integration |
|----------|-------------------|
| DEV-001 | Detect device â†’ use correct memory path |
| MEM-001 | Core memory protocol |
| Global v3.3 | Session start/end memory checks |

---

*Frans Memory Integration Skill v1.0 | Tier 1 Core Skill*
