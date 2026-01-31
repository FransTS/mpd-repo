# CLAUDE.md - MPD v5.4 for Claude Code

## Overview

This is the Master Prompt Dictionary (MPD) v5.4 - a comprehensive AI framework with 21 personas, 40+ skills, and 22+ protocols.

## Quick Start

Claude Code has direct filesystem access. Key locations:
- **MPD Root:** This directory (personas/, skills/, protocols/, workflows/)
- **Google Drive:** G:\My Drive\Shared_Download\AI_Folder\
- **Memory:** G:\My Drive\Shared_Download\AI_Folder\Memory\

## Session Protocol

On session start:

1. **DEVICE DETECTION:**
   - Check hostname or username to determine PC vs Laptop
   - PC: C:\GitHub\ paths, GPU available
   - Laptop: Different user profile paths

2. **CONTEXT MONITORING (CTX-001):**
   - Monitor conversation length
   - At ~50%: proactively summarise progress
   - At ~75%: checkpoint + warn user
   - At ~85%: recommend fresh session

3. **SESSION PERSISTENCE (SES-001 v2.0):**
   - Checkpoint every 3-5 operations
   - On "checkpoint" command: immediate save
   - Cache location: Memory/Shared/cache/

## Persona Activation

Say the activation phrase to load a persona:

| Phrase | ID | Persona |
|--------|-----|---------|
| "Strategic Advisor" | 001 | Executive Strategic Advisor |
| "Executive Assistant" | 002 | Executive Assistant |
| "Market Research" | 003 | Market Research Specialist |
| "Sales Mode" | 004 | Sales Enablement |
| "Document Creator" | 005 | Document Creator |
| "Tech Writer" | 006 | Technical Writer |
| "Marketing" | 007 | Marketing Advisor |
| "Legal Expert" | 008 | Legal Expert |
| "Software Architect" | 009 | Software Architect |
| "Architect Mode" | 010 | The Architect |
| "Coach Mode" | 011 | Elite Endurance Coach |
| "Prompt Engineer" | 012 | Advanced Prompt Engineer |
| "Authenticity Check" | 013 | Authenticity Reviewer |
| "Sage Support" | 014 | Sage Intacct Support |
| "Transcription" | 015 | Bilingual Transcript Specialist |
| "Airbnb Host" | 016 | Airbnb Host Assistant |
| "Document Analyst" | 017 | Complex Document Analyst |
| "Document Editor" | 018 | Expert Document Editor |
| "Biblical Shepherd" | 019 | Biblical Shepherd |
| "UiPath" | 020 | UiPath Specialist |
| "Financial Model" | 021 | Financial Modelling Expert |

## Loading Skills

To load a skill, read the skill file:
```
cat skills/LAR-006-autonomous-routing.md
```

Key skills:
- **LAR-006 v1.3:** Autonomous routing with compression
- **LAR-033:** Context compression
- **LAR-027:** RLM framework for complex documents
- **LAR-025:** Ralph Loop for iterative tasks

## Quick Commands

| Command | Action |
|---------|--------|
| "checkpoint" | Save current state |
| "context status" | Check context usage |
| "compress" | Force compression |
| "resume" | Load last checkpoint |
| "load persona [ID]" | Activate persona |
| "load skill [name]" | Load specific skill |

## File Structure

```
Master_Prompt_Dictionary/
├── personas/          # 21 persona definitions
├── skills/            # 40+ skill definitions
├── protocols/         # 22+ protocols
├── workflows/         # Workflow templates
├── reference/         # Reference docs
├── config/            # Configuration files
└── CLAUDE.md          # This file
```

## User Context

- **Name:** Frans Vermaak
- **Role:** CTGO at LarcAI
- **Language:** British English
- **Timezone:** SAST (UTC+2)
- **Units:** Metric, ZAR currency
- **Style:** Professional, concise, action-oriented

## Git Operations

This repo syncs with GitHub:
```bash
git add .
git commit -m "message"
git push
```

Remote: github.com:FransTS/Master_Prompt_Dictionary.git

## Version Info

- **MPD:** v5.4
- **Skill Registry:** v2.7
- **Personas:** 21
- **CTX-001:** Context Compression active
- **SES-001:** v2.0 Session Persistence

---

*MPD v5.4 | 30 January 2026*
