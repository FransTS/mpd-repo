"""
Transcription MCP Server v2.0
WhisperX-based bilingual transcription with speaker diarization

Author: Frans Vermaak, CTGO @ LarcAI
Version: 2.0.0
"""

__version__ = "2.0.0"

from .server import main
from .transcriber import WhisperXTranscriber
from .checkpoint import CheckpointManager
from .vocabulary import VocabularyCorrector
from .output import OutputGenerator

__all__ = [
    "main",
    "WhisperXTranscriber",
    "CheckpointManager", 
    "VocabularyCorrector",
    "OutputGenerator",
]
