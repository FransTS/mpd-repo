# Frans Skill: Prompt Engineering

## Metadata

| Field | Value |
|-------|-------|
| **Name** | prompt-engineering |
| **Version** | 1.0 |
| **ID** | LAR-003 |
| **Triggers** | "create prompt", "system prompt", "optimise prompt" |
| **Google Doc Name** | `SKILL_PromptEngineering` |

---

## Purpose

Design reliable, efficient, and safe prompts for production use across multiple LLM platforms.

---

## Core Patterns

| Pattern | Description | Use Case |
|---------|-------------|----------|
| **Role Assignment** | Define expertise and perspective | "You are an expert financial analyst..." |
| **Task Framing** | Clear, specific objective | "Analyse the following data and..." |
| **Context Setting** | Provide background information | "Given that the company operates in..." |
| **Output Specification** | Define format and structure | "Return your response as JSON with..." |
| **Example Provision** | Few-shot demonstrations | "Here is an example: Input: X, Output: Y" |

---

## Advanced Patterns

| Pattern | Description | When to Use |
|---------|-------------|-------------|
| **Chain-of-Thought** | Step-by-step reasoning | Complex reasoning tasks |
| **Self-Consistency** | Multiple reasoning paths | High-stakes decisions |
| **Reflection** | Self-check before answering | Accuracy-critical outputs |
| **Decomposition** | Break into sub-tasks | Multi-step problems |
| **Guardrails** | Safety constraints | Production deployments |

---

## Prompt Structure Template

```markdown
## 1. SYSTEM CONTEXT / ROLE
[Define who/what the AI should act as]
[Establish expertise level and perspective]

## 2. CORE INSTRUCTIONS
[Primary task description]
[Specific requirements]
[Key objectives]

## 3. CONSTRAINTS / RULES
+rule=requirement
-rule=prohibition
[Behavioural boundaries]

## 4. OUTPUT FORMAT
[Structure specification]
[Format requirements]
[Length guidelines]

## 5. EXAMPLES (if needed)
[Input example 1] â†’ [Output example 1]
[Input example 2] â†’ [Output example 2]

## 6. SAFETY GUARDRAILS
[Content restrictions]
[Fallback behaviours]
[Escalation triggers]
```

---

## XML Prompt Format (Frans Standard)

```xml
<persona id="XXX" v="1.0">
  <n>Persona Name</n>
  <activate>Activation Phrase</activate>
  <fallback>Fallback Persona</fallback>
  <role>Role description with expertise areas</role>
  <mission>Primary objective and purpose</mission>
  <rules>+requirement|-prohibition|setting=value</rules>
  <skills auto="skill1,skill2" demand="skill3,skill4"/>
</persona>
```

### Element Reference

| Element | Purpose | Required |
|---------|---------|----------|
| `id` | Unique identifier | Yes |
| `v` | Version number | Yes |
| `<n>` | Short name | Yes |
| `<activate>` | Trigger phrase | Yes |
| `<fallback>` | Backup persona | No |
| `<role>` | Role description | Yes |
| `<mission>` | Mission statement | Yes |
| `<rules>` | Constraints | Yes |
| `<skills>` | Skill references | No |

---

## Safety Checklist

### Prompt Injection Resistance
```
â˜ Input sanitisation considered
â˜ Clear instruction boundaries
â˜ System/user message separation
â˜ No dynamic code execution
```

### Output Safety
```
â˜ Content filtering defined
â˜ PII handling specified
â˜ Harmful content restrictions
â˜ Citation requirements (if applicable)
```

### Boundary Enforcement
```
â˜ Scope limits defined
â˜ Topic restrictions clear
â˜ Capability boundaries set
â˜ Authority levels specified
```

### Failure Handling
```
â˜ Graceful degradation
â˜ Error message format
â˜ Escalation triggers
â˜ Fallback behaviour
```

---

## Optimisation Techniques

### Token Efficiency
- Use abbreviations in XML (e.g., `<n>` not `<name>`)
- Compress repeated patterns
- Remove redundant instructions
- Use shorthand syntax for rules

### Clarity
- One instruction per line
- Active voice
- Specific over general
- Concrete examples

### Reliability
- Test edge cases
- Include failure modes
- Define ambiguous terms
- Specify defaults

---

## Testing Framework

### Test Categories

| Category | Description | Priority |
|----------|-------------|----------|
| **Happy Path** | Expected inputs | High |
| **Edge Cases** | Boundary conditions | High |
| **Adversarial** | Injection attempts | High |
| **Ambiguous** | Unclear inputs | Medium |
| **Volume** | Long/complex inputs | Medium |

### Test Template

```markdown
## Test Case: [Name]

**Input:**
[Test input]

**Expected Output:**
[Expected response characteristics]

**Actual Output:**
[Observed response]

**Result:** âœ… Pass / âŒ Fail

**Notes:**
[Observations]
```

---

## Common Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Vague instructions | Inconsistent outputs | Be specific and concrete |
| No examples | Model guesses format | Provide few-shot examples |
| Missing constraints | Boundary violations | Define explicit limits |
| No error handling | Crashes on edge cases | Specify failure behaviour |
| Conflicting rules | Unpredictable behaviour | Review for consistency |
| Over-engineering | Token waste | Keep it simple |

---

## Platform Considerations

### Claude
- Native XML support
- Strong instruction following
- System prompts respected

### GPT-4
- Add meta explanation for XML
- Function calling for structured output
- Custom GPT for persistence

### Gemini
- May prefer JSON format
- Gems for persona persistence
- Context window awareness

---

## Rules

```
+structure-prompts-clearly    # Organised, logical structure
+include-safety-guardrails    # Always add safety measures
+test-systematically          # Test before deployment
+version-control              # Track prompt versions
+document-changes             # Changelog for iterations
-deploy-untested-prompts      # Never skip testing
-use-vague-instructions       # No ambiguous language
-ignore-edge-cases            # Consider failure modes
```

---

## Prompt Engineering Workflow

```
1. DEFINE
   â”œâ”€â”€ Identify use case
   â”œâ”€â”€ Define success criteria
   â””â”€â”€ Determine constraints

2. DESIGN
   â”œâ”€â”€ Select appropriate patterns
   â”œâ”€â”€ Structure the prompt
   â””â”€â”€ Add safety guardrails

3. TEST
   â”œâ”€â”€ Happy path testing
   â”œâ”€â”€ Edge case testing
   â””â”€â”€ Adversarial testing

4. ITERATE
   â”œâ”€â”€ Analyse failures
   â”œâ”€â”€ Refine instructions
   â””â”€â”€ Re-test

5. DEPLOY
   â”œâ”€â”€ Version the prompt
   â”œâ”€â”€ Document changes
   â””â”€â”€ Monitor performance
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 012 Advanced Prompt Engineer | Primary user - full prompt development |
| 010 The Architect | System-level prompt design |
| 009 Software Architect | Technical integration prompts |

---

*Frans Skill LAR-003 | Prompt Engineering v1.0*
