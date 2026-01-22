# Frans Skill: Complex Document Analysis

## Metadata

| Field | Value |
|-------|-------|
| **Name** | complex-document-analysis |
| **Version** | 1.0 |
| **ID** | LAR-029 |
| **Triggers** | "multi-doc analysis", "complex contract", "due diligence", "deep document review" |
| **Dependencies** | LAR-027 (RLM Framework), PR-019 (RLM Protocol) |
| **Created** | 18 January 2026 |

---

## Purpose

Provide systematic methodology for analysing complex documents requiring:
- Multi-hop reasoning across sections
- Cross-document synthesis
- Dependency graph navigation
- Long-form aggregation tasks

**Primary Use Cases:**
- Legal contract suite analysis
- Due diligence document review
- Policy compliance mapping
- Research paper synthesis
- Code repository understanding

---

## Analysis Types

### Type 1: Single Complex Document

**Scope:** One document, 30+ pages, multiple cross-references

**Approach:**
1. Create document index (TOC, sections, subsections)
2. Map internal cross-references
3. Decompose query into section-specific sub-queries
4. Execute recursively with fresh context per section
5. Synthesise findings

### Type 2: Multi-Document Suite

**Scope:** 3+ related documents (e.g., contract + exhibits + amendments)

**Approach:**
1. Catalogue all documents with relationships
2. Create master index across all documents
3. Map inter-document references
4. Execute queries across document set
5. Aggregate and reconcile findings

### Type 3: Document Comparison

**Scope:** 2+ similar documents requiring comparison

**Approach:**
1. Identify comparison dimensions
2. Extract matching sections from each document
3. Create comparison matrix
4. Highlight differences and similarities
5. Produce reconciliation recommendations

### Type 4: Compliance Mapping

**Scope:** Document(s) against requirements/standards

**Approach:**
1. Parse requirements into checklist
2. For each requirement: search documents for coverage
3. Assess compliance level per requirement
4. Produce gap analysis
5. Recommend remediation

---

## Execution Framework

### Phase 1: Document Cataloguing

```markdown
## Document Inventory

| Doc ID | Name | Pages | Type | Relationships |
|--------|------|-------|------|---------------|
| D1 | Master Agreement | 45 | Contract | Parent of D2, D3 |
| D2 | Schedule A | 12 | Exhibit | Incorporated by D1 s.15 |
| D3 | Amendment 1 | 5 | Amendment | Modifies D1 s.8, s.12 |

## Cross-Reference Map
- D1 Section 15.1 → D2 (entire document)
- D1 Section 8.2 → D3 Section 2 (superseded)
- D1 Section 12 → D3 Section 3 (modified)
```

### Phase 2: Index Creation

For each document, generate:

```markdown
## Document Index: [D1]

### Sections
1. Definitions (pp. 1-3)
2. Scope of Services (pp. 4-8)
3. Term and Termination (pp. 9-12)
4. Fees and Payment (pp. 13-17)
...

### Key Terms Defined
- "Affiliate" → Section 1.1
- "Confidential Information" → Section 1.5
- "Deliverables" → Section 1.8

### External References
- [To D2] Section 15.1, 22.3
- [To D3] Section 8.2 (superseded), 12 (modified)
```

### Phase 3: Query Decomposition

Transform complex queries:

```
Original: "What are our termination rights and notice requirements across all documents?"

Decomposed:
├── Sub-Query 1: D1 termination provisions (Section 3)
├── Sub-Query 2: D1 notice requirements (Section 18)
├── Sub-Query 3: D3 modifications to termination (Section 2)
├── Sub-Query 4: Cross-reference any exhibits affecting termination
└── Synthesis: Aggregate current effective termination rights
```

### Phase 4: Recursive Execution

```
For Sub-Query 1 (D1 Section 3):
  → Search: "terminat" in D1
  → Found: Section 3.1, 3.2, 3.3, 3.4
  → Sub-call on 3.1: Extract termination for cause
  → Sub-call on 3.2: Extract termination for convenience
  → Sub-call on 3.3: Extract termination effects
  → Sub-call on 3.4: Cross-reference check
  → Return: Structured termination findings from D1
```

### Phase 5: Synthesis

```markdown
## Termination Rights Summary

### Effective Provisions (as modified)
| Right | Source | Notice Period | Conditions |
|-------|--------|---------------|------------|
| For Cause | D1 s.3.1 | 30 days | Material breach |
| For Convenience | D1 s.3.2 (modified by D3 s.2) | 90 days* | None |
| Automatic | D1 s.3.4 | N/A | Insolvency |

*Note: D3 Section 2 extended notice from 60 to 90 days

### Cross-Reference Validation
- D2 contains no termination modifications
- D3 Section 2 explicitly supersedes D1 Section 3.2
```

---

## Output Templates

### Template: Comprehensive Analysis

```markdown
# Complex Document Analysis Report

**Date:** [Date]
**Documents Analysed:** [List]
**Query:** [Original user query]
**Analyst:** [Persona ID]

---

## 1. Document Inventory
[Catalogue and relationships]

## 2. Analysis Methodology
[Which analysis type applied, decomposition approach]

## 3. Findings by Sub-Query

### Sub-Query 1: [Title]
**Target:** [Document, Section]
**Finding:** [Result]
**Confidence:** High/Medium/Low
**Source Citations:** [Specific references]

### Sub-Query 2: [Title]
...

## 4. Cross-Reference Reconciliation
[How documents interact, conflicts resolved]

## 5. Synthesised Response
[Direct answer to original query]

## 6. Gaps and Limitations
[What couldn't be determined]

## 7. Recommendations
[Suggested actions]

---

*Analysis performed using LAR-029 v1.0 with PR-019 RLM Protocol*
```

### Template: Comparison Matrix

```markdown
# Document Comparison Matrix

| Aspect | Document A | Document B | Document C | Notes |
|--------|-----------|-----------|-----------|-------|
| Term | 3 years | 2 years | 5 years | A vs C significant |
| Liability Cap | Unlimited | £1M | 12 months fees | B preferred |
| IP Rights | Client owns | Shared | Provider retains | Inconsistent |
| Termination Notice | 30 days | 60 days | 90 days | C most restrictive |

## Reconciliation Recommendations
1. [Recommendation]
2. [Recommendation]
```

### Template: Compliance Gap Analysis

```markdown
# Compliance Gap Analysis

**Standard/Requirement:** [Name]
**Documents Reviewed:** [List]

| Req ID | Requirement | Coverage | Source | Gap |
|--------|-------------|----------|--------|-----|
| R1 | Data encryption | Full | D1 s.12.3 | None |
| R2 | Audit rights | Partial | D1 s.14 | Missing frequency |
| R3 | Incident reporting | None | - | Full gap |

## Remediation Required
- R2: Add audit frequency (recommend quarterly)
- R3: Add incident reporting clause (template provided)
```

---

## Domain-Specific Patterns

### Legal/Contracts

| Pattern | Application |
|---------|-------------|
| Definition chase | Find where term is defined, trace usage |
| Clause dependency | Map which clauses reference others |
| Amendment overlay | Apply amendments to base document |
| Exhibit incorporation | Connect exhibits to referencing clauses |

### Code/Technical

| Pattern | Application |
|---------|-------------|
| Function trace | Follow function calls across files |
| Dependency mapping | Build import/requirement graph |
| Configuration cascade | Trace config inheritance |
| Documentation link | Connect code to docs to requirements |

### Research/Academic

| Pattern | Application |
|---------|-------------|
| Citation network | Map paper references |
| Methodology comparison | Extract and compare methods |
| Findings aggregation | Synthesise results across papers |
| Contradiction detection | Identify conflicting conclusions |

---

## Commands

| Command | Action |
|---------|--------|
| "Complex analysis on [documents]" | Full LAR-029 execution |
| "Catalogue documents" | Phase 1 only |
| "Create document index" | Phase 2 only |
| "Compare [doc A] vs [doc B]" | Comparison matrix analysis |
| "Compliance check against [standard]" | Gap analysis |
| "Trace definition: [term]" | Definition chase pattern |
| "Map dependencies in [document]" | Cross-reference mapping |

---

## Integration

| Component | Relationship |
|-----------|--------------|
| LAR-027 RLM Framework | Provides core recursive technique |
| PR-019 RLM Protocol | Provides execution protocol |
| LAR-002 Contract Analysis | LAR-029 enhances with RLM capability |
| Persona 016 | Primary user of this skill |
| Persona 008 | Legal-specific document analysis |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 18 Jan 2026 | Initial release |

---

*Frans Skill LAR-029 | Complex Document Analysis v1.0*
