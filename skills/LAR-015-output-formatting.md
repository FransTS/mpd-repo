# Frans Skill: Output Formatting Standards

## Metadata

| Field | Value |
|-------|-------|
| **Name** | output-formatting |
| **Version** | 1.0 |
| **ID** | LAR-015 |
| **Triggers** | "format as", "output in", formatting requests |
| **Always Active** | YES (standards applied automatically) |
| **Google Doc Name** | `SKILL_OutputFormatting` |

---

## Purpose

Ensure consistent, professional formatting across all outputs with standardised structures for markdown, tables, code blocks, and document sections.

---

## Core Formatting Standards

### Headings Hierarchy

```markdown
# Document Title (H1) - One per document

## Major Section (H2) - Primary divisions

### Subsection (H3) - Secondary divisions

#### Detail Section (H4) - Tertiary (use sparingly)
```

**Rules:**
- Never skip heading levels (H1 â†’ H3)
- Use sentence case for headings
- Keep headings concise (<60 characters)

---

### Tables

#### Standard Table

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
```

#### Table with Alignment

```markdown
| Left Aligned | Center Aligned | Right Aligned |
|:-------------|:--------------:|--------------:|
| Text         | Text           | Numbers       |
| More text    | More text      | 1,234         |
```

**Rules:**
- Always include header row
- Use consistent column widths where possible
- Right-align numbers, left-align text
- Keep tables under 6 columns for readability

---

### Lists

#### Bullet Lists (Unordered)

```markdown
- Item one
- Item two
  - Sub-item (2-space indent)
  - Another sub-item
- Item three
```

#### Numbered Lists (Ordered)

```markdown
1. First step
2. Second step
   - Sub-point under step 2
3. Third step
```

**Rules:**
- Use bullets for non-sequential items
- Use numbers for sequential steps or ranked items
- Maximum 2 levels of nesting
- Keep list items parallel in structure

---

### Code Blocks

#### Inline Code
Use backticks for `short code`, `file names`, `commands`.

#### Fenced Code Blocks

```python
# Always specify language for syntax highlighting
def example():
    return "Hello, World!"
```

**Supported languages:** `python`, `javascript`, `typescript`, `bash`, `sql`, `xml`, `json`, `markdown`, `yaml`, `html`, `css`

#### Code with Line Numbers (when relevant)

```python
# Line 1: Import
import os

# Line 4: Main function
def main():
    pass
```

**Rules:**
- Always specify language identifier
- Include comments for complex code
- Keep code blocks under 50 lines (split if longer)
- Use consistent indentation (2 or 4 spaces)

---

### Callouts and Highlights

#### Information Box

```markdown
> **Note:** Important information the user should be aware of.
```

#### Warning Box

```markdown
> âš ï¸ **Warning:** Potential issue or caution.
```

#### Critical Alert

```markdown
> ðŸ”´ **Critical:** Immediate attention required.
```

#### Tip

```markdown
> ðŸ’¡ **Tip:** Helpful suggestion or best practice.
```

---

### Status Indicators

| Icon | Meaning | Use |
|------|---------|-----|
| âœ… | Complete/Pass | Task done, check passed |
| âŒ | Failed/No | Check failed, not recommended |
| ðŸŸ¢ | On Track/Good | Status indicator |
| ðŸŸ¡ | At Risk/Warning | Needs attention |
| ðŸ”´ | Critical/Blocked | Immediate action needed |
| â³ | Pending/In Progress | Work ongoing |
| âš ï¸ | Caution | Warning message |
| ðŸ’¡ | Tip/Idea | Suggestion |
| ðŸ“ | Note | Information |

---

### Links and References

#### Inline Links

```markdown
See the [documentation](url) for details.
```

#### Reference Links

```markdown
See the [documentation][docs] for details.

[docs]: url "Optional title"
```

#### Internal References

```markdown
See [Section Name](#section-name) above.
```

---

## Document Templates

### Standard Report

```markdown
# [Report Title]

**Date:** [DD Month YYYY]
**Author:** [Name]
**Version:** [X.X]

---

## Executive Summary

[2-3 paragraphs summarising key points]

---

## [Section 1]

[Content]

### [Subsection 1.1]

[Content]

---

## [Section 2]

[Content]

---

## Conclusions

[Key takeaways]

## Recommendations

1. [Recommendation 1]
2. [Recommendation 2]

---

*[Footer/Attribution]*
```

### Status Update

```markdown
## Status Update: [Topic]

**Date:** [DD Month YYYY]
**Status:** ðŸŸ¢ On Track | ðŸŸ¡ At Risk | ðŸ”´ Blocked

### Summary
[Brief overview]

### Completed
- [Item 1]
- [Item 2]

### In Progress
- [Item 1] - [Progress %]

### Blocked/Issues
- [Issue] - [Action needed]

### Next Steps
1. [Next action]
```

---

## Output Length Guidelines

| Output Type | Target Length | Max Length |
|-------------|---------------|------------|
| Quick answer | 1-3 sentences | 100 words |
| Explanation | 2-4 paragraphs | 500 words |
| Analysis | 1-2 pages | 1000 words |
| Full report | 3-5 pages | 2500 words |
| Code snippet | 10-30 lines | 50 lines |
| Code file | 50-200 lines | Split if larger |

---

## Formatting by Persona

| Persona | Preferred Format |
|---------|------------------|
| 001 Executive Advisor | Executive summary first, bullet points, minimal jargon |
| 002 Executive Assistant | Clear structure, action items highlighted |
| 003 Market Research | Data tables, charts, source citations |
| 004 Sales Enablement | Bullet points, bold key phrases, scannable |
| 005 Document Creator | Full document structure, professional layout |
| 006 Technical Writer | Code blocks, step-by-step, technical accuracy |
| 008 Legal Expert | Numbered clauses, precise language, disclaimers |
| 009 Software Architect | Diagrams, code blocks, architecture notation |
| 011 Endurance Coach | Tables for plans, clear metrics, visual progress |
| 012 Prompt Engineer | XML/code blocks, structured examples |

---

## Stop Hook Integration

```xml
<stop-hook id="HOOK-FMT-001" type="SOFT">
  <trigger>Output exceeds recommended length</trigger>
  <validation>
    <check>Content cannot be condensed</check>
    <check>Length justified by complexity</check>
  </validation>
  <on-pass>Proceed with longer output</on-pass>
  <on-fail>Split into sections or summarise</on-fail>
</stop-hook>

<stop-hook id="HOOK-FMT-002" type="SOFT">
  <trigger>Complex data to present</trigger>
  <validation>
    <check>Best format selected (table/list/prose)</check>
    <check>Readable on target platform</check>
  </validation>
  <on-pass>Apply selected format</on-pass>
  <on-fail>Simplify or split data</on-fail>
</stop-hook>
```

---

## Anti-Patterns

| Don't | Do Instead |
|-------|------------|
| Wall of text | Break into paragraphs with headings |
| Deep nesting (>2 levels) | Flatten structure or use separate sections |
| Inconsistent formatting | Apply standards consistently |
| Missing language in code blocks | Always specify language |
| Overuse of bold/italic | Use sparingly for emphasis |
| Tables with >6 columns | Split or transpose |
| Mixing bullet and number styles | Be consistent within sections |

---

## Rules

```
+use-consistent-heading-hierarchy    # Never skip levels
+specify-code-block-languages        # Always include language
+right-align-numbers-in-tables       # Standard table formatting
+keep-paragraphs-focused             # One idea per paragraph
+use-status-indicators               # Visual status communication
-create-walls-of-text                # Break up content
-nest-lists-deeply                   # Max 2 levels
-use-inconsistent-formatting         # Apply standards uniformly
-exceed-length-without-justification # Respect length guidelines
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| **ALL** | Standards apply to all output |
| 005 Document Creator | Primary formatting expertise |
| 006 Technical Writer | Technical documentation formatting |

---

*Frans Skill LAR-015 | Output Formatting Standards v1.0 | Always Active*
