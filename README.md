# Frans Master Prompt Dictionary (MPD)

## Version Information

| Component | Version |
|-----------|---------|
| **MPD** | **5.3** |
| **Persona Registry** | 5.3 (21 personas) |
| **Skill Registry** | 2.7 (36 skills) |
| **Global Protocols** | 3.5 |
| **Memory Protocol** | **2.0 (Project Isolation)** |

**Last Updated:** 28 January 2026 | SAST

---

## Quick Start

### Session Start (MANDATORY)

```
1. IDENTIFY PROJECT SCOPE
   └── Get PROJECT_ID from custom instructions or ask user

2. DETECT DEVICE
   └── PC ($env:USERPROFILE contains "User")
   └── Laptop ($env:USERPROFILE contains "Frans Vermaak")

3. LOAD PROJECT MEMORY
   └── Read: Memory/Projects/{PROJECT_ID}/session_handoff.md
   └── Read: Memory/Projects/{PROJECT_ID}/active_task.md
   
   ⚠️ NEVER read Memory/Shared/ for session state
```

---

## Repository Structure

```
MPD/
├── personas/               # 21 AI personas (001-021)
├── skills/                 # 36 skills (LAR-xxx, SK-xxx)
├── protocols/              # Global and domain protocols
├── workflows/              # Composite workflows
├── reference/              # Templates and guides
├── scripts/                # Automation scripts
├── GDocs_Export/           # Google Docs compatible exports
├── Persona_Registry_v5.3.md
├── PROJECT_INSTRUCTIONS.md
├── README.md
└── CLAUDE.md               # Claude Code instructions
```

---

## Key Features v5.3

### Memory Protocol v2.0 (Project Isolation)
- All session state isolated per project
- Path: `Memory/Projects/{PROJECT_ID}/`
- Prevents cross-contamination between projects
- Mandatory for all personas

### Persona 021: Financial Modelling Expert
- Advanced Excel mastery
- Professional dashboard design
- Quotation model validation
- Financial model audit capabilities

### Skills Added
- SK-024 Excel Mastery
- SK-025 Financial Model Design
- LAR-032 Quotation Validation
- PR-022 Financial Model Audit Protocol

---

## Personas Summary

| Range | Domain | Count |
|-------|--------|-------|
| 001-009 | Business | 9 |
| 010 | System (Meta) | 1 |
| 011-018 | Specialist | 8 |
| 019 | Personal (Faith) | 1 |
| 020-021 | Technology | 2 |
| **Total** | | **21** |

---

## Memory Paths

| Purpose | Path |
|---------|------|
| Project Memory | `Memory/Projects/{PROJECT_ID}/` |
| Global Index | `Memory/_Global/project_index.md` |
| Device Logs | `Memory/{PC\|Laptop}/session_log.md` |
| ~~Shared~~ | ~~`Memory/Shared/`~~ (DEPRECATED) |

---

## Device Configuration

| Device | User Path | Git Repo |
|--------|-----------|----------|
| PC | `C:\Users\User\` | `C:\GitHub\Master_Prompt_Dictionary` |
| Laptop | `C:\Users\Frans Vermaak\` | `C:\GitHub\Master_Prompt_Dictionary` |

---

## Sync Commands

### Git Sync (Laptop)
```powershell
cd C:\GitHub\Master_Prompt_Dictionary
git add -A
git commit -m "MPD v5.3 update"
git push
```

### Git Sync (PC)
```powershell
cd C:\Users\User\Documents\GitHub\Master_Prompt_Dictionary
git add -A
git commit -m "MPD v5.3 update"
git push
```

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **5.3** | **28 Jan 2026** | **Persona 021, MEM-001 v2.0, SK-024/025, LAR-032, PR-022** |
| 5.2 | 21 Jan 2026 | Persona 020 UiPath Specialist |
| 5.1 | 20 Jan 2026 | Persona 019 Biblical Shepherd |
| 5.0 | 18 Jan 2026 | RLM integration, Persona 017 |

---

*Frans MPD v5.3 | Memory Protocol v2.0 | Project Isolation Active*
