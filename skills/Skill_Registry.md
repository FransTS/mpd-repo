# Frans Skill Registry v2.5

| Field | Value |
|-------|-------|
| **Document ID** | FRANS-SKILL-REG-2026-008 |
| **Version** | 2.5 |
| **Last Updated** | 19 January 2026 \| SAST (UTC+2) |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Frans Master Prompts v5.1 |

---

> **NEW in v2.5:**
> - LAR-030 Document Review Methodology (Persona 018 primary skill)
> - Editorial QA capabilities (spelling, grammar, formatting, facts, compliance)
> - Requirements gap analysis methodology
>
> **v2.4:** LAR-027 RLM Framework, LAR-028 Long-Context Processing, LAR-029 Complex Document Analysis
> **v2.3:** LAR-025 Ralph Loop, TDP-001 Tool Discovery
> **v2.2:** LAR-024 Memory Integration, MEM-001 Memory Protocol

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
| **Document Review** | `"review this document"`, `"expert editor"` |

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
| LAR-024 | memory-integration | automatic | Session persistence |
| LAR-028 | long-context-processing | automatic | Context management |

### Tier 2: Domain Skills (On-Demand)

| ID | Name | Triggers |
|----|------|----------|
| LAR-001 | research-protocol | "deep research" |
| LAR-002 | contract-analysis | "review contract" **(v2.0 RLM-enhanced)** |
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
| LAR-025 | ralph-loop | "Ralph Loop", "fresh context", "iterative" |
| LAR-027 | rlm-framework | "complex document", "due diligence" |
| LAR-029 | complex-document-analysis | "multi-document", "document suite" |
| **LAR-030** | **document-review** | **"review document", "expert editor", "proofread", "fact check"** |

### Tier 3: Specialist Skills

| ID | Name | Domain |
|----|------|--------|
| SK-015 | Transcription Methodology | Audio/Video |
| SK-016 | Afrikaans Processing | Linguistics |
| SK-017 | Speaker Diarisation | Audio |
| SK-018 | Domain Vocabulary | Terminology |
| SK-019 | Multimodal Analysis | Media |

---

## LAR-030 Document Review Quick Reference

```
REVIEW CATEGORIES:
├── LQ: Language Quality (spelling, grammar, punctuation, syntax)
├── DF: Design & Formatting (typography, layout, headings, tables)
├── FV: Fact Verification (numbers, dates, claims, references)
├── RC: Requirements Compliance (gap analysis, mapping)
└── SC: Style Consistency (tone, voice, terminology)

REVIEW DEPTHS:
├── Quick: LQ basics only (5-10 min)
├── Standard: LQ + DF + key facts (15-30 min)
├── Deep: All categories + compliance (30-60 min)
└── Forensic: Everything + cross-reference (60+ min)

ISSUE SEVERITY:
├── Critical: Must fix before submission
├── High: Should fix (significant impact)
├── Medium: Recommended (noticeable)
└── Low: Consider (polish)
```

---

## Protocols

| ID | Name | Purpose |
|----|------|---------|
| TDP-001 | Tool Discovery Protocol | Dynamic mcpl tool access |
| MEM-001 | Memory Protocol | Session persistence |
| SES-001 | Session Persistence | Checkpoint management |
| PR-017 | Long Complex Task Execution | Multi-step workflows |
| PR-018 | Ralph Loop Protocol | Iterative fresh-context execution |
| PR-019 | RLM Protocol | Complex document processing |

---

## Persona-Skill Matrix

| ID | Persona | Auto-Load Skills |
|----|---------|-----------------|
| 001 | Executive Strategic Advisor | research, decision-framework |
| 002 | Executive Assistant | email, meeting |
| 003 | Market Research | research, data-analysis, rlm-framework |
| 004 | Sales Enablement | sales-playbook |
| 008 | Legal Expert | contract-analysis v2.0, rlm-framework |
| 009 | Software Architect | architecture, ralph-loop, rlm-framework |
| 010 | The Architect | routing, batch-processing, memory, ralph-loop |
| 012 | Prompt Engineer | prompt-engineering, ralph-loop |
| 013 | Authenticity Reviewer | authenticity-check, self-assessment |
| 015 | Transcript Specialist | SK-015, SK-018, batch-processing |
| 017 | Complex Document Analyst | rlm-framework, complex-document-analysis |
| **018** | **Expert Document Editor** | **document-review, authenticity-check, self-assessment, knowledge-synthesis** |
| **ALL** | **All Personas** | TDP-001, memory-integration, long-context-processing |

---

## QA Skill Matrix

| Skill | Focus | Primary Persona |
|-------|-------|-----------------|
| LAR-007 | Self-assessment (output quality) | All |
| LAR-021 | AI authenticity check | 013 |
| LAR-029 | Complex document understanding | 017 |
| **LAR-030** | **Editorial review (language, facts, compliance)** | **018** |

---

## Document Workflow Skills

| Phase | Skill | Persona |
|-------|-------|---------|
| **Create** | (various by type) | 005, 006 |
| **Analyse** | LAR-027, LAR-029 | 017 |
| **Review/Edit** | **LAR-030** | **018** |
| **Authenticity** | LAR-021 | 013 |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **2.5** | **19 Jan 2026** | **LAR-030 document-review, Persona 018 integration** |
| 2.4 | 18 Jan 2026 | LAR-027/028/029 RLM skills, Persona 017 |
| 2.3 | 17 Jan 2026 | LAR-025 ralph-loop, PR-018, TDP-001 integration |
| 2.2 | 15 Jan 2026 | LAR-024 memory-integration, MEM-001 |
| 2.1 | 14 Jan 2026 | LAR-004 sales-playbook v2.0 |
| 2.0 | 12 Jan 2026 | LAR-023 batch-processing, PR-017 |

---

*Frans Skill Registry v2.5 | Compatible with Frans Master Prompts v5.1*
