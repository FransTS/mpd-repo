# CLAUDE.md - Frans Master Prompt Dictionary

## Project Context

This repository contains the Frans Master Prompt Dictionary (MPD) - a comprehensive framework for AI-assisted business operations featuring 15 specialised personas, modular skills, and token-efficient protocols.

**Owner:** Frans Vermaak (CTGO, LarcAI)  
**Version:** 4.9  
**Architecture:** Lean, dynamic tool discovery

---

## Tool Discovery (TDP-001)

Use MCP Launchpad (`mcpl`) for all tool operations. Do NOT embed tool definitions in prompts.

### Core Commands

```bash
# Find tools by capability
mcpl search "<what you need>"

# Get tool schema with usage example
mcpl inspect <server> <tool> --example

# Execute a tool
mcpl call <server> <tool> '{"param":"value"}'

# Verify all servers are running
mcpl verify

# Troubleshoot connection issues
mcpl session status
mcpl session stop
```

### Workflow

1. **Search first** - Always use `mcpl search` before assuming a tool exists
2. **Inspect if complex** - Use `--example` flag for unfamiliar tools
3. **Execute** - Use `mcpl call` with proper JSON parameters
4. **Recover** - On failure, run `mcpl verify` then retry

---

## Repository Structure

```
Master_Prompt_Dictionary/
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ personas/           # 15 specialised AI personas (001-015)
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ skills/             # Modular skill definitions
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ protocols/          # Core protocols (TDP-001, MEM-001, SES-001)
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ reference/          # Templates and architecture docs
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ config/             # mcp.json and environment configs
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ GDocs_Export/       # Consolidated exports
```

---

## Key Protocols

| Protocol | Purpose |
|----------|---------|
| **TDP-001** | Tool Discovery via mcpl |
| **MEM-001** | Memory structure and persistence |
| **SES-001** | Session handoff between contexts |

---

## Development Guidelines

1. **Token efficiency** - No embedded tool definitions; use TDP-001
2. **Reference, don't embed** - Link to protocols/skills
3. **Version control** - Update timestamps on all changes
4. **Cross-platform** - Test on PC, Laptop, and Claude Code

---

## Quick Reference

### Persona Activation

Say the activation phrase to engage a persona:
- "Strategic Advisor" Ã¢â€ â€™ 001
- "Executive Assistant" Ã¢â€ â€™ 002
- "Prompt Engineer" Ã¢â€ â€™ 012
- "Transcript Specialist" Ã¢â€ â€™ 015

### Memory Location

```
G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\MPD_Development\
```

### Session Commands

- `"checkpoint"` Ã¢â€ â€™ Save current state
- `"what's pending?"` Ã¢â€ â€™ Check active tasks
- `"end session"` Ã¢â€ â€™ Generate handoff document

---

*Frans MPD v4.9 | Dynamic Tool Discovery Architecture*
