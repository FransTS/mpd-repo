# Claude Local Memory Protocol v1.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MEM-001 |
| **Version** | 1.0 |
| **Created** | 13 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v4.8 |

---

## Purpose

Provide persistent memory across Claude sessions using local filesystem storage via Google Drive sync. Enables continuity of context, decisions, and project state across devices and sessions.

---

## Folder Structure

```
G:\My Drive\Shared_Download\AI_Folder\Memory\
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ MEMORY_PROTOCOL.md      # Protocol reference
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Shared/                 # Cross-device shared memory
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ context.md          # Current project context
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ decisions.md        # Key decisions log
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ tasks.md            # Active tasks and status
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ session_handoff.md  # Last session summary for continuity
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ PC/                     # PC-specific memory
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_log.md      # Session history
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ local_state.md      # PC-specific state
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Laptop/                 # Laptop-specific memory
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_log.md      # Session history
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ local_state.md      # Laptop-specific state
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Mobile/                 # Mobile-specific memory
    Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ notes.md            # Mobile session notes
```

---

## Session Start Protocol

At the START of each session, Claude should:

```
1. DETECT device (PC/Laptop/Mobile based on MCP availability and paths)
2. READ Shared/session_handoff.md for last session context
3. READ Shared/tasks.md for active tasks
4. READ device-specific session_log.md for local history
5. ACKNOWLEDGE context naturally (don't announce "reading memory")
```

---

## Session End Protocol

At the END of each session (or before context limit), Claude should:

```
1. UPDATE Shared/session_handoff.md with:
   - Date/time
   - Device used
   - Key activities completed
   - Pending items
   - Next steps

2. UPDATE device-specific session_log.md with session details

3. UPDATE Shared/tasks.md if tasks changed

4. UPDATE Shared/decisions.md if key decisions were made
```

---

## Device Detection

| Indicator | Device |
|-----------|--------|
| `C:\Users\User\` paths + Filesystem MCP | PC |
| `C:\Users\FransVermaak\` paths + Filesystem MCP | Laptop |
| Google Drive only (no Filesystem MCP) | Mobile |

---

## Memory Update Triggers

Claude should UPDATE memory when:

1. **Session ending** - Always write handoff
2. **Key decision made** - Log to decisions.md
3. **Task status changes** - Update tasks.md
4. **Context compaction imminent** - Emergency handoff
5. **User requests** - "Save this to memory"

---

## Memory Read Triggers

Claude should READ memory when:

1. **Session starts** - Always check handoff
2. **User references past work** - Check relevant files
3. **Continuity needed** - "What were we working on?"
4. **Task follow-up** - Check tasks.md

---

## Integration

| Protocol | Integration |
|----------|-------------|
| Global Protocols | Memory check at session start |
| Autonomous Protocols | Context from memory for routing |
| MCP Integration | Filesystem MCP for read/write |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 13 January 2026 | Initial Memory Protocol |

---

*Frans Memory Protocol v1.0 | Compatible with Master Prompts v4.8*
