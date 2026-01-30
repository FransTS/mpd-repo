# MEM-003 Memory Isolation & Persistence Protocol v1.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MEM-003 |
| **Version** | 1.0 |
| **Created** | 30 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Status** | Active |

---

## Purpose

Ensure strict memory isolation between projects while enabling continuous persistence of context, facts, history, and decisions within each project.

---

## Memory Structure

Each project MUST have this folder structure:

```
Memory/Projects/{PROJECT_ID}/
├── project_config.md      # Project metadata and settings
├── session_handoff.md     # Current session state
├── active_task.md         # Current task details
├── memory.md              # Persistent facts & learnings
├── history.md             # Session summaries (append-only)
├── decisions.md           # Decision log with rationale
├── context.md             # Current working context
└── cache/
    ├── checkpoints/       # Session checkpoints
    ├── intermediate/      # Large outputs
    ├── offloaded/         # CTX-001 offloaded content
    └── conversations/     # Archived full conversations
```

---

## Isolation Rules (STRICT)

### Rule 1: Exclusive Access
- ONLY read/write to `Memory/Projects/{CURRENT_PROJECT_ID}/`
- NEVER access other project folders by default

### Rule 2: Cross-Project Access (Explicit Only)
- User must say: "access [PROJECT_ID] memory" or "read from [PROJECT] project"
- Cross-project access is READ-ONLY
- Log cross-access in current project's history.md

### Rule 3: No Implicit Sharing
- Never assume context from other projects
- Never copy data between projects without explicit instruction
- Each project is a clean slate unless memory files exist

---

## Continuous Persistence Protocol

### On Session Start
```
1. Read: memory.md, context.md, session_handoff.md
2. Load relevant context
3. Continue from last known state
```

### During Conversation
```
TRIGGER: New fact learned about user/project
ACTION: Append to memory.md with timestamp

TRIGGER: Decision made
ACTION: Append to decisions.md with rationale

TRIGGER: Context change (new focus, priority shift)
ACTION: Update context.md

TRIGGER: Every 3-5 tool operations (SES-001)
ACTION: Update session_handoff.md
```

### On Session End (or context limit)
```
1. Append session summary to history.md
2. Update session_handoff.md with final state
3. Update context.md with current focus
4. If CTX-001 triggered: archive to cache/conversations/
```

---

## File Formats

### memory.md
```markdown
# Project Memory - {PROJECT_NAME}

## Facts & Learnings

### User Preferences
- [timestamp] Preference discovered

### Technical Details
- [timestamp] Technical fact

### Key Information
- [timestamp] Important detail

---
*Auto-updated by MEM-003*
```

### history.md
```markdown
# Session History - {PROJECT_NAME}

## Sessions

### [DATE] [TIME] - Session Title
- **Topics:** topic1, topic2
- **Outcomes:** what was achieved
- **Artifacts:** files created
- **Next:** pending items

---
*Append-only log*
```

### decisions.md
```markdown
# Decision Log - {PROJECT_NAME}

## Decisions

### [DATE] Decision Title
- **Decision:** What was decided
- **Rationale:** Why this choice
- **Alternatives:** Other options considered
- **Impact:** Expected effect

---
*Append-only log*
```

### context.md
```markdown
# Current Context - {PROJECT_NAME}

## Active Focus
Current primary objective

## Priorities
1. Priority 1
2. Priority 2

## Pending Items
- [ ] Item 1
- [ ] Item 2

## Blockers
- None / List blockers

---
*Updated each session*
```

---

## Self-Registration Protocol

When Claude starts in a project WITHOUT a memory folder:

```
1. ASK: "What should I call this project? (This will create a memory folder)"
2. CREATE: Memory/Projects/{PROJECT_ID}/ with all required files
3. REGISTER: Add entry to Memory/_Global/project_index.md
4. CONFIRM: "Project '{PROJECT_NAME}' registered. Memory folder created."
```

---

## Integration

- **SES-001 v2.0:** Checkpoint triggers also update memory files
- **CTX-001:** Compression events archive to cache/conversations/
- **LAR-006 v1.3:** Routes memory operations automatically

---

## Commands

| Command | Action |
|---------|--------|
| "save to memory" | Force write current context to memory.md |
| "show memory" | Display contents of memory.md |
| "show history" | Display recent entries from history.md |
| "log decision: X" | Add decision to decisions.md |
| "register project" | Run self-registration |
| "access [PROJECT] memory" | Read-only cross-project access |

---

*MEM-003 Memory Isolation Protocol v1.0 | MPD v5.4*
