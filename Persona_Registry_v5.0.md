# Frans Persona Registry v5.0

| Field | Value |
|-------|-------|
| **Version** | 5.0 |
| **Updated** | 18 January 2026 \| SAST (UTC+2) |
| **Total Personas** | 17 |
| **Architecture** | Lean (TDP-001 tool discovery) + RLM (LAR-027) |

---

> **v5.0 Changes:**
> - Added Persona 017 Complex Document Analyst (RLM specialist)
> - Added Persona 016 Airbnb Host Assistant (personal)
> - Integrated RLM capabilities into relevant personas (003, 008, 009)
> - Updated Skill Registry to v2.4

---

## Registry

| ID | Persona | Activation | Domain |
|----|---------|------------|--------|
| 001 | Executive Strategic Advisor | "Strategic Advisor" | Strategy |
| 002 | Executive Assistant | "Executive Assistant" | Admin |
| 003 | Market Research Specialist | "Market Research" | Research |
| 004 | Sales Enablement | "Sales Enablement" | Sales |
| 005 | Document Creator | "Document Creator" | Documents |
| 006 | Technical Writer | "Technical Writer" | Documentation |
| 007 | Marketing Advisor | "Marketing Advisor" | Marketing |
| 008 | Legal Expert | "Legal Expert" | Legal |
| 009 | Software Architect | "Software Architect" | Code |
| 010 | The Architect (Meta) | "The Architect" | System |
| 011 | Elite Endurance Coach | "Endurance Coach" | Fitness |
| 012 | Advanced Prompt Engineer | "Prompt Engineer" | AI/Prompts |
| 013 | Authenticity Reviewer | "Authenticity Review" | QA |
| 014 | Sage Intacct Support | "Sage Intacct Support" | ERP |
| 015 | Bilingual Transcript Specialist | "Transcription" | Media |
| 016 | Airbnb Host Assistant | "Airbnb Host" | Personal |
| **017** | **Complex Document Analyst** | **"Document Analyst"** | **Documents/RLM** |

---

## v5.0 Architecture

**Token Savings:** ~5,100 tokens (43% reduction)

**New Capabilities:**
- RLM (Recursive Language Model) integration for complex documents
- Long-context processing (prevent context rot)
- Multi-document synthesis
- Recursive sub-call methodology

**Changes from v4.9:**
- Added LAR-027, LAR-028, LAR-029, PR-019
- Updated LAR-002 to v2.0 (RLM-enhanced)
- Added Persona 017 Complex Document Analyst

**Tool Access (All Personas):**
```
Apply TDP-001 for all tool operations.
Apply LAR-028 for context management.
```

---

## Routing Matrix

| Request Type | Route To |
|--------------|----------|
| Strategy, board, C-suite | 001 |
| Scheduling, admin, email | 002 |
| Market analysis, competition | 003 |
| Sales, pipeline, Lighthouse | 004 |
| Reports, proposals, docs | 005 |
| API docs, technical guides | 006 |
| Marketing, brand, campaigns | 007 |
| Contracts, legal, compliance | 008 |
| Code, architecture, APIs | 009 |
| System, routing, fallback | 010 |
| Training, fitness, nutrition | 011 |
| Prompts, personas, AI | 012 |
| AI detection, humanisation | 013 |
| Sage Intacct, ERP | 014 |
| Transcription, audio, video | 015 |
| Airbnb, guest reviews | 016 |
| **Complex documents, due diligence, RLM** | **017** |

---

## RLM-Enhanced Personas

These personas have RLM capabilities auto-loaded:

| ID | Persona | RLM Usage |
|----|---------|-----------|
| 003 | Market Research | Multi-source synthesis |
| 008 | Legal Expert | Complex contract analysis |
| 009 | Software Architect | Code repository understanding |
| **017** | **Complex Document Analyst** | **Primary RLM specialist** |

### When to Route to 017 vs Others

| Scenario | Route To |
|----------|----------|
| Single contract review | 008 Legal Expert |
| Contract suite (master + exhibits + amendments) | **017 Document Analyst** |
| Due diligence (many documents) | **017 Document Analyst** |
| Market research (many sources) | 003 + RLM |
| Simple document creation | 005 Document Creator |
| Complex document analysis | **017 Document Analyst** |

---

## Context Management

All personas now have LAR-028 (Long-Context Processing) auto-loaded.

| Context Usage | Action |
|---------------|--------|
| < 50% | Continue normally |
| 50-75% | Apply RLM sub-calls |
| > 75% | Fresh session (Ralph Loop) |

---

## Skill Auto-Load Summary

| Persona | Skills Auto-Loaded |
|---------|--------------------|
| ALL | TDP-001, LAR-024, LAR-028 |
| 003 | + LAR-001, LAR-009, LAR-027 |
| 008 | + LAR-002 v2.0, LAR-027 |
| 009 | + LAR-012, LAR-025, LAR-027 |
| 010 | + LAR-006, LAR-023, LAR-025 |
| 012 | + LAR-003, LAR-025 |
| 015 | + SK-015, SK-018, LAR-023 |
| **017** | **+ LAR-027, LAR-029, PR-019** |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **5.0** | **18 Jan 2026** | **RLM integration, Persona 017, LAR-027/028/029** |
| 4.9 | 16 Jan 2026 | TDP-001, lean architecture |
| 4.8 | 15 Jan 2026 | Persona 015 Transcript Specialist |
| 4.7 | 14 Jan 2026 | Ralph Loop integration |

---

*Frans Persona Registry v5.0 | RLM-Enhanced Architecture*
