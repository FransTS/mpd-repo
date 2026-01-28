# SK-025: Financial Model Design

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | SK-025 |
| **Name** | Financial Model Design |
| **Version** | 1.0 |
| **Created** | 28 January 2026 |
| **Domain** | Financial Modelling |
| **Primary Persona** | 021 Financial Modelling Expert |

---

## Purpose

Best practices for designing professional, auditable, scalable financial models including quotation systems, pricing models, forecasts, and business cases.

---

## Model Architecture Framework

### Three-Layer Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                    │
│  Dashboards • Executive Summaries • Reports • Charts    │
├─────────────────────────────────────────────────────────┤
│                    CALCULATION LAYER                     │
│  Core Logic • Formulas • Scenarios • Sensitivities      │
├─────────────────────────────────────────────────────────┤
│                       INPUT LAYER                        │
│  Assumptions • Parameters • Data • Controls             │
└─────────────────────────────────────────────────────────┘
```

### Recommended Sheet Structure

```
WORKBOOK STRUCTURE:
│
├── 00_Cover          # Title, version, date, owner
├── 01_Contents       # Navigation, sheet index
├── 02_Instructions   # User guide
├── 03_Inputs         # All assumptions and inputs
├── 04_Data           # Raw data (often hidden)
├── 05_Calculations   # Core calculation engine
├── 06_Scenarios      # Scenario manager / sensitivity
├── 07_Summary        # Key outputs, KPIs
├── 08_Dashboard      # Visual executive view
├── 09_Reports        # Print-ready outputs
├── 10_Audit          # Check totals, error flags
└── 99_Changelog      # Version history
```

---

## Input Layer Design

### Input Section Standards

```
INPUT SHEET LAYOUT:
│
├── HEADER SECTION
│   ├── Model name and version
│   ├── Last updated date
│   └── Input owner/source
│
├── GROUPED INPUTS
│   ├── General Parameters
│   │   ├── Model start date
│   │   ├── Currency
│   │   ├── Inflation rate
│   │   └── Tax rate
│   │
│   ├── Revenue Assumptions
│   │   ├── Unit price
│   │   ├── Volume growth
│   │   └── Market share
│   │
│   ├── Cost Assumptions
│   │   ├── Fixed costs
│   │   ├── Variable costs
│   │   └── Cost escalation
│   │
│   └── Scenario Controls
│       ├── Scenario selector
│       └── Sensitivity variables
│
└── VALIDATION
    ├── Data validation on all inputs
    ├── Range checks (min/max)
    └── Error indicators
```

### Input Cell Standards

| Requirement | Implementation |
|-------------|----------------|
| Visual identity | Light blue background (#DCE6F1) |
| Data validation | Applied to all input cells |
| Documentation | Comment or adjacent description |
| Units | Clearly labelled (%, R, units, etc.) |
| Default values | Sensible defaults provided |
| Source reference | Where did this number come from? |

---

## Calculation Layer Design

### Formula Standards

```
GOLDEN RULES:
│
├── 1. NO HARDCODED NUMBERS
│   ├── Bad:  =A2*0.15
│   └── Good: =A2*$C$5 (where C5 is labelled "Tax Rate")
│
├── 2. ONE FORMULA PER ROW/COLUMN
│   ├── Bad:  Different formulas in same column
│   └── Good: Same formula copied down entire column
│
├── 3. CONSISTENT FLOW DIRECTION
│   ├── Time flows LEFT → RIGHT
│   └── Calculations flow TOP → BOTTOM
│
├── 4. ERROR HANDLING
│   ├── Wrap risky formulas in IFERROR
│   └── Check for #DIV/0!, #N/A, #REF!
│
├── 5. NAMED RANGES FOR KEY VALUES
│   ├── Use: =Revenue*TaxRate
│   └── Not: =B15*$C$5
│
└── 6. HELPER COLUMNS
    ├── Break complex calculations into steps
    └── Makes auditing and debugging easier
```

### Calculation Documentation

```
EVERY CALCULATION SHOULD HAVE:
│
├── Row/Column header describing what it calculates
├── Units clearly indicated
├── Formula logic documented (comment or adjacent cell)
├── Source reference if based on external data
└── Validation check (does total match expected?)
```

---

## Output Layer Design

### Summary Sheet Standards

```
SUMMARY LAYOUT:
│
├── KEY METRICS (Top of page)
│   ├── Total Revenue
│   ├── Total Cost
│   ├── Gross Margin
│   ├── Net Profit
│   ├── ROI / IRR / NPV
│   └── Payback Period
│
├── PERIOD SUMMARY TABLE
│   ├── Monthly/Quarterly/Annual breakdown
│   ├── Variance to budget/forecast
│   └── Growth rates
│
├── SCENARIO COMPARISON
│   ├── Base case
│   ├── Best case
│   ├── Worst case
│   └── Key drivers
│
└── CHARTS
    ├── Revenue trend
    ├── Cost breakdown
    ├── Profit waterfall
    └── Sensitivity tornado
```

---

## Dashboard Design Standards

### Visual Hierarchy

```
DASHBOARD STRUCTURE:
│
├── TOP: Executive Summary (KPIs at a glance)
│   ├── 3-5 key metrics in prominent cards
│   ├── Status indicators (on track / at risk)
│   └── Period selector
│
├── MIDDLE: Trend Analysis
│   ├── Line/area charts for time series
│   ├── Clear axis labels and legends
│   └── Comparison lines (budget, prior year)
│
├── BOTTOM: Detail Breakdown
│   ├── Tables for drill-down
│   ├── Pie/bar charts for composition
│   └── Variance analysis
│
└── FOOTER: Metadata
    ├── Last updated timestamp
    ├── Data source
    └── Contact for questions
```

### Chart Selection Guide

| Data Type | Recommended Chart |
|-----------|-------------------|
| Trend over time | Line chart or area chart |
| Composition (parts of whole) | Pie chart (≤6 items) or stacked bar |
| Comparison | Bar chart (horizontal for many items) |
| Correlation | Scatter plot |
| Distribution | Histogram |
| Change breakdown | Waterfall chart |
| KPI vs target | Gauge or bullet chart |
| Inline trend | Sparkline |

### Colour Palette (Professional)

```
PRIMARY PALETTE:
├── Dark Blue (headers):     #366092
├── Medium Blue (accents):   #4F81BD
├── Light Blue (inputs):     #DCE6F1
├── Dark Grey (text):        #333333
└── Light Grey (borders):    #D9D9D9

SEMANTIC COLOURS:
├── Positive/Good:           #00B050 (Green)
├── Negative/Bad:            #FF0000 (Red)
├── Warning/Caution:         #FFC000 (Amber)
├── Neutral:                 #808080 (Grey)
└── Input highlight:         #FFFF00 (Yellow) - sparingly
```

---

## Quotation Model Design

### Quotation Model Structure

```
QUOTATION MODEL LAYERS:
│
├── 1. INPUT LAYER
│   ├── Client information
│   ├── Project scope parameters
│   ├── Volume/quantity inputs
│   ├── Duration/timeline
│   └── Special requirements flags
│
├── 2. RATE CARD / PRICING MASTER
│   ├── Base rates by category
│   ├── Volume discounts (tiered)
│   ├── Duration discounts
│   ├── Premium/surcharge factors
│   └── Currency conversion
│
├── 3. CALCULATION ENGINE
│   ├── Line item calculations
│   ├── Subtotals by category
│   ├── Discount applications
│   ├── Tax calculations
│   └── Grand totals
│
├── 4. MARGIN ANALYSIS (Internal)
│   ├── Cost buildup
│   ├── Margin by line item
│   ├── Blended margin
│   └── Profitability flags
│
└── 5. OUTPUT LAYER
    ├── Client-facing quote
    ├── Internal approval summary
    ├── Comparison to standard pricing
    └── Terms and conditions reference
```

### Pricing Logic Patterns

```excel
# TIERED PRICING (Volume discounts)
=XLOOKUP(Quantity, TierBreaks, TierPrices, , -1) * Quantity

# Or with SUMPRODUCT for marginal tiers:
=SUMPRODUCT(
  (Quantity>TierStart)*(MIN(Quantity,TierEnd)-TierStart)*TierRate
)

# PERCENTAGE DISCOUNT APPLICATION
=BasePrice * (1 - DiscountPercent)

# MULTIPLE DISCOUNT STACKING
=BasePrice * (1-Discount1) * (1-Discount2) * (1-Discount3)

# CONDITIONAL PRICING
=IF(Duration>=12, AnnualRate, IF(Duration>=6, HalfYearRate, MonthlyRate))

# MINIMUM CHARGE
=MAX(CalculatedAmount, MinimumCharge)

# ROUNDING (To nearest 100)
=CEILING(Amount, 100)
```

---

## Version Control Standards

### Version Numbering

```
VERSION FORMAT: vX.Y.Z

X = Major version (structural changes)
Y = Minor version (formula changes, new features)
Z = Patch version (fixes, formatting)

EXAMPLES:
├── v1.0.0 - Initial release
├── v1.1.0 - Added scenario analysis
├── v1.1.1 - Fixed discount calculation
├── v2.0.0 - Complete restructure
└── v2.1.0 - Added dashboard
```

### Changelog Format

```markdown
## Changelog

### v1.1.1 (28 Jan 2026)
- Fixed: Discount calculation for volumes >1000
- Changed: Updated tax rate to 28%

### v1.1.0 (25 Jan 2026)
- Added: Scenario comparison table
- Added: Sensitivity analysis
- Changed: Improved dashboard layout

### v1.0.0 (20 Jan 2026)
- Initial release
```

---

## Error Prevention

### Built-in Checks

```
VALIDATION CHECKS TO INCLUDE:
│
├── TOTALS CHECK
│   └── =IF(SUM(Details)=Total, "✓", "ERROR")
│
├── BALANCE CHECK
│   └── =IF(Assets=Liabilities+Equity, "✓", "ERROR")
│
├── SIGN CHECK
│   └── =IF(AND(Revenue>0, Cost<0), "✓", "Check signs")
│
├── CIRCULAR REFERENCE CHECK
│   └── Use Formulas > Error Checking
│
├── INPUT RANGE CHECK
│   └── =IF(AND(Input>=Min, Input<=Max), "✓", "Out of range")
│
└── DATE LOGIC CHECK
    └── =IF(EndDate>StartDate, "✓", "Date error")
```

### Audit Trail Sheet

```
AUDIT SHEET CONTENTS:
│
├── Check totals across all sheets
├── Error flag summary
├── Input range violations
├── Formula consistency check
├── Last modified timestamp
├── User who made changes
└── Sign-off checkboxes
```

---

## Professional Formatting Rules

```
FORMATTING STANDARDS:
│
├── FONTS
│   ├── Body: Calibri 11pt or Arial 10pt
│   ├── Headers: Bold, 1-2pt larger
│   └── Consistent throughout
│
├── NUMBER FORMATS
│   ├── Currency: R #,##0 or R #,##0.00
│   ├── Percentage: 0.0% or 0.00%
│   ├── Large numbers: #,##0 or #,##0.0,"K"
│   └── Dates: DD-MMM-YYYY or YYYY-MM-DD
│
├── ALIGNMENT
│   ├── Text: Left-aligned
│   ├── Numbers: Right-aligned
│   ├── Headers: Centre-aligned
│   └── Consistent column widths
│
├── BORDERS
│   ├── Light borders for data cells
│   ├── Heavy borders for section breaks
│   └── No excessive gridlines
│
└── PRINT SETUP
    ├── Repeat headers on each page
    ├── Fit to page width
    ├── Include page numbers
    └── Header with model name/date
```

---

*SK-025 | Financial Model Design v1.0 | Professional Model Architecture*
