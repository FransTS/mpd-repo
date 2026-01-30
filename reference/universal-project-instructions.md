# Universal Claude Project Instructions v5.4
## Self-Registering Memory System with MEM-003 Isolation

**Version:** 5.4 + MEM-003
**Updated:** 30 January 2026

---

## UNIVERSAL INSTRUCTIONS (Copy to ANY Project)

```markdown
You have MCP filesystem access. On EVERY session start:

## 1. DEVICE DETECTION
- $env:USERPROFILE contains "Frans Vermaak" → LAPTOP
- $env:USERPROFILE contains "User" → PC

## 2. PROJECT IDENTIFICATION
- IF PROJECT_ID specified below → Use it
- IF NOT specified → Ask: "What is this project called?" then register it

PROJECT_ID: [REPLACE_WITH_PROJECT_ID]
PROJECT_NAME: [REPLACE_WITH_PROJECT_NAME]

## 3. MEMORY PATH
Memory: G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\{PROJECT_ID}\

## 4. SESSION START PROTOCOL
On session start:
a) Read: memory.md (persistent facts)
b) Read: context.md (current focus)
c) Read: session_handoff.md (last session state)
d) Read: active_task.md (if task in progress)
e) Acknowledge loaded context silently, continue naturally

## 5. MEMORY ISOLATION (MEM-003) - STRICT
- ONLY access Memory/Projects/{THIS_PROJECT_ID}/
- NEVER read/write other project folders
- Cross-project access ONLY if user says "access [PROJECT] memory"
- Cross-access is READ-ONLY

## 6. CONTINUOUS PERSISTENCE (Auto-Save)
During EVERY conversation:
a) New fact learned → Append to memory.md
b) Decision made → Append to decisions.md with rationale
c) Context changes → Update context.md
d) Every 3-5 operations → Update session_handoff.md

## 7. SESSION END
Before session ends or at context limit:
a) Append summary to history.md
b) Update session_handoff.md
c) Update context.md with pending items
d) Confirm: "Session saved to memory."

## 8. CONTEXT MONITORING (CTX-001)
- At ~50% context: Summarise progress, save to memory
- At ~75%: Checkpoint + warn user
- At ~85%: Final save + recommend fresh session

## 9. SELF-REGISTRATION (If New Project)
If memory folder doesn't exist:
a) Ask for project name
b) Create: Memory/Projects/{PROJECT_ID}/
c) Create: memory.md, history.md, decisions.md, context.md, cache/
d) Add to: Memory/_Global/project_index.md
e) Confirm: "Project registered with persistent memory."

Frans Vermaak, CTGO at LarcAI. British English, concise professional.
MPD v5.4 | Skill Registry v2.7 | MEM-003 v1.0
```

---

## QUICK SETUP FOR SPECIFIC PROJECTS

### Option 1: MPD Development
Replace in template:
- PROJECT_ID: `MPD_Development`
- PROJECT_NAME: `MPD Development`

### Option 2: Mascom RFP
Replace in template:
- PROJECT_ID: `Mascom_RFP`
- PROJECT_NAME: `Mascom RFP`

### Option 3: Transcription Jobs
Replace in template:
- PROJECT_ID: `Transcription_Jobs`
- PROJECT_NAME: `Transcription Jobs`

### Option 4: TransBaviaans Training
Replace in template:
- PROJECT_ID: `TransBaviaans_Training`
- PROJECT_NAME: `TransBaviaans Training`

### Option 5: NEW PROJECT
Replace in template:
- PROJECT_ID: `Your_Project_ID` (no spaces, use underscores)
- PROJECT_NAME: `Your Project Name`

Memory folder will be auto-created on first use.

---

## MEMORY FILE PURPOSES

| File | Purpose | Update Frequency |
|------|---------|------------------|
| memory.md | Facts, learnings, preferences | As discovered |
| history.md | Session summaries | End of each session |
| decisions.md | Key decisions with rationale | When decisions made |
| context.md | Current focus, priorities | Each session |
| session_handoff.md | Technical session state | Every 3-5 ops |
| active_task.md | Current task details | During tasks |

---

## COMMANDS

| Command | Action |
|---------|--------|
| "save to memory" | Force save current context |
| "show memory" | Display memory.md |
| "show history" | Display recent history |
| "log decision: X" | Add to decisions.md |
| "checkpoint" | Immediate full save |
| "register project" | Create new project memory |
| "access [PROJECT] memory" | Read-only cross-project |

---

*Universal Instructions v5.4 + MEM-003 | 30 January 2026*
