# SK-024: Excel Mastery

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | SK-024 |
| **Name** | Excel Mastery |
| **Version** | 1.0 |
| **Created** | 28 January 2026 |
| **Domain** | Microsoft Excel |
| **Primary Persona** | 021 Financial Modelling Expert |

---

## Purpose

Comprehensive Microsoft Excel expertise covering advanced formulas, data manipulation, Power Query, Power Pivot, VBA basics, and professional spreadsheet design.

---

## Formula Reference

### Lookup & Reference
```excel
# XLOOKUP (Modern - preferred)
=XLOOKUP(lookup_value, lookup_array, return_array, [if_not_found], [match_mode], [search_mode])
# Example: =XLOOKUP(A2, Products[ID], Products[Price], 0)

# INDEX/MATCH (Universal - always works)
=INDEX(return_range, MATCH(lookup_value, lookup_range, 0))
# Example: =INDEX(B:B, MATCH(A2, A:A, 0))

# FILTER (Dynamic array)
=FILTER(array, include, [if_empty])
# Example: =FILTER(A2:D100, B2:B100="Active", "No results")

# UNIQUE
=UNIQUE(array, [by_col], [exactly_once])
# Example: =UNIQUE(A2:A100)
```

### Logic Functions
```excel
# IFS (Multiple conditions - cleaner than nested IF)
=IFS(condition1, value1, condition2, value2, TRUE, default)
# Example: =IFS(A2>=90,"A", A2>=80,"B", A2>=70,"C", TRUE,"F")

# SWITCH (Value matching)
=SWITCH(expression, value1, result1, ..., [default])
# Example: =SWITCH(A2, "Q1","Jan-Mar", "Q2","Apr-Jun", "Other")

# LET (Named variables - cleaner formulas)
=LET(name1, value1, name2, value2, calculation)
# Example: =LET(x, A2*0.1, y, B2*0.2, x+y)

# LAMBDA (Custom functions)
=LAMBDA(parameter, formula_expression)
# Example: Define PROFIT as =LAMBDA(revenue,cost, revenue-cost)
```

### Aggregation Functions
```excel
# SUMPRODUCT (Conditional sum with multiple criteria)
=SUMPRODUCT((range1=criteria1)*(range2=criteria2)*values)
# Example: =SUMPRODUCT((A2:A100="Sales")*(B2:B100="Q1")*C2:C100)

# SUMIFS (Multiple criteria)
=SUMIFS(sum_range, criteria_range1, criteria1, ...)
# Example: =SUMIFS(D:D, A:A, "Sales", B:B, ">=2024-01-01")

# AVERAGEIFS / COUNTIFS / MAXIFS / MINIFS
# Same syntax pattern as SUMIFS
```

### Financial Functions
```excel
# NPV (Net Present Value)
=NPV(rate, value1, value2, ...) + initial_investment
# Example: =NPV(0.1, B2:B10) + A1

# IRR / XIRR (Internal Rate of Return)
=IRR(values, [guess])
=XIRR(values, dates, [guess])

# PMT (Payment calculation)
=PMT(rate, nper, pv, [fv], [type])
# Example: =PMT(0.05/12, 60, -25000) → Monthly payment

# FV / PV (Future/Present Value)
=FV(rate, nper, pmt, [pv], [type])
=PV(rate, nper, pmt, [fv], [type])
```

### Date Functions
```excel
# EOMONTH (End of month)
=EOMONTH(start_date, months)
# Example: =EOMONTH(A2, 0) → Last day of A2's month

# NETWORKDAYS / WORKDAY (Business days)
=NETWORKDAYS(start_date, end_date, [holidays])
=WORKDAY(start_date, days, [holidays])

# DATE manipulation
=YEAR(date), =MONTH(date), =DAY(date)
=DATE(year, month, day)
```

### Text Functions
```excel
# TEXTJOIN (Concatenate with delimiter)
=TEXTJOIN(delimiter, ignore_empty, text1, text2, ...)
# Example: =TEXTJOIN(", ", TRUE, A2:A10)

# SUBSTITUTE (Replace text)
=SUBSTITUTE(text, old_text, new_text, [instance_num])

# LEFT/MID/RIGHT
=LEFT(text, num_chars)
=MID(text, start_num, num_chars)
=RIGHT(text, num_chars)
```

### Array Formulas (Dynamic)
```excel
# SEQUENCE (Generate number sequence)
=SEQUENCE(rows, [columns], [start], [step])
# Example: =SEQUENCE(12, 1, 1, 1) → 1 to 12

# SORT / SORTBY
=SORT(array, [sort_index], [sort_order], [by_col])
=SORTBY(array, by_array1, [sort_order1], ...)

# CHOOSECOLS / CHOOSEROWS (Select specific columns/rows)
=CHOOSECOLS(array, col_num1, col_num2, ...)
```

---

## Power Query Essentials

### Common Transformations
```powerquery
// Remove columns
= Table.RemoveColumns(Source, {"Column1", "Column2"})

// Filter rows
= Table.SelectRows(Source, each [Status] = "Active")

// Add calculated column
= Table.AddColumn(Source, "Profit", each [Revenue] - [Cost])

// Change type
= Table.TransformColumnTypes(Source, {{"Date", type date}})

// Merge tables (JOIN)
= Table.NestedJoin(Table1, "Key", Table2, "Key", "Merged", JoinKind.LeftOuter)

// Unpivot columns
= Table.UnpivotOtherColumns(Source, {"ID", "Name"}, "Attribute", "Value")

// Group by
= Table.Group(Source, {"Category"}, {{"Total", each List.Sum([Amount])}})
```

### Connection Types
```
├── Excel files
├── CSV/Text files
├── Databases (SQL Server, Access, etc.)
├── Web pages
├── SharePoint
├── Folder (multiple files)
└── Blank query (custom)
```

---

## Power Pivot / DAX Basics

### Common DAX Measures
```dax
// SUM with filter context
Total Sales = SUM(Sales[Amount])

// CALCULATE (Modify filter context)
Sales YTD = CALCULATE(SUM(Sales[Amount]), DATESYTD(Calendar[Date]))

// RELATED (Get value from related table)
Category Name = RELATED(Categories[Name])

// Time intelligence
Sales LY = CALCULATE(SUM(Sales[Amount]), SAMEPERIODLASTYEAR(Calendar[Date]))
Sales Growth = DIVIDE([Total Sales] - [Sales LY], [Sales LY], 0)

// FILTER
High Value Sales = CALCULATE(SUM(Sales[Amount]), FILTER(Sales, Sales[Amount] > 1000))
```

---

## Data Validation Rules

```
VALIDATION TYPES:
├── Whole number (with min/max)
├── Decimal (with min/max)
├── List (dropdown from range or comma-separated)
├── Date (with start/end bounds)
├── Text length (min/max characters)
├── Custom formula (flexible)
└── Time (with bounds)

CUSTOM FORMULA EXAMPLES:
├── No duplicates: =COUNTIF($A:$A, A1)=1
├── Starts with prefix: =LEFT(A1,3)="PRJ"
├── Valid email: =ISNUMBER(FIND("@", A1))
├── Future date only: =A1>TODAY()
└── Depends on other cell: =A1<B1
```

---

## Conditional Formatting Patterns

```
HIGHLIGHT RULES:
├── Greater/Less than value
├── Between values
├── Equal to specific value
├── Text that contains
├── Dates (today, last 7 days, etc.)
├── Duplicate values
├── Top/Bottom N items
└── Above/Below average

DATA VISUALISATION:
├── Data bars (filled bars showing relative value)
├── Colour scales (gradient from low to high)
├── Icon sets (arrows, traffic lights, stars)
└── Custom formulas for complex rules

FORMULA-BASED EXAMPLES:
├── Highlight row: =$A1="Active"
├── Alternate rows: =MOD(ROW(),2)=0
├── Compare to adjacent: =A1<>B1
└── Highlight if blank: =ISBLANK(A1)
```

---

## Table Best Practices

```
STRUCTURED REFERENCES:
├── [Column] - This row's value in Column
├── [@Column] - Same as [Column] in formulas
├── Table1[Column] - Entire column
├── Table1[[#Headers],[Column]] - Header cell
├── Table1[[#Totals],[Column]] - Total row cell
└── Table1[@] - Entire current row

BENEFITS:
├── Auto-expansion when adding rows/columns
├── Readable formula references
├── Auto-filtering enabled
├── Consistent formatting
├── Named in formulas automatically
└── Works with Power Query easily
```

---

## Keyboard Shortcuts (Essential)

| Action | Shortcut |
|--------|----------|
| Select entire column | Ctrl+Space |
| Select entire row | Shift+Space |
| Insert row/column | Ctrl++ |
| Delete row/column | Ctrl+- |
| Go to Name Box | Ctrl+G or F5 |
| Create table | Ctrl+T |
| Toggle formula view | Ctrl+` |
| Fill down | Ctrl+D |
| Fill right | Ctrl+R |
| Absolute reference ($) | F4 |
| Trace precedents | Ctrl+[ |
| Trace dependents | Ctrl+] |
| Calculate now | F9 |
| Edit cell | F2 |

---

## Error Handling

```excel
# IFERROR (Catch any error)
=IFERROR(formula, value_if_error)
# Example: =IFERROR(A1/B1, 0)

# IFNA (Catch #N/A only)
=IFNA(formula, value_if_na)
# Example: =IFNA(VLOOKUP(...), "Not found")

# ISERROR / ISNA / ISERR (Test for errors)
=IF(ISERROR(formula), alternative, formula)

# Error types:
├── #DIV/0! - Division by zero
├── #N/A - Value not available
├── #NAME? - Unrecognised formula name
├── #REF! - Invalid reference
├── #VALUE! - Wrong value type
├── #NUM! - Invalid number
└── #NULL! - Incorrect range operator
```

---

## Performance Optimisation

```
DO:
├── Use Tables for data ranges
├── Use helper columns for complex calculations
├── Use INDEX/MATCH or XLOOKUP over VLOOKUP
├── Limit volatile functions (INDIRECT, OFFSET, NOW)
├── Use Power Query for large data transformation
├── Close unused workbooks
└── Use manual calculation for large models

AVOID:
├── Entire column references in non-Tables
├── Nested IF statements (use IFS/SWITCH)
├── Array formulas when not needed
├── Excessive conditional formatting
├── Volatile functions in large ranges
└── Cross-workbook links when possible
```

---

*SK-024 | Excel Mastery v1.0 | Comprehensive Excel Expertise*
