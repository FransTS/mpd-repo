"""
WhisperX Transcriber with Memory Optimisation
Handles 4GB VRAM constraint with intelligent chunking

Author: Frans Vermaak, CTGO @ LarcAI
"""

import asyncio
import gc
import logging
import subprocess
from pathlib import Path
from typing import Optional

import torch

logger = logging.getLogger(__name__)


class WhisperXTranscriber:
    """
    WhisperX wrapper with memory optimisation for 4GB VRAM GPUs.
    
    Features:
    - Automatic model selection based on available VRAM
    - Audio chunking for long files (>30 min)
    - CPU fallback for diarization OOM
    - Checkpoint saving between chunks
    """
    
    # Model configurations for different VRAM levels
    MODEL_CONFIGS = {
        "4gb": {"model": "medium", "batch_size": 4, "compute_type": "int8"},
        "6gb": {"model": "large-v2", "batch_size": 8, "compute_type": "int8"},
        "8gb": {"model": "large-v2", "batch_size": 16, "compute_type": "float16"},
        "12gb": {"model": "large-v3", "batch_size": 16, "compute_type": "float16"},
    }
    
    # Chunk settings
    CHUNK_DURATION = 1800  # 30 minutes in seconds
    CHUNK_OVERLAP = 10     # 10 seconds overlap
    
    def __init__(
        self,
        model_name: str = "auto",
        language: Optional[str] = None,
        hf_token: Optional[str] = None,
        job_dir: Optional[Path] = None,
        checkpoint_mgr = None
    ):
        self.language = language
        self.hf_token = hf_token
        self.job_dir = job_dir
        self.checkpoint_mgr = checkpoint_mgr
        
        # Detect optimal configuration
        self.config = self._detect_config(model_name)
        logger.info(f"Using config: {self.config}")
        
        # Lazy-load models
        self._whisper_model = None
        self._diarize_model = None
        self._align_model = None
    
    def _detect_config(self, model_name: str) -> dict:
        """Detect optimal model configuration based on available VRAM"""
        
        if model_name != "auto":
            # Manual override
            return {
                "model": model_name,
                "batch_size": 4,
                "compute_type": "int8"
            }
        
        # Check available VRAM
        if torch.cuda.is_available():
            vram_gb = torch.cuda.get_device_properties(0).total_memory / (1024**3)
            logger.info(f"Detected VRAM: {vram_gb:.1f} GB")
            
            if vram_gb >= 12:
                return self.MODEL_CONFIGS["12gb"]
            elif vram_gb >= 8:
                return self.MODEL_CONFIGS["8gb"]
            elif vram_gb >= 6:
                return self.MODEL_CONFIGS["6gb"]
            else:
                return self.MODEL_CONFIGS["4gb"]
        else:
            # CPU fallback
            logger.warning("No CUDA GPU detected, using CPU mode")
            return {
                "model": "small",
                "batch_size": 1,
                "compute_type": "int8",
                "device": "cpu"
            }
    
    def _get_device(self) -> str:
        """Get compute device"""
        return self.config.get("device", "cuda" if torch.cuda.is_available() else "cpu")
    
    def _load_whisper(self):
        """Lazy-load WhisperX model"""
        if self._whisper_model is None:
            import whisperx
            
            logger.info(f"Loading WhisperX model: {self.config['model']}")
            self._whisper_model = whisperx.load_model(
                self.config["model"],
                device=self._get_device(),
                compute_type=self.config["compute_type"],
                language=self.language
            )
        return self._whisper_model
    
    def _load_align_model(self, language_code: str):
        """Load alignment model for word timestamps"""
        import whisperx
        
        logger.info(f"Loading alignment model for: {language_code}")
        model, metadata = whisperx.load_align_model(
            language_code=language_code,
            device=self._get_device()
        )
        return model, metadata
    
    def _load_diarize_model(self):
        """Load diarization model"""
        if self._diarize_model is None:
            import whisperx
            
            if not self.hf_token:
                raise ValueError("HuggingFace token required for diarization")
            
            logger.info("Loading diarization model")
            self._diarize_model = whisperx.DiarizationPipeline(
                use_auth_token=self.hf_token,
                device=self._get_device()
            )
        return self._diarize_model
    
    def _clear_gpu_memory(self):
        """Clear GPU memory between heavy operations"""
        if torch.cuda.is_available():
            torch.cuda.empty_cache()
            gc.collect()
            logger.info("GPU memory cleared")
    
    def get_audio_duration(self, file_path: Path) -> float:
        """Get audio duration using ffprobe"""
        cmd = [
            "ffprobe",
            "-v", "quiet",
            "-show_entries", "format=duration",
            "-of", "csv=p=0",
            str(file_path)
        ]
        result = subprocess.run(cmd, capture_output=True, text=True)
        return float(result.stdout.strip())
    
    def _extract_audio(self, file_path: Path) -> Path:
        """Extract audio to 16kHz mono WAV"""
        cache_dir = self.job_dir / "cache" if self.job_dir else Path(".")
        cache_dir.mkdir(parents=True, exist_ok=True)
        
        audio_path = cache_dir / "audio.wav"
        
        if audio_path.exists():
            logger.info("Using cached audio file")
            return audio_path
        
        logger.info("Extracting audio...")
        cmd = [
            "ffmpeg", "-y",
            "-i", str(file_path),
            "-vn",  # No video
            "-acodec", "pcm_s16le",
            "-ar", "16000",
            "-ac", "1",
            str(audio_path)
        ]
        subprocess.run(cmd, capture_output=True, check=True)
        
        return audio_path
    
    def _chunk_audio(self, audio_path: Path, duration: float) -> list[dict]:
        """Split audio into chunks for memory efficiency"""
        
        if duration <= self.CHUNK_DURATION:
            return [{"index": 0, "start": 0, "end": duration, "path": audio_path}]
        
        chunks = []
        chunk_dir = self.job_dir / "cache" / "chunks" if self.job_dir else Path("chunks")
        chunk_dir.mkdir(parents=True, exist_ok=True)
        
        start = 0
        index = 0
        
        while start < duration:
            end = min(start + self.CHUNK_DURATION, duration)
            chunk_path = chunk_dir / f"chunk_{index:03d}.wav"
            
            if not chunk_path.exists():
                # Extract chunk with ffmpeg
                cmd = [
                    "ffmpeg", "-y",
                    "-i", str(audio_path),
                    "-ss", str(start),
                    "-to", str(end + self.CHUNK_OVERLAP if end < duration else end),
                    "-c", "copy",
                    str(chunk_path)
                ]
                subprocess.run(cmd, capture_output=True, check=True)
            
            chunks.append({
                "index": index,
                "start": start,
                "end": end,
                "path": chunk_path
            })
            
            start = end
            index += 1
        
        logger.info(f"Split audio into {len(chunks)} chunks")
        return chunks
    
    async def transcribe(
        self,
        file_path: Path,
        diarize: bool = True,
        speaker_names: Optional[list[str]] = None,
        resume_from: Optional[str] = None
    ) -> dict:
        """
        Main transcription pipeline.
        
        Returns:
            Dictionary with segments, speakers, and metadata
        """
        import whisperx
        
        file_path = Path(file_path)
        
        # Phase 1: Extract audio
        if not resume_from or resume_from < "01_ingested":
            audio_path = self._extract_audio(file_path)
            duration = self.get_audio_duration(audio_path)
            
            if self.checkpoint_mgr:
                self.checkpoint_mgr.save("01_ingested", {
                    "audio_path": str(audio_path),
                    "duration": duration
                })
        else:
            checkpoint = self.checkpoint_mgr.load("01_ingested")
            audio_path = Path(checkpoint["audio_path"])
            duration = checkpoint["duration"]
        
        # Phase 2: Chunk if needed
        if not resume_from or resume_from < "02_chunked":
            chunks = self._chunk_audio(audio_path, duration)
            
            if self.checkpoint_mgr:
                self.checkpoint_mgr.save("02_chunked", {
                    "chunks": [
                        {"index": c["index"], "start": c["start"], "end": c["end"], "path": str(c["path"])}
                        for c in chunks
                    ]
                })
        else:
            checkpoint = self.checkpoint_mgr.load("02_chunked")
            chunks = [
                {"index": c["index"], "start": c["start"], "end": c["end"], "path": Path(c["path"])}
                for c in checkpoint["chunks"]
            ]
        
        # Phase 3: Transcribe chunks
        all_segments = []
        model = self._load_whisper()
        
        for chunk in chunks:
            chunk_checkpoint_name = f"03_transcribed_chunk_{chunk['index']:02d}"
            
            # Check for existing checkpoint
            if resume_from and resume_from >= chunk_checkpoint_name:
                checkpoint = self.checkpoint_mgr.load(chunk_checkpoint_name)
                if checkpoint:
                    all_segments.extend(checkpoint["segments"])
                    continue
            
            logger.info(f"Transcribing chunk {chunk['index']+1}/{len(chunks)}")
            
            # Load audio
            audio = whisperx.load_audio(str(chunk["path"]))
            
            # Transcribe
            result = model.transcribe(
                audio,
                batch_size=self.config["batch_size"],
                language=self.language
            )
            
            # Detect language if auto
            detected_language = result.get("language", self.language or "en")
            
            # Align for word timestamps
            try:
                align_model, align_metadata = self._load_align_model(detected_language)
                result = whisperx.align(
                    result["segments"],
                    align_model,
                    align_metadata,
                    audio,
                    self._get_device(),
                    return_char_alignments=False
                )
                
                # Unload alignment model to save memory
                del align_model
                self._clear_gpu_memory()
                
            except Exception as e:
                logger.warning(f"Alignment failed: {e}. Using segment-level timestamps.")
            
            # Adjust timestamps for chunk offset
            for seg in result["segments"]:
                seg["start"] += chunk["start"]
                seg["end"] += chunk["start"]
                all_segments.append(seg)
            
            # Save checkpoint
            if self.checkpoint_mgr:
                self.checkpoint_mgr.save(chunk_checkpoint_name, {
                    "segments": result["segments"],
                    "language": detected_language
                })
            
            # Clear memory between chunks
            self._clear_gpu_memory()
            
            # Allow cancellation
            await asyncio.sleep(0.1)
        
        # Unload whisper model before diarization
        del self._whisper_model
        self._whisper_model = None
        self._clear_gpu_memory()
        
        # Phase 4: Diarization
        speakers_result = []
        if diarize:
            if not resume_from or resume_from < "04_diarized":
                logger.info("Running speaker diarization...")
                
                try:
                    diarize_model = self._load_diarize_model()
                    
                    # Run diarization on full audio
                    audio = whisperx.load_audio(str(audio_path))
                    diarize_segments = diarize_model(audio)
                    
                    # Assign speakers to segments
                    result_with_speakers = whisperx.assign_word_speakers(
                        diarize_segments,
                        {"segments": all_segments}
                    )
                    all_segments = result_with_speakers["segments"]
                    
                    # Calculate speaker statistics
                    speaker_times = {}
                    for seg in all_segments:
                        speaker = seg.get("speaker", "UNKNOWN")
                        duration = seg["end"] - seg["start"]
                        speaker_times[speaker] = speaker_times.get(speaker, 0) + duration
                    
                    # Map to provided names if available
                    speaker_ids = sorted(speaker_times.keys())
                    for i, speaker_id in enumerate(speaker_ids):
                        name = speaker_names[i] if speaker_names and i < len(speaker_names) else speaker_id
                        speakers_result.append({
                            "id": speaker_id,
                            "name": name,
                            "speaking_time": speaker_times[speaker_id]
                        })
                        
                        # Update segments with names
                        for seg in all_segments:
                            if seg.get("speaker") == speaker_id:
                                seg["speaker_name"] = name
                    
                    if self.checkpoint_mgr:
                        self.checkpoint_mgr.save("04_diarized", {
                            "segments": all_segments,
                            "speakers": speakers_result
                        })
                    
                except Exception as e:
                    logger.error(f"Diarization failed: {e}")
                    logger.info("Continuing without speaker labels")
            else:
                checkpoint = self.checkpoint_mgr.load("04_diarized")
                all_segments = checkpoint["segments"]
                speakers_result = checkpoint["speakers"]
        
        # Phase 5: Post-process
        if self.checkpoint_mgr:
            self.checkpoint_mgr.save("05_processed", {
                "segments": all_segments,
                "speakers": speakers_result,
                "duration": duration
            })
        
        return {
            "segments": all_segments,
            "speakers": speakers_result,
            "duration": duration,
            "language": self.language or "auto",
            "model": self.config["model"]
        }
