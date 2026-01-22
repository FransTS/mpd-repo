# Frans Skill: RLM Framework

## Metadata

| Field | Value |
|-------|-------|
| **Name** | rlm-framework |
| **Version** | 1.0 |
| **ID** | LAR-027 |
| **Triggers** | "recursive analysis", "deep dive", "context as environment" |
| **Based On** | MIT Recursive Language Models (Zhang et al., 2025) |
| **Created** | 18 January 2026 |

---

## Overview

Recursive Language Models (RLMs) treat long prompts as **external environments** rather than direct context input. This prevents context rot and enables processing of documents 100x beyond native context windows.

**Core Insight:** Long prompts should not be fed directly into the neural network—they should be treated as searchable environments the LLM can programmatically navigate.

---

## Key Concepts

### 1. Context as Environment

```
Traditional: Document → Context Window → Process
RLM:         Document → Variable in REPL → Search/Query → Process relevant parts
```

- Store massive documents as variables
- Model writes code to search, slice, filter
- Only relevant chunks enter active context
- Prevents context rot at scale

### 2. Recursive Sub-Calls

```
Root Query → Find relevant sections
           → Sub-call on Section A → Result A
           → Sub-call on Section B → Result B
           → Combine A + B → Final Answer
```

- Model can call "itself" on sub-sections
- Each sub-call gets fresh context
- Results aggregated at root level
- Enables arbitrarily deep analysis

### 3. Dependency Graph Thinking

Instead of treating documents as linear text, view them as **dependency graphs**:

- Contracts: Clauses reference other clauses
- Code: Functions call other functions
- Research: Papers cite other papers
- Policies: Sections depend on definitions

---

## When to Apply RLM

| Scenario | RLM Benefit |
|----------|-------------|
| Multi-document synthesis | Navigate across documents without loading all |
| Long contracts (50+ pages) | Search clauses, cross-reference dependencies |
| Code repository analysis | Trace function calls across files |
| Legal case review | Cross-reference precedents and statutes |
| Research synthesis | Aggregate findings from many papers |
| Due diligence | Systematic multi-source verification |

---

## RLM Process Framework

### Phase 1: Document Ingestion

```markdown
1. Identify all input documents/sources
2. Assign each to a searchable variable
3. Create document index/TOC
4. Map inter-document relationships
```

### Phase 2: Query Decomposition

```markdown
1. Parse original query intent
2. Identify required information sources
3. Break into atomic sub-queries
4. Plan execution order (dependencies first)
```

### Phase 3: Recursive Execution

```markdown
FOR each sub-query:
  1. Identify relevant document sections
  2. Extract minimal context needed
  3. Process with fresh context
  4. Store intermediate result
  5. IF deeper analysis needed:
     - Recurse with focused query
  6. Return to root level
```

### Phase 4: Result Synthesis

```markdown
1. Aggregate all sub-query results
2. Resolve conflicts/contradictions
3. Build coherent response
4. Cite sources for each claim
```

---

## Context Rot Prevention

| Context Load | % Used | Strategy |
|--------------|--------|----------|
| < 25% | Fresh | Continue normally |
| 25-50% | Growing | Consider sub-calls |
| 50-75% | Heavy | **Use RLM sub-calls** |
| > 75% | Critical | **Mandatory RLM decomposition** |

**Indicators of Context Rot:**
- Forgetting earlier instructions
- Contradicting previous statements
- Missing obvious connections
- Degraded response quality

---

## RLM Query Patterns

### Pattern 1: Search and Extract

```
Query: "Find all liability clauses in this contract"
RLM Approach:
  1. Search document for "liabil" keyword
  2. Extract surrounding context for each match
  3. Return clause numbers and text
```

### Pattern 2: Cross-Reference

```
Query: "Which clauses reference Section 5.2?"
RLM Approach:
  1. First: Read Section 5.2 content
  2. Search entire document for "5.2", "five.two", etc.
  3. For each match: extract context
  4. Return dependency map
```

### Pattern 3: Multi-Document Comparison

```
Query: "Compare termination rights across these 3 contracts"
RLM Approach:
  1. Sub-call on Contract A: "Extract termination clause"
  2. Sub-call on Contract B: "Extract termination clause"
  3. Sub-call on Contract C: "Extract termination clause"
  4. Root: Compare and tabulate differences
```

### Pattern 4: Aggregation Query

```
Query: "Summarise all financial obligations"
RLM Approach:
  1. Search for: payment, fee, cost, price, amount
  2. For each section found: extract obligation details
  3. Aggregate into financial summary
  4. Calculate totals if numeric
```

---

## Integration with Frans MPD

### With PR-018 (Ralph Loop)

- RLM handles within-task complexity
- Ralph Loop handles cross-session orchestration
- Use together for massive multi-day projects

### With LAR-023 (Batch Processing)

- RLM decomposes documents
- Batch processing handles multiple documents sequentially
- Combine for large document sets

### With LAR-024 (Memory Integration)

- Store RLM intermediate results in memory
- Resume complex analysis across sessions
- Build cumulative knowledge base

---

## Commands

| Command | Action |
|---------|--------|
| "RLM this document" | Apply recursive analysis |
| "Deep dive into [section]" | Recursive sub-call on specific section |
| "Cross-reference analysis" | Map dependencies across document |
| "Multi-doc synthesis" | Apply RLM across multiple sources |
| "Decompose query" | Break complex question into sub-queries |

---

## Best Practices

### DO

- ✅ Decompose complex queries into atomic parts
- ✅ Search before loading full sections
- ✅ Use sub-calls for distinct analysis tasks
- ✅ Aggregate results at root level
- ✅ Cite specific sections/pages

### DON'T

- ❌ Load entire documents into context
- ❌ Process everything in single pass
- ❌ Ignore cross-references
- ❌ Skip dependency mapping
- ❌ Assume linear document structure

---

## Persona Integration

| Persona | RLM Usage |
|---------|-----------|
| 008 Legal Expert | Contract deep-dive, clause cross-reference |
| 003 Market Research | Multi-source synthesis |
| 009 Software Architect | Code repository analysis |
| 010 The Architect | System-wide task decomposition |
| **016 Complex Document Analyst** | **Primary RLM specialist** |

---

## References

- Zhang, A. L., Kraska, T., & Khattab, O. (2025). *Recursive Language Models*. arXiv:2512.24601
- MIT OASYS Lab RLM Implementation: github.com/alexzhang13/rlm
- Prime Intellect RLM Implementation: primeintellect.ai/blog/rlm

---

*Frans Skill LAR-027 | RLM Framework v1.0*
