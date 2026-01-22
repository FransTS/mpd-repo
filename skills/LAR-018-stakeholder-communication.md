# Frans Skill: Stakeholder Communication

## Metadata

| Field | Value |
|-------|-------|
| **Name** | stakeholder-communication |
| **Version** | 1.0 |
| **ID** | LAR-018 |
| **Triggers** | "stakeholder update", "communicate to", "executive summary", "tailor message" |
| **Always Active** | NO (on-demand) |
| **Google Doc Name** | `SKILL_StakeholderCommunication` |

---

## Purpose

Craft targeted communications for different stakeholder groups. Adapt tone, detail level, and framing based on audience needs, concerns, and decision-making authority.

---

## Stakeholder Mapping

### RACI-Based Stakeholder Matrix

| Stakeholder Type | Information Need | Communication Style | Frequency |
|------------------|------------------|---------------------|-----------|
| **Executive Sponsor** | Strategic impact, ROI, risks | High-level summary, decisions needed | Weekly/milestone |
| **Project Owner** | Progress, blockers, decisions | Detailed status, action items | Daily/weekly |
| **Technical Lead** | Architecture, implementation details | Technical depth, specifications | As needed |
| **End Users** | How it affects them, training | Simple, benefit-focused | At launch/changes |
| **External Partners** | Contractual, timeline, dependencies | Formal, documented | Per agreement |
| **Regulators** | Compliance, audit trail | Precise, comprehensive | Per requirements |

### Stakeholder Analysis Template

```markdown
## Stakeholder: [Name/Group]

**Role:** [Their position/function]
**Interest Level:** [High | Medium | Low]
**Influence Level:** [High | Medium | Low]
**Primary Concerns:** [What they care about most]
**Communication Preference:** [Email | Meeting | Report | Dashboard]
**Key Questions They'll Ask:**
1. [Question 1]
2. [Question 2]
3. [Question 3]
```

---

## Communication Frameworks

### 1. Pyramid Principle (Barbara Minto)

**Structure:** Lead with conclusion, then support.

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚           MAIN MESSAGE                   â”‚
â”‚    (Answer/Recommendation first)         â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
                  â”‚
    â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
    â”‚             â”‚             â”‚
    â–¼             â–¼             â–¼
â”Œâ”€â”€â”€â”€â”€â”€â”€â”   â”Œâ”€â”€â”€â”€â”€â”€â”€â”   â”Œâ”€â”€â”€â”€â”€â”€â”€â”
â”‚Key     â”‚   â”‚Key     â”‚   â”‚Key     â”‚
â”‚Point 1 â”‚   â”‚Point 2 â”‚   â”‚Point 3 â”‚
â””â”€â”€â”€â”¬â”€â”€â”€â”˜   â””â”€â”€â”€â”¬â”€â”€â”€â”˜   â””â”€â”€â”€â”¬â”€â”€â”€â”˜
    â”‚           â”‚           â”‚
    â–¼           â–¼           â–¼
[Supporting] [Supporting] [Supporting]
[Details]   [Details]    [Details]
```

### 2. SCQA Framework (Situation-Complication-Question-Answer)

```markdown
**Situation:** [Current state - what everyone agrees on]

**Complication:** [The problem or change that creates tension]

**Question:** [The question this raises - implicit or explicit]

**Answer:** [Your recommendation/solution]
```

### 3. BLUF (Bottom Line Up Front)

For executive audiences:

```markdown
**BOTTOM LINE:** [One sentence with the key message/ask]

**Background:** [2-3 sentences of context]

**Details:** [Supporting information if they want to dig deeper]

**Action Required:** [Specific ask with deadline]
```

---

## Audience-Specific Templates

### Executive Update

```markdown
## [Project/Topic] Update - [Date]

**Status:** ðŸŸ¢ On Track | ðŸŸ¡ At Risk | ðŸ”´ Blocked

**Executive Summary:**
[2-3 sentences: Where we are, key achievement, main risk/blocker]

**Key Metrics:**
| Metric | Target | Actual | Trend |
|--------|--------|--------|-------|
| [Metric 1] | [X] | [Y] | â†‘â†“â†’ |
| [Metric 2] | [X] | [Y] | â†‘â†“â†’ |

**Decisions Needed:**
1. [Decision] - [Deadline]

**Risks:**
- [Risk]: [Mitigation in progress]

**Next Milestone:** [What] - [When]
```

### Technical Stakeholder Update

```markdown
## Technical Update: [Component/System]

**Summary:** [What changed and why]

**Technical Details:**
- Architecture: [Changes]
- Dependencies: [New/modified]
- Performance: [Metrics]

**Code/Config Changes:**
```
[Relevant snippets or references]
```

**Testing Status:**
- Unit tests: [Pass/Fail count]
- Integration: [Status]
- Performance: [Benchmarks]

**Known Issues:**
1. [Issue] - [Workaround/ETA]

**Documentation:**
- [Link to technical docs]
```

### End User Communication

```markdown
## [Feature/Change] - What's New for You

**In Brief:** [One sentence benefit statement]

**What's Changing:**
- âœ… [Change 1] - [Benefit to user]
- âœ… [Change 2] - [Benefit to user]

**What You Need to Do:**
1. [Simple action step]
2. [Simple action step]

**When:** [Date/Time with timezone]

**Questions?** Contact [support channel]
```

### Board/Investor Update

```markdown
## [Company/Project] - [Period] Update

**Headline:** [One compelling sentence]

### Key Highlights
- [Achievement 1 with metric]
- [Achievement 2 with metric]
- [Achievement 3 with metric]

### Financial Summary
| Metric | This Period | Last Period | YoY |
|--------|-------------|-------------|-----|
| Revenue | R[X]M | R[Y]M | +Z% |
| [Other] | | | |

### Strategic Progress
[2-3 paragraphs on strategy execution]

### Challenges & Mitigation
[Honest assessment with action plan]

### Outlook
[Forward-looking statements with appropriate caveats]

### Ask
[If any - funding, decisions, introductions]
```

---

## Tone Calibration

| Audience | Tone | Vocabulary | Detail Level |
|----------|------|------------|--------------|
| C-Suite | Confident, strategic | Business impact, ROI | Summary only |
| Board | Formal, balanced | Governance, fiduciary | High-level + risks |
| Technical | Direct, precise | Technical terms OK | Deep detail |
| Operations | Practical, actionable | Process-focused | Step-by-step |
| Users | Friendly, clear | No jargon | Benefit-focused |
| Legal/Compliance | Precise, qualified | Formal language | Comprehensive |
| Media/Public | Simple, quotable | Plain language | Sound bites |

---

## Difficult Conversations

### Delivering Bad News

```markdown
**Framework: NEWS**

**N**ature of the issue: [State the problem clearly]
**E**mpathy: [Acknowledge impact]
**W**hat we're doing: [Actions being taken]
**S**upport: [How you'll help / next steps]
```

### Escalation Communication

```markdown
## Escalation: [Issue Title]

**Severity:** [Critical | High | Medium]
**Impact:** [Who/what is affected]

**Issue:** [Clear description]

**Root Cause:** [Known | Under Investigation]

**Actions Taken:**
1. [Action] - [Time]
2. [Action] - [Time]

**Decision Needed:** [What you need from escalation recipient]

**Deadline:** [When decision is needed]
```

---

## Communication Checklist

Before sending any stakeholder communication:

- [ ] **Audience:** Do I know who's reading this and what they care about?
- [ ] **Purpose:** Is my ask/message clear in the first paragraph?
- [ ] **Tone:** Is it appropriate for this audience?
- [ ] **Length:** Is it as short as possible while being complete?
- [ ] **Action:** Is it clear what (if anything) I need from them?
- [ ] **Timing:** Is this the right moment to send this?
- [ ] **Channel:** Is this the right medium (email, meeting, doc)?
- [ ] **Follow-up:** Have I specified next steps?

---

## Stop Hook Integration

```xml
<stop-hook id="HOOK-STK-001" type="SOFT">
  <trigger>Communication to executive stakeholder</trigger>
  <validation>
    <check>BLUF/summary provided</check>
    <check>Appropriate detail level</check>
    <check>Action items clear</check>
  </validation>
  <on-pass>Deliver communication</on-pass>
  <on-fail>Restructure for audience</on-fail>
</stop-hook>

<stop-hook id="HOOK-STK-002" type="GATE">
  <trigger>External stakeholder communication</trigger>
  <validation>
    <check>User approval obtained</check>
    <check>Sensitive info reviewed</check>
  </validation>
  <on-pass>Send with approval</on-pass>
  <on-fail>Present draft for review</on-fail>
</stop-hook>
```

---

## Anti-Patterns (Avoid These)

| âŒ Don't | âœ… Do Instead |
|---------|--------------|
| Bury the lead | Start with main message (BLUF) |
| One-size-fits-all | Tailor to each audience |
| Information overload | Right level of detail for audience |
| Jargon to non-technical | Plain language, define terms |
| Vague asks | Specific action with deadline |
| Surprise escalations | Early warning, no ambush |
| Defensive tone on bad news | Own it, focus on solutions |

---

## Rules

```
+lead-with-conclusion          # BLUF for busy stakeholders
+tailor-to-audience            # Different message for different groups
+specify-action-required       # Clear asks with deadlines
+acknowledge-concerns          # Address what they care about
+provide-appropriate-detail    # Not too much, not too little
-send-without-purpose          # Every communication has a goal
-use-jargon-inappropriately    # Match vocabulary to audience
-hide-bad-news                 # Transparent, with solutions
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 001 Executive Strategic Advisor | Board/C-suite communications |
| 002 Executive Assistant | Scheduling, coordination messages |
| 005 Document Creator | Formal reports and presentations |
| 007 Marketing Advisor | External/public communications |

---

*Frans Skill LAR-018 | Stakeholder Communication v1.0*
