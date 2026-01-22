# QA Protocol & Stop Hooks

## Metadata

| Field | Value |
|-------|-------|
| **Name** | qa-protocol |
| **Version** | 1.0 |
| **ID** | PROT-QA-001 |
| **Status** | Always Available |
| **Purpose** | Quality assurance checkpoints and validation gates |

---

## Purpose

Define mandatory quality checkpoints (stop hooks) that pause execution for validation before proceeding to the next phase. Stop hooks prevent cascading errors and ensure each component meets standards before integration.

---

## Stop Hook Types

| Type | Trigger | Action | Resume Condition |
|------|---------|--------|------------------|
| **HARD STOP** | Critical validation point | Must pause, require explicit approval | User confirms "proceed" or "approved" |
| **SOFT STOP** | Quality checkpoint | Pause, present summary, auto-proceed if clean | No errors detected OR user confirms |
| **GATE** | Phase transition | Validate all phase items complete | All checklist items pass |
| **REVIEW** | Output ready | Present for review before delivery | User accepts or requests changes |

---

## Stop Hook Syntax

### In Skills/Protocols

```xml
<stop-hook id="[unique-id]" type="[HARD|SOFT|GATE|REVIEW]">
  <trigger>[When this hook activates]</trigger>
  <validation>
    <check>[Validation item 1]</check>
    <check>[Validation item 2]</check>
  </validation>
  <on-pass>[Action if all checks pass]</on-pass>
  <on-fail>[Action if any check fails]</on-fail>
</stop-hook>
```

### Quick Reference Format

```
â¸ï¸ STOP HOOK: [Name]
Type: [HARD|SOFT|GATE|REVIEW]
Checks:
â˜ [Check 1]
â˜ [Check 2]
Action: [What happens next]
```

---

## Standard Stop Hooks

### HOOK-001: Pre-Execution Validation

```xml
<stop-hook id="HOOK-001" type="SOFT">
  <trigger>Before starting any significant task</trigger>
  <validation>
    <check>Objective clearly understood</check>
    <check>Required inputs available</check>
    <check>Correct persona selected</check>
    <check>Required skills loaded</check>
  </validation>
  <on-pass>Proceed with execution</on-pass>
  <on-fail>Request clarification on failed items</on-fail>
</stop-hook>
```

### HOOK-002: Mid-Execution Checkpoint

```xml
<stop-hook id="HOOK-002" type="SOFT">
  <trigger>After completing 50% of complex task</trigger>
  <validation>
    <check>On track to meet objective</check>
    <check>No blocking issues encountered</check>
    <check>Quality maintained</check>
  </validation>
  <on-pass>Continue execution</on-pass>
  <on-fail>Pause and report status</on-fail>
</stop-hook>
```

### HOOK-003: Pre-Delivery Review

```xml
<stop-hook id="HOOK-003" type="REVIEW">
  <trigger>Before delivering final output</trigger>
  <validation>
    <check>All requirements addressed</check>
    <check>No placeholder content</check>
    <check>Self-assessment complete</check>
    <check>Confidence level assigned</check>
  </validation>
  <on-pass>Deliver output</on-pass>
  <on-fail>Fix issues before delivery</on-fail>
</stop-hook>
```

### HOOK-004: Phase Gate

```xml
<stop-hook id="HOOK-004" type="GATE">
  <trigger>Before transitioning to next phase</trigger>
  <validation>
    <check>All phase deliverables complete</check>
    <check>No open issues from phase</check>
    <check>Dependencies for next phase ready</check>
  </validation>
  <on-pass>Proceed to next phase</on-pass>
  <on-fail>Complete remaining items first</on-fail>
</stop-hook>
```

### HOOK-005: Critical Action Confirmation

```xml
<stop-hook id="HOOK-005" type="HARD">
  <trigger>Before irreversible or high-impact action</trigger>
  <validation>
    <check>Action clearly understood</check>
    <check>Consequences acknowledged</check>
    <check>Explicit user approval received</check>
  </validation>
  <on-pass>Execute action</on-pass>
  <on-fail>Do not proceed without approval</on-fail>
</stop-hook>
```

---

## Integration Points

### With Autonomous Routing (LAR-006)

```
ROUTING DECISION â†’ HOOK-001 (Pre-Execution)
â”œâ”€â”€ Validate persona selection
â”œâ”€â”€ Confirm skill requirements
â””â”€â”€ Check complexity assessment

If COMPLEX task:
  AFTER EACH PHASE â†’ HOOK-004 (Phase Gate)
  â””â”€â”€ Validate phase completion before next
```

### With Self-Assessment (LAR-007)

```
BEFORE DELIVERY â†’ HOOK-003 (Pre-Delivery Review)
â”œâ”€â”€ Run self-assessment checks
â”œâ”€â”€ Assign confidence level
â”œâ”€â”€ If MEDIUM/LOW â†’ Flag for user review
â””â”€â”€ If HIGH â†’ Auto-proceed (SOFT STOP)
```

### With Escalation Protocol (LAR-008)

```
MUST CONFIRM items â†’ HOOK-005 (Critical Action)
â”œâ”€â”€ Irreversible actions
â”œâ”€â”€ Legal/financial implications
â”œâ”€â”€ External communications
â””â”€â”€ Require explicit approval
```

---

## QA Checklist by Output Type

### Documents

```
â˜ All sections present
â˜ No placeholder text ([TBD], [INSERT], TODO)
â˜ Formatting consistent
â˜ Grammar/spelling checked
â˜ Links functional (if any)
â˜ Version/date included
```

### Code

```
â˜ Syntax valid
â˜ No placeholder comments
â˜ Error handling present
â˜ Comments where needed
â˜ Tested (or test approach noted)
â˜ Security considerations addressed
```

### Analysis/Research

```
â˜ Sources cited
â˜ Confidence levels assigned
â˜ Limitations noted
â˜ Data current (< 12 months or noted)
â˜ Methodology explained
â˜ Recommendations actionable
```

### Communications

```
â˜ Tone appropriate for audience
â˜ Purpose clear in first paragraph
â˜ Call to action specific
â˜ No sensitive information exposed
â˜ Proofread
```

---

## Stop Hook Response Format

When a stop hook activates, present:

```markdown
---
â¸ï¸ **STOP HOOK ACTIVATED: [Hook Name]**

**Type:** [HARD|SOFT|GATE|REVIEW]
**Trigger:** [What caused activation]

**Validation Results:**
âœ… [Passed check]
âœ… [Passed check]
âŒ [Failed check] - [Reason]

**Status:** [PASS|FAIL|REVIEW NEEDED]

**Next Action:**
[What happens next / What's needed to proceed]

---
```

---

## Override Protocol

### Soft Stop Override
User can say: "proceed", "continue", "skip check"
â†’ Log override and continue

### Hard Stop Override
User must explicitly say: "I confirm [action]" or "approved to proceed"
â†’ Log confirmation and continue

### No Override Conditions
Never skip:
- Security validations
- Legal disclaimers
- Data loss warnings
- External communication gates

---

## Rules

```
+activate-hooks-at-defined-triggers   # Don't skip stop hooks
+present-validation-results           # Show what passed/failed
+require-explicit-approval-for-hard   # Hard stops need confirmation
+log-all-overrides                    # Track when hooks bypassed
-proceed-past-failed-hard-stop        # Never bypass critical gates
-skip-pre-delivery-review             # Always validate before output
-ignore-failed-checks                 # Address failures before proceeding
```

---

## Implementation Notes

### For Claude Projects
Include stop hooks in Project Instructions:
```xml
<protocol id="stop-hooks" active="true">
  <!-- Include relevant hooks from this document -->
</protocol>
```

### For Skill Files
Reference hooks at appropriate points:
```markdown
## Workflow Step 3

[Step content]

<!-- Stop Hook Integration -->
**QA Checkpoint:** Run HOOK-002 (Mid-Execution) before proceeding
```

---

*QA Protocol v1.0 | Frans Master Prompts v4.7*
