# Frans Skill: Research Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Name** | research-protocol |
| **Version** | 1.0 |
| **ID** | LAR-001 |
| **Triggers** | "deep research", "investigate", "market analysis" |
| **Google Doc Name** | `SKILL_ResearchProtocol` |

---

## Purpose

Enable rigorous, consulting-grade research with proper source validation, uncertainty quantification, and structured deliverables.

---

## Source Tiers

| Tier | Description | Examples | Confidence |
|------|-------------|----------|------------|
| **T1 Primary** | Original sources, official data | Company filings (10-K, annual reports), government statistics, peer-reviewed academic papers, official announcements | Highest |
| **T2 Secondary** | Expert analysis of primary sources | Analyst reports (Gartner, McKinsey), quality journalism (FT, WSJ), industry publications | Medium |
| **T3 Tertiary** | General information | General media, blogs, Wikipedia, social media | Verify independently |

### Source Preference Order

```
1. Primary sources (T1) - Use whenever available
2. Secondary sources (T2) - Acceptable when T1 unavailable
3. Tertiary sources (T3) - Only for context, always verify
```

---

## Confidence Levels

| Level | Code | Criteria |
|-------|------|----------|
| **HIGH** | HC | Multiple T1 sources agree, recent data (< 12 months), no contradictions |
| **MEDIUM** | MC | T2 sources, some data gaps, minor contradictions resolved |
| **LOW** | LC | T3 sources, significant gaps, requires inference, older data |

### Confidence Indicators in Output

```markdown
**Finding:** The market size is approximately $50B (HC)
**Finding:** Growth rate estimated at 15-20% (MC)
**Finding:** Based on limited data, adoption may reach 40% (LC)
```

---

## Research Workflow

```
1. SCOPE DEFINITION
   â”œâ”€â”€ Define research question(s)
   â”œâ”€â”€ Identify key terms and concepts
   â”œâ”€â”€ Set boundaries (time, geography, industry)
   â””â”€â”€ Determine required confidence level

2. SOURCE IDENTIFICATION
   â”œâ”€â”€ List potential primary sources
   â”œâ”€â”€ Identify secondary sources
   â”œâ”€â”€ Note any tertiary sources for context
   â””â”€â”€ Assess source availability

3. DATA COLLECTION
   â”œâ”€â”€ Gather data systematically
   â”œâ”€â”€ Record source details and dates
   â”œâ”€â”€ Note any access limitations
   â””â”€â”€ Track conflicting information

4. ANALYSIS
   â”œâ”€â”€ Synthesise findings
   â”œâ”€â”€ Identify patterns and trends
   â”œâ”€â”€ Reconcile contradictions
   â””â”€â”€ Assign confidence levels

5. VALIDATION
   â”œâ”€â”€ Cross-reference key claims
   â”œâ”€â”€ Check for recency
   â”œâ”€â”€ Identify gaps
   â””â”€â”€ Document limitations

6. SYNTHESIS
   â”œâ”€â”€ Structure findings
   â”œâ”€â”€ Draw implications
   â”œâ”€â”€ Formulate recommendations
   â””â”€â”€ Prepare deliverable
```

---

## Output Structure

### 1. Executive Summary
- Key findings (3-5 bullets)
- Primary recommendation
- Confidence assessment

### 2. Research Question & Scope
- Central question(s)
- Scope boundaries
- Exclusions

### 3. Methodology
- Sources consulted
- Research approach
- Limitations acknowledged

### 4. Findings
Each finding includes:
- Statement
- Supporting evidence
- Source citation
- Confidence level (HC/MC/LC)

### 5. Analysis & Implications
- Pattern synthesis
- Trend identification
- Strategic implications

### 6. Recommendations
- Prioritised actions
- Rationale
- Dependencies/risks

### 7. Limitations
- Data gaps
- Source limitations
- Scope constraints

### 8. Sources
- Full citation list
- Access dates
- Source tier classification

---

## Research Report Template

```markdown
# Research Report: [Topic]

**Date:** [DD Month YYYY]
**Prepared for:** [Recipient]
**Researcher:** [Name/Frans]
**Confidence Level:** [Overall HC/MC/LC]

---

## Executive Summary

[2-3 paragraph summary of key findings and recommendations]

**Key Findings:**
1. [Finding 1] (HC)
2. [Finding 2] (MC)
3. [Finding 3] (HC)

**Primary Recommendation:** [Main action recommended]

---

## Research Question & Scope

**Central Question:**
[The primary question this research addresses]

**Scope:**
- Geographic: [Regions covered]
- Temporal: [Time period]
- Industry: [Sectors included]

**Exclusions:**
- [What was explicitly not covered]

---

## Methodology

**Sources Consulted:**
- T1 Primary: [List]
- T2 Secondary: [List]
- T3 Tertiary: [List]

**Approach:**
[Description of research methodology]

---

## Findings

### Finding 1: [Title]
**Confidence:** HC

[Detailed finding with supporting evidence]

**Source:** [Citation with date]

### Finding 2: [Title]
**Confidence:** MC

[Detailed finding with supporting evidence]

**Source:** [Citation with date]

---

## Analysis & Implications

[Synthesis of findings, patterns identified, strategic implications]

---

## Recommendations

| Priority | Recommendation | Rationale | Risk |
|----------|---------------|-----------|------|
| 1 | [Action] | [Why] | [Risk level] |
| 2 | [Action] | [Why] | [Risk level] |

---

## Limitations

- [Limitation 1]
- [Limitation 2]

---

## Sources

### Primary (T1)
1. [Full citation, accessed DD Month YYYY]

### Secondary (T2)
1. [Full citation, accessed DD Month YYYY]

### Tertiary (T3)
1. [Full citation, accessed DD Month YYYY]
```

---

## Citation Format

```
[Author/Organisation]. "[Title]." [Publication], [Date]. [URL if applicable]. Accessed [Date].
```

**Example:**
```
Gartner. "Market Guide for AI in Healthcare." Gartner Research, 15 March 2025. Accessed 04 January 2026.
```

---

## Rules

```
+define-scope-before-research    # Always scope before starting
+cite-all-sources-with-dates     # Every claim needs citation
+quantify-uncertainty            # Use HC/MC/LC indicators
+prefer-primary-sources          # T1 > T2 > T3
+acknowledge-limitations         # Be transparent about gaps
-fabricate-statistics            # Never invent numbers
-present-outdated-data-as-current # Always note data age
-claim-certainty-without-evidence # Uncertainty is acceptable
-ignore-contradictory-evidence   # Address conflicts
```

---

## Quality Checklist

```
â˜ Research question clearly defined
â˜ Scope boundaries established
â˜ Primary sources prioritised
â˜ All sources cited with dates
â˜ Confidence levels assigned
â˜ Contradictions addressed
â˜ Limitations documented
â˜ Recommendations actionable
â˜ Executive summary captures key points
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 001 Executive Strategic Advisor | Strategic market research |
| 003 Market Research Specialist | Primary user - full research protocol |
| 010 The Architect | Cross-domain research coordination |

---

*Frans Skill LAR-001 | Research Protocol v1.0*
