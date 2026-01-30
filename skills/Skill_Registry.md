# Frans Skill Registry v2.7

| Field | Value |
|-------|-------|
| **Document ID** | FRANS-SKILL-REG-2026-009 |
| **Version** | 2.7 |
| **Last Updated** | 29 January 2026 | SAST (UTC+2) |
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
| Ralph Loop | `"Ralph Loop this"`, `"fresh context"` |
| RLM Processing | `"analyse complex document"`, `"due diligence"` |
| **Context Status** | **`"context status"`, `"compress"`** |
| **Recovery** | **`"recover [topic]"`, `"show intent"`** |

---

## Skill Catalog

### Tier 1: Core Skills (Always Active)

| ID | Name | Triggers | Purpose |
|----|------|----------|---------|
| TDP-001 | tool-discovery | automatic | Dynamic tool access |
| LAR-006 | autonomous-routing | "handle this" | Task routing **(v1.3)** |
| LAR-007 | self-assessment | before delivery | Quality check |
| LAR-008 | escalation-protocol | "proceed or confirm" | User confirmation |
| LAR-013 | error-recovery | on failure | Failure handling |
| LAR-024 | memory-integration | automatic | Session persistence |
| LAR-028 | long-context-processing | automatic | Context management |
| LAR-031 | development-testing | code changes | Build verification |
| **LAR-033** | **context-compression** | **automatic** | **Three-tier compression** |

### Tier 2: Domain Skills (On-Demand)

| ID | Name | Triggers |
|----|------|----------|
| LAR-001 | research-protocol | "deep research" |
| LAR-002 | contract-analysis | "review contract" |
| LAR-003 | prompt-engineering | "create prompt" |
| LAR-004 | sales-playbook | "lighthouse", "workshop" |
| LAR-005 | email-mastery | "draft email" |
| LAR-009 | data-analysis | "analyse data" |
| LAR-010 | meeting-mastery | "meeting agenda" |
| LAR-011 | project-planning | "project plan" |
| LAR-012 | architecture-diagrams | "architecture diagram" |
| LAR-019 | knowledge-synthesis | "synthesise" |
| LAR-021 | authenticity-check | "humanize", "AI check" |
| LAR-025 | ralph-loop | "Ralph Loop", "fresh context" |
| LAR-027 | rlm-framework | "complex document" |
| LAR-029 | complex-document-analysis | "document suite" |
| LAR-030 | document-review | "review document" |
| LAR-032 | quotation-validation | "validate quote" |

### Tier 3: Specialist Skills

| ID | Name | Domain |
|----|------|--------|
| SK-015 to SK-019 | Transcription | Audio/Video |
| SK-020, SK-021 | Biblical | Spiritual |
| SK-022, SK-023 | UiPath | RPA |
| SK-024, SK-025 | Financial | Excel/Models |

---

## Protocols

| ID | Name | Purpose |
|----|------|---------|
| **CTX-001** | **Context Compression** | **Three-tier compression** |
| SES-001 | Session Persistence | Checkpointing **(v2.0)** |
| MEM-001 | Memory Protocol | Cross-session memory |
| PR-017 | Long Complex Task | Multi-step workflows |
| PR-018 | Ralph Loop | Fresh context execution |
| PR-019 | RLM Protocol | Document processing |

---

## Context Compression (CTX-001)

| Context | State | Action |
|---------|-------|--------|
| < 50% | Normal | Continue |
| 50-75% | ORANGE | Tier 1 & 2 compression |
| 75-85% | RED | Tier 3 summarisation |
| > 85% | CRITICAL | Fresh session |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **2.7** | **29 Jan 2026** | **CTX-001, LAR-033, compression integration** |
| 2.6 | 26 Jan 2026 | LAR-031 development-testing |
| 2.5 | 19 Jan 2026 | LAR-030 document-review |

---

*Frans Skill Registry v2.7 | Compatible with Frans Master Prompts v5.4*
