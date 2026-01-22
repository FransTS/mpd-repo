# LAR-021: Authenticity Check Skill

| Field | Value |
|-------|-------|
| **Skill ID** | LAR-021 |
| **Name** | Authenticity Check |
| **Version** | 1.0 |
| **Category** | Quality Assurance |
| **Triggers** | "check authenticity", "humanize", "AI check", "review for AI markers" |
| **Google Doc Name** | `SKILL_AuthenticityCheck` |
| **Last Updated** | 09 January 2026 |

---

## Purpose

Systematically review documents to detect and remove AI-generated markers while preserving accuracy and substance. Ensure all output appears authentically human-created.

---

## Activation

```
TRIGGERS:
├── "Check this for AI markers"
├── "Humanize this document"
├── "Review for authenticity"
├── "Make this sound human"
├── "AI detection check"
├── "Does this sound like AI?"
└── Auto-triggered by Persona 013 (Authenticity Reviewer)
```

---

## Review Process

### Phase 1: AI Marker Detection

#### 1.1 Language Scan

```
SCAN FOR:
├── Banned phrases (see Human Authenticity Protocol)
├── Excessive formality
├── Robotic transitions
├── Over-hedging
├── Generic examples
├── Perfect parallelism
└── Predictable structures

OUTPUT FORMAT:
┌─────────────────────────────────────────────┐
│ AI MARKER DETECTED                          │
├─────────────────────────────────────────────┤
│ Location: [paragraph/section]               │
│ Issue: [specific problem]                   │
│ Original: "[exact text]"                    │
│ Suggested: "[humanized version]"            │
│ Confidence: [High/Medium/Low]               │
└─────────────────────────────────────────────┘
```

#### 1.2 Structure Analysis

```
CHECK FOR:
├── Every section same length? → Vary it
├── All lists parallel? → Break pattern
├── Predictable flow? → Reorganize
├── Over-organized? → Simplify
├── Too many bullets? → Convert to prose
└── Excessive headers? → Consolidate
```

#### 1.3 Tone Assessment

| Document Type | Expected Tone | Current Tone | Match? |
|--------------|---------------|--------------|--------|
| [Type] | [Expected] | [Detected] | [Y/N] |

---

### Phase 2: Fact Verification

#### 2.1 Fact Extraction

```
EXTRACT ALL:
├── Statistics and numbers
├── Dates and timelines
├── Names (people, companies, products)
├── Quotes and attributions
├── Market/industry claims
├── Technical specifications
└── Historical references
```

#### 2.2 Verification Matrix

| Fact | Source | Verified? | Action |
|------|--------|-----------|--------|
| [Claim] | [Source/None] | [Y/N/?] | [Confirm/Flag/Remove] |

#### 2.3 Verification Prompts

```
FOR UNVERIFIED FACTS:
┌─────────────────────────────────────────────┐
│ ⚠️ VERIFICATION NEEDED                      │
├─────────────────────────────────────────────┤
│ Claim: "[specific claim]"                   │
│ Context: [where it appears]                 │
│ Impact if wrong: [High/Medium/Low]          │
│                                             │
│ Please confirm:                             │
│ □ Accurate as stated                        │
│ □ Needs correction: ___________             │
│ □ Remove claim                              │
│ □ Add source: ___________                   │
└─────────────────────────────────────────────┘
```

---

### Phase 3: Visual Element Review

#### 3.1 Chart/Graph Check

```
REVIEW:
├── Labels readable and natural?
├── Colors consistent but not rigid?
├── Data accurately represented?
├── Title describes insight?
├── Appropriate chart type?
└── Not over-designed?
```

#### 3.2 Table Check

```
REVIEW:
├── Minimal necessary borders?
├── Appropriate column count?
├── Headers clear?
├── Data alignment natural?
├── No excessive formatting?
└── Information hierarchy clear?
```

#### 3.3 Diagram Check

```
REVIEW:
├── Flow direction clear?
├── Labels explanatory?
├── Color palette limited (3-4)?
├── Grouping meaningful?
├── Not too perfect/symmetric?
└── Annotations where needed?
```

#### 3.4 Presentation Check

```
REVIEW:
├── One message per slide?
├── Layout variety?
├── Text minimal?
├── Images purposeful?
├── Speaker notes natural?
└── Builds meaningful?
```

---

### Phase 4: Humanization

#### 4.1 Language Humanization

```
TRANSFORMATION RULES:
├── Replace banned phrases with natural alternatives
├── Vary sentence length (mix short and long)
├── Add occasional contractions
├── Include specific examples
├── Insert natural transitions
├── Break perfect parallelism
└── Add personality where appropriate
```

#### 4.2 Structure Humanization

```
TRANSFORMATION RULES:
├── Vary paragraph lengths
├── Convert some bullets to prose
├── Reduce heading levels
├── Add natural white space
├── Create intentional asymmetry
└── Focus content (less is more)
```

#### 4.3 Preserve Substance

```
⚠️ CRITICAL: Never change:
├── Technical accuracy
├── Factual information
├── Key messages
├── Required compliance elements
├── Legal/contractual terms
├── Numerical data
└── Quoted material
```

---

## Output Format

### Authenticity Report

```markdown
# Authenticity Review Report

## Document: [Name]
## Date: [Date]
## Reviewer: Persona 013 (Authenticity Reviewer)

---

## Summary

| Metric | Score | Status |
|--------|-------|--------|
| AI Markers Found | [N] | [🔴/🟡/🟢] |
| Facts Requiring Verification | [N] | [List/None] |
| Visual Elements Reviewed | [N] | [Pass/Issues] |
| Overall Authenticity | [%] | [Low/Medium/High] |

---

## AI Markers Detected

### High Priority (Must Fix)
1. [Issue] → [Solution]
2. [Issue] → [Solution]

### Medium Priority (Should Fix)
1. [Issue] → [Solution]

### Low Priority (Consider)
1. [Issue] → [Solution]

---

## Fact Verification Required

| # | Claim | Action Needed |
|---|-------|---------------|
| 1 | [Claim] | [Confirm/Source/Remove] |

---

## Visual Element Notes

[Notes on charts, tables, diagrams, slides]

---

## Recommended Changes

[Numbered list of specific changes with before/after]

---

## Humanized Version

[If requested, include full humanized document]
```

---

## Quick Check Mode

For rapid review without full report:

```
QUICK CHECK OUTPUT:
┌─────────────────────────────────────────────┐
│ AUTHENTICITY QUICK CHECK                    │
├─────────────────────────────────────────────┤
│ AI Markers: [None/Few/Many]                 │
│ Confidence: [Looks Human/Borderline/Obvious AI] │
│ Top Issues: [1-3 main problems]             │
│ Recommendation: [Pass/Minor Edits/Rewrite]  │
└─────────────────────────────────────────────┘
```

---

## Integration

**Depends On:**
- Human Authenticity Protocol (rules reference)
- LAR-007: Self-Assessment (quality gate)
- LAR-019: Knowledge Synthesis (fact checking)

**Used By:**
- Persona 013: Authenticity Reviewer (primary)
- All document-creating personas (on-demand)

---

## Stop Hooks

| Hook ID | Trigger | Action |
|---------|---------|--------|
| HOOK-AUTHCHK-001 | Critical AI marker in final output | STOP → Must humanize before delivery |
| HOOK-AUTHCHK-002 | Unverified critical fact | STOP → Prompt user for confirmation |
| HOOK-AUTHCHK-003 | Substance changed during humanization | STOP → Revert and re-humanize |

---

*LAR-021: Authenticity Check v1.0*
