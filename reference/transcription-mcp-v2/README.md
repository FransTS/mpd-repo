# Transcription MCP Server v2.0

WhisperX-based bilingual transcription with speaker diarization for Claude Desktop.

## Features

- ✅ **120-minute meetings** - Intelligent chunking for long files
- ✅ **4GB VRAM support** - Optimised for RTX 3060 and similar
- ✅ **Bilingual** - English and Afrikaans
- ✅ **Speaker diarization** - Up to 10 speakers
- ✅ **Word-level timestamps** - Precise alignment
- ✅ **Crash recovery** - Checkpoint system for interruptions
- ✅ **Domain vocabulary** - Automatic correction of technical terms

## Requirements

- Python 3.10+
- NVIDIA GPU with 4GB+ VRAM (or CPU fallback)
- CUDA Toolkit 11.8+
- ffmpeg
- HuggingFace account (for diarization models)

## Installation

### 1. Clone/Copy Project

```powershell
cd C:\GitHub
# Copy from Google Drive or clone from repo
Copy-Item -Recurse "G:\My Drive\Shared_Download\AI_Folder\MPD\reference\transcription-mcp-v2" ".\transcription-mcp"
cd transcription-mcp
```

### 2. Create Virtual Environment

```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

### 3. Install PyTorch with CUDA

```powershell
pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu118
```

### 4. Install WhisperX and Dependencies

```powershell
pip install whisperx
pip install mcp pydantic python-docx aiofiles python-dotenv
pip install -e .
```

### 5. Configure HuggingFace Token

1. Create account: https://huggingface.co/join
2. Accept model terms:
   - https://huggingface.co/pyannote/segmentation-3.0
   - https://huggingface.co/pyannote/speaker-diarization-3.1
3. Create token: https://huggingface.co/settings/tokens
4. Copy `.env.example` to `.env` and add your token

### 6. Configure Claude Desktop

Edit `%APPDATA%\Claude\claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "transcription": {
      "command": "C:\\GitHub\\transcription-mcp\\venv\\Scripts\\python.exe",
      "args": ["-m", "transcription_mcp.server"],
      "cwd": "C:\\GitHub\\transcription-mcp",
      "env": {
        "HF_TOKEN": "hf_your_token_here",
        "WORK_DIR": "G:\\My Drive\\Shared_Download\\AI_Folder\\Memory\\Projects\\Transcription_Jobs"
      }
    }
  }
}
```

### 7. Restart Claude Desktop

Close and reopen Claude Desktop to load the MCP server.

## Usage

### Basic Transcription

```
User: Transcribe the meeting at D:\Recordings\standup.mp4
```

### With Speaker Names

```
User: Transcribe D:\Recordings\meeting.mp4 with speakers Frans and Magdel
```

### Resume After Crash

```
User: Resume transcription
```

or

```
User: transcribe(resume_job_id="trans_20260120_143022")
```

### Add Vocabulary

```
User: Add vocabulary correction "kapitek" -> "Capitec"
```

## Configuration

### Model Selection

The server automatically selects the optimal model based on available VRAM:

| VRAM | Model | Expected Speed |
|------|-------|----------------|
| 4GB | medium | ~0.3x realtime |
| 6GB | large-v2 | ~0.25x realtime |
| 8GB+ | large-v2/v3 | ~0.2x realtime |

Override with `model="medium"` or `model="large-v2"` parameter.

### Vocabulary Corrections

Edit `config/vocabulary.json` to add domain-specific corrections:

```json
{
  "corrections": {
    "your company name": "YourCompany"
  },
  "preserve_case": ["YourCompany"]
}
```

## Output Files

Jobs are saved to:

```
{WORK_DIR}/{job_id}/
├── metadata.json      # Job configuration
├── checkpoints/       # Recovery checkpoints
├── cache/             # Temporary files
│   ├── audio.wav
│   └── chunks/
└── output/
    ├── transcript.json
    └── transcript.docx
```

## Troubleshooting

### "CUDA out of memory"

- Reduce batch size: Edit `MODEL_CONFIGS` in `transcriber.py`
- Force smaller model: `model="small"`
- Enable CPU fallback: Set `FORCE_CPU=true` in `.env`

### "HuggingFace token required"

- Ensure you've accepted model terms on HuggingFace
- Check token is correctly set in `.env` or Claude Desktop config

### Slow Performance

- Ensure CUDA is being used: Check logs for "Using config: ..."
- Close other GPU-intensive applications
- Consider using CPU for diarization only

### Diarization Fails

- pyannote models may need updated dependencies
- Try: `pip install pyannote.audio --upgrade`

## License

Internal LarcAI project.

## Author

Frans Vermaak, CTGO @ LarcAI
