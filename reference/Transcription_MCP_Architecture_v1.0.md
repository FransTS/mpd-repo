# Transcription MCP Server Architecture
## LarcAI Video/Audio Transcription Pipeline

**Version:** 1.0 Draft  
**Created:** 19 January 2026  
**Author:** Frans Vermaak, CTGO  
**Project:** MPD Enhancement - Transcription Automation

---

## 1. Executive Summary

### Purpose
Build a dedicated MCP server to automate transcription of 1-2 hour bilingual (English/Afrikaans) video meetings with:
- **>98% language accuracy** through multi-pass verification
- **>95% speaker identification accuracy** through visual frame analysis
- Synchronised screenshot integration for visual content reference
- Professional document output with timestamps and speaker attribution

### Critical Design Principles

| Priority | Requirement | Rationale |
|----------|-------------|-----------|
| 1 | Language Accuracy | Incorrect transcription → wrong summaries → flawed decisions |
| 2 | Speaker Attribution | Who said what is essential for accountability and context |
| 3 | Visual Correlation | Technical discussions often reference on-screen content |
| 4 | Processing Efficiency | 1-2 hour videos must complete in reasonable time |

---

## 2. Architecture Overview

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
                    │  • pyannote-audio (diarisation) │
                    │  • Claude Vision (frame verify) │
                    └─────────────────────────────────┘
```

---

## 3. Three-Pass Processing Engine

### Pass 1: Initial Transcription
- Extract audio (ffmpeg)
- Segment by silence (VAD)
- Transcribe with faster-whisper (large-v3 multilingual model)
- Output: Raw segments with timestamps

### Pass 2: Language Verification
- Detect language per segment (EN/AF/Mixed)
- Flag low-confidence segments (<0.85)
- Re-transcribe flagged segments with language hint
- Apply vocabulary corrections
- Output: Verified transcript with language tags

### Pass 3: Speaker Diarisation
- Audio-based speaker clustering (pyannote)
- Extract key frames for visual verification
- Correlate speakers with visual identification
- Output: Speaker-attributed transcript

---

## 4. Visual Speaker Identification

### Frame Extraction Strategy
- Every 30 seconds (baseline)
- At detected speaker changes
- After significant pauses (>3 sec)
- At topic transitions

### Visual Analysis (Claude Vision)
- Count visible participants
- Identify active speaker (camera focus, lip movement)
- Track speaker positions (left/right/centre)
- Detect on-screen content (slides, demos)

### Accuracy Improvement
| Method | Speaker Accuracy |
|--------|------------------|
| Audio-only guess | ~60-70% |
| Content analysis | ~75-85% |
| Visual verification | >98% |

---

## 5. Primary Tools

| Tool | Purpose |
|------|---------|
| `transcription_start` | Start transcription job |
| `transcription_status` | Check processing progress |
| `transcription_get_result` | Retrieve completed transcript |
| `transcription_verify_speaker` | Visual verification for segment |
| `transcription_capture_screenshot` | Extract frame at timestamp |
| `transcription_apply_vocabulary` | Apply domain corrections |

---

## 6. Output Formats

| Format | Use Case |
|--------|----------|
| DOCX | Professional delivery with embedded screenshots |
| JSON | Integration/API with full metadata |
| SRT/VTT | Video subtitles |
| Markdown | Quick review |

---

## 7. Dependencies

### Core
- Python 3.10+
- faster-whisper (large-v3)
- pyannote-audio 3.1+
- ffmpeg 5.0+

### Optional
- NVIDIA GPU (8GB+ VRAM) for faster processing

---

## 8. Quality Targets

| Metric | Target |
|--------|--------|
| Word Error Rate | <5% |
| Language Detection | >98% |
| Speaker Attribution | >95% |
| Timestamp Accuracy | ±1 second |

---

## 9. Integration

### Claude Desktop Config
```json
{
  "mcpServers": {
    "transcription_mcp": {
      "command": "python",
      "args": ["-m", "transcription_mcp.server"],
      "cwd": "C:\\GitHub\\transcription-mcp"
    }
  }
}
```

---

**Full architecture document:** See `/reference/Transcription_MCP_Architecture_v1.0.md`

**Status:** Draft for Review
