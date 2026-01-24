# Frans Master Prompt Dictionary

**Version:** 4.8.1
**Document ID:** LARC-PROMPT-MASTER-2026-004
**Last Updated:** 10 January 2026 | SAST (UTC+2)
**Owner:** Frans Vermaak (CTGO, LarcAI)
**Format:** Optimised XML with MCP Integration

---

## What's New in v4.8

- **MCP Integration Protocol** - Environment detection and capability-aware behaviour
- **LAR-022 MCP Setup Guide** - Step-by-step MCP server configuration
- **Environment-Aware Personas** - Adapted workflows based on available capabilities
- **Fallback Chains** - Graceful degradation from MCP Ã¢â€ â€™ Container Ã¢â€ â€™ Cloud Ã¢â€ â€™ Minimal
- **Updated Cross-Platform Guide** - MCP Desktop as Tier 1 platform

---

## Architecture Overview

```
PROJECT INSTRUCTIONS (set once per project):
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Global Protocols (timestamp, version, skill loader, MCP detection)
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ MCP Integration Protocol (environment detection, capabilities)
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Autonomous Protocols (routing, self-assessment, escalate)
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ User Context (owner, timezone, preferences)
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Output Standards (language, format, accuracy)

PERSONA PROMPT (lean, ~200 tokens):
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Identity + Mission
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Persona-specific rules
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Skill references
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ MCP Capabilities (preferred, optional, fallback)
```

## Environment Hierarchy

```
Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â
Ã¢â€â€š TIER 1: MCP DESKTOP (Full Capabilities)                     Ã¢â€â€š
Ã¢â€â€š Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Local files, desktop automation, PDF tools, browser     Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â¤
Ã¢â€â€š TIER 2: CLAUDE COMPUTER-USE (Container)                     Ã¢â€â€š
Ã¢â€â€š Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Container filesystem, bash, code execution              Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â¤
Ã¢â€â€š TIER 3: CLAUDE WEB/MOBILE (Cloud)                           Ã¢â€â€š
Ã¢â€â€š Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Google Drive (Docs only), web search                    Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â¤
Ã¢â€â€š TIER 4: OTHER PLATFORMS (Variable)                          Ã¢â€â€š
Ã¢â€â€š Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ GPT-4, Gemini, others                                   Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ
```

## Repository Structure

```
Master_Prompt_Dictionary/
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ README.md                 # This file
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ PROJECT_INSTRUCTIONS.md   # Complete project setup template
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ protocols/
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ global-protocols.md   # v3.0 with MCP detection
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ mcp-integration-protocol.md  # NEW: Environment capabilities
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ autonomous-protocols.md # Routing, self-assessment, escalation
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ user-context.md       # Frans-specific defaults
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ qa-protocol.md        # Stop hooks and QA framework
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ governance-protocol.md
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ human-authenticity-protocol.md
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ personas/
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 001-executive-strategic-advisor.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 002-executive-assistant.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 003-market-research-specialist.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 004-sales-enablement.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 005-document-creator.md      # MCP-enhanced
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 006-technical-writer.md      # MCP-enhanced
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 007-marketing-advisor.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 008-legal-expert.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 009-software-architect.md    # MCP-enhanced
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 010-the-architect.md         # MCP-enhanced (environment detection)
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 011-elite-endurance-coach.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 012-advanced-prompt-engineer.md
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 013-authenticity-reviewer.md
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ 014-sage-intacct-support-specialist.md  # NEW: Sage Intacct ERP support
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ skills/
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ SKILL_REGISTRY.md     # v1.9 with 22 skills + MCP protocol
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ LAR-001 to LAR-021    # Individual skill files
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ LAR-022-mcp-setup-guide.md  # NEW: MCP configuration
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ workflows/
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ COMPOSITE_WORKFLOWS.md # Multi-persona workflow templates
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ reference/
    Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ rules-syntax.md       # Syntax guide
    Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ cross-platform-guide.md # v2.0 with MCP tier
```

---

## Rules Syntax Guide

| Syntax | Meaning | Example |
|--------|---------|---------|
| `+rule` | Requirement (must do) | `+code=complete,tested` |
| `-rule` | Prohibition (must not) | `-placeholders` |
| `key=value` | Attribute setting | `tone=professional` |
| `a,b,c` | Multiple values (AND) | `format=md,mermaid` |

## Persona Quick Reference

| ID | Name | Activation | MCP Enhancement |
|----|------|------------|-----------------|
| 001 | Executive Strategic Advisor | Strategic Advisor | Web + Drive |
| 002 | Executive Assistant | Executive Assistant | Drive access |
| 003 | Market Research Specialist | Market Research | Web search + output |
| 004 | Sales Enablement | Sales Enablement | Direct file save |
| 005 | Document Creator | Document Creator | **Filesystem, PDF Tools** |
| 006 | Technical Writer | Technical Writer | **Filesystem, Context7** |
| 007 | Marketing Advisor | Marketing Advisor | Theme application |
| 008 | Legal Expert | Legal Expert | **PDF form filling** |
| 009 | Software Architect | Software Architect | **Full MCP access** |
| 010 | The Architect | The Architect | **Environment detection** |
| 011 | Elite Endurance Coach | Endurance Coach | Spreadsheet output |
| 012 | Advanced Prompt Engineer | Prompt Engineer | Skill management |
| 013 | Authenticity Reviewer | Authenticity Reviewer | Document review |
| 014 | Sage Intacct Support | Sage Intacct Support | Web search, docs |

## Domain Ã¢â€ â€™ Persona Selection Matrix

| Domain | Persona |
|--------|---------|
| Strategic/Board-level | 001 Executive Strategic Advisor |
| Admin/Scheduling | 002 Executive Assistant |
| Market/Competitor | 003 Market Research |
| Sales/Revenue | 004 Sales Enablement |
| Documents/Reports | 005 Document Creator |
| Technical Docs | 006 Technical Writer |
| Brand/Campaigns | 007 Marketing Advisor |
| Contracts/Legal | 008 Legal Expert |
| Code/Architecture | 009 Software Architect |
| Meta/Routing/MCP | 010 The Architect |
| Fitness | 011 Endurance Coach |
| Prompts/AI | 012 Prompt Engineer |
| Content Review | 013 Authenticity Reviewer |
| Sage Intacct/ERP | 014 Sage Intacct Support |

---

## MCP Server Configuration (This Laptop)

### Available Servers

| Server | Purpose | Test Command |
|--------|---------|--------------|
| Filesystem | Local file access | `Filesystem:list_allowed_directories` |
| Windows-MCP | Desktop automation | `Windows-MCP:State-Tool` |
| PDF Tools | PDF manipulation | `PDF Tools:list_profiles` |
| Context7 | Library documentation | `Context7:resolve-library-id` |

### Config Location

`%APPDATA%\Claude\claude_desktop_config.json`

### Quick Troubleshooting

| Issue | Solution |
|-------|----------|
| "spawn uv ENOENT" | `irm https://astral.sh/uv/install.ps1 \| iex` |
| Server disconnected | Restart Claude Desktop |
| Path not accessible | Add to config, restart |
| MCP not configured | Say: "setup mcp" |

---

## Cross-Platform Compatibility

> See [`reference/cross-platform-guide.md`](reference/cross-platform-guide.md) for complete setup instructions.

| Platform | File Access | Automation | Notes |
|----------|-------------|------------|-------|
| **MCP Desktop** | Ã¢Å“â€¦ Local | Ã¢Å“â€¦ Full | Primary environment |
| **Computer-Use** | Ã¢Å“â€¦ Container | Ã¢ÂÅ’ | Cloud container |
| **Claude Web/Mobile** | Ã¢Å“â€¦ Drive (Docs) | Ã¢ÂÅ’ | Google Docs only |
| **GPT-4/ChatGPT** | Ã¢Å“â€¦ .docx | Ã¢ÂÅ’ | Add meta block |
| **Gemini** | Ã¢Å“â€¦ Multiple | Ã¢ÂÅ’ | May prefer JSON |

---

## Always-Active Skills

These skills apply automatically to ALL personas:

| ID | Skill | Function |
|----|-------|----------|
| MCP-001 | mcp-integration | Environment detection and adaptation |
| LAR-006 | autonomous-routing | Auto-select personas for tasks |
| LAR-007 | self-assessment | Quality check before delivery |
| LAR-008 | escalation-protocol | Ask vs. proceed decisions |
| LAR-013 | error-recovery | Handle failures gracefully |
| LAR-014 | context-management | Track session state |
| LAR-015 | output-formatting | Consistent formatting standards |

---

## New Machine Setup

When using Claude on a new Windows PC:

1. Say: **"setup mcp"** or **"configure mcp"**
2. Claude loads LAR-022 MCP Setup Guide
3. Follow step-by-step instructions (~5 minutes)
4. Restart Claude Desktop
5. Verify with: "test mcp servers"

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **4.8.1** | **10 Jan 2026** | **Persona 014: Sage Intacct Support Specialist** |
| 4.8 | 09 Jan 2026 | MCP Integration Protocol, LAR-022, environment-aware personas, cross-platform guide v2.0 |
| 4.7.3 | 09 Jan 2026 | Authenticity Reviewer persona, LAR-021 |
| 4.7.2 | 08 Jan 2026 | Governance Protocol, LAR-017 to LAR-020 |
| 4.7.1 | 06 Jan 2026 | Anti-patterns, stop hooks, composite workflows |
| 4.7 | 04 Jan 2026 | File format protocol, skill loader v2.0 |
| 4.6 | 04 Jan 2026 | Autonomous protocols, v1.3 registry |
| 4.5 | 04 Jan 2026 | XML optimisation, 40-50% token reduction |

---

*Frans Master Prompts v4.8 - MCP-Integrated, Environment-Aware*
