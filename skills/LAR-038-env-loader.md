# Frans Skill: Environment Loader

## Metadata

| Field | Value |
|-------|-------|
| **Name** | env-loader |
| **Version** | 1.0 |
| **ID** | LAR-038 |
| **Triggers** | "load env", "load keys", "environment variables" |
| **Updated** | 30 January 2026 |

---

## Purpose

Centralized management of API keys and environment variables across all devices and personas. Keys are stored securely in Google Drive and loaded as needed.

---

## Centralised Key Location

```
G:\My Drive\Shared_Download\AI_Folder\config\.env
```

This location:
- Syncs across PC and Laptop via Google Drive
- Is accessible to all personas via filesystem MCP
- Keeps secrets out of git repositories

---

## .env File Format

```bash
# LarcAI Environment Variables
TAVILY_API_KEY=tvly-xxxx
CONTEXT7_API_KEY=xxxx
GEMINI_API_KEY=xxxx
OPENAI_API_KEY=sk-xxxx
ANTHROPIC_API_KEY=sk-ant-xxxx
```

---

## Loading Keys in Claude Code

### Read Specific Key

```bash
# Read entire .env
cat "G:/My Drive/Shared_Download/AI_Folder/config/.env"

# Extract specific key
grep "TAVILY_API_KEY" "G:/My Drive/Shared_Download/AI_Folder/config/.env"
```

### PowerShell: Load into Session

```powershell
# Load all keys from .env into current session
Get-Content "G:\My Drive\Shared_Download\AI_Folder\config\.env" | ForEach-Object {
    if ($_ -match "^([^#][^=]+)=(.+)$") {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
    }
}

# Verify
$env:TAVILY_API_KEY
```

### Python: Load with dotenv

```python
from dotenv import load_dotenv
import os

# Load from centralised location
env_path = r"G:\My Drive\Shared_Download\AI_Folder\config\.env"
load_dotenv(env_path)

# Use keys
tavily_key = os.getenv("TAVILY_API_KEY")
```

---

## MCP Server Configuration

### Option 1: System Environment Variables (Recommended)

Set once in Windows (persists across restarts):

```powershell
# Run as Administrator
[System.Environment]::SetEnvironmentVariable("TAVILY_API_KEY", "tvly-xxx", "User")
[System.Environment]::SetEnvironmentVariable("CONTEXT7_API_KEY", "xxx", "User")
```

Then MCP servers automatically inherit these variables.

### Option 2: Wrapper Script

Create `start-mcp.ps1`:

```powershell
# Load .env
$envFile = "G:\My Drive\Shared_Download\AI_Folder\config\.env"
Get-Content $envFile | ForEach-Object {
    if ($_ -match "^([^#][^=]+)=(.+)$") {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
    }
}

# Start MCP server
npx -y @anthropic/mcp-server-tavily
```

### Option 3: Direct in MCP Config

Reference via env block (keys visible in config):

```json
"tavily": {
  "command": "npx",
  "args": ["-y", "@anthropic/mcp-server-tavily"],
  "env": {
    "TAVILY_API_KEY": "tvly-xxx"
  }
}
```

---

## Device Detection

| Device | .env Path |
|--------|-----------|
| PC | `G:\My Drive\Shared_Download\AI_Folder\config\.env` |
| Laptop | `G:\My Drive\Shared_Download\AI_Folder\config\.env` |
| Cloud | Load from Google Drive via API |

---

## Security Best Practices

1. **Never commit .env** - Already in .gitignore
2. **Use .env.example** - Template without real keys
3. **Rotate keys periodically** - Update centralised file
4. **Limit key scopes** - Use least-privilege API keys

---

## Integration with Personas

Any persona can load keys:

```markdown
## Loading Keys

1. Read: G:\My Drive\Shared_Download\AI_Folder\config\.env
2. Extract required key
3. Use in API calls
```

---

## Quick Commands

| Command | Action |
|---------|--------|
| "load env" | Read .env file |
| "show tavily key" | Extract TAVILY_API_KEY |
| "set system env" | Guide for Windows env vars |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 30 Jan 2026 | Initial environment loader skill |

---

*Frans Skill LAR-038 | Environment Loader v1.0*
