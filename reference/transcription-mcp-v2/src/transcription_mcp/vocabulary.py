"""
Vocabulary Corrector for Domain-Specific Terms
Fixes common ASR mistakes for technical and company terms

Author: Frans Vermaak, CTGO @ LarcAI
"""

import json
import logging
import re
from pathlib import Path
from typing import Optional

logger = logging.getLogger(__name__)

# Default vocabulary file location
DEFAULT_VOCAB_PATH = Path(__file__).parent.parent.parent / "config" / "vocabulary.json"


class VocabularyCorrector:
    """
    Post-processing vocabulary corrector.
    
    Fixes common ASR mistakes like:
    - "lock ai" -> "LarcAI"
    - "france" -> "Frans" (in speaker context)
    - "c shop" -> "C#"
    """
    
    # Built-in corrections (always applied)
    BUILTIN_CORRECTIONS = {
        # Company names
        "lock ai": "LarcAI",
        "lark ai": "LarcAI",
        "larc ai": "LarcAI",
        "lark": "LarcAI",
        
        # Person names
        "france": "Frans",
        "franz": "Frans",
        "magdell": "Magdel",
        "magdal": "Magdel",
        
        # Technical terms
        "c shop": "C#",
        "c sharp": "C#",
        "see sharp": "C#",
        "your path": "UiPath",
        "ui path": "UiPath",
        "you i path": "UiPath",
        "banks": "BaNCS",  # Capitec banking system
        
        # Common technical
        "github": "GitHub",
        "javascript": "JavaScript",
        "typescript": "TypeScript",
        "python": "Python",
        "nodejs": "Node.js",
        "node js": "Node.js",
        "api": "API",
        "apis": "APIs",
        "sql": "SQL",
        "json": "JSON",
        "yaml": "YAML",
        "html": "HTML",
        "css": "CSS",
        
        # AI/ML terms
        "gpt": "GPT",
        "chatgpt": "ChatGPT",
        "claude": "Claude",
        "anthropic": "Anthropic",
        "open ai": "OpenAI",
        "openai": "OpenAI",
        "llm": "LLM",
        "llms": "LLMs",
        "rag": "RAG",
        
        # Afrikaans common words often misheard
        "ja nee": "ja-nee",
        "janee": "ja-nee",
    }
    
    def __init__(self, vocab_path: Optional[Path] = None):
        """
        Initialize corrector with optional custom vocabulary file.
        
        Args:
            vocab_path: Path to custom vocabulary JSON file
        """
        self.corrections = dict(self.BUILTIN_CORRECTIONS)
        self.preserve_case = set()
        
        # Load custom vocabulary
        vocab_path = vocab_path or DEFAULT_VOCAB_PATH
        if vocab_path.exists():
            self._load_vocabulary(vocab_path)
        
        # Build regex pattern for efficient matching
        self._build_pattern()
    
    def _load_vocabulary(self, path: Path):
        """Load vocabulary from JSON file"""
        try:
            with open(path, "r", encoding="utf-8") as f:
                vocab = json.load(f)
            
            # Add corrections
            if "corrections" in vocab:
                self.corrections.update(vocab["corrections"])
            
            # Track terms that need case preservation
            if "preserve_case" in vocab:
                self.preserve_case.update(vocab["preserve_case"])
            
            logger.info(f"Loaded {len(vocab.get('corrections', {}))} custom vocabulary terms")
            
        except Exception as e:
            logger.warning(f"Failed to load vocabulary: {e}")
    
    def _build_pattern(self):
        """Build regex pattern for all corrections"""
        # Sort by length (longer matches first)
        sorted_terms = sorted(self.corrections.keys(), key=len, reverse=True)
        
        # Escape special regex characters and join
        escaped_terms = [re.escape(term) for term in sorted_terms]
        
        # Word boundary pattern (case insensitive)
        self.pattern = re.compile(
            r'\b(' + '|'.join(escaped_terms) + r')\b',
            re.IGNORECASE
        )
    
    def _replace_match(self, match: re.Match) -> str:
        """Replace a matched term with its correction"""
        original = match.group(0)
        lower = original.lower()
        
        if lower in self.corrections:
            correction = self.corrections[lower]
            
            # Preserve original case if correction is all lowercase
            # and not in preserve_case list
            if correction not in self.preserve_case:
                if original.isupper():
                    return correction.upper()
                elif original.istitle():
                    return correction.title()
            
            return correction
        
        return original
    
    def correct_text(self, text: str) -> str:
        """
        Apply vocabulary corrections to text.
        
        Args:
            text: Input text
        
        Returns:
            Corrected text
        """
        return self.pattern.sub(self._replace_match, text)
    
    def apply_corrections(self, result: dict) -> dict:
        """
        Apply corrections to transcription result.
        
        Args:
            result: Transcription result with segments
        
        Returns:
            Result with corrected text
        """
        corrections_applied = 0
        
        for segment in result.get("segments", []):
            original = segment.get("text", "")
            corrected = self.correct_text(original)
            
            if original != corrected:
                segment["text_original"] = original
                segment["text"] = corrected
                corrections_applied += 1
            
            # Also correct word-level if present
            for word in segment.get("words", []):
                original_word = word.get("word", "")
                corrected_word = self.correct_text(original_word)
                if original_word != corrected_word:
                    word["word_original"] = original_word
                    word["word"] = corrected_word
        
        logger.info(f"Applied {corrections_applied} vocabulary corrections")
        result["vocabulary_corrections"] = corrections_applied
        
        return result
    
    def add_correction(self, incorrect: str, correct: str, save: bool = True):
        """
        Add a new correction.
        
        Args:
            incorrect: Incorrect transcription (case insensitive)
            correct: Correct term
            save: Whether to save to vocabulary file
        """
        self.corrections[incorrect.lower()] = correct
        
        # Rebuild pattern
        self._build_pattern()
        
        # Save to file
        if save:
            self._save_vocabulary()
        
        logger.info(f"Added correction: '{incorrect}' -> '{correct}'")
    
    def _save_vocabulary(self):
        """Save current vocabulary to file"""
        vocab_path = DEFAULT_VOCAB_PATH
        vocab_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Separate builtin from custom
        custom_corrections = {
            k: v for k, v in self.corrections.items()
            if k not in self.BUILTIN_CORRECTIONS
        }
        
        vocab = {
            "corrections": custom_corrections,
            "preserve_case": list(self.preserve_case)
        }
        
        with open(vocab_path, "w", encoding="utf-8") as f:
            json.dump(vocab, f, indent=2, ensure_ascii=False)
        
        logger.info(f"Saved vocabulary to {vocab_path}")
