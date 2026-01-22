# LAR-030: Document Review Methodology

| Field | Value |
|-------|-------|
| **Skill ID** | LAR-030 |
| **Name** | Document Review Methodology |
| **Version** | 1.0 |
| **Last Updated** | 19 January 2026 |
| **Primary Persona** | 018 (Expert Document Editor) |
| **Category** | Quality Assurance |

---

## Purpose

Systematic methodology for comprehensive document review covering language quality, design/formatting, fact verification, requirements compliance, and style consistency.

---

## When to Use

```
TRIGGERS:
├── Document review/edit requests
├── Pre-submission quality checks
├── Requirements compliance verification
├── Fact-checking requirements
├── Formatting/design audits
└── Style consistency reviews
```

---

## Review Categories

### 1. Language Quality (LQ)

| Check | Items |
|-------|-------|
| LQ-01 | Spelling (technical terms, proper nouns, regional variants) |
| LQ-02 | Grammar (agreement, tense, modifiers, articles) |
| LQ-03 | Punctuation (commas, semicolons, apostrophes, hyphens) |
| LQ-04 | Syntax (sentence structure, clarity, ambiguity) |
| LQ-05 | Word choice (precision, redundancy, jargon) |
| LQ-06 | Paragraphs (flow, transitions, coherence) |
| LQ-07 | Readability (sentence length, complexity, audience) |

### 2. Design & Formatting (DF)

| Check | Items |
|-------|-------|
| DF-01 | Typography (fonts, sizes, weights, consistency) |
| DF-02 | Layout (margins, alignment, spacing, balance) |
| DF-03 | Headings (hierarchy, numbering, styles) |
| DF-04 | Lists (bullet/number, parallelism, punctuation) |
| DF-05 | Tables (structure, headers, alignment, borders) |
| DF-06 | Images/Diagrams (placement, captions, quality) |
| DF-07 | Page design (headers, footers, page numbers) |
| DF-08 | White space (balance, readability) |
| DF-09 | Consistency (same elements styled identically) |

### 3. Fact Verification (FV)

| Check | Items |
|-------|-------|
| FV-01 | Numbers (statistics, figures, calculations) |
| FV-02 | Dates (accuracy, consistency, format) |
| FV-03 | Names (people, companies, products) |
| FV-04 | Claims (verifiable statements) |
| FV-05 | References (citations, sources, links) |
| FV-06 | Internal consistency (same fact stated differently) |
| FV-07 | External verification (against reliable sources) |

### 4. Requirements Compliance (RC)

| Check | Items |
|-------|-------|
| RC-01 | Requirement extraction (from source document) |
| RC-02 | Mapping (requirement → deliverable section) |
| RC-03 | Coverage scoring (fully/partially/not addressed) |
| RC-04 | Gap identification (missing requirements) |
| RC-05 | Compliance matrix generation |
| RC-06 | Remediation recommendations |

### 5. Style Consistency (SC)

| Check | Items |
|-------|-------|
| SC-01 | Tone (formal/informal, consistent throughout) |
| SC-02 | Voice (active/passive, person, consistency) |
| SC-03 | Terminology (technical terms, acronyms, definitions) |
| SC-04 | Brand alignment (style guide compliance) |
| SC-05 | Audience appropriateness |
| SC-06 | Regional standards (British/American, date formats) |

---

## Review Depth Levels

| Level | Categories | Time | Use When |
|-------|------------|------|----------|
| **Quick** | LQ-01,02,03 | 5-10 min | Urgent, informal |
| **Standard** | LQ all, DF-01,02,03, FV-01,02 | 15-30 min | Most documents |
| **Deep** | All LQ, DF, FV + RC | 30-60 min | Formal submissions |
| **Forensic** | All categories, cross-reference | 60+ min | High-stakes |

---

## Issue Severity Classification

| Severity | Definition | Examples |
|----------|------------|----------|
| **Critical** | Blocks submission; causes confusion/error | Wrong client name, incorrect figures, missing required section |
| **High** | Significant professional impact | Grammar errors in executive summary, broken formatting |
| **Medium** | Noticeable but not blocking | Minor punctuation, inconsistent capitalisation |
| **Low** | Polish items | Optional style improvements, minor spacing |

---

## Review Process

### Phase 1: Triage (2 min)

```
ASSESS:
├── Document type
├── Audience
├── Requirements source (if any)
├── Review depth required
├── Time available
└── Priority areas
```

### Phase 2: First Pass - Language (variable)

```
SCAN ORDER:
├── Title and headings (most visible)
├── Opening paragraph (first impression)
├── Executive summary (high stakes)
├── Body content (systematic)
├── Conclusion/recommendations
├── Appendices
└── Metadata (headers, footers)
```

### Phase 3: Second Pass - Formatting (variable)

```
VISUAL SCAN:
├── Overall layout impression
├── Heading hierarchy check
├── Table/list consistency
├── Image placement/quality
├── Page design elements
└── White space balance
```

### Phase 4: Fact Check (variable)

```
VERIFICATION:
├── Extract all factual claims
├── Categorise by verifiability
├── Check critical facts first
├── Flag unverifiable for user
└── Document verification status
```

### Phase 5: Requirements Check (if applicable)

```
COMPLIANCE:
├── Load requirements document
├── Create requirement list
├── Map to deliverable
├── Score each requirement
├── Generate gap list
└── Build compliance matrix
```

### Phase 6: Style Audit (5 min)

```
CONSISTENCY:
├── Tone check
├── Voice consistency
├── Terminology audit
├── Brand compliance
└── Regional standards
```

### Phase 7: Synthesis (5 min)

```
OUTPUT:
├── Prioritise findings
├── Group by category
├── Calculate scores
├── Generate summary
└── Deliver report
```

---

## Output Template

```markdown
## Document Quality Report

**Document:** [Name]
**Type:** [Type]
**Reviewed:** [Date]
**Depth:** [Quick/Standard/Deep/Forensic]

### Quality Scores

| Category | Score |
|----------|-------|
| Language | X/10 |
| Formatting | X/10 |
| Facts | X/10 |
| Compliance | X/10 |
| Style | X/10 |
| **Overall** | **X/10** |

### Issues Summary

| Priority | Count |
|----------|-------|
| Critical | X |
| High | X |
| Medium | X |
| Low | X |

### Critical Issues (Must Fix)

1. [Location]: [Issue] → [Correction]

### Recommendations

1. [Priority recommendation]

### Verdict

[Ready / Minor Edits / Major Revision Required]
```

---

## British English Reference

| American | British (Use This) |
|----------|-------------------|
| organize | organise |
| color | colour |
| center | centre |
| program | programme |
| analyze | analyse |
| license (noun) | licence |
| practice (verb) | practise |

**Date Format:** DD/MM/YYYY or DD Month YYYY
**Currency:** R or ZAR
**Quotations:** Single quotes ('example')

---

## Common Issues Reference

### Frequently Missed Spelling

| Wrong | Correct |
|-------|---------|
| seperate | separate |
| accomodate | accommodate |
| occured | occurred |
| liase | liaise |
| committment | commitment |
| recieve | receive |

### Frequently Missed Grammar

| Issue | Example |
|-------|---------|
| Subject-verb | The team are → is |
| Dangling modifier | Fix placement |
| Comma splice | Use semicolon or split |
| Affect/effect | Verb/noun distinction |
| Its/it's | Possessive/contraction |
| Their/there/they're | Context dependent |

### Frequently Missed Punctuation

| Issue | Rule |
|-------|------|
| Serial comma | Use in British formal writing |
| Semicolon | Independent clauses only |
| Colon | Complete sentence before |
| Hyphen | Compound modifiers before noun |
| En-dash | Ranges (2020–2025) |

---

## Integration with Other Skills

| Skill | When to Combine |
|-------|-----------------|
| LAR-021 | Authenticity check after review |
| LAR-027 | Long/complex documents (RLM) |
| LAR-029 | Multi-document review |
| LAR-002 | Contract-specific review |
| LAR-001 | Deep fact verification research |

---

*LAR-030: Document Review Methodology v1.0*
