# Frans Persona Registry v5.3

| Field | Value |
|-------|-------|
| **Version** | 5.3 |
| **Updated** | 28 January 2026 \| SAST (UTC+2) |
| **Total Personas** | 21 |
| **Architecture** | Lean (TDP-001 tool discovery) + RLM (LAR-027) |

---

> **v5.3 Changes:**
> - Added Persona 021 Financial Modelling Expert (Excel & quotation specialist)
> - Added SK-024 Excel Mastery, SK-025 Financial Model Design
> - Added LAR-032 Quotation Validation Framework
> - Added PR-022 Financial Model Audit Protocol
>
> **v5.2:** Persona 020 UiPath Specialist, SK-022/023, PR-021
>
> **v5.1:** Persona 019 Biblical Shepherd, SK-020/021, PR-020
>
> **v5.0:** Persona 017 Complex Document Analyst, RLM integration

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
| 017 | Complex Document Analyst | "Document Analyst" | Documents/RLM |
| 018 | Expert Document Editor | "Expert Editor" | Documents/QA |
| 019 | Biblical Shepherd | "Shepherd" | Faith/Scripture |
| 020 | UiPath Specialist | "UiPath Specialist" | RPA/Automation |
| **021** | **Financial Modelling Expert** | **"Financial Model"** | **Finance/Excel** |

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
| Complex documents, due diligence, RLM | 017 |
| Document review, editing, proofreading | 018 |
| Bible, Scripture, faith, prayer, spiritual, devotional | 019 |
| UiPath, RPA, robot licensing, Orchestrator, automation platform | 020 |
| **Financial models, quotations, Excel, pricing, spreadsheet audit, dashboard** | **021** |

---

## RLM-Enhanced Personas

These personas have RLM capabilities auto-loaded:

| ID | Persona | RLM Usage |
|----|---------|-----------|
| 003 | Market Research | Multi-source synthesis |
| 008 | Legal Expert | Complex contract analysis |
| 009 | Software Architect | Code repository understanding |
| 017 | Complex Document Analyst | Primary RLM specialist |

---

## Persona Categories

### Business (001-009)
Executive, Assistant, Research, Sales, Document, Technical, Marketing, Legal, Software

### System (010)
The Architect (meta-orchestrator)

### Specialist (011-018)
Coach, Prompt Engineer, Authenticity, Sage Intacct, Transcription, Airbnb, Document Analyst, Document Editor

### Personal (019)
Biblical Shepherd (faith/Scripture)

### Technology (020-021)
UiPath Specialist (RPA/Automation), **Financial Modelling Expert (Finance/Excel)**

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
| 017 | + LAR-027, LAR-029, PR-019 |
| 018 | + LAR-030, LAR-021, LAR-007 |
| 019 | + SK-020, SK-021, PR-020 |
| 020 | + SK-022, SK-023, PR-021 |
| **021** | **+ SK-024, SK-025, LAR-032, LAR-009, PR-022** |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **5.3** | **28 Jan 2026** | **Persona 021 Financial Modelling Expert, SK-024/025, LAR-032, PR-022** |
| 5.2 | 21 Jan 2026 | Persona 020 UiPath Specialist, SK-022/023, PR-021 |
| 5.1 | 20 Jan 2026 | Persona 019 Biblical Shepherd, SK-020/021, PR-020 |
| 5.0 | 18 Jan 2026 | RLM integration, Persona 017, LAR-027/028/029 |
| 4.9 | 16 Jan 2026 | TDP-001, lean architecture |
| 4.8 | 15 Jan 2026 | Persona 015 Transcript Specialist |
| 4.7 | 14 Jan 2026 | Ralph Loop integration |

---

*Frans Persona Registry v5.3 | 21 Personas*
