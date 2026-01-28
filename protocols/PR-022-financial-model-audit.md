# PR-022: Financial Model Audit Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | PR-022 |
| **Name** | Financial Model Audit Protocol |
| **Version** | 1.0 |
| **Created** | 28 January 2026 |
| **Domain** | Financial Model QA |
| **Primary Persona** | 021 Financial Modelling Expert |

---

## Purpose

Comprehensive audit protocol for validating financial models, quotation systems, and complex Excel-based calculations to ensure accuracy, integrity, and professional quality before deployment or client delivery.

---

## Audit Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                     FINANCIAL MODEL AUDIT FLOW                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐      │
│  │  INTAKE  │───▶│ MAPPING  │───▶│  AUDIT   │───▶│  TEST    │      │
│  │  Phase 1 │    │  Phase 2 │    │  Phase 3 │    │  Phase 4 │      │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘      │
│       │               │               │               │              │
│       ▼               ▼               ▼               ▼              │
│  Understand      Document       Formula-by-     Stress test        │
│  objectives      architecture   formula check   boundaries         │
│                                                                      │
│                           │                                          │
│                           ▼                                          │
│                    ┌──────────┐    ┌──────────┐                     │
│                    │  REPORT  │───▶│ SIGN-OFF │                     │
│                    │  Phase 5 │    │  Phase 6 │                     │
│                    └──────────┘    └──────────┘                     │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Intake

### Objective
Understand the model's purpose, scope, and audit requirements.

### Checklist
```
INTAKE QUESTIONS:
│
├── 1. MODEL IDENTIFICATION
│   ├── Model name and version?
│   ├── Owner/creator?
│   ├── Date created/last modified?
│   └── File location?
│
├── 2. PURPOSE AND SCOPE
│   ├── What is this model for?
│   ├── What decisions does it support?
│   ├── Who are the users?
│   └── What outputs matter most?
│
├── 3. DATA SOURCES
│   ├── Where do inputs come from?
│   ├── How often are they updated?
│   ├── Are there external links?
│   └── What is the data quality?
│
├── 4. AUDIT REQUIREMENTS
│   ├── Full audit or targeted review?
│   ├── Specific concerns to address?
│   ├── Timeline for completion?
│   └── Required sign-off level?
│
└── 5. PRIOR ISSUES
    ├── Known bugs or limitations?
    ├── Previous audit findings?
    └── User-reported problems?
```

### Deliverable
- Intake form completed
- Audit scope defined
- Timeline agreed

---

## Phase 2: Model Mapping

### Objective
Document the model's structure and data flows.

### Checklist
```
MAPPING ACTIVITIES:
│
├── 1. SHEET INVENTORY
│   ├── List all worksheets
│   ├── Identify purpose of each
│   ├── Note hidden sheets
│   └── Document sheet dependencies
│
├── 2. INPUT IDENTIFICATION
│   ├── Locate all input cells
│   ├── Document input sources
│   ├── Note validation rules
│   └── Identify input ranges
│
├── 3. OUTPUT IDENTIFICATION
│   ├── Locate key outputs
│   ├── Identify report sheets
│   ├── Note dashboard elements
│   └── Document print areas
│
├── 4. CALCULATION FLOW
│   ├── Trace major calculations
│   ├── Identify intermediate steps
│   ├── Note complex formulas
│   └── Document dependencies
│
└── 5. EXTERNAL DEPENDENCIES
    ├── List external file links
    ├── Identify database connections
    ├── Note API calls
    └── Document macros/VBA
```

### Deliverable
- Model map document
- Data flow diagram
- Sheet dependency matrix

---

## Phase 3: Formula Audit

### Objective
Verify every unique formula for accuracy and appropriateness.

### Audit Procedure
```
FOR EACH UNIQUE FORMULA:
│
├── 1. UNDERSTAND
│   ├── What is it calculating?
│   ├── What inputs does it use?
│   ├── What should the output be?
│   └── Is the approach correct?
│
├── 2. VERIFY
│   ├── Trace all precedents
│   ├── Check mathematical accuracy
│   ├── Verify reference types ($A$1 vs A1)
│   ├── Confirm lookup ranges
│   └── Test conditional logic
│
├── 3. TEST
│   ├── Calculate manually to confirm
│   ├── Try boundary values
│   ├── Check error handling
│   └── Verify across row/column
│
└── 4. DOCUMENT
    ├── Record formula location
    ├── Note any issues found
    ├── Classify severity
    └── Recommend fix if needed
```

### Focus Areas
```
HIGH-RISK FORMULA TYPES:
│
├── LOOKUPS (VLOOKUP, XLOOKUP, INDEX/MATCH)
│   ├── Correct range?
│   ├── Correct match type?
│   ├── Error handling for not-found?
│   └── Sorted data if required?
│
├── CONDITIONALS (IF, IFS, SWITCH)
│   ├── All branches tested?
│   ├── Boundary conditions correct?
│   ├── Default/else case handled?
│   └── Logic order correct?
│
├── AGGREGATIONS (SUM, SUMIF, SUMPRODUCT)
│   ├── Range includes all items?
│   ├── No double-counting?
│   ├── Criteria correct?
│   └── Array formula entered correctly?
│
└── FINANCIAL (NPV, IRR, PMT)
    ├── Rate period matches cash flows?
    ├── Sign convention correct?
    ├── Correct number of periods?
    └── Initial investment handled correctly?
```

### Deliverable
- Formula audit workpaper
- Issues log with severity
- Recommended fixes

---

## Phase 4: Stress Testing

### Objective
Verify model behaviour under extreme and boundary conditions.

### Test Scenarios
```
STRESS TEST MATRIX:
│
├── ZERO VALUES
│   ├── All inputs = 0
│   ├── Selected inputs = 0
│   ├── Divisor = 0
│   └── Empty cells
│
├── MINIMUM VALUES
│   ├── Smallest valid inputs
│   ├── Just above zero
│   ├── Negative where allowed
│   └── Minimum thresholds
│
├── MAXIMUM VALUES
│   ├── Very large numbers
│   ├── Maximum valid inputs
│   ├── 100% percentages
│   └── Capacity limits
│
├── BOUNDARY CONDITIONS
│   ├── At tier thresholds
│   ├── At date boundaries
│   ├── At rounding points
│   └── At validation limits
│
└── INVALID INPUTS
    ├── Text in number fields
    ├── Negative where not allowed
    ├── Out-of-range values
    └── Invalid dates
```

### Test Documentation
```markdown
## Stress Test Log

| Test ID | Description | Input Values | Expected Result | Actual Result | Pass/Fail | Notes |
|---------|-------------|--------------|-----------------|---------------|-----------|-------|
| ST-001 | Zero quantity | Qty=0 | Total=0 | Total=0 | ✅ | |
| ST-002 | Max quantity | Qty=999999 | Calculated | #NUM! | ❌ | Overflow |
```

### Deliverable
- Stress test results
- Failed tests documented
- Edge case issues

---

## Phase 5: Reporting

### Audit Report Structure
```markdown
# Financial Model Audit Report

## 1. Executive Summary
- Model: [Name and version]
- Audit date: [Date]
- Auditor: [Name]
- Overall finding: [Pass / Conditional Pass / Fail]
- Critical issues: [Count]

## 2. Scope and Methodology
- Audit scope: [Full / Targeted]
- Methodology: [PR-022 Financial Model Audit Protocol]
- Sheets audited: [List]

## 3. Findings Summary
| Severity | Count | Examples |
|----------|-------|----------|
| Critical | X | [Brief list] |
| High | X | [Brief list] |
| Medium | X | [Brief list] |
| Low | X | [Brief list] |

## 4. Detailed Findings

### Critical Issues
[Detailed description, location, impact, recommendation]

### High Priority Issues
[Detailed description, location, impact, recommendation]

### Medium Priority Issues
[Detailed description, location, impact, recommendation]

### Low Priority Issues
[Detailed description, location, impact, recommendation]

## 5. Stress Test Results
[Summary of boundary testing]

## 6. Recommendations
1. [Prioritised recommendation]
2. [Prioritised recommendation]

## 7. Appendices
- A: Formula audit workpaper
- B: Stress test log
- C: Model map
```

### Severity Classification

| Severity | Definition | Action Required |
|----------|------------|-----------------|
| **Critical** | Calculation error affecting key outputs | Must fix before use |
| **High** | Logic error or missing validation | Should fix before use |
| **Medium** | Design issue or inefficiency | Recommend fixing |
| **Low** | Cosmetic or documentation gap | Consider fixing |

### Deliverable
- Complete audit report
- Executive summary
- Detailed findings
- Recommendations

---

## Phase 6: Sign-Off

### Sign-Off Criteria

```
PASS CRITERIA:
├── No critical issues
├── No high issues (or all resolved)
├── Stress tests pass
└── Documentation complete

CONDITIONAL PASS:
├── No critical issues
├── High issues documented with mitigation
├── Known limitations accepted
└── Remediation plan agreed

FAIL:
├── Critical issues present
├── Model not fit for purpose
├── Remediation required before use
└── Re-audit required after fixes
```

### Sign-Off Form
```markdown
## Model Audit Sign-Off

**Model:** [Name]
**Version:** [Version]
**Audit Date:** [Date]

### Audit Result: [PASS / CONDITIONAL PASS / FAIL]

### Conditions (if applicable):
1. [Condition]

### Sign-Off:

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Auditor | | | |
| Model Owner | | | |
| Approver | | | |

### Notes:
[Any additional notes]
```

---

## Quick Audit Checklist

For time-constrained reviews:

```
RAPID AUDIT (30-60 minutes):
│
├── [ ] Check for circular references
├── [ ] Verify totals cross-foot
├── [ ] Test key formulas manually
├── [ ] Check for #REF!, #DIV/0!, #N/A errors
├── [ ] Verify inputs are isolated
├── [ ] Test one boundary condition per section
├── [ ] Check tax calculation
├── [ ] Verify grand total formula
└── [ ] Document any issues found
```

---

*PR-022 | Financial Model Audit Protocol v1.0 | Systematic Model Validation*
