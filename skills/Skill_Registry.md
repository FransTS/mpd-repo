# Frans Skill Registry v2.7

| Field | Value |
|-------|-------|
| **Document ID** | FRANS-SKILL-REG-2026-009 |
| **Version** | 2.7 |
| **Last Updated** | 29 January 2026 \| SAST (UTC+2) |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Frans Master Prompts v5.4 |

---

> **NEW in v2.7:**
> - CTX-001 Context Compression Protocol (LangChain Deep Agents methodology)
> - LAR-033 Context Compression Skill (three-tier compression)
> - SES-001 v2.0 with compression integration
> - LAR-006 v1.3 with compression routing
> - Goal drift detection and recovery
>
> **v2.6:** LAR-031 Development Testing Protocol
> **v2.5:** LAR-030 Document Review Methodology
> **v2.4:** LAR-027 RLM Framework, LAR-028/029 Complex Documents

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
| **Context Status** | **`"context status"`, `"compress"` (NEW)** |
| **Recovery** | **`"recover [topic]"`, `"show intent"` (NEW)** |

---

## Skill Catalog

### Tier 1: Core Skills (Always Active)

| ID | Name | Triggers | Purpose |
|----|------|----------|---------|
| TDP-001 | tool-discovery | automatic | Dynamic tool access via mcpl |
| LAR-006 | autonomous-routing | "handle this" | Task routing **(v1.3 with compression)** |
| LAR-007 | self-assessment | before delivery | Quality check |
| LAR-008 | escalation-protocol | "proceed or confirm" | User confirmation |
| LAR-013 | error-recovery | on failure | Failure handling |
| LAR-024 | memory-integration | automatic | Session persistence |
| LAR-028 | long-context-processing | automatic | Context management |
| LAR-031 | development-testing | code changes | Build verification gates |
| **LAR-033** | **context-compression** | **automatic/thresholds** | **Three-tier compression (NEW)** |

### Tier 2: Domain Skills (On-Demand)

| ID | Name | Triggers |
|----|------|----------|
| LAR-001 | research-protocol | "deep research" |
| LAR-002 | contract-analysis | "review contract" (v2.0 RLM-enhanced) |
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
| LAR-032 | quotation-validation | "validate quote", "verify citation" |

### Tier 3: Specialist Skills

| ID | Name | Domain |
|----|------|--------|
| SK-015 | Transcription Methodology | Audio/Video |
| SK-016 | Afrikaans Processing | Linguistics |
| SK-017 | Speaker Diarisation | Audio |
| SK-018 | Domain Vocabulary | Terminology |
| SK-019 | Multimodal Analysis | Media |
| SK-020 | Scripture Lookup | Biblical |
| SK-021 | Devotional Generator | Spiritual |
| SK-022 | UiPath Technical | RPA |
| SK-023 | UiPath Licensing | RPA |
| SK-024 | Excel Mastery | Spreadsheets |
| SK-025 | Financial Model Design | Finance |

---

## Context Compression Quick Reference (NEW v2.7)

`
CONTEXT THRESHOLDS (CTX-001):
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª < 25%  GREEN    Normal operation
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª 25-50% YELLOW   Monitor, prepare
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª 50-75% ORANGE   Tier 1 & 2 active
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª 75-85% RED      Tier 3 summarisation
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª > 85%  CRITICAL Checkpoint + fresh session

THREE-TIER COMPRESSION:
Tier 1: Offload large tool results (> 15k tokens) ƒÅ' cache/offloaded/
Tier 2: Truncate persisted tool inputs (at 50%) ƒÅ' file pointers
Tier 3: Summarise conversation (at 75%) ƒÅ' cache/conversations/

GOAL DRIFT DETECTION:
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Run after Tier 3 summarisation
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Check intent alignment
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Warn on clarification/completion drift
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Recover from archive if drift detected
`

---

## Protocols

| ID | Name | Purpose |
|----|------|---------|
| **CTX-001** | **Context Compression** | **Three-tier compression (NEW)** |
| TDP-001 | Tool Discovery Protocol | Dynamic mcpl tool access |
| MEM-001 | Memory Protocol | Session persistence |
| SES-001 | Session Persistence | Checkpoint management **(v2.0)** |
| PR-017 | Long Complex Task Execution | Multi-step workflows |
| PR-018 | Ralph Loop Protocol | Iterative fresh-context execution |
| PR-019 | RLM Protocol | Complex document processing |
| PR-020 | Spiritual Counsel | Biblical guidance |
| PR-021 | UiPath Implementation | RPA deployment |
| PR-022 | Financial Model Audit | Model verification |

---

## Persona-Skill Matrix (Updated v2.7)

| ID | Persona | Auto-Load Skills |
|----|---------|-----------------|
| 001 | Executive Strategic Advisor | research, decision-framework, **context-compression** |
| 002 | Executive Assistant | email, meeting, **context-compression** |
| 003 | Market Research | research, data-analysis, rlm-framework, **context-compression** |
| 004 | Sales Enablement | sales-playbook, **context-compression** |
| 005 | Document Creator | **context-compression** |
| 006 | Technical Writer | **context-compression** |
| 007 | Marketing Advisor | **context-compression** |
| 008 | Legal Expert | contract-analysis v2.0, rlm-framework, **context-compression** |
| 009 | Software Architect | architecture, ralph-loop, rlm-framework, development-testing, **context-compression** |
| 010 | The Architect | routing, batch-processing, memory, ralph-loop, development-testing, **context-compression** |
| 011 | Elite Endurance Coach | **context-compression** |
| 012 | Prompt Engineer | prompt-engineering, ralph-loop, **context-compression** |
| 013 | Authenticity Reviewer | authenticity-check, self-assessment, **context-compression** |
| 014 | Sage Intacct Support | **context-compression** |
| 015 | Transcript Specialist | SK-015, SK-018, batch-processing, **context-compression** |
| 016 | Airbnb Host Assistant | **context-compression** |
| 017 | Complex Document Analyst | rlm-framework, complex-document-analysis, **context-compression** |
| 018 | Expert Document Editor | document-review, authenticity-check, **context-compression** |
| 019 | Biblical Shepherd | SK-020, SK-021, **context-compression** |
| 020 | UiPath Specialist | SK-022, SK-023, **context-compression** |
| 021 | Financial Modelling Expert | SK-024, SK-025, **context-compression** |
| **ALL** | **All Personas** | TDP-001, memory-integration, long-context-processing, **CTX-001**, **LAR-033** |

---

## Context Management Skills

| Skill | Focus | Integration |
|-------|-------|-------------|
| LAR-014 | Context tracking (what to remember) | Informs compression |
| LAR-028 | Long context processing | Works with compression |
| **LAR-033** | **Context compression (how to compress)** | **Executes CTX-001** |
| SES-001 | Session persistence (checkpointing) | Triggers on compression |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **2.7** | **29 Jan 2026** | **CTX-001, LAR-033, SES-001 v2.0, LAR-006 v1.3, all personas updated** |
| 2.6 | 26 Jan 2026 | LAR-031 development-testing-protocol |
| 2.5 | 19 Jan 2026 | LAR-030 document-review, Persona 018 |
| 2.4 | 18 Jan 2026 | LAR-027/028/029 RLM skills, Persona 017 |
| 2.3 | 17 Jan 2026 | LAR-025 ralph-loop, PR-018, TDP-001 |
| 2.2 | 15 Jan 2026 | LAR-024 memory-integration, MEM-001 |

---

*Frans Skill Registry v2.7 | Compatible with Frans Master Prompts v5.4*
