# MCP Launchpad Installation Guide

## Prerequisites

- Python 3.13+ ([python.org](https://www.python.org/downloads/))
- uv package manager

## Step 1: Install Python 3.13+

Download and install from: https://www.python.org/downloads/

**Important:** Check "Add Python to PATH" during installation.

## Step 2: Install uv

```powershell
irm https://astral.sh/uv/install.ps1 | iex
```

**After install, restart terminal or run:**
```powershell
$env:Path = "C:\Users\Frans Vermaak\.local\bin;$env:Path"
```

## Step 3: Install MCP Launchpad

```powershell
uv tool install https://github.com/kenneth-liao/mcp-launchpad.git
```

## Step 4: Verify Installation

```powershell
mcpl --version
mcpl list
```

## Step 5: Create MCP Configuration

Create `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-filesystem", "G:\\My Drive\\Shared_Download\\AI_Folder"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-context7"]
    }
  }
}
```

## Step 6: Test

```bash
mcpl verify
mcpl search "file"
```

---

## Usage (Once Installed)

```bash
# Find tools
mcpl search "<capability>"

# Execute tool
mcpl call <server> <tool> '{"param":"value"}'

# Get help
mcpl inspect <server> <tool> --example
```

---

*Created: 16 January 2026 | Frans MPD*
