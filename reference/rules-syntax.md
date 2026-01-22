# Rules Syntax Guide

**Version:** 4.7
**Purpose:** Reference for Frans prompt rule syntax

---

## Basic Syntax

| Syntax | Meaning | Example |
|--------|---------|---------|
| `+rule` | Requirement (must do) | `+code=complete,tested` |
| `-rule` | Prohibition (must not) | `-placeholders` |
| `key=value` | Attribute setting | `tone=professional` |
| `a,b,c` | Multiple values (AND) | `format=md,mermaid` |
| `\|` | Rule separator | `+tone=exec\|-vague` |

---

## Detailed Syntax Reference

### Requirements (`+rule`)

Requirements indicate mandatory behaviors or outputs.

```
+tone=executive           # Must use executive tone
+format=structured        # Must use structured format
+sources=cited            # Must cite all sources
+code=complete,tested     # Code must be complete AND tested
+analysis=data-driven     # Analysis must be data-driven
```

### Prohibitions (`-rule`)

Prohibitions indicate what must NOT be done.

```
-placeholders             # Never use placeholder content
-speculation=unfounded    # No unfounded speculation
-jargon=unexplained       # No unexplained jargon
-errors=none              # Zero tolerance for errors
-overtraining=prevent     # Prevent overtraining
```

### Attributes (`key=value`)

Attributes set specific values or modes.

```
tone=professional         # Set tone to professional
format=md                 # Set format to markdown
language=british-english  # Set language variant
currency=ZAR              # Set currency
```

### Multiple Values (`a,b,c`)

Comma-separated values indicate AND relationship (all apply).

```
+tone=professional,warm   # Both professional AND warm
+format=md,mermaid        # Support both formats
+code=complete,tested     # Must be complete AND tested
+assume=metric,british    # Assume both conventions
```

### Rule Chains (`|`)

Pipe separator chains multiple rules in one line.

```
+tone=executive|+analysis=data-driven|-vague-timelines
```

Expands to:
- `+tone=executive`
- `+analysis=data-driven`
- `-vague-timelines`

---

## Common Rule Patterns

### Tone Rules
```
+tone=executive           # C-suite level
+tone=professional        # Business professional
+tone=professional,warm   # Professional but personable
+tone=persuasive          # Sales/marketing focused
+tone=technical           # Technical precision
```

### Quality Rules
```
+accuracy=verified        # All facts verified
+sources=cited            # Sources always cited
-errors=none              # Zero errors
-fabrications             # No made-up content
+completeness=full        # All elements addressed
```

### Format Rules
```
+format=structured        # Use clear structure
+format=md                # Markdown format
+format=xml-optimized     # Optimized XML
+structure=logical        # Logical organization
```

### Code Rules
```
+code=complete            # Full implementations only
+code=complete,tested     # Complete and testable
-placeholders=never       # No placeholder code
+patterns=appropriate     # Use appropriate patterns
+security=considered      # Security in design
```

### Behavior Rules
```
+proactive=anticipate     # Anticipate needs
+proceed=assumption       # Proceed with assumptions
+priorities=urgent-first  # Triage by urgency
-overengineering          # Avoid unnecessary complexity
```

---

## XML Persona Structure

```xml
<persona id="XXX" v="4.7">
  <n>Persona Name</n>
  <activate>Activation Phrase</activate>
  <fallback>Fallback Persona</fallback>
  <role>Role description</role>
  <mission>Mission statement</mission>
  <rules>+rule1|+rule2|-prohibition|key=value</rules>
  <skills auto="skill1,skill2" demand="skill3,skill4"/>
</persona>
```

### Element Reference

| Element | Purpose | Required |
|---------|---------|----------|
| `id` | Unique identifier | Yes |
| `v` | Version number | Yes |
| `<n>` | Short name | Yes |
| `<activate>` | Activation phrase | Yes |
| `<fallback>` | Fallback persona | No |
| `<role>` | Role description | Yes |
| `<mission>` | Mission statement | Yes |
| `<rules>` | Rule definitions | Yes |
| `<skills>` | Skill references | No |

### Skills Attributes

| Attribute | Purpose |
|-----------|---------|
| `auto` | Skills loaded automatically |
| `demand` | Skills loaded on request |

---

## Best Practices

### Do
- Keep rules concise
- Use consistent syntax
- Group related rules
- Version your personas
- Test rule combinations

### Don't
- Mix syntax styles
- Create conflicting rules
- Over-specify behaviors
- Forget fallbacks
- Leave rules ambiguous

---

## Example Persona Rules

### Executive Advisor
```
+tone=executive|+analysis=data-driven|-vague-timelines|+frameworks=proven
```

### Technical Writer
```
+clarity=paramount|+accuracy=verified|+audience=calibrated|-jargon=unexplained
```

### Sales Enablement
```
+focus=revenue|+tone=persuasive,professional|+metrics=quantified|-fluff=eliminate
```

### Software Architect
```
+code=complete,tested|+patterns=appropriate|+security=considered|-placeholders=never
```

---

*Rules Syntax Guide | Frans Master Prompts v4.7*
