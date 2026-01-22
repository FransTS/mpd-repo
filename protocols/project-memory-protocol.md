# Project-Aware Memory Protocol v1.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | MEM-002 |
| **Version** | 1.0 |
| **Created** | 15 January 2026 |
| **Replaces** | MEM-001 (global memory) |
| **Purpose** | Project-specific memory with device detection |

---

## Problem Solved

| Issue | Solution |
|-------|----------|
| Memory shared across all projects | Each project gets own memory space |
| Different projects have different context | Project-specific `context.md`, `active_task.md` |
| Device switching mid-project | Device detection + project memory = seamless |
| Checkpoints mixed between projects | Project-specific checkpoint folders |

---

## New Memory Structure

```
Memory/
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ _Global/                        # Cross-project resources
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_starter_prompt.md   # Universal starter prompt
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ project_index.md            # List of all projects
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ templates/                  # Shared templates
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Projects/                       # PROJECT-SPECIFIC MEMORY
Ã¢â€â€š   Ã¢â€â€š
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ MPD_Development/            # Project: MPD Development
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ project_config.md       # Project metadata
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ active_task.md          # Current task for THIS project
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_handoff.md      # Last session for THIS project
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ context.md              # Project context/goals
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ decisions.md            # Project decisions
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ tasks.md                # Project task list
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ cache/
Ã¢â€â€š   Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ checkpoints/        # Project checkpoints
Ã¢â€â€š   Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ intermediate/       # Project outputs
Ã¢â€â€š   Ã¢â€â€š       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ research/           # Project research
Ã¢â€â€š   Ã¢â€â€š
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Frans_Sales/               # Project: Frans Sales
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ project_config.md
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ active_task.md
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ session_handoff.md
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ cache/
Ã¢â€â€š   Ã¢â€â€š
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Frans_Product/             # Project: Frans Product Dev
Ã¢â€â€š   Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ ...
Ã¢â€â€š   Ã¢â€â€š
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ [New_Project]/              # Template for new projects
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ PC/                             # Device session logs (global)
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ session_log.md
Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Laptop/
    Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ session_log.md
```

---

## Project Config File Format

Each project has a `project_config.md`:

```markdown
# Project: [Name]

**Project ID:** PRJ-[XXX]
**Created:** [date]
**Status:** active | paused | completed

## Description
[What this project is about]

## Key Paths
- Claude Project: [name in Claude UI if applicable]
- Related folders: [paths]
- GitHub repo: [if applicable]

## Default Persona
[Which persona to use, e.g., 009-Software-Architect]

## Key Context
[Important info Claude needs for this project]
```

---

## Session Flow (Multi-Project, Multi-Device)

```
NEW CHAT STARTS
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 1. DETECT DEVICE (DEV-001)
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ PC or Laptop or Web/Mobile
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 2. IDENTIFY PROJECT
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Option A: User specifies "Project: MPD"
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Option B: Claude asks "Which project?"
Ã¢â€â€š   Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Option C: Detect from Claude Project name
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Option D: Read from prompt/instructions
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 3. LOAD PROJECT MEMORY
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Memory/Projects/[project_name]/
Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Read session_handoff.md
Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Read active_task.md
Ã¢â€â€š       Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ Read context.md
Ã¢â€â€š       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ Load relevant checkpoints
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 4. OFFER RESUME (if task in progress)
Ã¢â€â€š   Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ "You have an active task in [project]: [description]. Resume?"
Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ 5. PROCEED WITH PROJECT CONTEXT
    Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ All memory operations scoped to this project
```

---

## Device + Project Matrix

| Device | Project Access | Memory Write | Cache |
|--------|----------------|--------------|-------|
| PC | All projects | Ã¢Å“â€¦ Full | Ã¢Å“â€¦ Full |
| Laptop | All projects | Ã¢Å“â€¦ Full | Ã¢Å“â€¦ Full |
| Web | All projects (via Drive) | Ã¢Å¡Â Ã¯Â¸Â Limited | Ã¢ÂÅ’ No |
| Mobile | All projects (read-only) | Ã¢ÂÅ’ No | Ã¢ÂÅ’ No |

**Key:** Projects sync via Google Drive, accessible from any device with MCP.

---

## Session Starter Prompt (Universal)

```
You have MCP filesystem access. Execute this startup sequence:

1. DETECT DEVICE: Check $env:USERPROFILE for "Frans Vermaak" (Laptop) or "User" (PC)

2. IDENTIFY PROJECT: [CHOOSE ONE]
   - This is the **[PROJECT_NAME]** project
   - OR ask me which project

3. LOAD PROJECT MEMORY from: 
   `G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\[PROJECT_NAME]\`
   - Read: session_handoff.md, active_task.md, context.md

4. APPLY SES-001: Checkpoint every 3-5 ops, cache to project folder

5. If active task is IN_PROGRESS, offer to resume

Frans Vermaak, CTGO at LarcAI. British English, concise.
```

---

## Project-Specific Starter Prompts

Save these IN each Claude Project's custom instructions:

### For MPD Development Project:
```
Project: MPD_Development
Memory: G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\MPD_Development\

Read session_handoff.md and active_task.md, apply SES-001 checkpointing.
Default persona: The Architect (010) or Prompt Engineer (012).
```

### For Frans Sales Project:
```
Project: Frans_Sales  
Memory: G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Frans_Sales\

Read session_handoff.md and active_task.md, apply SES-001 checkpointing.
Default persona: Sales Enablement (004).
```

---

## Creating a New Project

1. Create folder: `Memory/Projects/[ProjectName]/`
2. Create files:
   - `project_config.md` (metadata)
   - `active_task.md` (copy template)
   - `session_handoff.md` (copy template)
   - `context.md` (project goals)
   - `cache/checkpoints/` folder
   - `cache/intermediate/` folder

3. Add to `Memory/_Global/project_index.md`
4. Create Claude Project with custom instructions pointing to memory

---

## Integration

| Protocol | Integration |
|----------|-------------|
| DEV-001 | Device detection (unchanged) |
| SES-001 | Checkpoints go to PROJECT cache folder |
| MEM-001 | Superseded by MEM-002 |
| Global v3.4 | Update to reference project memory |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 15 January 2026 | Initial project-aware memory protocol |
