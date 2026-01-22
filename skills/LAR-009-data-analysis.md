# Frans Skill: Data Analysis

## Metadata

| Field | Value |
|-------|-------|
| **Name** | data-analysis |
| **Version** | 1.0 |
| **ID** | LAR-009 |
| **Triggers** | "analyse data", "insights from", "summarise spreadsheet" |
| **Google Doc Name** | `SKILL_DataAnalysis` |

---

## Purpose

Analyse CSV/Excel data, generate statistics, identify patterns, and specify visualisations for actionable insights.

---

## Workflow

```
1. DATA INTAKE
   â”œâ”€â”€ Identify data source
   â”œâ”€â”€ Determine format (CSV, Excel, JSON)
   â””â”€â”€ Assess initial data quality

2. DATA PROFILING
   â”œâ”€â”€ Identify data types per column
   â”œâ”€â”€ Measure completeness (null/missing)
   â”œâ”€â”€ Calculate cardinality
   â””â”€â”€ Detect potential issues

3. STATISTICAL ANALYSIS
   â”œâ”€â”€ Descriptive statistics by type
   â”œâ”€â”€ Central tendency (mean, median, mode)
   â”œâ”€â”€ Dispersion (std dev, range, IQR)
   â””â”€â”€ Distribution shape

4. PATTERN IDENTIFICATION
   â”œâ”€â”€ Correlations between variables
   â”œâ”€â”€ Trends over time
   â”œâ”€â”€ Anomalies and outliers
   â””â”€â”€ Clusters and segments

5. INSIGHT GENERATION
   â”œâ”€â”€ Key findings with data support
   â”œâ”€â”€ Business implications
   â””â”€â”€ Actionable recommendations

6. VISUALISATION SPECIFICATION
   â”œâ”€â”€ Recommend appropriate charts
   â”œâ”€â”€ Specify axes and legends
   â””â”€â”€ Note any data transformations needed
```

---

## Chart Selection Guide

| Data Type | Recommended Chart |
|-----------|-------------------|
| **Distribution** | Histogram, Box Plot |
| **Comparison** | Bar Chart, Grouped Bar |
| **Trend** | Line Chart, Area Chart |
| **Composition** | Pie Chart, Stacked Bar |
| **Relationship** | Scatter Plot, Bubble Chart |
| **Geographic** | Map, Choropleth |
| **Ranking** | Horizontal Bar, Lollipop |
| **Part-to-whole** | Treemap, Sunburst |

---

## Output Template

### 1. Data Profile

| Column | Type | Non-Null | Unique | Sample Values |
|--------|------|----------|--------|---------------|
| [name] | [type] | [count/%] | [count] | [examples] |

### 2. Key Statistics

| Metric | Value |
|--------|-------|
| Total Records | [n] |
| Date Range | [start] to [end] |
| Key Metric Mean | [value] |
| Key Metric Median | [value] |

### 3. Key Findings (3-5)

1. **Finding 1:** [Statement with supporting data]
   - Evidence: [specific numbers]
   - Implication: [what this means]

2. **Finding 2:** [Statement with supporting data]
   - Evidence: [specific numbers]
   - Implication: [what this means]

### 4. Patterns & Anomalies

| Type | Description | Data Support |
|------|-------------|--------------|
| Trend | [description] | [evidence] |
| Anomaly | [description] | [evidence] |
| Correlation | [description] | [r-value or observation] |

### 5. Recommendations

1. [Actionable recommendation based on findings]
2. [Actionable recommendation based on findings]

### 6. Suggested Visualisations

| Chart Type | Purpose | Variables |
|------------|---------|-----------|
| [type] | [what it shows] | X: [var], Y: [var] |

---

## Statistical Methods Reference

### Descriptive Statistics
- **Numeric:** Mean, Median, Mode, Std Dev, Min, Max, Quartiles
- **Categorical:** Frequency counts, Mode, Cardinality
- **Temporal:** Range, Gaps, Seasonality indicators

### Correlation Analysis
- Pearson correlation (linear relationships)
- Spearman correlation (monotonic relationships)
- Cross-tabulation (categorical variables)

### Anomaly Detection
- Z-score method (> 3 standard deviations)
- IQR method (< Q1-1.5*IQR or > Q3+1.5*IQR)
- Visual inspection of distributions

---

## Rules

```
+profile-before-analysing        # Always profile data first
+quantify-all-findings           # Support insights with numbers
+cite-specific-data-points       # Reference actual values
+recommend-visualisations        # Always suggest charts
-present-raw-data-without-synthesis  # No data dumps
-make-claims-without-evidence    # Back up all statements
-assume-data-quality             # Always verify
```

---

## Data Quality Checks

Before analysis, verify:

```
â˜ Missing values identified and handled
â˜ Data types correctly interpreted
â˜ Duplicates checked
â˜ Outliers identified
â˜ Date formats consistent
â˜ Categorical values standardised
â˜ Numeric ranges sensible
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 003 Market Research | Market data analysis |
| 011 Endurance Coach | Training/performance data |
| 001 Executive Strategic Advisor | Business metrics analysis |

---

*Frans Skill LAR-009 | Data Analysis v1.0*
