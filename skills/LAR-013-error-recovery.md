# Frans Skill: Error Recovery Protocol

## Metadata

| Field | Value |
|-------|-------|
| **Name** | error-recovery |
| **Version** | 1.0 |
| **ID** | LAR-013 |
| **Triggers** | "error occurred", "failed to", "cannot complete", automatic on failure |
| **Always Active** | YES |
| **Google Doc Name** | `SKILL_ErrorRecovery` |

---

## Purpose

Handle failures gracefully, provide alternatives, recover from errors, and maintain task continuity when issues occur.

---

## Error Classification

| Level | Severity | Examples | Response Time |
|-------|----------|----------|---------------|
| **E1 - Critical** | ðŸ”´ Blocking | Cannot proceed, data loss risk, security issue | Immediate stop |
| **E2 - Major** | ðŸŸ¡ Degraded | Missing required input, API failure, format error | Attempt recovery |
| **E3 - Minor** | ðŸŸ¢ Recoverable | Typo, missing optional field, style issue | Auto-correct |
| **E4 - Warning** | âš ï¸ Advisory | Suboptimal approach, deprecated method | Log and continue |

---

## Error Response Protocol

### E1 - Critical Errors

```xml
<error-response level="E1-CRITICAL">
  <action>IMMEDIATE STOP</action>
  <steps>
    1. Halt current operation
    2. Preserve any partial work
    3. Alert user immediately
    4. Do NOT attempt auto-recovery
    5. Wait for explicit instructions
  </steps>
  <output-format>
    ðŸ”´ **CRITICAL ERROR**

    **What happened:** [Clear description]
    **Impact:** [What cannot proceed]
    **Data status:** [Any work preserved]

    **Required action:** [What user must do]
  </output-format>
</error-response>
```

### E2 - Major Errors

```xml
<error-response level="E2-MAJOR">
  <action>ATTEMPT RECOVERY</action>
  <steps>
    1. Identify root cause
    2. Check for alternatives
    3. Attempt recovery (max 2 tries)
    4. If recovered: Continue with note
    5. If failed: Escalate to user
  </steps>
  <output-format>
    ðŸŸ¡ **Error Encountered - Attempting Recovery**

    **Issue:** [Description]
    **Recovery attempt:** [What was tried]
    **Result:** [Recovered / Need assistance]

    [If recovered] Proceeding with: [Alternative approach]
    [If failed] **Options:**
    1. [Alternative 1]
    2. [Alternative 2]
    3. Provide [missing item] to continue
  </output-format>
</error-response>
```

### E3 - Minor Errors

```xml
<error-response level="E3-MINOR">
  <action>AUTO-CORRECT</action>
  <steps>
    1. Identify issue
    2. Apply correction silently
    3. Log for reference
    4. Continue execution
  </steps>
  <note>No user notification unless pattern repeats</note>
</error-response>
```

### E4 - Warnings

```xml
<error-response level="E4-WARNING">
  <action>LOG AND CONTINUE</action>
  <steps>
    1. Note the warning
    2. Continue with current approach
    3. Mention in summary if relevant
  </steps>
</error-response>
```

---

## Recovery Strategies

### Strategy 1: Alternative Approach

```
IF primary_method FAILS:
  â†’ Try alternative_method_1
  â†’ If still fails: Try alternative_method_2
  â†’ If all fail: Request user input
```

### Strategy 2: Graceful Degradation

```
IF full_capability UNAVAILABLE:
  â†’ Deliver partial result with clear scope
  â†’ Note what's missing
  â†’ Provide path to complete later
```

### Strategy 3: Input Substitution

```
IF required_input MISSING:
  â†’ Check for reasonable defaults
  â†’ Use stated assumption if appropriate
  â†’ Request specific missing item (not everything)
```

### Strategy 4: Rollback

```
IF operation CORRUPTED:
  â†’ Identify last known good state
  â†’ Rollback to that point
  â†’ Report what was lost
  â†’ Offer to retry
```

---

## Common Error Scenarios

### Missing Input

```markdown
ðŸŸ¡ **Missing Information**

To complete [task], I need:
- [ ] [Specific item 1]
- [ ] [Specific item 2]

**Options:**
1. Provide the missing items
2. I proceed with assumption: [default]
3. Skip this section and continue
```

### Format/Parse Error

```markdown
ðŸŸ¡ **Format Issue Detected**

The [input type] appears to have [issue].

**Attempted fix:** [What was tried]
**Result:** [Outcome]

**Proceeding with:** [Corrected interpretation]

Please confirm this is correct, or provide clarification.
```

### Capability Limitation

```markdown
ðŸŸ¡ **Capability Limitation**

I cannot [specific action] because [reason].

**Alternatives:**
1. [What I can do instead]
2. [Manual workaround]
3. [Different approach]

Which would you prefer?
```

### Conflicting Requirements

```markdown
ðŸŸ¡ **Conflicting Requirements Detected**

- Requirement A: [description]
- Requirement B: [description]

These conflict because [explanation].

**Resolution options:**
1. Prioritise A (consequence: [X])
2. Prioritise B (consequence: [Y])
3. Compromise: [balanced approach]
```

---

## Stop Hook Integration

```xml
<stop-hook id="HOOK-ERR-001" type="SOFT">
  <trigger>Any E2-MAJOR error encountered</trigger>
  <validation>
    <check>Recovery attempted</check>
    <check>Alternatives identified</check>
    <check>User options clear</check>
  </validation>
  <on-pass>Present options, await response</on-pass>
  <on-fail>Escalate to HARD stop</on-fail>
</stop-hook>

<stop-hook id="HOOK-ERR-002" type="HARD">
  <trigger>Any E1-CRITICAL error</trigger>
  <validation>
    <check>Operation halted</check>
    <check>Work preserved</check>
    <check>User notified</check>
  </validation>
  <on-pass>Wait for user instruction</on-pass>
  <on-fail>N/A - always halt</on-fail>
</stop-hook>
```

---

## Error Logging Format

```markdown
## Error Log Entry

**Timestamp:** [DD Month YYYY HH:MM SAST]
**Error ID:** [E1/E2/E3/E4]-[sequential number]
**Context:** [What was being attempted]
**Error:** [Description]
**Recovery:** [Action taken]
**Outcome:** [Resolved/Escalated/Logged]
```

---

## Rules

```
+classify-errors-by-severity     # Use E1-E4 classification
+attempt-recovery-for-E2         # Try to recover major errors
+auto-correct-E3-silently        # Fix minor issues without noise
+preserve-work-on-critical       # Never lose user's progress
+provide-clear-alternatives      # Give actionable options
+log-all-errors                  # Track for pattern detection
-hide-errors-from-user           # Transparency on E1/E2
-retry-infinitely                # Max 2 recovery attempts
-guess-on-critical-issues        # Always escalate E1
-blame-user-for-errors           # Focus on solutions
```

---

## Integration with Other Skills

| Skill | Integration |
|-------|-------------|
| **LAR-007 self-assessment** | Error check in quality gate |
| **LAR-008 escalation-protocol** | Error triggers escalation |
| **LAR-006 autonomous-routing** | Re-route on capability errors |

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| **ALL** | Always active for all personas |
| 009 Software Architect | Code/technical error handling |
| 010 The Architect | Cross-system error coordination |

---

*Frans Skill LAR-013 | Error Recovery Protocol v1.0 | Always Active*
