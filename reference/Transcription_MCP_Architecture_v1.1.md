# Transcription MCP Server Architecture v1.1
## LarcAI Video/Audio Transcription Pipeline

**Version:** 1.1  
**Updated:** 19 January 2026 | 14:35 SAST (UTC+2)  
**Author:** Frans Vermaak, CTGO  
**Project:** MPD Enhancement - Transcription Automation

---

## 1. Executive Summary

### Purpose
Build a dedicated MCP server to automate transcription of 1-2 hour bilingual (English/Afrikaans) video meetings with:
- **>98% language accuracy** through multi-pass verification
- **>95% speaker identification accuracy** through NVIDIA NeMo + visual verification
- Synchronised screenshot integration for visual content reference
- Professional document output with timestamps and speaker attribution

### Critical Design Principles

| Priority | Requirement | Rationale |
|----------|-------------|-----------|
| 1 | Language Accuracy | Incorrect transcription → wrong summaries → flawed decisions |
| 2 | Speaker Attribution | Who said what is essential for accountability and context |
| 3 | Visual Correlation | Technical discussions often reference on-screen content |
| 4 | Processing Efficiency | 1-2 hour videos must complete in reasonable time |

### Key Technology Decisions

| Component | Choice | Rationale |
|-----------|--------|-----------|
| ASR Engine | faster-whisper (large-v3) | Best multilingual accuracy, GPU optimised |
| Speaker Diarisation | **NVIDIA NeMo** | Apache 2.0 license, no restrictions, state-of-the-art |
| Visual Verification | Claude Vision | Built-in capability, no additional cost |
| Output Format | JSON-first → DOCX | Maximum flexibility, structured data |
| Compute | GPU Required | 4x speedup, production quality |

---

## 2. Why NVIDIA NeMo (Not pyannote-audio)

### Licensing Comparison

| Feature | pyannote-audio | NVIDIA NeMo |
|---------|---------------|-------------|
| License | MIT (models require HF agreement) | **Apache 2.0** |
| HuggingFace Token | Required | **Not required** |
| Commercial Use | Requires agreement | **Unrestricted** |
| Model Access | Must accept terms | **Direct download** |

### Performance Comparison

| Metric | pyannote 3.1 | NeMo Sortformer |
|--------|--------------|-----------------|
| DER (CALLHOME) | ~11% | **~7-10%** |
| DER (DIHARD III) | ~19% | **~13%** |
| RTF (GPU) | 2.5% | **214x realtime** |
| Max Speakers | Unlimited | 4 (sufficient for meetings) |

### NeMo Components Used

```
┌─────────────────────────────────────────────────────────────────┐
│                    NVIDIA NeMo DIARISATION STACK                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│   MarbleNet VAD                                                  │
│   └── Voice Activity Detection                                   │
│       └── Identifies speech vs silence timestamps                │
│                                                                  │
│   TitaNet                                                        │
│   └── Speaker Embedding Extractor                                │
│       └── Extracts voice characteristics per segment             │
│                                                                  │
│   Sortformer (End-to-End Diariser)                              │
│   └── Transformer-based speaker labelling                        │
│       └── Outputs speaker timestamps in arrival order            │
│                                                                  │
│   OR: MSDD (Multi-Scale Diarization Decoder)                    │
│   └── Neural diariser for clustering refinement                  │
│       └── Better for >4 speakers if needed                       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        TRANSCRIPTION MCP SERVER                              │
│                          (transcription_mcp)                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌───────────┐ │
│  │   INGESTION  │───▶│  PROCESSING  │───▶│  CORRELATION │───▶│  OUTPUT   │ │
│  │    MODULE    │    │    ENGINE    │    │    ENGINE    │    │  MODULE   │ │
│  └──────────────┘    └──────────────┘    └──────────────┘    └───────────┘ │
│         │                   │                   │                  │        │
│         ▼                   ▼                   ▼                  ▼        │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                        SHARED SERVICES                                │  │
│  │  • Job Queue & State Management                                       │  │
│  │  • Progress Reporting                                                 │  │
│  │  • Error Recovery & Checkpointing                                     │  │
│  │  • Vocabulary Manager (Domain-specific terms)                         │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
                    ┌─────────────────────────────────┐
                    │     EXTERNAL DEPENDENCIES       │
                    │  • ffmpeg (media processing)    │
                    │  • faster-whisper (ASR)         │
                    │  • NVIDIA NeMo (diarisation)    │
                    │  • Claude Vision (frame verify) │
                    └─────────────────────────────────┘
```

---

## 4. Three-Pass Processing Engine

### Pass 1: Initial Transcription (faster-whisper)
- Extract audio (ffmpeg) → 16kHz mono WAV
- Segment by silence (VAD)
- Transcribe with faster-whisper large-v3
- Output: Raw segments with timestamps and confidence scores

### Pass 2: Language Verification
- Detect language per segment (EN/AF/Mixed)
- Flag low-confidence segments (<0.85)
- Re-transcribe flagged segments with explicit language hint
- Apply domain vocabulary corrections
- Output: Verified transcript with language tags

### Pass 3: Speaker Diarisation (NVIDIA NeMo)
- Run NeMo Sortformer on audio
- Extract key frames for visual verification
- Correlate NeMo speaker IDs with visual identification
- Resolve conflicts, assign names where possible
- Output: Speaker-attributed transcript

---

## 5. Checkpoint System

### Local Storage Structure

```
G:\My Drive\Shared_Download\AI_Folder\Memory\
└── Projects\
    └── Transcription_Jobs\
        └── {job_id}\
            ├── metadata.json           # Job configuration
            ├── checkpoints\
            │   ├── 01_ingested.json    # After file validation
            │   ├── 02_audio.json       # After audio extraction
            │   ├── 03_raw_transcript.json
            │   ├── 04_verified.json    # After language verification
            │   ├── 05_diarised.json    # After speaker attribution
            │   ├── 06_visual.json      # After visual verification
            │   └── 07_complete.json    # Final output
            ├── cache\
            │   ├── audio.wav           # Extracted audio
            │   ├── segments\           # Transcript chunks
            │   └── frames\             # Extracted video frames
            └── output\
                ├── transcript.json     # Structured output
                ├── transcript.docx     # Formatted document
                └── screenshots\        # Content screenshots
```

### Checkpoint Manager

```python
class CheckpointManager:
    """
    Manages job state persistence for recovery and long-running jobs.
    Uses local Google Drive path for cross-device access.
    """
    
    BASE_PATH = "G:\\My Drive\\Shared_Download\\AI_Folder\\Memory\\Projects\\Transcription_Jobs"
    
    checkpoint_phases = [
        ("01_ingested", "File validated and job created"),
        ("02_audio", "Audio extracted from video"),
        ("03_raw_transcript", "Initial transcription complete"),
        ("04_verified", "Language verification complete"),
        ("05_diarised", "Speaker diarisation complete"),
        ("06_visual", "Visual verification complete"),
        ("07_complete", "Output generated"),
    ]
    
    async def save_checkpoint(self, job_id: str, phase: str, data: dict):
        """Save checkpoint to local Google Drive path."""
        checkpoint_dir = Path(self.BASE_PATH) / job_id / "checkpoints"
        checkpoint_dir.mkdir(parents=True, exist_ok=True)
        
        checkpoint = {
            "job_id": job_id,
            "phase": phase,
            "timestamp": datetime.now().isoformat(),
            "data": data
        }
        
        checkpoint_path = checkpoint_dir / f"{phase}.json"
        with open(checkpoint_path, 'w', encoding='utf-8') as f:
            json.dump(checkpoint, f, indent=2, ensure_ascii=False)
        
        return checkpoint_path
    
    async def get_latest_checkpoint(self, job_id: str) -> Tuple[str, dict]:
        """Find and load the latest checkpoint for a job."""
        checkpoint_dir = Path(self.BASE_PATH) / job_id / "checkpoints"
        
        if not checkpoint_dir.exists():
            return None, None
        
        # Find latest checkpoint by phase order
        for phase, _ in reversed(self.checkpoint_phases):
            checkpoint_path = checkpoint_dir / f"{phase}.json"
            if checkpoint_path.exists():
                with open(checkpoint_path, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                return phase, data
        
        return None, None
    
    async def can_resume(self, job_id: str) -> bool:
        """Check if a job can be resumed from checkpoint."""
        phase, _ = await self.get_latest_checkpoint(job_id)
        return phase is not None and phase != "07_complete"
```

### Automatic Checkpointing

Checkpoints are saved automatically:
- After each major processing phase
- Every 15 minutes during long operations
- On error (preserves progress)
- On user interrupt (Ctrl+C)

---

## 6. Output Strategy: JSON-First

### Why JSON-First?

1. **Flexibility:** JSON can be transformed to any format (DOCX, SRT, VTT, Markdown)
2. **Structured Data:** Easy to query, filter, search
3. **API Ready:** Direct integration with other systems
4. **Debugging:** Human-readable, easy to inspect
5. **Incremental Updates:** Can update specific segments without regenerating

### JSON Output Schema

```json
{
  "metadata": {
    "job_id": "uuid",
    "source_file": "meeting_2026-01-19.mp4",
    "source_hash": "sha256:...",
    "duration_seconds": 3600,
    "processed_at": "2026-01-19T10:30:00+02:00",
    "processing_time_seconds": 450,
    "language_distribution": {
      "english": 0.65,
      "afrikaans": 0.30,
      "mixed": 0.05
    },
    "quality_metrics": {
      "transcription_confidence": 0.94,
      "speaker_identification_confidence": 0.96,
      "segments_verified_visually": 45,
      "vocabulary_corrections_applied": 12
    }
  },
  "participants": [
    {
      "id": "speaker_1",
      "nemo_cluster_id": 0,
      "identified_name": "Frans Vermaak",
      "identification_method": "visual_verification",
      "visual_description": "Left side of frame, glasses, dark hair",
      "first_appearance": "00:00:05",
      "speaking_time_seconds": 1200,
      "segment_count": 85
    }
  ],
  "transcript": [
    {
      "id": "seg_001",
      "timestamp_start": "00:00:05.230",
      "timestamp_end": "00:00:12.450",
      "speaker_id": "speaker_1",
      "speaker_name": "Frans Vermaak",
      "text": "Good morning everyone. Let's start with the agenda for today.",
      "text_original": "Good morning everyone. Let's start with the agenda for today.",
      "language": "en",
      "language_confidence": 0.98,
      "transcription_confidence": 0.97,
      "word_timestamps": [
        {"word": "Good", "start": 5.23, "end": 5.45},
        {"word": "morning", "start": 5.48, "end": 5.92}
      ],
      "verification": {
        "nemo_speaker_id": 0,
        "visual_verified": true,
        "visual_frame": "frames/frame_00_05.jpg",
        "visual_confidence": "high"
      }
    }
  ],
  "screenshots": [
    {
      "id": "screen_001",
      "timestamp": "00:02:30",
      "file_path": "screenshots/content_00_02_30.jpg",
      "description": "Technical architecture diagram",
      "capture_reason": "screen_share_detected",
      "associated_segments": ["seg_015", "seg_016", "seg_017"]
    }
  ],
  "vocabulary_corrections": [
    {
      "segment_id": "seg_042",
      "original": "the lark AI system",
      "corrected": "the LarcAI system",
      "reason": "company_name"
    }
  ]
}
```

### DOCX Generation from JSON

```python
async def generate_docx(json_path: str, output_path: str, options: DocxOptions):
    """
    Generate professional DOCX from JSON transcript.
    
    Options:
    - include_timestamps: bool
    - include_language_tags: bool
    - include_screenshots: bool
    - speaker_colours: dict[str, str]
    - verbatim_level: "strict" | "clean" | "intelligent"
    """
    
    with open(json_path, 'r') as f:
        data = json.load(f)
    
    doc = Document()
    
    # Add header
    doc.add_heading(f"Meeting Transcript", 0)
    doc.add_paragraph(f"Date: {data['metadata']['processed_at']}")
    doc.add_paragraph(f"Duration: {format_duration(data['metadata']['duration_seconds'])}")
    doc.add_paragraph(f"Participants: {', '.join(p['identified_name'] or p['id'] for p in data['participants'])}")
    
    # Add transcript
    for segment in data['transcript']:
        # Speaker name (bold)
        p = doc.add_paragraph()
        runner = p.add_run(f"{segment['speaker_name']} ")
        runner.bold = True
        
        # Timestamp (grey)
        if options.include_timestamps:
            runner = p.add_run(f"[{segment['timestamp_start']}] ")
            runner.font.color.rgb = RGBColor(128, 128, 128)
        
        # Text
        p.add_run(segment['text'])
        
        # Language tag if mixed
        if options.include_language_tags and segment['language'] == 'mixed':
            runner = p.add_run(" [Mixed EN/AF]")
            runner.font.size = Pt(8)
            runner.font.color.rgb = RGBColor(100, 100, 100)
    
    doc.save(output_path)
```

---

## 7. MCP Tool Definitions

### Primary Tools

| Tool | Description | Annotations |
|------|-------------|-------------|
| `transcription_start` | Start transcription job | readOnly: false, destructive: false |
| `transcription_status` | Check job progress | readOnly: true |
| `transcription_resume` | Resume from checkpoint | readOnly: false |
| `transcription_get_result` | Get completed transcript | readOnly: true |
| `transcription_verify_speaker` | Visual speaker verification | readOnly: true |
| `transcription_capture_screenshot` | Extract frame at timestamp | readOnly: false |
| `transcription_apply_vocabulary` | Apply domain corrections | readOnly: false |
| `transcription_generate_docx` | Generate DOCX from JSON | readOnly: false |

### Tool: transcription_start

```python
class TranscriptionStartInput(BaseModel):
    """Input for starting a transcription job."""
    model_config = ConfigDict(str_strip_whitespace=True, extra='forbid')
    
    file_path: str = Field(
        ..., 
        description="Path to video/audio file",
        min_length=1
    )
    language_hint: str = Field(
        default="auto",
        description="Primary language: en, af, or auto"
    )
    speaker_names: Optional[List[str]] = Field(
        default=None,
        description="Known participant names",
        max_length=10
    )
    vocabulary_file: Optional[str] = Field(
        default=None,
        description="Path to domain vocabulary JSON"
    )
    visual_verification: bool = Field(
        default=True,
        description="Enable visual speaker verification"
    )
    screenshot_capture: bool = Field(
        default=True,
        description="Capture content screenshots"
    )
    max_speakers: int = Field(
        default=4,
        description="Maximum expected speakers (NeMo limit: 4)",
        ge=2, le=4
    )

@mcp.tool(
    name="transcription_start",
    annotations={
        "readOnlyHint": False,
        "destructiveHint": False,
        "idempotentHint": False,
        "openWorldHint": True
    }
)
async def transcription_start(params: TranscriptionStartInput) -> dict:
    """
    Start transcription of a video or audio file.
    
    Creates a new job, validates input, and begins processing.
    Progress can be monitored with transcription_status.
    If interrupted, use transcription_resume to continue.
    
    Returns:
        job_id: Unique identifier for tracking
        estimated_duration: Estimated processing time
        checkpoint_path: Location of checkpoints
    """
    pass
```

### Tool: transcription_resume

```python
class TranscriptionResumeInput(BaseModel):
    """Input for resuming a transcription job."""
    job_id: str = Field(..., description="Job ID to resume")

@mcp.tool(
    name="transcription_resume",
    annotations={
        "readOnlyHint": False,
        "destructiveHint": False,
        "idempotentHint": True,
        "openWorldHint": False
    }
)
async def transcription_resume(params: TranscriptionResumeInput) -> dict:
    """
    Resume a transcription job from its last checkpoint.
    
    Automatically detects the last successful phase and continues
    from that point. All previous work is preserved.
    
    Returns:
        job_id: Job identifier
        resumed_from: Checkpoint phase resumed from
        next_phase: Phase to process next
    """
    checkpoint_mgr = CheckpointManager()
    phase, data = await checkpoint_mgr.get_latest_checkpoint(params.job_id)
    
    if not phase:
        raise ValueError(f"No checkpoint found for job {params.job_id}")
    
    if phase == "07_complete":
        return {"job_id": params.job_id, "status": "already_complete"}
    
    # Continue from next phase
    return await continue_processing(params.job_id, phase, data)
```

---

## 8. Dependencies & Installation

### Python Dependencies

```toml
[project]
name = "transcription-mcp"
version = "1.0.0"
requires-python = ">=3.10"

dependencies = [
    # MCP Server
    "mcp>=1.0.0",
    "pydantic>=2.0.0",
    "httpx>=0.25.0",
    
    # Audio Processing
    "faster-whisper>=1.0.0",
    
    # Speaker Diarisation (NVIDIA NeMo)
    "nemo_toolkit[asr]>=2.0.0",
    "torch>=2.0.0",
    "torchaudio>=2.0.0",
    
    # Media Processing
    "ffmpeg-python>=0.2.0",
    
    # Document Generation
    "python-docx>=1.0.0",
    "Pillow>=10.0.0",
    
    # Utilities
    "aiofiles>=23.0.0",
    "python-dotenv>=1.0.0",
]
```

### System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| Python | 3.10 | 3.11+ |
| RAM | 16 GB | 32 GB |
| GPU VRAM | 8 GB | 16 GB+ |
| Storage | 20 GB free | 100 GB SSD |
| ffmpeg | 5.0+ | 6.0+ |
| CUDA | 11.8+ | 12.x |

### Installation

```bash
# 1. Create virtual environment
python -m venv venv
venv\Scripts\activate  # Windows

# 2. Install CUDA toolkit (if not installed)
# Download from: https://developer.nvidia.com/cuda-downloads

# 3. Install NeMo (requires Cython first)
pip install Cython packaging
pip install "nemo_toolkit[asr]"

# 4. Install remaining dependencies
pip install -e .

# 5. Download Whisper model
python -c "from faster_whisper import WhisperModel; WhisperModel('large-v3')"

# 6. Verify NeMo installation
python -c "import nemo.collections.asr as nemo_asr; print('NeMo OK')"
```

---

## 9. Claude Desktop Integration

```json
{
  "mcpServers": {
    "transcription_mcp": {
      "command": "python",
      "args": ["-m", "transcription_mcp.server"],
      "cwd": "C:\\GitHub\\transcription-mcp",
      "env": {
        "TRANSCRIPTION_WORK_DIR": "G:\\My Drive\\Shared_Download\\AI_Folder\\Memory\\Projects\\Transcription_Jobs",
        "WHISPER_MODEL": "large-v3",
        "WHISPER_DEVICE": "cuda",
        "NEMO_DEVICE": "cuda"
      }
    }
  }
}
```

---

## 10. Quality Targets

| Metric | Target | Measurement |
|--------|--------|-------------|
| Word Error Rate (WER) | <5% | Comparison with manual transcript |
| Language Detection | >98% | Per-segment verification |
| Speaker Attribution | >95% | NeMo + visual verification |
| Timestamp Accuracy | ±1 second | Random sampling |
| Processing Speed | <0.5x realtime | 1hr video in <30min |

---

## 11. File Structure

```
transcription-mcp/
├── src/
│   └── transcription_mcp/
│       ├── __init__.py
│       ├── server.py              # MCP server entry
│       ├── tools/
│       │   ├── __init__.py
│       │   ├── ingest.py          # File validation
│       │   ├── transcribe.py      # Whisper integration
│       │   ├── diarise.py         # NeMo integration
│       │   ├── verify.py          # Visual verification
│       │   └── output.py          # JSON/DOCX generation
│       ├── processing/
│       │   ├── __init__.py
│       │   ├── audio.py           # ffmpeg wrapper
│       │   ├── whisper_engine.py  # faster-whisper
│       │   ├── nemo_engine.py     # NeMo diarisation
│       │   └── frames.py          # Frame extraction
│       ├── models/
│       │   ├── __init__.py
│       │   ├── inputs.py          # Pydantic inputs
│       │   ├── outputs.py         # Pydantic outputs
│       │   └── transcript.py      # Transcript model
│       └── utils/
│           ├── __init__.py
│           ├── checkpoint.py      # Checkpoint manager
│           ├── vocabulary.py      # Vocabulary manager
│           └── config.py          # Configuration
├── config/
│   └── vocabulary/
│       ├── technical.json
│       └── company.json
├── tests/
├── pyproject.toml
├── README.md
└── .env.example
```

---

## 12. References

### MPD Skills
- SK-015: Transcription Methodology
- SK-016: Afrikaans Language Processing
- SK-017: Speaker Diarisation
- SK-019: Multimodal Analysis

### External Documentation
- [NVIDIA NeMo Speaker Diarisation](https://docs.nvidia.com/nemo-framework/user-guide/latest/nemotoolkit/asr/speaker_diarization/intro.html)
- [faster-whisper Documentation](https://github.com/SYSTRAN/faster-whisper)
- [MCP Python SDK](https://github.com/modelcontextprotocol/python-sdk)

---

**Document Status:** Final Architecture  
**Next Steps:** Create project structure and implement core server
