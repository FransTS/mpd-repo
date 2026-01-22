# Frans Skill: Iterative Loop (Ralph Wiggum Method)

## Metadata

| Field | Value |
|-------|-------|
| **Name** | iterative-loop |
| **Version** | 1.0 |
| **ID** | LAR-016 |
| **Triggers** | "iterate until done", "ralph loop", "refine until complete", "autonomous iteration" |
| **Always Active** | NO (on-demand) |
| **Google Doc Name** | `SKILL_IterativeLoop` |
| **Based On** | [Ralph Wiggum Plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum) |

---

## Purpose

Enable autonomous iterative refinement of work through self-referential feedback loops. Claude continuously improves output by observing previous iterations until completion criteria are met.

---

## Core Concept

> "Ralph is a Bash loop" â€” The AI feeds its own output back as context, enabling progressive refinement without external automation.

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚                    ITERATIVE LOOP CYCLE                          â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚                                                                  â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”                                              â”‚
â”‚   â”‚ Initial      â”‚                                              â”‚
â”‚   â”‚ Prompt       â”‚                                              â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”˜                                              â”‚
â”‚          â”‚                                                       â”‚
â”‚          â–¼                                                       â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”     â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”     â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”   â”‚
â”‚   â”‚ Iteration 1  â”‚â”€â”€â”€â”€â–¶â”‚ Iteration 2  â”‚â”€â”€â”€â”€â–¶â”‚ Iteration N  â”‚   â”‚
â”‚   â”‚ Initial work â”‚     â”‚ Refine work  â”‚     â”‚ Final polish â”‚   â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜     â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜     â””â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”˜   â”‚
â”‚          â”‚                    â”‚                     â”‚           â”‚
â”‚          â–¼                    â–¼                     â–¼           â”‚
â”‚   â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”     â”‚
â”‚   â”‚              PERSISTENT CONTEXT                       â”‚     â”‚
â”‚   â”‚  â€¢ Modified files    â€¢ Test results                  â”‚     â”‚
â”‚   â”‚  â€¢ Git history       â€¢ Error messages                â”‚     â”‚
â”‚   â”‚  â€¢ Previous output   â€¢ Quality metrics               â”‚     â”‚
â”‚   â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜     â”‚
â”‚                                                                  â”‚
â”‚          â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”                                       â”‚
â”‚          â”‚ Completion   â”‚ â—€â”€â”€ "DONE" signal triggers exit      â”‚
â”‚          â”‚ Promise Met  â”‚                                       â”‚
â”‚          â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜                                       â”‚
â”‚                                                                  â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

---

## Invocation Syntax

### Standard Loop

```bash
/ralph-loop "<task description>" --max-iterations <n> --completion-promise "<signal>"
```

### Parameters

| Parameter | Required | Description | Default |
|-----------|----------|-------------|---------|
| `task` | YES | Clear description of work to complete | â€” |
| `--max-iterations` | RECOMMENDED | Maximum iteration limit | 10 |
| `--completion-promise` | YES | Text signal indicating task is complete | "DONE" |

### Cancel Command

```bash
/cancel-ralph
```

---

## Best Practices

### 1. Prompt Design

| âœ… Do | âŒ Don't |
|-------|---------|
| Define explicit success criteria | Leave completion ambiguous |
| Include testable acceptance conditions | Rely on subjective judgment |
| Break into phases with checkpoints | Create single monolithic tasks |
| Embed verification commands (tests, lints) | Skip automated verification |

### 2. Iteration Limits

| Task Type | Recommended Max |
|-----------|-----------------|
| Simple refinement | 3-5 |
| Feature implementation | 10-15 |
| Complex multi-file | 20-30 |
| Full project build | 50+ |

### 3. Completion Promise Design

```markdown
Good completion promises:
- "DONE: All tests passing"
- "COMPLETE: Build successful"
- "FINISHED: No lint errors"

Bad completion promises:
- "Done" (too generic, might appear in output)
- "Complete" (common word)
- "" (no promise = infinite loop risk)
```

---

## Ideal Use Cases

| Excellent Fit | Poor Fit |
|---------------|----------|
| Test-driven development | Creative writing |
| Bug fixing with test suite | Subjective design decisions |
| Code refactoring | One-time operations |
| Documentation generation | Tasks without clear success metrics |
| API implementation | Exploratory research |
| Build/lint error resolution | Human approval required |

---

## Integration with Frans Skills

### Automatic Skill Synergies

| Skill | Integration |
|-------|-------------|
| **LAR-007 self-assessment** | Quality check each iteration |
| **LAR-013 error-recovery** | Handle iteration failures |
| **LAR-014 context-management** | Track state across iterations |
| **LAR-015 output-formatting** | Consistent output each cycle |

### Recommended Skill Chains

```
For Code Tasks:
iterative-loop + LAR-009 (architecture) + self-assessment

For Document Tasks:
iterative-loop + LAR-005 (docx) + output-formatting

For Research Tasks:
iterative-loop + LAR-001 (research) + context-management
```

---

## Stop Hook Integration

```xml
<stop-hook id="HOOK-RALPH-001" type="GATE">
  <trigger>Iteration boundary reached</trigger>
  <validation>
    <check>Completion promise not yet detected</check>
    <check>Max iterations not exceeded</check>
    <check>No critical errors blocking progress</check>
  </validation>
  <on-pass>Continue to next iteration</on-pass>
  <on-fail>Exit loop, report status</on-fail>
</stop-hook>

<stop-hook id="HOOK-RALPH-002" type="HARD">
  <trigger>Max iterations exceeded</trigger>
  <validation>
    <check>Work-in-progress saved</check>
    <check>Status report generated</check>
  </validation>
  <on-pass>Exit with partial completion report</on-pass>
  <on-fail>Force exit, preserve state</on-fail>
</stop-hook>

<stop-hook id="HOOK-RALPH-003" type="SOFT">
  <trigger>Completion promise detected</trigger>
  <validation>
    <check>All success criteria met</check>
    <check>Final quality assessment passed</check>
  </validation>
  <on-pass>Exit loop successfully</on-pass>
  <on-fail>Continue one more iteration for verification</on-fail>
</stop-hook>
```

---

## Example Prompts

### Code Implementation

```markdown
/ralph-loop "
Implement the UserAuthentication module:

1. Create src/auth/UserAuthentication.ts
2. Implement login(), logout(), validateToken() methods
3. Add comprehensive unit tests in tests/auth/
4. Ensure all tests pass
5. Fix any TypeScript errors
6. Run linter and fix issues

Success criteria:
- All tests passing (npm test)
- No TypeScript errors (npm run type-check)
- No lint errors (npm run lint)
- Coverage > 80%

When ALL criteria met, output: AUTH_MODULE_COMPLETE
" --max-iterations 15 --completion-promise "AUTH_MODULE_COMPLETE"
```

### Document Refinement

```markdown
/ralph-loop "
Create comprehensive API documentation:

1. Document all endpoints in docs/api/
2. Include request/response examples
3. Add error code reference
4. Validate markdown formatting
5. Check all links resolve
6. Ensure consistency with codebase

Each iteration:
- Check for TODO markers
- Verify example accuracy
- Test code samples

When documentation is complete with no TODOs, output: DOCS_COMPLETE
" --max-iterations 10 --completion-promise "DOCS_COMPLETE"
```

### Bug Fix Cycle

```markdown
/ralph-loop "
Fix failing tests in the payment module:

Current failures:
- PaymentProcessor.test.ts (3 failing)
- RefundHandler.test.ts (1 failing)

For each iteration:
1. Run: npm test -- --grep 'payment'
2. Analyse failure output
3. Fix root cause
4. Re-run tests

Continue until: ALL TESTS PASSING
" --max-iterations 20 --completion-promise "ALL TESTS PASSING"
```

---

## Iteration Progress Tracking

Each iteration should output:

```markdown
## Iteration [N] of [MAX]

**Status:** [In Progress | Blocked | Near Complete]

**Completed this iteration:**
- [Action 1]
- [Action 2]

**Remaining:**
- [ ] [Task 1]
- [ ] [Task 2]

**Blockers:** [None | Description]

**Next iteration focus:** [What to address next]

---
[COMPLETION_PROMISE or continue]
```

---

## Anti-Patterns (Avoid These)

| âŒ Don't | âœ… Do Instead |
|---------|--------------|
| Vague completion criteria | Explicit, testable success conditions |
| No iteration limit | Always set --max-iterations |
| Generic completion promise | Unique, specific promise text |
| Subjective quality measures | Automated verification (tests, lints) |
| Single massive task | Phased approach with checkpoints |
| Ignore iteration context | Reference and build on previous work |

---

## Claude Code Plugin Setup

To enable the Ralph Wiggum plugin in Claude Code:

```bash
# Clone the plugin
git clone https://github.com/anthropics/claude-code.git
cd claude-code/plugins/ralph-wiggum

# Follow plugin installation instructions
# See: https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum
```

---

## Rules

```
+define-completion-criteria       # Always specify success conditions
+set-iteration-limits             # Prevent infinite loops
+use-automated-verification       # Tests, lints, builds
+track-iteration-progress         # Report status each cycle
+build-on-previous-work           # Reference prior iterations
-skip-max-iterations              # Always set a limit
-use-generic-promises             # Unique completion signals
-attempt-subjective-tasks         # Stick to verifiable work
-ignore-persistent-context        # Files and history matter
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 009 Software Architect | Primary user for code iteration |
| 006 Technical Writer | Documentation refinement cycles |
| 012 Prompt Engineer | Prompt iteration and testing |
| 010 The Architect | Orchestrate multi-phase loops |

---

## Related Resources

- [Ralph Wiggum Plugin Repository](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum)
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)

---

*Frans Skill LAR-016 | Iterative Loop (Ralph Wiggum Method) v1.0*
