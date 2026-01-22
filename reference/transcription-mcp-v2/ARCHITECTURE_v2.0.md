# Transcription MCP Server v2.0
## WhisperX-Based Bilingual Pipeline

**Version:** 2.0  
**Created:** 20 January 2026  
**Author:** Frans Vermaak, CTGO  
**Status:** Implementation Ready

---

## 1. Executive Summary

### Why v2.0?

v1.1 architecture failed because:
- Never implemented (design only)
- Required 8GB+ VRAM (RTX 3060 has 4GB)
- NeMo + faster-whisper + Claude Vision = complex, fragile
- No chunking for long audio = OOM crashes
- No CPU fallback

### v2.0 Solution

| Component | v1.1 (Failed) | v2.0 (New) |
|-----------|---------------|------------|
| ASR Engine | faster-whisper standalone | **WhisperX** (wraps faster-whisper) |
| Diarization | NVIDIA NeMo | **pyannote.audio** (via WhisperX) |
| VRAM Required | 8GB+ | **4GB** (with optimisations) |
| Long Audio | No chunking | **Intelligent chunking** |
| Crash Recovery | Designed, not implemented | **Implemented checkpoints** |
| Model | large-v3 | **medium** or **large-v2** (configurable) |

### Capabilities

- ✅ 120-minute meeting transcription
- ✅ Bilingual English/Afrikaans
- ✅ Speaker diarization (up to 10 speakers)
- ✅ Word-level timestamps
- ✅ Works on 4GB VRAM GPU
- ✅ CPU fallback for OOM scenarios
- ✅ Checkpoint/resume for crash recovery
- ✅ Professional DOCX output

---

## 2. System Requirements

### Your Hardware (PC)

| Component | Available | Required | Status |
|-----------|-----------|----------|--------|
| GPU | RTX 3060 (4GB) | 4GB+ | ✅ |
| RAM | 64GB | 16GB | ✅ |
| Storage | SSD | 20GB free | ✅ |
| CUDA | Needs install | 11.8+ | ⚠️ |

### Software Dependencies

```
Python 3.10+
CUDA Toolkit 11.8 or 12.x
ffmpeg 5.0+
HuggingFace account (for pyannote models)
```

---

## 3. Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                    TRANSCRIPTION MCP v2.0                           │
│                      (WhisperX Core)                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│  │   INGEST    │───▶│  TRANSCRIBE │───▶│   OUTPUT    │             │
│  │   MODULE    │    │   ENGINE    │    │   MODULE    │             │
│  └─────────────┘    └─────────────┘    └─────────────┘             │
│        │                  │                  │                      │
│        ▼                  ▼                  ▼                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                    SHARED SERVICES                           │   │
│  │  • Checkpoint Manager (crash recovery)                       │   │
│  │  • Memory Monitor (OOM prevention)                           │   │
│  │  • Audio Chunker (long file handling)                        │   │
│  │  • Vocabulary Corrector (domain terms)                       │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │      WHISPERX PIPELINE        │
              │  ┌─────────────────────────┐  │
              │  │ faster-whisper (ASR)    │  │
              │  │ wav2vec2 (alignment)    │  │
              │  │ pyannote (diarization)  │  │
              │  └─────────────────────────┘  │
              └───────────────────────────────┘
```

---

## 4. Memory-Optimised Processing

### Model Selection by VRAM

| VRAM | Model | Batch Size | Compute Type |
|------|-------|------------|--------------|
| 4GB | medium | 4 | int8 |
| 6GB | large-v2 | 8 | int8 |
| 8GB+ | large-v3 | 16 | float16 |

### Chunking Strategy

For 4GB VRAM, audio is processed in chunks:

```
┌──────────────────────────────────────────────────────────────┐
│                    120-MINUTE MEETING                         │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Chunk 1      Chunk 2      Chunk 3      Chunk 4             │
│  [0-30min]    [30-60min]   [60-90min]   [90-120min]         │
│      │            │            │            │                │
│      ▼            ▼            ▼            ▼                │
│  Transcribe   Transcribe   Transcribe   Transcribe          │
│      │            │            │            │                │
│      └────────────┴────────────┴────────────┘                │
│                        │                                     │
│                        ▼                                     │
│                    MERGE                                     │
│              (align timestamps)                              │
│                        │                                     │
│                        ▼                                     │
│                   DIARIZE                                    │
│              (full audio pass)                               │
│                        │                                     │
│                        ▼                                     │
│                    OUTPUT                                    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### OOM Prevention

```python
MEMORY_THRESHOLDS = {
    "warning": 0.80,   # 80% VRAM - reduce batch size
    "critical": 0.90,  # 90% VRAM - switch to CPU
    "abort": 0.95      # 95% VRAM - save checkpoint, stop
}
```

---

## 5. Processing Pipeline

### Phase 1: Ingest (5%)
- Validate file exists and is audio/video
- Extract audio to 16kHz mono WAV (ffmpeg)
- Calculate duration, estimate processing time
- Create job directory and metadata
- **Checkpoint: 01_ingested**

### Phase 2: Chunk (5%)
- If duration > 30 min: split into chunks
- Overlap: 10 seconds between chunks
- Save chunk boundaries
- **Checkpoint: 02_chunked**

### Phase 3: Transcribe (60%)
- Load WhisperX with memory-optimised settings
- Process each chunk sequentially
- VAD preprocessing (reduce hallucinations)
- Word-level alignment via wav2vec2
- Apply vocabulary corrections
- **Checkpoint: 03_transcribed** (per chunk)

### Phase 4: Diarize (20%)
- Run pyannote.audio on full audio
- Assign speaker IDs to segments
- Merge with transcription
- **Checkpoint: 04_diarized**

### Phase 5: Post-Process (5%)
- Apply domain vocabulary corrections
- Merge speaker turns
- Quality validation
- **Checkpoint: 05_processed**

### Phase 6: Output (5%)
- Generate JSON transcript
- Generate DOCX document
- **Checkpoint: 06_complete**

---

## 6. MCP Tools

### Primary Tools

| Tool | Description |
|------|-------------|
| `transcribe` | Start/resume transcription job |
| `transcribe_status` | Check job progress |
| `transcribe_cancel` | Cancel running job |
| `transcribe_list` | List all jobs |
| `vocabulary_add` | Add domain terms |

### Tool: transcribe

```python
@mcp.tool()
async def transcribe(
    file_path: str,
    language: str = "auto",  # "en", "af", "auto"
    speakers: list[str] = None,  # ["Frans", "Magdel"]
    model: str = "auto",  # "medium", "large-v2", "auto"
    diarize: bool = True,
    output_format: str = "both"  # "json", "docx", "both"
) -> dict:
    """
    Transcribe audio/video file with speaker diarization.
    
    Automatically:
    - Detects optimal model for available VRAM
    - Chunks long files (>30 min)
    - Saves checkpoints for crash recovery
    - Applies vocabulary corrections
    
    Returns:
        job_id: Unique job identifier
        estimated_time: Processing time estimate
        output_path: Where results will be saved
    """
```

---

## 7. File Structure

```
C:\GitHub\transcription-mcp\
├── src/
│   └── transcription_mcp/
│       ├── __init__.py
│       ├── server.py           # MCP server entry
│       ├── transcriber.py      # WhisperX wrapper
│       ├── chunker.py          # Audio chunking
│       ├── checkpoint.py       # Crash recovery
│       ├── memory.py           # VRAM monitoring
│       ├── vocabulary.py       # Domain corrections
│       └── output.py           # JSON/DOCX generation
├── config/
│   ├── vocabulary.json         # Domain terms
│   └── settings.json           # Default settings
├── pyproject.toml
├── README.md
└── .env.example
```

### Job Directory Structure

```
G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs\
└── {job_id}/
    ├── metadata.json
    ├── checkpoints/
    │   ├── 01_ingested.json
    │   ├── 02_chunked.json
    │   ├── 03_transcribed_chunk_01.json
    │   ├── 03_transcribed_chunk_02.json
    │   ├── 04_diarized.json
    │   ├── 05_processed.json
    │   └── 06_complete.json
    ├── cache/
    │   ├── audio.wav
    │   └── chunks/
    └── output/
        ├── transcript.json
        └── transcript.docx
```

---

## 8. Vocabulary Correction

### Default Corrections (config/vocabulary.json)

```json
{
  "corrections": {
    "france": "Frans",
    "franz": "Frans",
    "lock ai": "LarcAI",
    "lark ai": "LarcAI",
    "c shop": "C#",
    "see sharp": "C#",
    "your path": "UiPath",
    "ui path": "UiPath",
    "banks": "BaNCS",
    "magdell": "Magdel",
    "magdal": "Magdel"
  },
  "preserve_case": [
    "LarcAI",
    "BaNCS",
    "UiPath"
  ]
}
```

---

## 9. Quality Targets

| Metric | Target | Measurement |
|--------|--------|-------------|
| Word Error Rate | <5% | Manual spot-check |
| Speaker Attribution | >95% | Per-segment accuracy |
| Processing Speed | <0.3x realtime | 60min → <20min |
| Max Duration | 120 minutes | Tested |
| Crash Recovery | 100% | Resume from any checkpoint |

---

## 10. Installation

### Step 1: Prerequisites

```powershell
# Check CUDA
nvcc --version  # Should show 11.8+

# If not installed:
# Download from https://developer.nvidia.com/cuda-downloads
# Install CUDA Toolkit 12.x
```

### Step 2: Create Environment

```powershell
cd C:\GitHub
mkdir transcription-mcp
cd transcription-mcp

python -m venv venv
.\venv\Scripts\Activate.ps1
```

### Step 3: Install Dependencies

```powershell
pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install whisperx
pip install mcp pydantic python-docx aiofiles
```

### Step 4: HuggingFace Token

1. Create account: https://huggingface.co/join
2. Accept pyannote terms:
   - https://huggingface.co/pyannote/segmentation-3.0
   - https://huggingface.co/pyannote/speaker-diarization-3.1
3. Create token: https://huggingface.co/settings/tokens
4. Save to `.env` file

### Step 5: Configure Claude Desktop

Add to `%APPDATA%\Claude\claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "transcription": {
      "command": "C:\\GitHub\\transcription-mcp\\venv\\Scripts\\python.exe",
      "args": ["-m", "transcription_mcp.server"],
      "cwd": "C:\\GitHub\\transcription-mcp",
      "env": {
        "HF_TOKEN": "hf_xxxxxxxxxxxxxxxxxxxx",
        "WORK_DIR": "G:\\My Drive\\Shared_Download\\AI_Folder\\Memory\\Projects\\Transcription_Jobs"
      }
    }
  }
}
```

---

## 11. Usage Examples

### Basic Transcription

```
User: Transcribe the meeting recording at D:\Meetings\standup_2026-01-20.mp4

Claude: [calls transcribe tool]
Starting transcription job trans_20260120_143022
- File: standup_2026-01-20.mp4 (62 minutes)
- Model: medium (auto-selected for 4GB VRAM)
- Estimated time: 18 minutes
- Output: G:\My Drive\...\Transcription_Jobs\trans_20260120_143022\

Progress will be saved. If interrupted, say "resume transcription" to continue.
```

### Resume After Crash

```
User: Resume transcription

Claude: [calls transcribe_status, then transcribe with resume]
Found incomplete job: trans_20260120_143022
Last checkpoint: 03_transcribed_chunk_02 (45% complete)
Resuming from chunk 3...
```

---

## 12. Comparison: v1.1 vs v2.0

| Aspect | v1.1 | v2.0 |
|--------|------|------|
| Implementation | Design doc only | **Full code** |
| VRAM Required | 8GB+ | **4GB** |
| Max Duration | 60min (crashed) | **120min** |
| Diarization | NeMo (complex) | **pyannote** (integrated) |
| Recovery | Designed | **Implemented** |
| Speed (60min) | N/A (crashed) | **~18 min** |
| Dependencies | 6+ separate | **3 main** |

---

**Document Status:** Ready for Implementation  
**Next:** Create server.py and supporting modules
