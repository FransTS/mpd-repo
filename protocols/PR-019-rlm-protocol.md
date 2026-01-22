# PR-019: RLM Protocol (Recursive Language Model)

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | PR-019 |
| **Version** | 1.0 |
| **Created** | 18 January 2026 |
| **Purpose** | Recursive processing for long-context tasks |
| **Based On** | MIT RLM (Zhang et al., 2025) |
| **Complementary** | PR-018 (Ralph Loop), LAR-027 (RLM Framework) |

---

## Overview

The RLM Protocol defines how to process documents and queries that exceed effective context limits by treating content as a searchable environment with recursive sub-query capability.

**Problem Solved:** Context rot—where model quality degrades as context grows, especially for complex reasoning tasks.

---

## Protocol Activation

Activate PR-019 when ANY of these conditions exist:

| Condition | Threshold |
|-----------|-----------|
| Document length | > 30 pages / 50,000 tokens |
| Number of documents | > 3 documents to cross-reference |
| Query complexity | Multi-hop reasoning required |
| Context usage | > 50% of window consumed |
| Task type | Aggregation, comparison, dependency mapping |

---

## Core Workflow

```
┌─────────────────────────────────────────────────────────┐
│  1. DOCUMENT INDEXING                                   │
│     • Catalogue all input documents                     │
│     • Create searchable index (TOC, section headers)    │
│     • Identify document relationships                   │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│  2. QUERY DECOMPOSITION                                 │
│     • Parse user intent                                 │
│     • Break into atomic sub-queries                     │
│     • Map dependencies between sub-queries              │
│     • Plan execution order                              │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│  3. RECURSIVE EXECUTION                                 │◄───┐
│     FOR each sub-query:                                 │    │
│       • Search document index for relevant sections     │    │
│       • Extract minimal necessary context               │    │
│       • Process sub-query (fresh context)               │    │
│       • IF needs deeper analysis → RECURSE              ├────┘
│       • Store intermediate result                       │
└────────────────────────┬────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│  4. RESULT SYNTHESIS                                    │
│     • Aggregate all sub-query results                   │
│     • Resolve conflicts/contradictions                  │
│     • Construct coherent response                       │
│     • Cite sources for each claim                       │
└─────────────────────────────────────────────────────────┘
```

---

## Execution Rules

### Rule 1: Never Bulk Load

```
❌ WRONG: Load entire 100-page document into context
✅ RIGHT: Index document → Search for relevant sections → Load only those
```

### Rule 2: Decompose Before Execute

```
❌ WRONG: "Analyse this contract for all risks"
✅ RIGHT: 
  Sub-query 1: "Find liability clauses"
  Sub-query 2: "Find indemnification clauses"
  Sub-query 3: "Find termination clauses"
  Sub-query 4: "Cross-reference dependencies"
  Synthesis: Aggregate findings into risk assessment
```

### Rule 3: Fresh Context Per Sub-Call

Each sub-query should operate with:
- Only the question being asked
- Only the document section relevant to that question
- Clean context (no accumulated history)

### Rule 4: Aggregate at Root Level

- Sub-calls return structured findings
- Root level combines and synthesises
- Final response cites specific sources

---

## Sub-Query Template

When decomposing queries, use this structure:

```markdown
## Sub-Query [N]

**Question:** [Specific atomic question]
**Target:** [Document/Section to search]
**Search Terms:** [Keywords to locate relevant content]
**Expected Output:** [Structure of result]
**Dependencies:** [Other sub-queries that must complete first]
```

---

## Recursion Depth Control

| Depth | Scope | Example |
|-------|-------|---------|
| 0 | Root query | "Analyse contract risks" |
| 1 | Section analysis | "Review Section 8: Liability" |
| 2 | Clause deep-dive | "Parse sub-clause 8.2.1 definitions" |
| 3 | Term clarification | "Define 'gross negligence' as used" |

**Maximum recommended depth:** 3 levels

**Guardrails:**
- Track recursion depth
- Set maximum iterations (default: 10)
- Detect circular references
- Timeout after excessive iterations

---

## Document Relationship Types

When mapping document relationships:

| Relationship | Example | Query Pattern |
|--------------|---------|---------------|
| **References** | "See Section 5.2" | Search for section number mentions |
| **Defines** | "As defined in Article 1" | Map definitions to usage |
| **Modifies** | "Notwithstanding Section 3" | Identify exceptions/overrides |
| **Incorporates** | "Exhibit A attached hereto" | Link attachments to main body |
| **Conflicts** | Contradictory provisions | Compare and flag |

---

## Output Format

RLM analysis should produce:

```markdown
# RLM Analysis Report

## Query
[Original user query]

## Decomposition
| Sub-Query | Target Section | Status |
|-----------|----------------|--------|
| 1. [Query] | [Section] | Complete |
| 2. [Query] | [Section] | Complete |

## Findings

### Sub-Query 1: [Title]
**Source:** [Document, Section X.X, Page Y]
**Finding:** [Result]

### Sub-Query 2: [Title]
**Source:** [Document, Section X.X, Page Y]
**Finding:** [Result]

## Synthesis
[Combined analysis addressing original query]

## Cross-References Identified
- Section X.X → Section Y.Y (defines terms)
- Section A.A → Exhibit B (incorporates)

## Sources Cited
1. [Document], Section X.X, Page Y
2. [Document], Section A.A, Page Z
```

---

## Integration Matrix

| Protocol/Skill | Integration Point |
|----------------|-------------------|
| PR-018 Ralph Loop | Ralph Loop for multi-session, RLM for within-session complexity |
| LAR-027 RLM Framework | Skill provides patterns, protocol provides execution |
| LAR-023 Batch Processing | Batch for multiple documents, RLM for each document's complexity |
| SES-001 Session Persistence | Checkpoint after major RLM phases |
| MEM-001 Memory Protocol | Store RLM findings for cross-session continuity |

---

## Commands

| Command | Action |
|---------|--------|
| "Apply RLM protocol" | Full protocol activation |
| "Decompose this query" | Phase 2 only |
| "Search and extract" | Index + targeted extraction |
| "Recursive analysis on [section]" | Sub-call on specific section |
| "Synthesise findings" | Phase 4 aggregation |

---

## Error Handling

| Error | Response |
|-------|----------|
| Circular reference detected | Flag sections, request human guidance |
| Max recursion depth exceeded | Return partial results, note limitation |
| Section not found | Broaden search, suggest alternatives |
| Conflicting information | Present both, flag contradiction |
| Timeout | Checkpoint progress, allow resume |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 18 Jan 2026 | Initial release |

---

*Frans Master Prompt Dictionary - Protocol PR-019 v1.0*
