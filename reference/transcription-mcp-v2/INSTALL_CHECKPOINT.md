# Transcription MCP v2.0 - Installation Checkpoint
## Cross-Device Installation Guide

**Created:** 20 January 2026 | 18:45 SAST  
**Device:** PC (completed)  
**Pending:** Laptop  

---

## 1. Prerequisites

### Required Software
- Python 3.10+ (installed at `C:\Users\Frans Vermaak\AppData\Local\Programs\Python\Python312\`)
- CUDA Toolkit 12.x or 13.x: https://developer.nvidia.com/cuda-downloads
- ffmpeg: https://ffmpeg.org/download.html (add to PATH)

### HuggingFace Setup (ONE TIME - ALREADY DONE)
1. ✅ Account created: https://huggingface.co/join
2. ✅ Accepted pyannote terms:
   - https://huggingface.co/pyannote/segmentation-3.0
   - https://huggingface.co/pyannote/speaker-diarization-3.1
3. ✅ Token created: `YOUR_HF_TOKEN_HERE`

---

## 2. Installation Steps (Laptop)

### Step 1: Copy Project Files

```powershell
# Create directory
New-Item -ItemType Directory -Path "C:\GitHub" -Force

# Copy from Google Drive (will sync automatically)
Copy-Item -Recurse "G:\My Drive\Shared_Download\AI_Folder\MPD\reference\transcription-mcp-v2" "C:\GitHub\transcription-mcp"
```

### Step 2: Create Virtual Environment

```powershell
cd C:\GitHub\transcription-mcp

# Use full Python path if 'python' not in PATH
# Laptop path: C:\Users\Frans Vermaak\AppData\Local\Programs\Python\Python312\python.exe
python -m venv venv
```

### Step 3: Run Installation Script

```powershell
C:\Users\User\Documents\install_transcription.bat
```

Or manually:

```powershell
cd C:\GitHub\transcription-mcp
.\venv\Scripts\Activate.ps1

pip install --upgrade pip
pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install whisperx
pip install mcp pydantic python-docx aiofiles python-dotenv
pip install -e .
```

### Step 4: Create .env File

```powershell
notepad C:\GitHub\transcription-mcp\.env
```

Content:
```
HF_TOKEN=YOUR_HF_TOKEN_HERE
WORK_DIR=G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs
```

### Step 5: Configure Claude Desktop

Edit: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "preferences": {
    "chromeExtensionEnabled": true
  },
  "mcpServers": {
    "filesystem": {
      "command": "cmd.exe",
      "args": ["/c", "npx", "-y", "@modelcontextprotocol/server-filesystem", "C:\\Users\\Frans Vermaak\\Documents", "G:\\My Drive\\Shared_Download\\AI_Folder"]
    },
    "transcription": {
      "command": "C:\\GitHub\\transcription-mcp\\venv\\Scripts\\python.exe",
      "args": ["-m", "transcription_mcp.server"],
      "cwd": "C:\\GitHub\\transcription-mcp",
      "env": {
        "HF_TOKEN": "YOUR_HF_TOKEN_HERE",
        "WORK_DIR": "G:\\My Drive\\Shared_Download\\AI_Folder\\Memory\\Projects\\Transcription_Jobs"
      }
    }
  }
}
```

**Note:** Laptop uses `C:\Users\Frans Vermaak\` not `C:\Users\User\`

### Step 6: Restart Claude Desktop

---

## 3. File Locations

| Item | PC Path | Laptop Path |
|------|---------|-------------|
| Project | `C:\GitHub\transcription-mcp` | `C:\GitHub\transcription-mcp` |
| Python | `C:\Users\User\AppData\Local\Programs\Python\Python312\` | `C:\Users\Frans Vermaak\AppData\Local\Programs\Python\Python312\` |
| Claude Config | `C:\Users\User\AppData\Roaming\Claude\` | `C:\Users\Frans Vermaak\AppData\Roaming\Claude\` |
| Jobs Output | `G:\My Drive\...\Transcription_Jobs\` | Same (Google Drive sync) |
| Source Code | `G:\My Drive\...\MPD\reference\transcription-mcp-v2\` | Same (Google Drive sync) |

---

## 4. Quick Test

After installation, test with:

```
Transcribe D:\path\to\meeting.mp4
```

Or use the built-in transcription MCP tools:
- `transcribe` - Start transcription
- `transcribe_status` - Check progress
- `transcribe_list` - List jobs
- `vocabulary_add` - Add corrections

---

## 5. Troubleshooting

### "python not recognized"
Use full path: `C:\Users\Frans Vermaak\AppData\Local\Programs\Python\Python312\python.exe`

### "CUDA not found"
Install CUDA Toolkit: https://developer.nvidia.com/cuda-downloads

### "HuggingFace token error"
Verify token in `.env` matches: `YOUR_HF_TOKEN_HERE`

### "pyannote access denied"
Accept model terms at:
- https://huggingface.co/pyannote/segmentation-3.0
- https://huggingface.co/pyannote/speaker-diarization-3.1

---

## 6. Version Info

| Component | Version |
|-----------|---------|
| Transcription MCP | 2.0.0 |
| WhisperX | 3.7.4 |
| PyTorch | 2.8.0 |
| faster-whisper | 1.2.1 |
| pyannote-audio | 3.4.0 |

---

**Status:** PC ✅ Complete | Laptop ⏳ Pending
