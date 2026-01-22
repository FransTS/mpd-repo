# TDP-001: Tool Discovery Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | TDP-001 |
| **Version** | 1.0 |
| **Created** | 16 January 2026 \| SAST (UTC+2) |
| **Replaces** | MCP-001 (mcp-integration-protocol.md) |
| **Purpose** | Dynamic tool discovery via MCP Launchpad |

---

## Overview

Use `mcpl` (MCP Launchpad) for all tool discovery and execution. This eliminates the need to embed tool definitions, server inventories, or detection logic in prompts.

**Token savings:** ~5,000 tokens across MPD

---

## Core Commands

```bash
# Find tools (always search first)
mcpl search "<capability>"

# Get tool schema with example
mcpl inspect <server> <tool> --example

# Execute tool
mcpl call <server> <tool> '{"param":"value"}'

# Verify all servers
mcpl verify

# Troubleshoot
mcpl session status
mcpl session stop
```

---

## Workflow

```
TASK REQUIRES TOOL
       â”‚
       â–¼
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚ mcpl search      â”‚ â† Always search first
â”‚ "<capability>"   â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
         â”‚
         â–¼
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚ mcpl inspect     â”‚ â† Get schema if complex
â”‚ --example        â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
         â”‚
         â–¼
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚ mcpl call        â”‚ â† Execute
â”‚ <server> <tool>  â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
         â”‚
    â”Œâ”€â”€â”€â”€â”´â”€â”€â”€â”€â”
    â”‚ Success â”‚â”€â”€â–º Continue
    â””â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”˜
         â”‚ Failure
         â–¼
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚ mcpl verify      â”‚ â† Troubleshoot
â”‚ mcpl session stopâ”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

---

## Device Compatibility

| Device | mcpl Available | Action |
|--------|----------------|--------|
| PC | âœ… Yes | Full dynamic discovery |
| Laptop | âœ… Yes | Full dynamic discovery |
| Claude Code | âœ… Yes | Full dynamic discovery |
| Web (computer use) | âš ï¸ Partial | Works via bash_tool |
| Mobile | âŒ No | Inform user of limitation |

**Graceful degradation:** If mcpl unavailable, inform user:
> "Extended tool discovery requires desktop or Claude Code. I can assist with guidance, but cannot execute MCP tools directly."

---

## Error Recovery

| Error | Solution |
|-------|----------|
| Tool not found | `mcpl search` with different terms |
| Missing parameters | `mcpl inspect --example` |
| Server disconnected | `mcpl session stop` then retry |
| Timeout | `MCPL_CONNECTION_TIMEOUT=120` |

---

## Integration

**In Personas:** Replace all MCP/tool sections with:

```markdown
## Tool Access
Apply TDP-001 for all tool operations.
```

**In Skills:** Remove embedded tool references. Use mcpl at runtime.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 16 Jan 2026 | Initial release, replaces MCP-001 |

---

*Frans Tool Discovery Protocol v1.0 | ~100 tokens*
