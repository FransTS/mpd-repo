# Frans Cross-Platform Guide v2.0

| Field | Value |
|-------|-------|
| **Version** | 2.0 |
| **Last Updated** | 09 January 2026 \| SAST (UTC+2) |
| **Compatible With** | Master Prompts v4.8, Skill Registry v1.9 |

---

## Overview

Enable Frans personas to work consistently across all environments:

- **MCP Desktop** - Full local capabilities (Windows with MCP servers)
- **Claude Computer-Use** - Container-based file creation
- **Claude Web/Mobile** - Cloud-based with Drive integration
- **GPT-4 / ChatGPT** - Custom GPT and API
- **Gemini** - Gems and API
- **Other LLMs** - Llama, Mistral, etc.

---

## Environment Hierarchy

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚ TIER 1: MCP DESKTOP (Full Capabilities)                     â”‚
â”‚ â”œâ”€â”€ Local file read/write/search                            â”‚
â”‚ â”œâ”€â”€ Desktop automation (apps, browser, GUI)                 â”‚
â”‚ â”œâ”€â”€ PDF manipulation                                        â”‚
â”‚ â”œâ”€â”€ Direct save to user's directories                       â”‚
â”‚ â””â”€â”€ All cloud capabilities below                            â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚ TIER 2: CLAUDE COMPUTER-USE (Container)                     â”‚
â”‚ â”œâ”€â”€ Container file system (/home/claude, /mnt/)             â”‚
â”‚ â”œâ”€â”€ Bash commands, code execution                           â”‚
â”‚ â”œâ”€â”€ File creation with download links                       â”‚
â”‚ â”œâ”€â”€ Web search and fetch                                    â”‚
â”‚ â””â”€â”€ Skills from /mnt/skills/                                â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚ TIER 3: CLAUDE WEB/MOBILE (Cloud)                           â”‚
â”‚ â”œâ”€â”€ Google Drive integration                                â”‚
â”‚ â”œâ”€â”€ Web search                                              â”‚
â”‚ â”œâ”€â”€ Conversation memory                                     â”‚
â”‚ â””â”€â”€ Skills from Drive (Google Docs only)                    â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚ TIER 4: OTHER PLATFORMS (Variable)                          â”‚
â”‚ â”œâ”€â”€ GPT-4: Custom GPT with Knowledge files                  â”‚
â”‚ â”œâ”€â”€ Gemini: Gems with attachments                           â”‚
â”‚ â””â”€â”€ Others: User paste for context                          â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

---

## MCP Desktop Setup (Tier 1)

### Requirements

- Windows 10/11
- Node.js v18+
- uv (Python package manager)
- Claude Desktop app

### Quick Setup

See **LAR-022 MCP Setup Guide** for detailed instructions.

```powershell
# 1. Install uv
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# 2. Create config
cd $env:APPDATA\Claude
notepad claude_desktop_config.json

# 3. Paste configuration (see LAR-022)
# 4. Restart Claude Desktop
```

### MCP Servers Available

| Server | Package | Capabilities |
|--------|---------|--------------|
| Filesystem | `@modelcontextprotocol/server-filesystem` | File read/write/search |
| Windows-MCP | `windows-mcp` (uvx) | Desktop automation |
| PDF Tools | `@anthropic/mcp-server-pdf` | PDF manipulation |
| Context7 | `@upstash/context7-mcp` | Library documentation |

### MCP Desktop Capabilities

| Capability | Method |
|------------|--------|
| Read local files | `Filesystem:read_file` |
| Write files | `Filesystem:write_file` |
| Search files | `Filesystem:search_files` |
| Launch apps | `Windows-MCP:App-Tool` |
| Browser control | `Windows-MCP:Click-Tool`, `Type-Tool` |
| Screen state | `Windows-MCP:State-Tool` |
| Fill PDFs | `PDF Tools:fill_pdf` |
| Read PDFs | `PDF Tools:read_pdf_content` |

---

## Claude Computer-Use Setup (Tier 2)

### Automatic Activation

Computer-use mode activates automatically when:
- Using Claude.ai with "Computer use" enabled
- Container environment detected
- `/mnt/skills/` path accessible

### File Locations

| Purpose | Path |
|---------|------|
| Working directory | `/home/claude/` |
| User uploads | `/mnt/user-data/uploads/` |
| Final outputs | `/mnt/user-data/outputs/` |
| System skills | `/mnt/skills/public/` |
| Example skills | `/mnt/skills/examples/` |

### Output Workflow

```
1. Create files in /home/claude/
2. Move completed files to /mnt/user-data/outputs/
3. Use present_files tool to share with user
4. User receives download link
```

---

## Claude Web/Mobile Setup (Tier 3)

### Google Drive Integration

**CRITICAL:** Claude can ONLY read Google Docs format from Drive.

#### Supported
- âœ… Native Google Docs (created in Drive)
- âœ… Converted Google Docs (from .docx)

#### Not Supported
- âŒ `.docx` (Microsoft Word)
- âŒ `.md` (Markdown)
- âŒ `.txt` (Plain text)
- âŒ `.pdf` (PDF documents)

### Conversion Process

1. Download `.docx` from Claude
2. Upload to Google Drive
3. Right-click â†’ **Open with â†’ Google Docs**
4. Google creates a native Docs version
5. Claude can now read the file

### Skill Loading (Web/Mobile)

```
google_drive_search: name contains 'SKILL_[name]'
google_drive_fetch: [document_id]
```

---

## GPT-4 / ChatGPT Setup (Tier 4)

### Custom GPT Configuration

| Component | Setup Location |
|-----------|----------------|
| Global Protocols | Instructions field |
| Persona definition | Instructions field |
| Skills | Knowledge files (.docx) |

### Instructions Template

```
## Meta Information
This GPT uses XML-formatted instructions. Parse <persona>, <rules>, 
and <skills> tags to understand behaviour requirements.

## Global Protocols
[Paste from global-protocols.md]

## Active Persona
[Paste persona definition]

## Rules Syntax
+rule = must do
-rule = must not
key=value = setting
```

### Knowledge Files

- Upload `.docx` skill files directly
- GPT-4 reads .docx natively
- No conversion needed

---

## Gemini Setup (Tier 4)

### Gems Configuration

| Component | Setup Location |
|-----------|----------------|
| Instructions | Gem instructions field |
| Skills | File attachments |

### Format Preference

Gemini may prefer JSON over XML:

```json
{
  "persona": {
    "id": "001",
    "name": "Executive Strategic Advisor",
    "role": "Strategic analysis and advisory",
    "rules": {
      "must": ["executive-tone", "data-driven"],
      "must_not": ["casual-language"]
    }
  }
}
```

### File Support

- âœ… `.docx` works directly
- âœ… Google Docs native integration
- âœ… PDF support

---

## Platform Comparison Matrix

| Feature | MCP Desktop | Computer-Use | Web/Mobile | GPT-4 | Gemini |
|---------|-------------|--------------|------------|-------|--------|
| Local file access | âœ… Full | âŒ | âŒ | âŒ | âŒ |
| Container files | âŒ | âœ… Full | âŒ | âŒ | âŒ |
| Google Drive | âœ… | âœ… | âœ… Docs only | âŒ | âœ… |
| Desktop automation | âœ… | âŒ | âŒ | âŒ | âŒ |
| Browser control | âœ… | âŒ | âŒ | âŒ | âŒ |
| PDF manipulation | âœ… MCP | âœ… Skills | âŒ | âŒ | âŒ |
| Web search | âœ… | âœ… | âœ… | âœ… | âœ… |
| Code execution | âœ… PowerShell | âœ… Bash | âŒ | âœ… | âœ… |
| .docx read | âœ… | âœ… | âŒ | âœ… | âœ… |
| .md read | âœ… | âœ… | âŒ | âš ï¸ | âš ï¸ |
| Native XML | âœ… | âœ… | âœ… | âš ï¸ Meta | âš ï¸ JSON |

---

## Skill Loading by Platform

| Platform | Primary Method | Format | Fallback |
|----------|----------------|--------|----------|
| MCP Desktop | `Filesystem:read_file` | .md, .txt, any | Drive, paste |
| Computer-Use | `view /mnt/skills/...` | SKILL.md | Drive, paste |
| Web/Mobile | `google_drive_fetch` | Google Docs | Paste |
| GPT-4 | Knowledge files | .docx | Paste |
| Gemini | Attachments | .docx, Docs | Paste |
| Other | User paste | Text | - |

---

## Fallback Behaviour

### When MCP Not Available

```
IF task requires local files:
â”œâ”€â”€ MCP available â†’ Use Filesystem MCP
â”œâ”€â”€ Drive available â†’ Search Google Drive
â””â”€â”€ Neither â†’ Request user paste or upload

IF task requires desktop automation:
â”œâ”€â”€ MCP available â†’ Use Windows-MCP
â””â”€â”€ Not available â†’ Provide step-by-step instructions

IF task requires PDF work:
â”œâ”€â”€ MCP available â†’ Use PDF Tools MCP
â”œâ”€â”€ Computer-use â†’ Use container PDF skills
â””â”€â”€ Neither â†’ Request upload, provide guidance
```

### Cross-Platform Persona Behaviour

Personas should adapt to available capabilities:

```xml
<mcp-capabilities>
  <preferred>filesystem,windows-mcp</preferred>
  <optional>pdf-tools</optional>
  <fallback>google-drive,user-paste</fallback>
</mcp-capabilities>
```

---

## Setup Checklist by Platform

### MCP Desktop (Frans's Laptop)

```
â˜ Node.js v18+ installed
â˜ uv installed
â˜ claude_desktop_config.json created
â˜ Filesystem paths configured
â˜ Windows-MCP configured
â˜ PDF Tools configured (optional)
â˜ Context7 configured (optional)
â˜ Claude Desktop restarted
â˜ All servers verified working
```

### New Windows Machine

```
â˜ Install Node.js
â˜ Install uv
â˜ Create claude_desktop_config.json
â˜ Configure paths for that machine
â˜ Restart Claude Desktop
â˜ Test filesystem access
â˜ Test Windows-MCP (if needed)
```

### Claude Web/Mobile Only

```
â˜ Google Drive connected
â˜ Skills converted to Google Docs format
â˜ Skills in AI_Folder/Skills/
â˜ Test skill loading via Drive
```

### GPT-4 Custom GPT

```
â˜ Instructions configured with meta block
â˜ Global protocols pasted
â˜ Persona definition pasted
â˜ .docx skill files uploaded as Knowledge
â˜ Code Interpreter enabled
```

---

## Troubleshooting

| Issue | Platform | Solution |
|-------|----------|----------|
| MCP server disconnected | Desktop | Restart Claude, check config |
| Cannot read Drive file | Web/Mobile | Convert to Google Docs |
| Skill not found | Any | Check filename, format |
| GPT ignores XML | GPT-4 | Add meta block explanation |
| Path access denied | Desktop | Add path to config, restart |
| uv not found | Desktop | Reinstall, restart PowerShell |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0 | 09 Jan 2026 | Added MCP Desktop tier, environment hierarchy, updated capabilities matrix |
| 1.2 | 04 Jan 2026 | File format requirements, conversion instructions |
| 1.1 | 04 Jan 2026 | Initial cross-platform guide |

---

*Frans Cross-Platform Guide v2.0 | Compatible with Master Prompts v4.8*
