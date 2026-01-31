# Frans Persona Registry v5.4

| Field | Value |
|-------|-------|
| **Document ID** | FRANS-PERSONA-REG-2026-010 |
| **Version** | 5.4 |
| **Last Updated** | 29 January 2026 \| SAST (UTC+2) |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Skill Registry** | v2.7 |
| **Total Personas** | 21 |

---

> **NEW in v5.4:**
> - CTX-001 Context Compression Protocol deployed to ALL personas
> - LAR-033 Context Compression Skill (Always Active)
> - SES-001 v2.0 Session Persistence with compression
> - LAR-006 v1.3 Autonomous Routing with compression routing
> - Three-tier compression architecture (LangChain Deep Agents)
> - Goal drift detection and recovery
>
> **v5.3:** Persona 021 Financial Modelling Expert, SK-024/025, PR-022
> **v5.2:** Persona 020 UiPath Specialist, SK-022/023, PR-021

---

## Quick Reference

### Activation Commands

| ID | Persona | Activation Phrase |
|----|---------|-------------------|
| 001 | Executive Strategic Advisor | "Strategic Advisor" |
| 002 | Executive Assistant | "Executive Assistant" |
| 003 | Market Research Specialist | "Market Research" |
| 004 | Sales Enablement | "Sales Mode" |
| 005 | Document Creator | "Document Creator" |
| 006 | Technical Writer | "Tech Writer" |
| 007 | Marketing Advisor | "Marketing" |
| 008 | Legal Expert | "Legal Expert" |
| 009 | Software Architect | "Software Architect" |
| 010 | The Architect | "Architect Mode" |
| 011 | Elite Endurance Coach | "Coach Mode" |
| 012 | Advanced Prompt Engineer | "Prompt Engineer" |
| 013 | Authenticity Reviewer | "Authenticity Check" |
| 014 | Sage Intacct Support | "Sage Support" |
| 015 | Bilingual Transcript Specialist | "Transcription" |
| 016 | Airbnb Host Assistant | "Airbnb Host" |
| 017 | Complex Document Analyst | "Document Analyst" |
| 018 | Expert Document Editor | "Document Editor" |
| 019 | Biblical Shepherd | "Biblical Shepherd" |
| 020 | UiPath Specialist | "UiPath" |
| 021 | Financial Modelling Expert | "Financial Model" |

---

## Context Compression (NEW v5.4)

### CTX-001 Protocol - All Personas

All personas now implement the CTX-001 Context Compression Protocol based on LangChain's Deep Agents methodology.

**Three-Tier Compression:**

| Tier | Trigger | Action |
|------|---------|--------|
| 1 | Tool result > 15k tokens | Offload to cache/offloaded/ |
| 2 | Context > 50% | Truncate persisted tool inputs |
| 3 | Context > 75% | Summarise + archive + checkpoint |

**Context Thresholds:**

| Usage | State | Action |
|-------|-------|--------|
| < 25% | GREEN | Normal |
| 25-50% | YELLOW | Monitor |
| 50-75% | ORANGE | Tier 1 & 2 |
| 75-85% | RED | Tier 3 |
| > 85% | CRITICAL | Fresh session |

**Goal Drift Detection:**
- Runs after Tier 3 summarisation
- Verifies intent alignment
- Recovers from archive if drift detected

---

## Persona Categories

### Executive & Strategy (001-002)
- 001: Executive Strategic Advisor
- 002: Executive Assistant

### Business Operations (003-004)
- 003: Market Research Specialist
- 004: Sales Enablement

### Content & Documentation (005-007)
- 005: Document Creator
- 006: Technical Writer
- 007: Marketing Advisor

### Technical & Legal (008-009)
- 008: Legal Expert
- 009: Software Architect

### Meta & Coordination (010)
- 010: The Architect (Meta-persona)

### Specialist Domains (011-021)
- 011: Elite Endurance Coach
- 012: Advanced Prompt Engineer
- 013: Authenticity Reviewer
- 014: Sage Intacct Support Specialist
- 015: Bilingual Transcript Specialist
- 016: Airbnb Host Assistant
- 017: Complex Document Analyst
- 018: Expert Document Editor
- 019: Biblical Shepherd
- 020: UiPath Specialist
- 021: Financial Modelling Expert

---

## Always-Active Skills (All Personas)

| Skill ID | Name | Purpose |
|----------|------|---------|
| TDP-001 | Tool Discovery | Dynamic MCP access |
| LAR-006 | Autonomous Routing | Task routing (v1.3) |
| LAR-007 | Self-Assessment | Quality checks |
| LAR-013 | Error Recovery | Failure handling |
| LAR-024 | Memory Integration | Persistence |
| LAR-028 | Long Context | Context management |
| **LAR-033** | **Context Compression** | **Three-tier compression** |

---

## Always-Active Protocols (All Personas)

| Protocol ID | Name | Purpose |
|-------------|------|---------|
| **CTX-001** | **Context Compression** | **Three-tier architecture** |
| SES-001 | Session Persistence | Checkpointing (v2.0) |
| MEM-001 | Memory Protocol | Cross-session memory |
| DEV-001 | Device Detection | Environment setup |

---

## File Locations

`
G:\My Drive\Shared_Download\AI_Folder\MPD\
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª personas/               # 21 persona files
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª skills/                 # LAR-xxx, SK-xxx skills
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª protocols/              # CTX-001, SES-001, etc.
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª reference/              # Architecture docs

G:\My Drive\Shared_Download\AI_Folder\Memory\Shared\cache\
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª offloaded/              # Tier 1: Large tool results
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª conversations/          # Tier 3: Archived conversations
ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª checkpoints/            # Task checkpoints
ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª intermediate/          # Intermediate results
`

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| **5.4** | **29 Jan 2026** | **CTX-001, LAR-033, SES-001 v2.0, LAR-006 v1.3 - all personas** |
| 5.3 | 26 Jan 2026 | Persona 021 Financial Modelling Expert |
| 5.2 | 24 Jan 2026 | Persona 020 UiPath Specialist |
| 5.1 | 19 Jan 2026 | Persona 018 Expert Document Editor |
| 5.0 | 18 Jan 2026 | Persona 017 Complex Document Analyst, RLM |
| 4.9 | 17 Jan 2026 | Ralph Loop PR-018, TDP-001 |
| 4.8 | 10 Jan 2026 | Persona 015 Transcript Specialist |

---

*Frans Persona Registry v5.4 | 21 Personas | Skill Registry v2.7*
