# Frans Skill Registry v2.7

| Field | Value |
|-------|-------|
| **Document ID** | FRANS-SKILL-REG-2026-009 |
| **Version** | 2.7 |
| **Last Updated** | 28 January 2026 \| SAST (UTC+2) |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Frans Master Prompts v5.3 |

---

> **NEW in v2.7:**
> - SK-024 Excel Mastery (comprehensive Excel expertise)
> - SK-025 Financial Model Design (model architecture best practices)
> - LAR-032 Quotation Validation (model verification)
> - PR-022 Financial Model Audit Protocol
> - **MEM-001 v2.0 Project Isolation now MANDATORY**
> - Global Protocols v3.5 integration
>
> **v2.6:** LAR-031 Development Testing Protocol
> **v2.5:** LAR-030 Document Review Methodology
> **v2.4:** LAR-027 RLM Framework, LAR-028/029

---

## CRITICAL: Memory Protocol v2.0

**ALL SKILLS MUST RESPECT PROJECT ISOLATION:**
```
Memory path: Memory/Projects/{PROJECT_ID}/
├── session_handoff.md    (THIS PROJECT ONLY)
├── active_task.md        (THIS PROJECT ONLY)
└── cache/                (THIS PROJECT ONLY)

⚠️ NEVER write to Memory/Shared/ for session state
⚠️ NEVER access other project folders
```

---

## Quick Reference

| Action | Command |
|--------|---------|
| Load skill | `"Load skill: [name]"` or trigger phrase |
| Autonomous mode | `"handle this"` or `"figure out"` |
| Tool discovery | `mcpl search "<capability>"` |
| Ralph Loop | `"Ralph Loop this"`, `"fresh context"` |
| Batch processing | `"batch process"`, `"checkpoint"` |
| Memory | `"save to memory"`, `"remember this"` |
| RLM Processing | `"analyse complex document"`, `"due diligence"` |
| Document Review | `"review this document"`, `"expert editor"` |
| Dev Testing | `"code change"`, `"implement feature"` |
| **Financial Model** | `"quotation model"`, `"audit spreadsheet"`, `"Excel model"` |

---

## Skill Catalog

### Tier 1: Core Skills (Always Active)

| ID | Name | Triggers | Purpose |
|----|------|----------|---------|
| TDP-001 | tool-discovery | automatic | Dynamic tool access via mcpl |
| LAR-006 | autonomous-routing | "handle this" | Task routing **(v1.2 with RLM detection)** |
| LAR-007 | self-assessment | before delivery | Quality check |
| LAR-008 | escalation-protocol | "proceed or confirm" | User confirmation |
| LAR-013 | error-recovery | on failure | Failure handling |
| LAR-024 | memory-integration | automatic | Session persistence **(v2.0 project isolation)** |
| LAR-028 | long-context-processing | automatic | Context management |
| LAR-031 | development-testing | code changes | Build verification gates |

### Tier 2: Domain Skills (On-Demand)

| ID | Name | Triggers |
|----|------|----------|
| LAR-001 | research-protocol | "deep research" |
| LAR-002 | contract-analysis | "review contract" (RLM-enhanced) |
| LAR-003 | prompt-engineering | "create prompt" |
| LAR-004 | sales-playbook | "lighthouse", "workshop" |
| LAR-005 | email-mastery | "draft email" |
| LAR-009 | data-analysis | "analyse data" |
| LAR-010 | meeting-mastery | "meeting agenda" |
| LAR-011 | project-planning | "project plan" |
| LAR-012 | architecture-diagrams | "architecture diagram" |
| LAR-019 | knowledge-synthesis | "synthesise", "combine sources" |
| LAR-021 | authenticity-check | "humanize", "AI check" |
| LAR-022 | mcp-setup-guide | "setup mcp" |
| LAR-023 | batch-processing | "batch process", "checkpoint" |
| LAR-025 | ralph-loop | "Ralph Loop", "fresh context" |
| LAR-027 | rlm-framework | "complex document", "due diligence" |
| LAR-029 | complex-document-analysis | "multi-document", "document suite" |
| LAR-030 | document-review | "review document", "expert editor" |
| LAR-031 | development-testing | "code change", "implement feature" |
| **LAR-032** | **quotation-validation** | **"validate quotation", "audit model", "check calculations"** |

### Tier 3: Specialist Skills

| ID | Name | Domain |
|----|------|--------|
| SK-015 | Transcription Methodology | Audio/Video |
| SK-016 | Afrikaans Processing | Linguistics |
| SK-017 | Speaker Diarisation | Audio |
| SK-018 | Domain Vocabulary | Terminology |
| SK-019 | Multimodal Analysis | Media |
| SK-020 | Scripture Lookup | Faith |
| SK-021 | Devotional Generator | Faith |
| SK-022 | UiPath Technical | RPA |
| SK-023 | UiPath Licensing | RPA |
| **SK-024** | **Excel Mastery** | **Finance/Excel** |
| **SK-025** | **Financial Model Design** | **Finance/Modelling** |

---

## Financial Modelling Quick Reference

```
PERSONA 021 CAPABILITIES:

EXCEL MASTERY (SK-024):
├── Advanced formulas: XLOOKUP, INDEX/MATCH, SUMPRODUCT
├── Financial functions: NPV, IRR, PMT, FV, PV
├── Power Query: Data transformation, M language
├── Power Pivot: DAX measures, data model
├── Dynamic arrays: FILTER, SORT, UNIQUE, SEQUENCE
└── Performance optimisation

MODEL DESIGN (SK-025):
├── Three-layer architecture (Input/Calculation/Output)
├── Professional formatting standards
├── Dashboard design principles
├── Version control standards
└── Documentation requirements

QUOTATION VALIDATION (LAR-032):
├── Structural audit: Input isolation, formula hygiene
├── Calculation verification: Formula accuracy, aggregations
├── Pricing logic: Rate cards, discounts, taxes
├── Boundary testing: Zero, min, max, edge cases
└── Consistency checks: Cross-sheet, units, terminology

MODEL AUDIT PROTOCOL (PR-022):
├── Phase 1: Intake (understand objectives)
├── Phase 2: Mapping (document architecture)
├── Phase 3: Formula audit (verify accuracy)
├── Phase 4: Stress testing (boundary conditions)
├── Phase 5: Reporting (findings and recommendations)
└── Phase 6: Sign-off (pass/conditional/fail)
```

---

## Protocols

| ID | Name | Purpose |
|----|------|---------|
| TDP-001 | Tool Discovery Protocol | Dynamic mcpl tool access |
| **MEM-001 v2.0** | **Memory Protocol** | **Project-isolated session persistence** |
| SES-001 v1.1 | Session Persistence | Checkpoint management with project isolation |
| PR-017 | Long Complex Task Execution | Multi-step workflows |
| PR-018 | Ralph Loop Protocol | Iterative fresh-context execution |
| PR-019 | RLM Protocol | Complex document processing |
| PR-020 | Spiritual Counsel Protocol | Faith-based guidance |
| PR-021 | UiPath Implementation | RPA deployment |
| **PR-022** | **Financial Model Audit** | **Systematic model validation** |

---

## Persona-Skill Matrix

| ID | Persona | Auto-Load Skills |
|----|---------|-----------------|
| 001 | Executive Strategic Advisor | research, decision-framework |
| 002 | Executive Assistant | email, meeting |
| 003 | Market Research | research, data-analysis, rlm-framework |
| 004 | Sales Enablement | sales-playbook |
| 008 | Legal Expert | contract-analysis v2.0, rlm-framework |
| 009 | Software Architect | architecture, ralph-loop, rlm-framework, development-testing |
| 010 | The Architect | routing, batch-processing, memory, ralph-loop, development-testing |
| 012 | Prompt Engineer | prompt-engineering, ralph-loop |
| 013 | Authenticity Reviewer | authenticity-check, self-assessment |
| 015 | Transcript Specialist | SK-015, SK-018, batch-processing |
| 017 | Complex Document Analyst | rlm-framework, complex-document-analysis |
| 018 | Expert Document Editor | document-review, authenticity-check, self-assessment |
| 019 | Biblical Shepherd | SK-020, SK-021, PR-020 |
| 020 | UiPath Specialist | SK-022, SK-023, PR-021 |
| **021** | **Financial Modelling Expert** | **SK-024, SK-025, LAR-032, PR-022, LAR-009** |
| **ALL** | **All Personas** | **TDP-001, LAR-024 (MEM-001 v2.0), LAR-028** |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **2.7** | **28 Jan 2026** | **SK-024, SK-025, LAR-032, PR-022, MEM-001 v2.0 integration** |
| 2.6 | 26 Jan 2026 | LAR-031 development-testing-protocol |
| 2.5 | 19 Jan 2026 | LAR-030 document-review |
| 2.4 | 18 Jan 2026 | LAR-027/028/029 RLM skills |
| 2.3 | 17 Jan 2026 | LAR-025 ralph-loop, TDP-001 |
| 2.2 | 15 Jan 2026 | LAR-024 memory-integration |

---

*Frans Skill Registry v2.7 | Memory Protocol v2.0 | 21 Personas | 36 Skills*
