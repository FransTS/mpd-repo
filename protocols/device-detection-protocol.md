# Device Detection Protocol v1.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | DEV-001 |
| **Version** | 1.0 |
| **Created** | 14 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v4.8 |
| **Priority** | MANDATORY - Execute at EVERY interaction start |

---

## Purpose

Accurately detect the device and environment Claude is operating in to ensure correct routing, path handling, and capability awareness. This protocol MUST run at the start of every session before any file operations or routing decisions.

---

## Device Matrix

| Device | User Path | MCP Available | Git Repo Path | SSH Key |
|--------|-----------|---------------|---------------|---------|
| **PC** | `C:\Users\User\` | Filesystem, Windows-MCP | `C:\GitHub\Master_Prompt_Dictionary` | `Frans PC` |
| **Laptop** | `C:\Users\Frans Vermaak\` | Filesystem, Windows-MCP | `C:\GitHub\Master_Prompt_Dictionary` | `Frans Laptop` |
| **Mobile** | N/A | None | N/A | N/A |
| **Claude Code (PC)** | `C:\Users\User\` | Limited/Different | Same as PC | `Frans PC` |
| **Claude Code (Laptop)** | `C:\Users\Frans Vermaak\` | Limited/Different | Same as Laptop | `Frans Laptop` |
| **Web (claude.ai)** | N/A | Google Drive only | N/A | N/A |

---

## Detection Logic

### Step 1: Check MCP Availability

```
IF Windows-MCP available:
    Ã¢â€ â€™ Desktop environment (PC, Laptop, or Claude Code)
    Ã¢â€ â€™ Proceed to Step 2
ELSE IF Filesystem MCP available:
    Ã¢â€ â€™ Check paths to determine device
    Ã¢â€ â€™ Proceed to Step 2
ELSE IF Google Drive tools available:
    Ã¢â€ â€™ Web environment (claude.ai)
    Ã¢â€ â€™ Device = WEB
ELSE:
    Ã¢â€ â€™ Mobile app or limited environment
    Ã¢â€ â€™ Device = MOBILE
```

### Step 2: Identify Specific Device (Desktop)

```powershell
# Run this check when Windows-MCP is available
$userProfile = $env:USERPROFILE

IF $userProfile contains "Frans Vermaak":
    Device = LAPTOP
ELSEIF $userProfile contains "User":
    Device = PC
ELSE:
    Device = UNKNOWN_DESKTOP
```

### Step 3: Detect Claude Code vs Claude Desktop

```
IF running in terminal/CLI context:
    Environment = CLAUDE_CODE
ELSEIF running in chat interface with full MCP:
    Environment = CLAUDE_DESKTOP
```

---

## Detection Command (PowerShell)

```powershell
# Standard Device Detection Script
$detection = @{
    ComputerName = $env:COMPUTERNAME
    UserProfile = $env:USERPROFILE
    Username = $env:USERNAME
    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
}

# Determine device
$device = switch -Regex ($env:USERPROFILE) {
    "Frans Vermaak" { "LAPTOP" }
    "\\User$" { "PC" }
    default { "UNKNOWN" }
}

$detection.Device = $device
$detection
```

---

## Device-Specific Configurations

### PC Configuration
```yaml
device: PC
user_path: C:\Users\User\
git_repo: C:\GitHub\Master_Prompt_Dictionary
ssh_key: id_ed25519_pc (Frans PC)
google_drive: G:\My Drive\
mcp_servers:
  - Filesystem (Documents, Google Drive, Git Repo)
  - Windows-MCP
```

### Laptop Configuration
```yaml
device: LAPTOP
user_path: C:\Users\Frans Vermaak\
git_repo: C:\Users\Frans Vermaak\Documents\GitHub\Master_Prompt_Dictionary
ssh_key: id_ed25519_laptop (Frans Laptop)
google_drive: G:\My Drive\
mcp_servers:
  - Filesystem
  - Windows-MCP
  - PDF Tools (if installed)
```

### Mobile Configuration
```yaml
device: MOBILE
user_path: N/A
git_repo: N/A (read-only via Google Docs)
mcp_servers: None
capabilities:
  - Read Google Docs
  - Basic chat
  - No file operations
```

### Web (claude.ai) Configuration
```yaml
device: WEB
user_path: N/A
git_repo: N/A
mcp_servers:
  - Google Drive (read Google Docs only)
capabilities:
  - Read Google Docs from Drive
  - Web search
  - No local file operations
```

### Claude Code Configuration
```yaml
device: CLAUDE_CODE_[PC|LAPTOP]
capabilities:
  - Full filesystem access
  - Git operations
  - Terminal commands
  - Different tool interface than Desktop
```

---

## Mandatory Session Start Sequence

At the START of every interaction, Claude MUST:

```
1. DETECT environment capabilities
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Check: Windows-MCP? Filesystem MCP? Google Drive?

2. IF Desktop environment detected:
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ RUN PowerShell device detection
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ IDENTIFY: PC or Laptop

3. SET device context:
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Store device identifier
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Load device-specific paths
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Adjust capabilities accordingly

4. ACKNOWLEDGE (internally, not to user unless relevant):
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Device: [PC|LAPTOP|MOBILE|WEB|CLAUDE_CODE]
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Capabilities: [List]
   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Paths: [Device-specific]
```

---

## Path Mapping by Device

| Resource | PC | Laptop | Mobile/Web |
|----------|----|----|------------|
| MPD | `G:\My Drive\...\MPD\` | `G:\My Drive\...\MPD\` | Google Doc |
| Memory | `G:\My Drive\...\Memory\` | `G:\My Drive\...\Memory\` | Google Doc |
| Git Repo | `C:\GitHub\Master_Prompt_Dictionary` | `C:\Users\Frans Vermaak\Documents\GitHub\...` | N/A |
| Session Log | `Memory\PC\session_log.md` | `Memory\Laptop\session_log.md` | N/A |

---

## Integration with Other Protocols

| Protocol | Integration |
|----------|-------------|
| Global Protocols | Device detection runs FIRST |
| Memory Protocol | Write to device-specific session log |
| MCP Integration | Load device-appropriate paths |
| Autonomous Routing | Route based on device capabilities |
| Browser Security | Apply on PC/Laptop only |

---

## Error Handling

### Unknown Device
```
IF device cannot be determined:
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ ASK user: "Which device are you using? (PC/Laptop/Mobile)"
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ STORE response for session
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ PROCEED with appropriate configuration
```

### MCP Not Available
```
IF expected MCP not available:
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ LOG: "MCP [name] not available"
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ FALL BACK to alternative methods
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ INFORM user if critical capability missing
```

---

## Quick Reference

```
Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â
Ã¢â€â€š           DEVICE DETECTION QUICK REFERENCE          Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â¤
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€š  User Path Contains:                                Ã¢â€â€š
Ã¢â€â€š    "Frans Vermaak" Ã¢â€ â€™ LAPTOP                         Ã¢â€â€š
Ã¢â€â€š    "User"          Ã¢â€ â€™ PC                             Ã¢â€â€š
Ã¢â€â€š    N/A (no MCP)    Ã¢â€ â€™ MOBILE or WEB                  Ã¢â€â€š
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€š  MCP Available:                                     Ã¢â€â€š
Ã¢â€â€š    Windows-MCP     Ã¢â€ â€™ Desktop (PC or Laptop)         Ã¢â€â€š
Ã¢â€â€š    Filesystem only Ã¢â€ â€™ Check paths                    Ã¢â€â€š
Ã¢â€â€š    Google Drive    Ã¢â€ â€™ Web (claude.ai)                Ã¢â€â€š
Ã¢â€â€š    None            Ã¢â€ â€™ Mobile app                     Ã¢â€â€š
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€š  Always Check BEFORE:                               Ã¢â€â€š
Ã¢â€â€š    Ã¢â‚¬Â¢ File operations                                Ã¢â€â€š
Ã¢â€â€š    Ã¢â‚¬Â¢ Git commands                                   Ã¢â€â€š
Ã¢â€â€š    Ã¢â‚¬Â¢ Path references                                Ã¢â€â€š
Ã¢â€â€š    Ã¢â‚¬Â¢ Capability assumptions                         Ã¢â€â€š
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 14 January 2026 | Initial Device Detection Protocol |

---

*Frans Device Detection Protocol v1.0 | Compatible with Master Prompts v4.8*
