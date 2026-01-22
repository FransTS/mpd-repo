# Frans Skill: MCP Setup Guide

## Metadata

| Field | Value |
|-------|-------|
| **Name** | mcp-setup-guide |
| **Version** | 1.0 |
| **ID** | LAR-022 |
| **Triggers** | "setup mcp", "configure mcp", "mcp not working", "install mcp" |
| **Google Doc Name** | `SKILL_MCPSetupGuide` |

---

## Purpose

Provide step-by-step instructions for configuring MCP (Model Context Protocol) servers on Windows machines to enable enhanced Claude Desktop capabilities.

---

## Prerequisites

| Requirement | Check Command | Expected Output |
|-------------|---------------|-----------------|
| Node.js v18+ | `node --version` | v18.x.x or higher |
| npm | `npm --version` | 8.x.x or higher |
| Claude Desktop | Installed | App launches |
| Windows 10/11 | - | - |

---

## Quick Setup (5 Minutes)

### Step 1: Install uv (Python Package Manager)

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**After installation:** Close and reopen PowerShell, then verify:

```powershell
uv --version
```

### Step 2: Navigate to Claude Config Directory

```powershell
cd $env:APPDATA\Claude
```

### Step 3: Create MCP Configuration File

```powershell
notepad claude_desktop_config.json
```

Click **Yes** when asked to create a new file.

### Step 4: Paste Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\USERNAME\\Documents",
        "C:\\Users\\USERNAME\\GoogleDrive-AI"
      ]
    },
    "windows-mcp": {
      "command": "uvx",
      "args": [
        "windows-mcp"
      ]
    },
    "pdf-tools": {
      "command": "npx",
      "args": [
        "-y",
        "@anthropic/mcp-server-pdf"
      ]
    },
    "context7": {
      "command": "npx",
      "args": [
        "-y",
        "@anthropic/mcp-server-context7"
      ]
    }
  }
}
```

**IMPORTANT:** Replace `USERNAME` with your actual Windows username.

### Step 5: Save and Restart

1. Save the file (Ctrl + S)
2. Close Notepad
3. Right-click Claude in system tray â†’ **Exit**
4. Reopen Claude Desktop

---

## Detailed Server Configurations

### Filesystem Server

**Purpose:** Read, write, search, and manage files in specified directories.

```json
"filesystem": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-filesystem",
    "PATH_1",
    "PATH_2",
    "PATH_3"
  ]
}
```

**Configuration Tips:**
- Add multiple paths as separate arguments
- Use double backslashes: `C:\\Users\\...`
- Only listed directories (and subdirectories) are accessible
- Common paths to include:
  - Documents folder
  - Google Drive sync folder
  - Project directories
  - Desktop (if needed)

**Frans's Standard Paths:**
```json
"C:\\Users\\User\\Documents",
"C:\\Users\\FransVermaak\\GoogleDrive-AI",
"G:\\My Drive\\Shared_Download\\AI_Folder"
```

---

### Windows-MCP Server

**Purpose:** Desktop automation, app control, browser interaction, screenshots.

```json
"windows-mcp": {
  "command": "uvx",
  "args": [
    "windows-mcp"
  ]
}
```

**Capabilities:**
- Launch applications
- Click, type, scroll
- Take screenshots (State-Tool with vision)
- Execute PowerShell commands
- Read screen state (UI elements, coordinates)

**Requirements:**
- uv must be installed
- Some features may require admin privileges

---

### PDF Tools Server

**Purpose:** PDF analysis, form filling, data extraction.

```json
"pdf-tools": {
  "command": "npx",
  "args": [
    "-y",
    "@anthropic/mcp-server-pdf"
  ]
}
```

**Capabilities:**
- Read PDF content
- List form fields
- Fill PDF forms
- Extract data to CSV
- Validate form completion
- Bulk fill from CSV

---

### Context7 Server

**Purpose:** Fetch up-to-date library and API documentation.

```json
"context7": {
  "command": "npx",
  "args": [
    "-y",
    "@upstash/context7-mcp"
  ]
}
```

**Capabilities:**
- Resolve library IDs
- Fetch documentation by topic
- Get code examples

---

## Verification Commands

After restarting Claude Desktop, run these in a new chat:

### Test Filesystem

```
"List the allowed directories for filesystem access"
```

Expected: List of configured paths.

### Test Windows-MCP

```
"What applications are currently open on my desktop?"
```

Expected: List of open windows with names.

### Test PDF Tools

```
"List my saved PDF profiles"
```

Expected: Empty list or saved profiles.

---

## Troubleshooting

### Error: "spawn uv ENOENT"

**Cause:** uv not installed or not in PATH.

**Solution:**
```powershell
# Install uv
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# Close and reopen PowerShell
# Verify installation
uv --version
```

---

### Error: "Server disconnected"

**Cause:** MCP server crashed or failed to start.

**Solution:**
1. Open Claude's developer settings (from error message)
2. Check server logs for specific errors
3. Verify Node.js is installed: `node --version`
4. Restart Claude Desktop completely (Exit from system tray)

---

### Error: "Cannot find path ... claude_desktop_config.json"

**Cause:** Configuration file doesn't exist.

**Solution:**
```powershell
cd $env:APPDATA\Claude
notepad claude_desktop_config.json
# Create new file when prompted
```

---

### Error: Path not accessible

**Cause:** Directory not in allowed list.

**Solution:**
1. Open `claude_desktop_config.json`
2. Add the directory to filesystem args
3. Use double backslashes: `C:\\Path\\To\\Folder`
4. Save and restart Claude

---

### Windows-MCP: "Tool result is too large"

**Cause:** Screenshot/state data exceeds limit.

**Solution:**
```
Use State-Tool with use_vision=false for text-only state
```

---

### Multiple MCP Servers Showing

**Cause:** Duplicate configurations (file + developer settings).

**Solution:**
1. Open developer settings from error message
2. Remove duplicate servers
3. Keep only one configuration source

---

## Configuration File Location

| OS | Path |
|----|------|
| Windows | `%APPDATA%\Claude\claude_desktop_config.json` |
| macOS | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Linux | `~/.config/Claude/claude_desktop_config.json` |

---

## Complete Example Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\FransVermaak\\Documents",
        "C:\\Users\\FransVermaak\\GoogleDrive-AI",
        "G:\\My Drive\\Shared_Download\\AI_Folder",
        "C:\\Users\\FransVermaak\\Desktop"
      ]
    },
    "windows-mcp": {
      "command": "uvx",
      "args": [
        "windows-mcp"
      ]
    },
    "pdf-tools": {
      "command": "npx",
      "args": [
        "-y",
        "@anthropic/mcp-server-pdf"
      ]
    },
    "context7": {
      "command": "npx",
      "args": [
        "-y",
        "@upstash/context7-mcp"
      ]
    }
  }
}
```

---

## Post-Setup Checklist

```
â˜ uv installed and verified
â˜ Node.js v18+ installed
â˜ claude_desktop_config.json created
â˜ Filesystem paths configured (with correct username)
â˜ Claude Desktop restarted (Exit from system tray)
â˜ Filesystem MCP verified (list directories)
â˜ Windows-MCP verified (list open apps)
â˜ PDF Tools verified (list profiles)
```

---

## Mobile/Web Fallback

When MCP is not available (mobile app, web browser, unconfigured PC):

1. **File Access:** Use Google Drive integration
2. **PDF Work:** Upload files directly to chat
3. **Automation:** Receive step-by-step instructions instead
4. **Skills:** Load from Google Drive (Google Docs format only)

---

## Updating MCP Servers

To update to latest versions:

```powershell
# Clear npm cache
npm cache clean --force

# Restart Claude Desktop
# Servers will fetch latest versions on next start
```

---

## Uninstalling MCP

1. Delete or rename `claude_desktop_config.json`
2. Restart Claude Desktop
3. MCP servers will no longer load

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 09 Jan 2026 | Initial MCP Setup Guide |

---

*Frans Skill LAR-022 | MCP Setup Guide v1.0*
