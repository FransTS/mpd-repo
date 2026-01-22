# Claude Local Memory Protocol v1.1

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MEM-001 |
| **Version** | 1.1 |
| **Created** | 13 January 2026 |
| **Updated** | 15 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v4.8.5, Skill Registry v2.2 |

---

## Purpose

Provide persistent memory across Claude sessions using local filesystem storage via Google Drive sync.

---

## Folder Structure

```
G:\My Drive\Shared_Download\AI_Folder\Memory\
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ MEMORY_PROTOCOL.md          # This file
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Shared/                     # Cross-device shared memory
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ context.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ decisions.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ tasks.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_handoff.md
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ cache/
Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ research/
Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ templates/
Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ references/
Ã¢â€â€š       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ projects/
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ PC/
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_log.md
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ cache/temp/
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Laptop/
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_log.md
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ cache/temp/
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Mobile/
    Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ notes.md
```

---

## Session Protocols

### Session Start
```
1. DETECT device (PC/Laptop/Mobile)
2. READ Shared/session_handoff.md
3. READ Shared/tasks.md
4. READ device-specific session_log.md
5. CHECK cache for relevant data
```

### Session End
```
1. UPDATE Shared/session_handoff.md
2. UPDATE Shared/tasks.md if changed
3. UPDATE Shared/decisions.md if decisions made
4. CACHE important intermediate results
5. APPEND to device session_log.md
```

---

## Caching System

| Scope | Location | Purpose |
|-------|----------|---------|
| **Shared** | `Memory/Shared/cache/` | Cross-device |
| **Device** | `Memory/[PC|Laptop]/cache/` | Device-specific |
| **Temp** | `Memory/[PC|Laptop]/cache/temp/` | Session temporary |

---

## Device Detection

| Indicator | Device |
|-----------|--------|
| Filesystem MCP with `C:\Users\User\` | PC |
| Filesystem MCP with `C:\Users\FransVermaak\` | Laptop |
| Google Drive only (no MCP) | Mobile/Web |

---

## Integration

- **LAR-024**: Memory Integration Skill (implementation)
- **Global Protocols v3.3**: Session start/end checklist
- **All Personas**: Auto-load on PC/Laptop

---

*Frans Memory Protocol v1.1 | MEM-001*
