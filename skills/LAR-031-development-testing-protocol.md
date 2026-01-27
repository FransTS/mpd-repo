# LAR-031: Development Testing Protocol

| Field | Value |
|-------|-------|
| **Document ID** | LAR-031-DEV-TEST-2026-001 |
| **Version** | 1.0 |
| **Created** | 26 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Classification** | Core Development Skill |

---

## Purpose

Enterprise-grade protocol ensuring code changes are verified, tested, and deployed without regression errors. Eliminates build failures through systematic verification gates.

---

## Trigger Phrases

- "apply development protocol"
- "code change"
- "implement feature"
- "fix bug"
- Any TypeScript/React/Node.js development task

---

## Protocol Overview

```
PRE-FLIGHT → ANALYSE → PLAN → IMPLEMENT → VERIFY → BUILD → DEPLOY → DOCUMENT
    │           │        │        │          │        │        │         │
    └── Gate 1 ─┴─ Gate 2┴─ Gate 3┴── Gate 4 ┴─ Gate 5┴─ Gate 6┴─ Gate 7 ┘
```

---

## Phase 1: Pre-Flight Check

**Gate 1: Environment Ready**

| Check | Command | Pass Criteria |
|-------|---------|---------------|
| Correct directory | `pwd` / `Get-Location` | In project root |
| Git status clean | `git status` | No uncommitted changes |
| Branch correct | `git branch --show-current` | On expected branch |
| Dependencies current | `npm install` (if needed) | No errors |

**Checkpoint:** Create restore point
```powershell
git stash push -m "pre-change-checkpoint-$(Get-Date -Format 'yyyyMMdd-HHmm')"
```

---

## Phase 2: Analyse Current State

**Gate 2: Full Understanding**

| Step | Action | Verification |
|------|--------|--------------|
| 2.1 | Read target file(s) completely | File contents in context |
| 2.2 | Identify all dependencies | List imports/exports |
| 2.3 | Check related files | Components, hooks, services |
| 2.4 | Note current line numbers | For precise edits |

**Required Output:**
```markdown
### Current State Analysis
- File: [path]
- Lines: [total]
- Key sections: [list with line numbers]
- Dependencies: [imports used]
- Exports: [what this file provides]
```

---

## Phase 3: Plan Changes

**Gate 3: Change Plan Documented**

### Change Classification

| Type | Criteria | Risk Level |
|------|----------|------------|
| **Simple** | Single file, <20 lines changed | Low |
| **Moderate** | 2-3 files, new imports/exports | Medium |
| **Complex** | 4+ files, new components, API changes | High |

### Change Plan Template

```markdown
### Change Plan
**Classification:** [Simple/Moderate/Complex]
**Files to modify:**
1. [file1.tsx] - Lines [X-Y]: [description]
2. [file2.ts] - Lines [A-B]: [description]

**New files:**
- [newfile.tsx] - [purpose]

**Dependencies affected:**
- [component/hook] will need [change]

**Rollback command:**
git checkout HEAD -- [files] OR git stash pop
```

---

## Phase 4: Implement Changes

**Gate 4: Changes Applied Correctly**

### Implementation Rules

1. **One logical change per edit** - Never combine unrelated changes
2. **Verify after each file** - Check the change was applied
3. **Preserve formatting** - Match existing code style
4. **Add, don't assume** - Never assume previous edits persisted

### Verification Pattern

```powershell
# After EACH file change:
Select-String -Path "[file]" -Pattern "[key change]" -Context 2,2
# OR
Get-Content "[file]" | Select-Object -Skip [line-2] -First 5
```

### Error Recovery

If edit fails:
1. Read current file state (not assumed state)
2. Identify what actually exists
3. Re-apply with correct context

---

## Phase 5: Verify Syntax

**Gate 5: TypeScript Clean**

```powershell
# TypeScript check (no emit)
npx tsc --noEmit

# Expected output: (empty = success)
# If errors: FIX BEFORE PROCEEDING
```

### Common TypeScript Errors

| Error | Cause | Fix |
|-------|-------|-----|
| TS6133 | Unused import/variable | Remove or use it |
| TS2339 | Property doesn't exist | Check object type |
| TS2345 | Type mismatch | Align types |
| TS2307 | Module not found | Check import path |

**Rule:** Do NOT proceed to build if TypeScript check fails.

---

## Phase 6: Build

**Gate 6: Build Successful**

```powershell
npm run build
```

### Build Success Criteria

| Indicator | Status |
|-----------|--------|
| Exit code 0 | ✓ Pass |
| "built in Xs" message | ✓ Pass |
| No errors in output | ✓ Pass |
| Warnings acceptable | ⚠ Note but proceed |

### Build Failure Recovery

1. Read exact error message
2. Identify file and line
3. Return to Phase 2 (Analyse)
4. Apply fix
5. Re-run TypeScript check
6. Re-run build

---

## Phase 7: Deploy

**Gate 7: Deployed Successfully**

### Git Commit Standards

```powershell
git add -A
git commit -m "[type]: [scope] - [description]"
git push origin [branch]
```

**Commit Types:**
| Type | Use For |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code restructure |
| `style` | Formatting only |
| `docs` | Documentation |
| `chore` | Maintenance |

### Deployment Verification

For Vercel/cloud deployments:
1. Wait 2-3 minutes for deploy
2. Hard refresh target URL (Ctrl+Shift+R)
3. Verify version badge updated
4. Test new functionality

---

## Phase 8: Document

**Session Documentation Template**

```markdown
## Session Summary - [Date]

### Changes Made
- [v X.Y.Z]: [Feature/fix description]

### Files Modified
- [file1]: [what changed]
- [file2]: [what changed]

### Commits
- [hash]: [message]

### Testing Performed
- [ ] TypeScript check passed
- [ ] Build successful
- [ ] Deployed to [environment]
- [ ] Functionality verified

### Notes
[Any issues encountered and how resolved]
```

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────┐
│  DEVELOPMENT TESTING PROTOCOL - QUICK REFERENCE             │
├─────────────────────────────────────────────────────────────┤
│  1. PRE-FLIGHT                                              │
│     □ git status (clean?)                                   │
│     □ Correct directory?                                    │
│     □ Create checkpoint if needed                           │
│                                                             │
│  2. ANALYSE                                                 │
│     □ Read target files COMPLETELY                          │
│     □ Note line numbers                                     │
│     □ List dependencies                                     │
│                                                             │
│  3. PLAN                                                    │
│     □ Classify: Simple/Moderate/Complex                     │
│     □ Document all changes needed                           │
│     □ Identify rollback strategy                            │
│                                                             │
│  4. IMPLEMENT                                               │
│     □ One change at a time                                  │
│     □ Verify EACH change applied                            │
│     □ Check file after edit                                 │
│                                                             │
│  5. VERIFY SYNTAX                                           │
│     □ npx tsc --noEmit                                      │
│     □ STOP if errors - fix first                            │
│                                                             │
│  6. BUILD                                                   │
│     □ npm run build                                         │
│     □ Check for success message                             │
│     □ If fail → return to step 2                            │
│                                                             │
│  7. DEPLOY                                                  │
│     □ git add -A                                            │
│     □ git commit -m "[type]: description"                   │
│     □ git push origin [branch]                              │
│     □ Verify deployment                                     │
│                                                             │
│  8. DOCUMENT                                                │
│     □ Update session handoff                                │
│     □ Note version changes                                  │
└─────────────────────────────────────────────────────────────┘
```

---

## Anti-Patterns (NEVER DO)

| Anti-Pattern | Why It Fails |
|--------------|--------------|
| Assume previous edit worked | Edits can fail silently |
| Skip TypeScript check | Build will fail |
| Multiple unrelated changes | Hard to isolate failures |
| Build without verification | Wastes time on failures |
| Commit without testing | Broken deploys |
| Ignore build warnings | May indicate real issues |

---

## Integration with Other Skills

| Skill | Integration |
|-------|-------------|
| LAR-013 Error Recovery | Use for build failure recovery |
| LAR-023 Batch Processing | For multi-file changes |
| SES-001 Session Persistence | Checkpoint complex changes |

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 26 Jan 2026 | Initial enterprise protocol |

---

*LAR-031 Development Testing Protocol v1.0 | LarcAI Standards*
