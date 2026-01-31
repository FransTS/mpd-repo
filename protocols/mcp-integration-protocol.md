# MCP Integration Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MCP-001 |
| **Version** | 1.1 |
| **Last Updated** | 30 January 2026 \| SAST (UTC+2) |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v5.4 |

---

## Purpose

Enable intelligent detection and utilisation of Model Context Protocol (MCP) servers when available, with graceful fallback for environments without MCP access (mobile, unconfigured PCs).

---

## Centralised API Keys

**Location:** `G:\My Drive\Shared_Download\AI_Folder\config\.env`

All API keys are stored centrally and sync across devices via Google Drive.

```bash
# Load keys when needed
TAVILY_API_KEY=tvly-xxx
CONTEXT7_API_KEY=xxx
GEMINI_API_KEY=xxx
OPENAI_API_KEY=sk-xxx
ANTHROPIC_API_KEY=sk-ant-xxx
```

**Loading keys:** See LAR-038 (env-loader) for methods.

---

## Environment Detection Protocol

**Execute at session start or when capabilities are unclear:**

```
ENVIRONMENT DETECTION (Priority Order):
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Step 1: Check MCP Servers
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Windows-MCP available?
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ Desktop automation, browser control, GUI interaction
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Filesystem MCP available?
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ Local file read/write/search
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ PDF Tools MCP available?
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ PDF analysis, form filling, extraction
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Context7 MCP available?
Ã¢â€â€š       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ Library documentation lookup
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Step 2: Check Claude Computer-Use
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ /mnt/skills/ accessible?
Ã¢â€â€š       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ Container mode with bash, file creation
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Step 3: Check Cloud Tools
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Google Drive tools available?
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ Drive search/fetch for skills and files
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Web search available?
Ã¢â€â€š       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ YES Ã¢â€ â€™ External research capability
Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€“Âº Step 4: Fallback
    Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ NONE of above Ã¢â€ â€™ Request user paste content
```

---

## MCP Server Inventory

### Currently Configured (Frans's Laptop)

| Server | Capabilities | Use Cases |
|--------|--------------|-----------|
| **Windows-MCP** | App launch, click, type, scroll, screenshot, PowerShell | Desktop automation, browser control, form filling |
| **Filesystem** | Read, write, edit, search, directory tree | Local file management, skill loading, output saving |
| **PDF Tools** | Read content, fill forms, extract data, validate | Contract review, form completion, document analysis |
| **Context7** | Library documentation lookup | Technical reference, API docs |

### Detection Commands

To verify MCP availability, attempt a simple operation:

| Server | Test Command |
|--------|--------------|
| Filesystem | `Filesystem:list_allowed_directories` |
| Windows-MCP | `Windows-MCP:State-Tool` (no vision) |
| PDF Tools | `PDF Tools:list_profiles` |
| Context7 | `Context7:resolve-library-id` with known library |

---

## Capability Matrix by Environment

| Capability | MCP Desktop | Computer-Use | Web/Mobile | Mobile Only |
|------------|-------------|--------------|------------|-------------|
| Local file access | Ã¢Å“â€¦ Filesystem MCP | Ã¢Å“â€¦ /home/claude | Ã¢ÂÅ’ | Ã¢ÂÅ’ |
| User's files | Ã¢Å“â€¦ Allowed dirs | Ã¢ÂÅ’ | Ã¢Å“â€¦ Drive only | Ã¢ÂÅ’ |
| Create documents | Ã¢Å“â€¦ Direct save | Ã¢Å“â€¦ /mnt/user-data/outputs | Ã¢Å“â€¦ Drive | Ã¢ÂÅ’ |
| Desktop automation | Ã¢Å“â€¦ Windows-MCP | Ã¢ÂÅ’ | Ã¢ÂÅ’ | Ã¢ÂÅ’ |
| Browser control | Ã¢Å“â€¦ Windows-MCP | Ã¢ÂÅ’ | Ã¢ÂÅ’ | Ã¢ÂÅ’ |
| PDF manipulation | Ã¢Å“â€¦ PDF Tools MCP | Ã¢Å“â€¦ Skills | Ã¢ÂÅ’ | Ã¢ÂÅ’ |
| Web search | Ã¢Å“â€¦ | Ã¢Å“â€¦ | Ã¢Å“â€¦ | Ã¢Å“â€¦ |
| Skill loading | Ã¢Å“â€¦ Local files | Ã¢Å“â€¦ /mnt/skills | Ã¢Å“â€¦ Drive (Docs) | Ã¢ÂÅ’ Paste |

---

## Skill Loading Priority (MCP-Aware)

```
SKILL LOADING ORDER:
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Priority 1: Local Filesystem (MCP)
Ã¢â€â€š   Path: User's allowed directories
Ã¢â€â€š   Format: .md files readable directly
Ã¢â€â€š   Command: Filesystem:read_file
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Priority 2: Claude Computer-Use Skills
Ã¢â€â€š   Path: /mnt/skills/public/ or /mnt/skills/examples/
Ã¢â€â€š   Format: SKILL.md files
Ã¢â€â€š   Command: view /mnt/skills/[path]/SKILL.md
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Priority 3: GitHub Repository (via Filesystem MCP)
Ã¢â€â€š   Path: G:\My Drive\Shared_Download\AI_Folder\GitHub\Master_Prompt_Dictionary
Ã¢â€â€š   Format: .md files
Ã¢â€â€š   Command: Filesystem:read_file
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€“Âº Priority 4: Google Drive (Web/Mobile)
Ã¢â€â€š   Path: AI_Folder/Skills/
Ã¢â€â€š   Format: Google Docs ONLY (not .docx)
Ã¢â€â€š   Command: google_drive_search Ã¢â€ â€™ google_drive_fetch
Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€“Âº Priority 5: User Paste
    Request: "Please paste the skill content"
    Acknowledge: "Skill loaded. Proceeding..."
```

---

## MCP-Enhanced Workflows

### Document Creation (MCP Desktop)

```
WITH Filesystem MCP:
1. Create document in memory
2. Save directly to user's preferred location
3. Open with Windows-MCP if requested
4. Verify file exists

WITHOUT MCP:
1. Create document
2. Provide download link
3. Instruct user on save location
```

### PDF Form Filling (MCP Desktop)

```
WITH PDF Tools MCP:
1. Read PDF fields: PDF Tools:read_pdf_fields
2. Display field names to user
3. Fill fields: PDF Tools:fill_pdf
4. Validate: PDF Tools:validate_pdf
5. Save to output location

WITHOUT MCP:
1. Request user upload PDF
2. Analyse visually if possible
3. Provide text content for manual entry
```

### Research with Browser (MCP Desktop)

```
WITH Windows-MCP:
1. Launch browser: Windows-MCP:App-Tool (launch)
2. Navigate: Windows-MCP:Type-Tool in address bar
3. Capture content: Windows-MCP:State-Tool
4. Extract information
5. Return to Claude or continue browsing

WITHOUT MCP:
1. Use web_search tool
2. Use web_fetch for full page content
3. Summarise findings
```

### File Organisation (MCP Desktop)

```
WITH Filesystem MCP:
1. List directory: Filesystem:list_directory
2. Search files: Filesystem:search_files
3. Read content: Filesystem:read_file
4. Move/rename: Filesystem:move_file
5. Create directories: Filesystem:create_directory

WITHOUT MCP:
1. Request user describe file locations
2. Provide instructions for manual organisation
```

---

## Fallback Chains

### When MCP Server Disconnects

```
IF Windows-MCP fails:
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Inform user of disconnection
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Suggest: Check system tray, restart Claude
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Offer: Continue with web-only capabilities
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Alternative: Provide step-by-step manual instructions

IF Filesystem MCP fails:
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Fall back to Google Drive if available
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Fall back to user paste
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Create files in Claude's container for download

IF PDF Tools MCP fails:
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Use Claude computer-use PDF skills if available
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Request user paste text content
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Provide manual form-filling guidance
```

---

## User Communication Templates

### MCP Available

```
"I have access to your local filesystem and can work directly with files 
in [allowed directories]. I can also control desktop applications if needed."
```

### MCP Partially Available

```
"I have access to [available capabilities] but not [unavailable]. 
For [task], I'll [fallback approach]."
```

### MCP Unavailable

```
"I'm running in [web/mobile] mode without local file access. 
I can work with your Google Drive files or you can paste content directly."
```

### Setup Prompt (New Machine)

```
"I notice MCP servers aren't configured on this machine. 
Would you like setup instructions? I have a guide for Windows machines 
that takes about 5-10 minutes."
```

---

## Integration with Personas

### Personas with Enhanced MCP Capabilities

| Persona | MCP Enhancements |
|---------|------------------|
| 005 Document Creator | Direct file save, template access, PDF conversion |
| 006 Technical Writer | Local file editing, PDF generation, multi-file projects |
| 008 Legal Expert | PDF form filling, contract file management |
| 009 Software Architect | Full filesystem access, code file management, browser testing |
| 010 The Architect | Environment detection, capability routing, MCP diagnostics |

### MCP Capability Declaration

Add to persona definitions:

```xml
<mcp-capabilities>
  <requires>filesystem</requires>
  <optional>windows-mcp,pdf-tools</optional>
  <fallback>google-drive,user-paste</fallback>
</mcp-capabilities>
```

---

## Troubleshooting Quick Reference

| Symptom | Likely Cause | Solution |
|---------|--------------|----------|
| "spawn uv ENOENT" | uv not installed | Install uv: `irm https://astral.sh/uv/install.ps1 \| iex` |
| "Server disconnected" | MCP server crashed | Restart Claude Desktop |
| Filesystem access denied | Path not in allowed list | Check claude_desktop_config.json |
| Windows-MCP not responding | App focus issue | Use State-Tool to verify state |
| PDF Tools error | File path incorrect | Verify file exists with Filesystem |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 09 Jan 2026 | Initial MCP Integration Protocol |

---

*Frans MCP Integration Protocol v1.0 | Compatible with Master Prompts v4.8*
