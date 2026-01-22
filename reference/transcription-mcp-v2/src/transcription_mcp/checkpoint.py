"""
Checkpoint Manager for Crash Recovery
Saves and loads job state at each processing phase

Author: Frans Vermaak, CTGO @ LarcAI
"""

import json
import logging
from datetime import datetime
from pathlib import Path
from typing import Optional

logger = logging.getLogger(__name__)


class CheckpointManager:
    """
    Manages job state persistence for crash recovery.
    
    Checkpoints are saved after each major phase:
    - 01_ingested: Audio extracted
    - 02_chunked: Audio split into chunks
    - 03_transcribed_chunk_XX: Each chunk transcribed
    - 04_diarized: Speakers identified
    - 05_processed: Post-processing complete
    - 06_complete: Final output generated
    """
    
    PHASES = [
        "01_ingested",
        "02_chunked",
        # 03_transcribed_chunk_XX are dynamic
        "04_diarized",
        "05_processed",
        "06_complete"
    ]
    
    def __init__(self, job_dir: Path):
        self.job_dir = Path(job_dir)
        self.checkpoint_dir = self.job_dir / "checkpoints"
        self.checkpoint_dir.mkdir(parents=True, exist_ok=True)
    
    def save(self, phase: str, data: dict) -> Path:
        """
        Save checkpoint for a processing phase.
        
        Args:
            phase: Phase identifier (e.g., "01_ingested")
            data: State data to persist
        
        Returns:
            Path to saved checkpoint file
        """
        checkpoint = {
            "phase": phase,
            "timestamp": datetime.now().isoformat(),
            "data": data
        }
        
        checkpoint_path = self.checkpoint_dir / f"{phase}.json"
        
        # Write atomically (write to temp, then rename)
        temp_path = checkpoint_path.with_suffix(".tmp")
        with open(temp_path, "w", encoding="utf-8") as f:
            json.dump(checkpoint, f, indent=2, ensure_ascii=False, default=str)
        
        temp_path.replace(checkpoint_path)
        
        logger.info(f"Checkpoint saved: {phase}")
        return checkpoint_path
    
    def load(self, phase: str) -> Optional[dict]:
        """
        Load checkpoint data for a specific phase.
        
        Args:
            phase: Phase identifier
        
        Returns:
            Checkpoint data or None if not found
        """
        checkpoint_path = self.checkpoint_dir / f"{phase}.json"
        
        if not checkpoint_path.exists():
            return None
        
        with open(checkpoint_path, "r", encoding="utf-8") as f:
            checkpoint = json.load(f)
        
        return checkpoint.get("data")
    
    def get_latest(self) -> Optional[dict]:
        """
        Find the most recent checkpoint.
        
        Returns:
            Dictionary with phase and data of latest checkpoint
        """
        latest = None
        latest_time = None
        
        for checkpoint_file in self.checkpoint_dir.glob("*.json"):
            with open(checkpoint_file, "r", encoding="utf-8") as f:
                checkpoint = json.load(f)
            
            timestamp = datetime.fromisoformat(checkpoint["timestamp"])
            
            if latest_time is None or timestamp > latest_time:
                latest_time = timestamp
                latest = checkpoint
        
        return latest
    
    def get_resume_phase(self) -> Optional[str]:
        """
        Determine which phase to resume from.
        
        Returns:
            Phase identifier to resume from, or None if no checkpoints
        """
        latest = self.get_latest()
        
        if not latest:
            return None
        
        return latest["phase"]
    
    def list_checkpoints(self) -> list[dict]:
        """
        List all saved checkpoints.
        
        Returns:
            List of checkpoint summaries (phase, timestamp)
        """
        checkpoints = []
        
        for checkpoint_file in sorted(self.checkpoint_dir.glob("*.json")):
            with open(checkpoint_file, "r", encoding="utf-8") as f:
                checkpoint = json.load(f)
            
            checkpoints.append({
                "phase": checkpoint["phase"],
                "timestamp": checkpoint["timestamp"],
                "file": str(checkpoint_file)
            })
        
        return checkpoints
    
    def clear(self):
        """Remove all checkpoints (use with caution)"""
        for checkpoint_file in self.checkpoint_dir.glob("*.json"):
            checkpoint_file.unlink()
        
        logger.info("All checkpoints cleared")
    
    def is_complete(self) -> bool:
        """Check if job completed successfully"""
        complete_checkpoint = self.checkpoint_dir / "06_complete.json"
        return complete_checkpoint.exists()
