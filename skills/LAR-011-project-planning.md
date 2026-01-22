# Frans Skill: Project Planning

## Metadata

| Field | Value |
|-------|-------|
| **Name** | project-planning |
| **Version** | 1.0 |
| **ID** | LAR-011 |
| **Triggers** | "project plan", "milestones", "gantt", "WBS" |
| **Google Doc Name** | `SKILL_ProjectPlanning` |

---

## Purpose

Create comprehensive project plans with clear scope, milestones, dependencies, and risk management.

---

## Project Plan Structure

```
1. Project Charter
2. Scope Definition
3. Work Breakdown Structure (WBS)
4. Milestone Schedule
5. Dependency Map
6. Resource Allocation
7. Risk Register
8. Status Report Template
```

---

## 1. Project Charter Template

```markdown
# Project Charter: [Project Name]

**Version:** [X.X]
**Date:** [DD Month YYYY]
**Sponsor:** [Name]
**Project Manager:** [Name]

---

## Executive Summary

[2-3 paragraph overview of the project, its purpose, and expected outcomes]

---

## Business Case

### Problem Statement
[What problem does this project solve?]

### Opportunity
[What opportunity does this project capture?]

### Expected Benefits
| Benefit | Measure | Target |
|---------|---------|--------|
| [Benefit 1] | [How measured] | [Target value] |
| [Benefit 2] | [How measured] | [Target value] |

---

## Objectives

| # | Objective | Success Measure | Target |
|---|-----------|-----------------|--------|
| 1 | [Objective] | [Measure] | [Target] |
| 2 | [Objective] | [Measure] | [Target] |

---

## Scope

### In Scope
- [Deliverable/Feature 1]
- [Deliverable/Feature 2]
- [Deliverable/Feature 3]

### Out of Scope
- [Excluded item 1]
- [Excluded item 2]

---

## Timeline

| Phase | Description | Start | End | Duration |
|-------|-------------|-------|-----|----------|
| Phase 1 | [Description] | [Date] | [Date] | [X] weeks |
| Phase 2 | [Description] | [Date] | [Date] | [X] weeks |
| Phase 3 | [Description] | [Date] | [Date] | [X] weeks |

---

## Budget

| Category | Estimated Cost | Notes |
|----------|----------------|-------|
| [Category 1] | R [amount] | [Notes] |
| [Category 2] | R [amount] | [Notes] |
| Contingency (10%) | R [amount] | |
| **Total** | **R [amount]** | |
```

---

## 2. Work Breakdown Structure (WBS)

```
1.0 [Project Name]
â”œâ”€â”€ 1.1 Phase 1: [Name]
â”‚   â”œâ”€â”€ 1.1.1 [Deliverable]
â”‚   â”‚   â”œâ”€â”€ 1.1.1.1 [Task]
â”‚   â”‚   â””â”€â”€ 1.1.1.2 [Task]
â”‚   â””â”€â”€ 1.1.2 [Deliverable]
â”œâ”€â”€ 1.2 Phase 2: [Name]
â”‚   â”œâ”€â”€ 1.2.1 [Deliverable]
â”‚   â””â”€â”€ 1.2.2 [Deliverable]
â””â”€â”€ 1.3 Phase 3: [Name]
    â”œâ”€â”€ 1.3.1 [Deliverable]
    â””â”€â”€ 1.3.2 [Deliverable]
```

---

## 3. Milestone Schedule

| # | Milestone | Target Date | Status | Owner |
|---|-----------|-------------|--------|-------|
| M1 | Project Kickoff | [Date] | ðŸŸ¢ | [Name] |
| M2 | Requirements Complete | [Date] | ðŸŸ¢ | [Name] |
| M3 | Design Approved | [Date] | ðŸŸ¡ | [Name] |
| M4 | Development Complete | [Date] | â³ | [Name] |
| M5 | Testing Complete | [Date] | â³ | [Name] |
| M6 | Go-Live | [Date] | â³ | [Name] |

---

## 4. Risk Register

| ID | Risk | Probability | Impact | Score | Mitigation | Owner | Status |
|----|------|-------------|--------|-------|------------|-------|--------|
| R1 | [Risk description] | High | High | 25 | [Strategy] | [Name] | ðŸŸ¢ |
| R2 | [Risk description] | Medium | High | 15 | [Strategy] | [Name] | ðŸŸ¡ |
| R3 | [Risk description] | Low | Medium | 6 | [Strategy] | [Name] | ðŸŸ¢ |

### Risk Scoring Matrix

|  | **Low Impact (1-2)** | **Medium Impact (3)** | **High Impact (4-5)** |
|--|----------------------|-----------------------|-----------------------|
| **High Probability (4-5)** | 4-10 ðŸŸ¡ | 12-15 ðŸŸ¡ | 20-25 ðŸ”´ |
| **Medium Probability (3)** | 3-6 ðŸŸ¢ | 9 ðŸŸ¡ | 12-15 ðŸŸ¡ |
| **Low Probability (1-2)** | 1-4 ðŸŸ¢ | 3-6 ðŸŸ¢ | 4-10 ðŸŸ¡ |

---

## 5. Resource Allocation

| Resource | Role | Allocation | Phase | Cost/Period |
|----------|------|------------|-------|-------------|
| [Name] | Project Manager | 100% | All | R [X] |
| [Name] | Developer | 50% | Phase 2-3 | R [X] |
| [Name] | Analyst | 25% | Phase 1-2 | R [X] |

---

## 6. Status Report Template

```markdown
# Project Status Report: [Project Name]

**Reporting Period:** [Date] to [Date]
**Report Date:** [DD Month YYYY]
**Project Manager:** [Name]

---

## Overall Status: ðŸŸ¢ On Track

| Area | Status | Trend |
|------|--------|-------|
| Schedule | ðŸŸ¢ | â†’ |
| Budget | ðŸŸ¡ | â†“ |
| Scope | ðŸŸ¢ | â†’ |
| Resources | ðŸŸ¢ | â†’ |

---

## Accomplishments This Period
- [Achievement 1]
- [Achievement 2]

## Planned Next Period
- [Task 1]
- [Task 2]

## Issues & Risks
| Type | Description | Impact | Action | Owner |
|------|-------------|--------|--------|-------|
| Issue | [Description] | [Impact] | [Action] | [Name] |
| Risk | [Description] | [Impact] | [Action] | [Name] |

## Decisions Needed
- [Decision 1] - Required by [Date]
```

---

## Status Indicators

| Icon | Status | Meaning |
|------|--------|---------|
| ðŸŸ¢ | On Track | Proceeding as planned |
| ðŸŸ¡ | At Risk | May miss target without intervention |
| ðŸ”´ | Blocked/Overdue | Action required immediately |
| â³ | Pending | Not yet started |
| âœ… | Complete | Finished |

---

## Dependency Types

| Type | Symbol | Description |
|------|--------|-------------|
| Finish-to-Start (FS) | â†’ | Task B starts after Task A finishes |
| Start-to-Start (SS) | â‡‰ | Task B starts when Task A starts |
| Finish-to-Finish (FF) | â‡‡ | Task B finishes when Task A finishes |
| Start-to-Finish (SF) | â† | Task B finishes when Task A starts |

---

## Mermaid Gantt Template

```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD

    section Phase 1
    Requirements     :a1, 2026-01-01, 2w
    Design          :a2, after a1, 2w

    section Phase 2
    Development     :b1, after a2, 4w
    Testing         :b2, after b1, 2w

    section Phase 3
    Deployment      :c1, after b2, 1w
    Go-Live         :milestone, after c1, 0d
```

---

## Rules

```
+define-scope-clearly        # Explicit in/out scope
+identify-dependencies       # Map all task dependencies
+include-risk-register       # Proactive risk management
+assign-owners               # Every item has an owner
+set-measurable-objectives   # SMART objectives
-create-plans-without-milestones  # Must have milestones
-ignore-risks                # Always consider risks
-skip-status-reporting       # Regular updates required
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 001 Executive Strategic Advisor | Strategic initiative planning |
| 009 Software Architect | Technical project planning |
| 010 The Architect | Cross-functional project coordination |

---

*Frans Skill LAR-011 | Project Planning v1.0*
