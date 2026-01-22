"""
Transcription MCP Server v2.0
WhisperX-based bilingual transcription with speaker diarization

Author: Frans Vermaak, CTGO @ LarcAI
Created: 20 January 2026
"""

import asyncio
import json
import os
import logging
from datetime import datetime
from pathlib import Path
from typing import Optional
from uuid import uuid4

from dotenv import load_dotenv
from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent
from pydantic import BaseModel, Field

from .transcriber import WhisperXTranscriber
from .checkpoint import CheckpointManager
from .vocabulary import VocabularyCorrector
from .output import OutputGenerator

# Load environment
load_dotenv()

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
logger = logging.getLogger(__name__)

# Configuration
WORK_DIR = Path(os.getenv(
    "WORK_DIR",
    r"G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs"
))
HF_TOKEN = os.getenv("HF_TOKEN")

# Ensure work directory exists
WORK_DIR.mkdir(parents=True, exist_ok=True)

# Active jobs tracking
active_jobs: dict[str, dict] = {}


class TranscribeInput(BaseModel):
    """Input parameters for transcription"""
    file_path: str = Field(..., description="Path to audio/video file")
    language: str = Field(default="auto", description="Language: en, af, or auto")
    speakers: Optional[list[str]] = Field(default=None, description="Known speaker names")
    model: str = Field(default="auto", description="Model: medium, large-v2, or auto")
    diarize: bool = Field(default=True, description="Enable speaker diarization")
    output_format: str = Field(default="both", description="Output: json, docx, or both")
    resume_job_id: Optional[str] = Field(default=None, description="Job ID to resume")


class TranscribeStatusInput(BaseModel):
    """Input for checking job status"""
    job_id: str = Field(..., description="Job ID to check")


class VocabularyAddInput(BaseModel):
    """Input for adding vocabulary corrections"""
    incorrect: str = Field(..., description="Incorrect transcription")
    correct: str = Field(..., description="Correct term")


# Initialize MCP server
server = Server("transcription-mcp")


@server.list_tools()
async def list_tools() -> list[Tool]:
    """List available transcription tools"""
    return [
        Tool(
            name="transcribe",
            description="Transcribe audio/video file with optional speaker diarization. "
                       "Supports English and Afrikaans. Handles files up to 120 minutes. "
                       "Automatically saves checkpoints for crash recovery.",
            inputSchema=TranscribeInput.model_json_schema()
        ),
        Tool(
            name="transcribe_status",
            description="Check the status of a transcription job",
            inputSchema=TranscribeStatusInput.model_json_schema()
        ),
        Tool(
            name="transcribe_list",
            description="List all transcription jobs",
            inputSchema={"type": "object", "properties": {}}
        ),
        Tool(
            name="transcribe_cancel",
            description="Cancel a running transcription job",
            inputSchema=TranscribeStatusInput.model_json_schema()
        ),
        Tool(
            name="vocabulary_add",
            description="Add a vocabulary correction for domain-specific terms",
            inputSchema=VocabularyAddInput.model_json_schema()
        ),
    ]


@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    """Handle tool calls"""
    
    if name == "transcribe":
        return await handle_transcribe(TranscribeInput(**arguments))
    
    elif name == "transcribe_status":
        return await handle_status(TranscribeStatusInput(**arguments))
    
    elif name == "transcribe_list":
        return await handle_list()
    
    elif name == "transcribe_cancel":
        return await handle_cancel(TranscribeStatusInput(**arguments))
    
    elif name == "vocabulary_add":
        return await handle_vocabulary_add(VocabularyAddInput(**arguments))
    
    else:
        return [TextContent(type="text", text=f"Unknown tool: {name}")]


async def handle_transcribe(params: TranscribeInput) -> list[TextContent]:
    """Handle transcription request"""
    
    # Check for resume
    if params.resume_job_id:
        job_id = params.resume_job_id
        job_dir = WORK_DIR / job_id
        if not job_dir.exists():
            return [TextContent(
                type="text",
                text=f"Job not found: {job_id}"
            )]
    else:
        # Create new job
        job_id = f"trans_{datetime.now().strftime('%Y%m%d_%H%M%S')}_{uuid4().hex[:6]}"
        job_dir = WORK_DIR / job_id
        job_dir.mkdir(parents=True, exist_ok=True)
    
    # Validate file
    file_path = Path(params.file_path)
    if not file_path.exists():
        return [TextContent(
            type="text",
            text=f"File not found: {params.file_path}"
        )]
    
    # Check HuggingFace token for diarization
    if params.diarize and not HF_TOKEN:
        return [TextContent(
            type="text",
            text="Diarization requires HF_TOKEN in environment. "
                 "Set it in .env or Claude Desktop config."
        )]
    
    # Initialize components
    checkpoint_mgr = CheckpointManager(job_dir)
    vocab_corrector = VocabularyCorrector()
    output_gen = OutputGenerator()
    
    # Check for existing checkpoint
    last_checkpoint = checkpoint_mgr.get_latest()
    resume_from = None
    if last_checkpoint:
        resume_from = last_checkpoint["phase"]
        logger.info(f"Resuming from checkpoint: {resume_from}")
    
    # Create job metadata
    metadata = {
        "job_id": job_id,
        "file_path": str(file_path),
        "language": params.language,
        "speakers": params.speakers,
        "model": params.model,
        "diarize": params.diarize,
        "output_format": params.output_format,
        "created_at": datetime.now().isoformat(),
        "status": "starting"
    }
    
    # Save metadata
    with open(job_dir / "metadata.json", "w") as f:
        json.dump(metadata, f, indent=2)
    
    # Track active job
    active_jobs[job_id] = {
        "status": "running",
        "progress": 0,
        "phase": "starting"
    }
    
    try:
        # Initialize transcriber
        transcriber = WhisperXTranscriber(
            model_name=params.model,
            language=params.language if params.language != "auto" else None,
            hf_token=HF_TOKEN if params.diarize else None,
            job_dir=job_dir,
            checkpoint_mgr=checkpoint_mgr
        )
        
        # Get file info
        duration = transcriber.get_audio_duration(file_path)
        estimated_time = duration * 0.3  # ~0.3x realtime on 4GB GPU
        
        # Update status
        active_jobs[job_id].update({
            "duration": duration,
            "estimated_time": estimated_time,
            "phase": "transcribing"
        })
        
        # Run transcription (async with progress updates)
        result = await transcriber.transcribe(
            file_path,
            diarize=params.diarize,
            speaker_names=params.speakers,
            resume_from=resume_from
        )
        
        # Apply vocabulary corrections
        active_jobs[job_id]["phase"] = "correcting"
        result = vocab_corrector.apply_corrections(result)
        
        # Generate outputs
        active_jobs[job_id]["phase"] = "generating_output"
        output_paths = {}
        
        if params.output_format in ["json", "both"]:
            json_path = output_gen.generate_json(result, job_dir / "output")
            output_paths["json"] = str(json_path)
        
        if params.output_format in ["docx", "both"]:
            docx_path = output_gen.generate_docx(result, job_dir / "output")
            output_paths["docx"] = str(docx_path)
        
        # Save final checkpoint
        checkpoint_mgr.save("06_complete", {
            "result": result,
            "output_paths": output_paths
        })
        
        # Update metadata
        metadata["status"] = "complete"
        metadata["completed_at"] = datetime.now().isoformat()
        metadata["output_paths"] = output_paths
        with open(job_dir / "metadata.json", "w") as f:
            json.dump(metadata, f, indent=2)
        
        # Update tracking
        active_jobs[job_id].update({
            "status": "complete",
            "progress": 100,
            "phase": "complete"
        })
        
        # Format response
        speaker_summary = ""
        if result.get("speakers"):
            speaker_summary = "\nSpeakers identified:\n"
            for s in result["speakers"]:
                speaker_summary += f"  - {s['name']}: {s['speaking_time']:.0f}s\n"
        
        return [TextContent(
            type="text",
            text=f"Transcription complete!\n\n"
                 f"Job ID: {job_id}\n"
                 f"Duration: {duration/60:.1f} minutes\n"
                 f"Segments: {len(result.get('segments', []))}\n"
                 f"{speaker_summary}\n"
                 f"Output files:\n"
                 f"  JSON: {output_paths.get('json', 'N/A')}\n"
                 f"  DOCX: {output_paths.get('docx', 'N/A')}"
        )]
        
    except Exception as e:
        logger.exception(f"Transcription failed: {e}")
        
        # Update status
        active_jobs[job_id].update({
            "status": "failed",
            "error": str(e)
        })
        
        metadata["status"] = "failed"
        metadata["error"] = str(e)
        with open(job_dir / "metadata.json", "w") as f:
            json.dump(metadata, f, indent=2)
        
        return [TextContent(
            type="text",
            text=f"Transcription failed: {e}\n\n"
                 f"Job ID: {job_id}\n"
                 f"Checkpoints saved. Resume with: transcribe(resume_job_id='{job_id}')"
        )]


async def handle_status(params: TranscribeStatusInput) -> list[TextContent]:
    """Handle status check"""
    
    job_id = params.job_id
    
    # Check active jobs first
    if job_id in active_jobs:
        job = active_jobs[job_id]
        return [TextContent(
            type="text",
            text=f"Job: {job_id}\n"
                 f"Status: {job['status']}\n"
                 f"Phase: {job.get('phase', 'unknown')}\n"
                 f"Progress: {job.get('progress', 0)}%"
        )]
    
    # Check on disk
    job_dir = WORK_DIR / job_id
    if not job_dir.exists():
        return [TextContent(type="text", text=f"Job not found: {job_id}")]
    
    metadata_path = job_dir / "metadata.json"
    if metadata_path.exists():
        with open(metadata_path) as f:
            metadata = json.load(f)
        
        return [TextContent(
            type="text",
            text=f"Job: {job_id}\n"
                 f"Status: {metadata.get('status', 'unknown')}\n"
                 f"File: {metadata.get('file_path', 'N/A')}\n"
                 f"Created: {metadata.get('created_at', 'N/A')}\n"
                 f"Completed: {metadata.get('completed_at', 'N/A')}"
        )]
    
    return [TextContent(type="text", text=f"Job metadata not found: {job_id}")]


async def handle_list() -> list[TextContent]:
    """List all jobs"""
    
    jobs = []
    
    # List directories in work dir
    if WORK_DIR.exists():
        for job_dir in WORK_DIR.iterdir():
            if job_dir.is_dir() and job_dir.name.startswith("trans_"):
                metadata_path = job_dir / "metadata.json"
                if metadata_path.exists():
                    with open(metadata_path) as f:
                        metadata = json.load(f)
                    jobs.append({
                        "job_id": job_dir.name,
                        "status": metadata.get("status", "unknown"),
                        "created": metadata.get("created_at", "N/A")
                    })
    
    if not jobs:
        return [TextContent(type="text", text="No transcription jobs found.")]
    
    # Format list
    lines = ["Transcription Jobs:", ""]
    for job in sorted(jobs, key=lambda x: x["created"], reverse=True)[:10]:
        lines.append(f"  {job['job_id']}: {job['status']}")
    
    if len(jobs) > 10:
        lines.append(f"\n  ... and {len(jobs) - 10} more")
    
    return [TextContent(type="text", text="\n".join(lines))]


async def handle_cancel(params: TranscribeStatusInput) -> list[TextContent]:
    """Cancel a running job"""
    
    job_id = params.job_id
    
    if job_id in active_jobs:
        active_jobs[job_id]["status"] = "cancelled"
        return [TextContent(
            type="text",
            text=f"Cancellation requested for job: {job_id}\n"
                 f"Checkpoints have been saved."
        )]
    
    return [TextContent(type="text", text=f"Job not running: {job_id}")]


async def handle_vocabulary_add(params: VocabularyAddInput) -> list[TextContent]:
    """Add vocabulary correction"""
    
    vocab_corrector = VocabularyCorrector()
    vocab_corrector.add_correction(params.incorrect, params.correct)
    
    return [TextContent(
        type="text",
        text=f"Added vocabulary correction:\n"
             f"  '{params.incorrect}' -> '{params.correct}'"
    )]


async def main():
    """Run the MCP server"""
    logger.info("Starting Transcription MCP Server v2.0")
    logger.info(f"Work directory: {WORK_DIR}")
    logger.info(f"HuggingFace token: {'configured' if HF_TOKEN else 'NOT SET'}")
    
    async with stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream,
            write_stream,
            server.create_initialization_options()
        )


if __name__ == "__main__":
    asyncio.run(main())
