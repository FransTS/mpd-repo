# Frans Skill: Context Management

## Metadata

| Field | Value |
|-------|-------|
| **Name** | context-management |
| **Version** | 1.0 |
| **ID** | LAR-014 |
| **Triggers** | "remember that", "keep track", "context:", session management |
| **Always Active** | YES |
| **Google Doc Name** | `SKILL_ContextManagement` |

---

## Purpose

Track conversation state, maintain key facts, manage session context, and ensure continuity across multi-turn interactions.

---

## Context Types

| Type | Persistence | Examples |
|------|-------------|----------|
| **Session** | Current conversation only | Task progress, stated preferences |
| **User** | Across sessions (if stored) | Name, role, defaults |
| **Project** | Project-specific | Codebase details, project goals |
| **Task** | Single task duration | Current objective, constraints |

---

## Context Tracking Framework

### 1. User Context

```xml
<context type="user">
  <identity>
    <name>[User name]</name>
    <role>[Title/Position]</role>
    <organisation>[Company]</organisation>
  </identity>
  <preferences>
    <language>[British English]</language>
    <timezone>[SAST]</timezone>
    <currency>[ZAR]</currency>
    <tone>[Executive]</tone>
  </preferences>
  <defaults>
    <audience>[Executive]</audience>
    <format>[Structured]</format>
    <proceed-bias>[High - prefer action]</proceed-bias>
  </defaults>
</context>
```

### 2. Session Context

```xml
<context type="session">
  <timestamp>[Session start time]</timestamp>
  <active-persona>[Current persona ID]</active-persona>
  <loaded-skills>[List of loaded skills]</loaded-skills>
  <task-stack>
    <task id="1" status="completed">[Description]</task>
    <task id="2" status="in-progress">[Description]</task>
  </task-stack>
  <key-facts>
    <fact id="1">[Important information mentioned]</fact>
    <fact id="2">[Constraint or requirement stated]</fact>
  </key-facts>
  <decisions>
    <decision id="1">[Decision made and rationale]</decision>
  </decisions>
</context>
```

### 3. Task Context

```xml
<context type="task">
  <objective>[What we're trying to accomplish]</objective>
  <constraints>
    <constraint>[Limitation 1]</constraint>
    <constraint>[Limitation 2]</constraint>
  </constraints>
  <inputs-received>
    <input type="[type]">[Description]</input>
  </inputs-received>
  <outputs-delivered>
    <output type="[type]">[Description]</output>
  </outputs-delivered>
  <assumptions>
    <assumption>[What was assumed]</assumption>
  </assumptions>
</context>
```

---

## Context Operations

### CAPTURE - Recording New Context

```
WHEN user provides information:
  1. Classify: User / Session / Project / Task
  2. Extract key facts
  3. Store in appropriate context block
  4. Acknowledge if significant

Example triggers:
- "My name is..." â†’ User context
- "For this task..." â†’ Task context
- "Remember that..." â†’ Session context
- "The project uses..." â†’ Project context
```

### RECALL - Using Stored Context

```
WHEN generating response:
  1. Check relevant context blocks
  2. Apply user preferences
  3. Reference previous decisions
  4. Maintain consistency with stated facts

Example application:
- Use British English (user preference)
- Reference earlier mentioned deadline
- Apply stated constraints
```

### UPDATE - Modifying Context

```
WHEN context changes:
  1. Identify what changed
  2. Update relevant block
  3. Check for conflicts with existing context
  4. Note the change if significant

Example:
- "Actually, the deadline is Friday" â†’ Update task context
- "Let's use a different approach" â†’ Update session decisions
```

### CLEAR - Resetting Context

```
WHEN starting fresh:
  - "New task" â†’ Clear task context, keep session
  - "New session" â†’ Clear session, keep user
  - "Reset" â†’ Clear all except user defaults
```

---

## Context Summary Format

When providing context summary:

```markdown
## Current Context Summary

**Session:** [Duration/Start time]
**Active Persona:** [Persona name]

### Key Facts
1. [Important fact from conversation]
2. [Important fact from conversation]

### Current Task
- **Objective:** [What we're doing]
- **Status:** [Progress]
- **Constraints:** [Limitations]

### Decisions Made
1. [Decision and rationale]

### Assumptions Active
1. [Assumption being used]

### Pending Items
1. [What's still needed]
```

---

## Context Conflict Resolution

When new information conflicts with stored context:

```markdown
âš ï¸ **Context Update**

**Previous understanding:** [Old context]
**New information:** [What changed]

**Updated context:** [New state]

Proceeding with the updated understanding.
```

---

## Stop Hook Integration

```xml
<stop-hook id="HOOK-CTX-001" type="SOFT">
  <trigger>Significant context change detected</trigger>
  <validation>
    <check>Change clearly understood</check>
    <check>No critical conflicts</check>
    <check>Dependencies updated</check>
  </validation>
  <on-pass>Update context, continue</on-pass>
  <on-fail>Clarify with user before proceeding</on-fail>
</stop-hook>

<stop-hook id="HOOK-CTX-002" type="SOFT">
  <trigger>Long conversation (>10 turns) without context summary</trigger>
  <validation>
    <check>Key facts captured</check>
    <check>Task progress tracked</check>
  </validation>
  <on-pass>Offer context summary</on-pass>
  <on-fail>Generate summary proactively</on-fail>
</stop-hook>
```

---

## Context Handoff Protocol

When transitioning between personas or tasks:

```markdown
## Context Handoff

**From:** [Previous persona/task]
**To:** [New persona/task]

### Carried Forward
- [Relevant context item 1]
- [Relevant context item 2]

### Not Applicable
- [Context item specific to previous task]

### New Context Needed
- [What the new persona/task needs]
```

---

## Memory Limitations

### What IS Tracked
- Explicit user statements
- Decisions made with rationale
- Constraints and requirements
- Progress on current task
- Key outputs delivered

### What is NOT Tracked
- Implied preferences (unless confirmed)
- Tentative ideas not actioned
- Superseded information
- Irrelevant tangents

---

## Rules

```
+capture-explicit-facts           # Store what user explicitly states
+apply-user-preferences           # Use stored preferences consistently
+maintain-task-continuity         # Track progress across turns
+acknowledge-context-changes      # Note when context updates
+offer-summaries-proactively      # Help user track state
-assume-unstated-context          # Don't invent context
-carry-irrelevant-context         # Keep context lean
-contradict-stored-facts          # Maintain consistency
-lose-critical-context            # Preserve important information
```

---

## Integration with Other Skills

| Skill | Integration |
|-------|-------------|
| **LAR-006 autonomous-routing** | Context informs persona selection |
| **LAR-007 self-assessment** | Context completeness check |
| **LAR-008 escalation-protocol** | Context clarity affects escalation |
| **LAR-013 error-recovery** | Context preserved on errors |

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| **ALL** | Always active for all personas |
| 010 The Architect | Cross-persona context coordination |
| 002 Executive Assistant | Session and scheduling context |

---

*Frans Skill LAR-014 | Context Management v1.0 | Always Active*
