# LAR-032: Quotation Validation

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | LAR-032 |
| **Name** | Quotation Validation |
| **Version** | 1.0 |
| **Created** | 28 January 2026 |
| **Domain** | Financial Model Audit |
| **Primary Persona** | 021 Financial Modelling Expert |

---

## Purpose

Systematic validation of quotation models and complex pricing spreadsheets to ensure accuracy, consistency, and reliability before client delivery or internal approval.

---

## Activation Triggers

```
TRIGGERS:
├── "Validate quotation"
├── "Audit pricing model"
├── "Check quote accuracy"
├── "Verify calculations"
├── "Model integrity check"
├── "Spreadsheet audit"
└── Complex financial model review requests
```

---

## Validation Framework

### Phase 1: Structural Audit

```
STRUCTURAL CHECKS:
│
├── 1.1 INPUT ISOLATION
│   ├── All inputs in dedicated section?
│   ├── Inputs visually distinct (blue background)?
│   ├── Data validation applied?
│   └── Clear labels and units?
│
├── 1.2 FORMULA HYGIENE
│   ├── No hardcoded numbers in formulas?
│   ├── Named ranges used appropriately?
│   ├── Consistent formula patterns?
│   └── Error handling present?
│
├── 1.3 ARCHITECTURE
│   ├── Clear flow: Inputs → Calculations → Outputs?
│   ├── Logical sheet organisation?
│   ├── Time flows left to right?
│   └── Calculations flow top to bottom?
│
├── 1.4 REFERENCES
│   ├── No circular references?
│   ├── No broken references (#REF!)?
│   ├── External links documented?
│   └── Absolute/relative references correct?
│
└── OUTPUT: Structure Score (0-100)
    └── Findings list with severity
```

### Phase 2: Calculation Verification

```
CALCULATION CHECKS:
│
├── 2.1 FORMULA ACCURACY
│   ├── Trace precedents for key formulas
│   ├── Verify mathematical logic
│   ├── Check operator precedence
│   └── Test with known values
│
├── 2.2 AGGREGATION CHECKS
│   ├── Row totals = Column totals? (cross-foot)
│   ├── Subtotals sum to grand total?
│   ├── Percentages sum to 100%?
│   └── No double-counting?
│
├── 2.3 LOOKUP VERIFICATION
│   ├── VLOOKUP/XLOOKUP return correct values?
│   ├── Lookup ranges correct?
│   ├── Match types appropriate?
│   └── Error handling for not-found?
│
├── 2.4 CONDITIONAL LOGIC
│   ├── All IF branches tested?
│   ├── Boundary conditions correct?
│   ├── Nested logic clear?
│   └── Default cases handled?
│
└── OUTPUT: Calculation Score (0-100)
    └── Formula issues with line references
```

### Phase 3: Pricing Logic Validation

```
PRICING CHECKS:
│
├── 3.1 RATE CARD ACCURACY
│   ├── Base rates correct?
│   ├── Rate card source verified?
│   ├── Effective dates checked?
│   └── Currency correct?
│
├── 3.2 DISCOUNT LOGIC
│   ├── Discount tiers calculated correctly?
│   ├── Volume breaks at right thresholds?
│   ├── Discount stacking order correct?
│   └── Maximum discount limits respected?
│
├── 3.3 TAX CALCULATIONS
│   ├── VAT rate correct (currently 15% ZA)?
│   ├── Tax applied to correct items?
│   ├── Tax-exempt items excluded?
│   └── Rounding correct?
│
├── 3.4 TOTAL VERIFICATION
│   ├── Subtotal = Sum of line items?
│   ├── Discount amount calculated correctly?
│   ├── Tax = (Subtotal - Discount) × Tax Rate?
│   └── Grand Total = Subtotal - Discount + Tax?
│
└── OUTPUT: Pricing Score (0-100)
    └── Pricing discrepancies list
```

### Phase 4: Boundary Testing

```
STRESS TESTS:
│
├── 4.1 ZERO VALUES
│   ├── What happens with quantity = 0?
│   ├── Division by zero handled?
│   ├── Zero price scenarios?
│   └── Empty input cells?
│
├── 4.2 MINIMUM VALUES
│   ├── Minimum quantities respected?
│   ├── Minimum charges applied?
│   ├── Minimum order values?
│   └── Negative value prevention?
│
├── 4.3 MAXIMUM VALUES
│   ├── Large quantity handling?
│   ├── Overflow prevention?
│   ├── Maximum discount caps?
│   └── Display formatting for large numbers?
│
├── 4.4 EDGE CASES
│   ├── Tier boundary values (exactly 100, 1000)?
│   ├── Date boundary (month-end, year-end)?
│   ├── Currency rounding at boundaries?
│   └── Percentage at 100%?
│
└── OUTPUT: Boundary Score (0-100)
    └── Failed edge cases list
```

### Phase 5: Consistency Verification

```
CONSISTENCY CHECKS:
│
├── 5.1 CROSS-SHEET CONSISTENCY
│   ├── Same item priced same across sheets?
│   ├── Input values consistent throughout?
│   ├── Subtotals match between sheets?
│   └── Formatting consistent?
│
├── 5.2 UNIT CONSISTENCY
│   ├── All amounts in same currency?
│   ├── Percentages expressed consistently?
│   ├── Date formats consistent?
│   └── Decimal places consistent?
│
├── 5.3 TERMINOLOGY CONSISTENCY
│   ├── Same names used throughout?
│   ├── Abbreviations consistent?
│   ├── Category names match?
│   └── Column headers consistent?
│
├── 5.4 HISTORICAL CONSISTENCY
│   ├── Compare to previous quotes?
│   ├── Significant variance explained?
│   ├── Rate changes documented?
│   └── Volume assumptions consistent?
│
└── OUTPUT: Consistency Score (0-100)
    └── Inconsistencies list
```

---

## Validation Report Format

```markdown
# Quotation Model Validation Report

## Summary
| Category | Score | Status |
|----------|-------|--------|
| Structure | 85/100 | ⚠️ Minor issues |
| Calculations | 95/100 | ✅ Pass |
| Pricing Logic | 100/100 | ✅ Pass |
| Boundary Tests | 78/100 | ⚠️ Issues found |
| Consistency | 90/100 | ✅ Pass |
| **OVERALL** | **89/100** | **⚠️ Conditional Pass** |

## Critical Issues (Must Fix)
1. [Issue description] - [Location] - [Recommended fix]

## High Priority Issues (Should Fix)
1. [Issue description] - [Location] - [Recommended fix]

## Medium Priority Issues (Recommended)
1. [Issue description] - [Location] - [Recommended fix]

## Low Priority Issues (Consider)
1. [Issue description] - [Location] - [Recommended fix]

## Test Cases Executed
| Test | Input | Expected | Actual | Status |
|------|-------|----------|--------|--------|
| [Name] | [Values] | [Result] | [Result] | ✅/❌ |

## Recommendations
1. [Recommendation]

## Sign-off
- Validated by: [Name]
- Date: [Date]
- Version: [Model version]
```

---

## Common Issues Checklist

### Formula Issues
- [ ] Hardcoded numbers in formulas
- [ ] Inconsistent formula across row/column
- [ ] Missing error handling
- [ ] Circular references
- [ ] Broken references (#REF!)
- [ ] Incorrect absolute/relative references

### Calculation Issues
- [ ] Incorrect operator precedence
- [ ] Rounding errors
- [ ] Double-counting
- [ ] Missing items in totals
- [ ] Wrong lookup results
- [ ] Boundary condition failures

### Design Issues
- [ ] Inputs mixed with calculations
- [ ] No data validation
- [ ] Missing documentation
- [ ] Inconsistent formatting
- [ ] No version control
- [ ] No audit trail

### Pricing Issues
- [ ] Outdated rates
- [ ] Wrong discount tier
- [ ] Tax calculation error
- [ ] Currency mismatch
- [ ] Minimum charge ignored
- [ ] Maximum discount exceeded

---

## Quick Validation Commands

```
EXCEL KEYBOARD SHORTCUTS FOR AUDITING:
│
├── Show formulas: Ctrl + `
├── Trace precedents: Ctrl + [
├── Trace dependents: Ctrl + ]
├── Go to special (errors): Ctrl + G, Special, Errors
├── Find all formulas: Ctrl + G, Special, Formulas
├── Evaluate formula: Alt + M, V
└── Error checking: Alt + M, K
```

---

## Integration

| Component | Integration |
|-----------|-------------|
| SK-024 | Excel expertise for formula analysis |
| SK-025 | Model design standards reference |
| PR-022 | Full audit protocol |
| LAR-009 | Data analysis capabilities |

---

*LAR-032 | Quotation Validation v1.0 | Model Accuracy Assurance*
