# Frans Skill: Risk Assessment

## Metadata

| Field | Value |
|-------|-------|
| **Name** | risk-assessment |
| **Version** | 1.0 |
| **ID** | LAR-020 |
| **Triggers** | "assess risk", "risk analysis", "what could go wrong", "identify risks" |
| **Always Active** | NO (on-demand) |
| **Google Doc Name** | `SKILL_RiskAssessment` |

---

## Purpose

Systematically identify, analyse, and prioritise risks. Provide actionable mitigation strategies with clear ownership and monitoring triggers.

---

## Risk Assessment Framework

```
â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
â”‚                    RISK ASSESSMENT PROCESS                       â”‚
â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
â”‚                                                                  â”‚
â”‚  1. IDENTIFY â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¶â”‚
â”‚     What could go wrong?                                         â”‚
â”‚     â€¢ Brainstorm risks                                          â”‚
â”‚     â€¢ Review categories                                          â”‚
â”‚     â€¢ Check historical data                                      â”‚
â”‚                                                                  â”‚
â”‚  2. ANALYSE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¶â”‚
â”‚     How bad and how likely?                                      â”‚
â”‚     â€¢ Assess probability                                         â”‚
â”‚     â€¢ Assess impact                                              â”‚
â”‚     â€¢ Calculate risk score                                       â”‚
â”‚                                                                  â”‚
â”‚  3. PRIORITISE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¶â”‚
â”‚     What matters most?                                           â”‚
â”‚     â€¢ Rank by risk score                                        â”‚
â”‚     â€¢ Identify critical risks                                    â”‚
â”‚     â€¢ Focus resources                                            â”‚
â”‚                                                                  â”‚
â”‚  4. MITIGATE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¶â”‚
â”‚     What do we do about it?                                      â”‚
â”‚     â€¢ Define response strategy                                   â”‚
â”‚     â€¢ Assign owners                                              â”‚
â”‚     â€¢ Set triggers                                               â”‚
â”‚                                                                  â”‚
â”‚  5. MONITOR â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â–¶â”‚
â”‚     Is it working?                                               â”‚
â”‚     â€¢ Track indicators                                           â”‚
â”‚     â€¢ Review regularly                                           â”‚
â”‚     â€¢ Update assessment                                          â”‚
â”‚                                                                  â”‚
â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```

---

## Risk Categories

### Business Risk Categories

| Category | Examples |
|----------|----------|
| **Strategic** | Market shifts, competitive threats, technology disruption |
| **Operational** | Process failures, capacity constraints, supply chain |
| **Financial** | Cash flow, currency, credit, fraud |
| **Compliance** | Regulatory changes, legal exposure, data privacy |
| **Reputational** | Brand damage, customer trust, media coverage |
| **Technology** | System failures, cyber security, data loss |
| **People** | Key person dependency, skills gaps, retention |
| **External** | Economic conditions, political changes, natural disasters |

### Project Risk Categories

| Category | Examples |
|----------|----------|
| **Scope** | Requirements creep, unclear specifications |
| **Schedule** | Delays, dependencies, unrealistic timelines |
| **Resource** | Budget overruns, skill shortages, availability |
| **Technical** | Complexity, integration issues, performance |
| **Stakeholder** | Resistance, communication gaps, changing priorities |
| **Vendor** | Third-party delays, quality issues, contract disputes |

---

## Risk Scoring Matrix

### Probability Scale

| Level | Score | Definition | Likelihood |
|-------|-------|------------|------------|
| **Rare** | 1 | Unlikely to occur | <10% |
| **Unlikely** | 2 | Could occur but not expected | 10-25% |
| **Possible** | 3 | Might occur | 25-50% |
| **Likely** | 4 | Probably will occur | 50-75% |
| **Almost Certain** | 5 | Expected to occur | >75% |

### Impact Scale

| Level | Score | Definition | Business Impact |
|-------|-------|------------|-----------------|
| **Negligible** | 1 | Minimal impact | <R10K, minor delay |
| **Minor** | 2 | Some impact, manageable | R10-50K, days delay |
| **Moderate** | 3 | Significant impact | R50-250K, weeks delay |
| **Major** | 4 | Serious impact | R250K-1M, months delay |
| **Severe** | 5 | Critical impact | >R1M, project failure |

### Risk Score Matrix

```
                         IMPACT
              1    2    3    4    5
           â”Œâ”€â”€â”€â”€â”¬â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”¬â”€â”€â”€â”€â”
         5 â”‚ 5  â”‚ 10 â”‚ 15 â”‚ 20 â”‚ 25 â”‚  PROBABILITY
           â”œâ”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¤
         4 â”‚ 4  â”‚ 8  â”‚ 12 â”‚ 16 â”‚ 20 â”‚
           â”œâ”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¤
         3 â”‚ 3  â”‚ 6  â”‚ 9  â”‚ 12 â”‚ 15 â”‚
           â”œâ”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¤
         2 â”‚ 2  â”‚ 4  â”‚ 6  â”‚ 8  â”‚ 10 â”‚
           â”œâ”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¼â”€â”€â”€â”€â”¤
         1 â”‚ 1  â”‚ 2  â”‚ 3  â”‚ 4  â”‚ 5  â”‚
           â””â”€â”€â”€â”€â”´â”€â”€â”€â”€â”´â”€â”€â”€â”€â”´â”€â”€â”€â”€â”´â”€â”€â”€â”€â”˜

Risk Score = Probability Ã— Impact

ðŸ”´ Critical (20-25): Immediate action required
ðŸŸ  High (12-19): Priority attention needed
ðŸŸ¡ Medium (6-11): Monitor and plan mitigation
ðŸŸ¢ Low (1-5): Accept or monitor
```

---

## Risk Register Template

```markdown
# Risk Register: [Project/Initiative]

**Last Updated:** [Date]
**Owner:** [Name]
**Review Frequency:** [Weekly/Monthly]

## Summary Dashboard

| Risk Level | Count | Trend |
|------------|-------|-------|
| ðŸ”´ Critical | [N] | â†‘â†“â†’ |
| ðŸŸ  High | [N] | â†‘â†“â†’ |
| ðŸŸ¡ Medium | [N] | â†‘â†“â†’ |
| ðŸŸ¢ Low | [N] | â†‘â†“â†’ |

## Active Risks

### RISK-001: [Risk Title]

| Field | Value |
|-------|-------|
| **Category** | [Category] |
| **Description** | [What could happen] |
| **Probability** | [1-5] |
| **Impact** | [1-5] |
| **Risk Score** | [PÃ—I] |
| **Risk Level** | ðŸ”´ðŸŸ ðŸŸ¡ðŸŸ¢ |
| **Trigger** | [What indicates risk is materialising] |
| **Response Strategy** | [Avoid/Mitigate/Transfer/Accept] |
| **Mitigation Actions** | [Specific actions] |
| **Owner** | [Name] |
| **Status** | [Open/Mitigating/Closed] |
| **Residual Risk** | [Score after mitigation] |

---

[Repeat for each risk]
```

---

## Risk Response Strategies

### The 4 T's of Risk Response

| Strategy | When to Use | Example |
|----------|-------------|---------|
| **Terminate** (Avoid) | Risk unacceptable, can change plans | Don't enter risky market |
| **Treat** (Mitigate) | Can reduce probability or impact | Add testing, backup systems |
| **Transfer** | Can shift risk to third party | Insurance, outsourcing |
| **Tolerate** (Accept) | Risk acceptable or unavoidable | Document and monitor |

### Mitigation Action Template

```markdown
## Mitigation: [Risk ID]

**Risk:** [Brief description]

**Strategy:** [Terminate/Treat/Transfer/Tolerate]

**Actions:**
| Action | Owner | Deadline | Status |
|--------|-------|----------|--------|
| [Action 1] | [Name] | [Date] | â¬œ |
| [Action 2] | [Name] | [Date] | â¬œ |

**Expected Outcome:**
- Probability: [Before] â†’ [After]
- Impact: [Before] â†’ [After]
- Residual Risk Score: [New score]

**Monitoring:**
- **Indicator:** [What to watch]
- **Frequency:** [How often]
- **Escalation Trigger:** [When to escalate]
```

---

## Quick Risk Assessment

For rapid risk identification:

```markdown
## Quick Risk Assessment: [Topic]

### Top 5 Risks

| # | Risk | P | I | Score | Mitigation |
|---|------|---|---|-------|------------|
| 1 | [Risk] | [1-5] | [1-5] | [PÃ—I] | [One-line action] |
| 2 | [Risk] | [1-5] | [1-5] | [PÃ—I] | [One-line action] |
| 3 | [Risk] | [1-5] | [1-5] | [PÃ—I] | [One-line action] |
| 4 | [Risk] | [1-5] | [1-5] | [PÃ—I] | [One-line action] |
| 5 | [Risk] | [1-5] | [1-5] | [PÃ—I] | [One-line action] |

### Critical Risk Summary
**Highest risk:** [Risk #] - Requires [action] by [owner]

### Recommendation
[Go/No-Go/Proceed with caution]
```

---

## Pre-Mortem Technique

For proactive risk identification:

```markdown
## Pre-Mortem Analysis: [Initiative]

**Scenario:** It's [timeframe] from now. This has failed spectacularly.

### Brainstorm: What Went Wrong?

1. [Failure mode 1]
2. [Failure mode 2]
3. [Failure mode 3]
4. [Failure mode 4]
5. [Failure mode 5]

### Most Likely Culprits
| Failure Mode | Likelihood | Preventability | Priority |
|--------------|------------|----------------|----------|
| [Mode 1] | [H/M/L] | [H/M/L] | [1-5] |
| [Mode 2] | [H/M/L] | [H/M/L] | [1-5] |

### Preventive Actions
| Risk | Prevention | Owner | Timeline |
|------|------------|-------|----------|
| [Risk 1] | [Action] | [Name] | [When] |
| [Risk 2] | [Action] | [Name] | [When] |
```

---

## Stop Hook Integration

```xml
<stop-hook id="HOOK-RSK-001" type="SOFT">
  <trigger>Critical risk identified (score 20+)</trigger>
  <validation>
    <check>Risk clearly documented</check>
    <check>Mitigation strategy defined</check>
    <check>Owner assigned</check>
  </validation>
  <on-pass>Escalate to user attention</on-pass>
  <on-fail>Complete risk documentation first</on-fail>
</stop-hook>

<stop-hook id="HOOK-RSK-002" type="GATE">
  <trigger>Proceeding with high-risk decision</trigger>
  <validation>
    <check>Risks explicitly acknowledged</check>
    <check>User accepts residual risk</check>
  </validation>
  <on-pass>Proceed with documentation</on-pass>
  <on-fail>Present risks for acceptance</on-fail>
</stop-hook>
```

---

## Anti-Patterns (Avoid These)

| âŒ Don't | âœ… Do Instead |
|---------|--------------|
| Ignore risks hoping they go away | Document and track all risks |
| Rate all risks as high priority | Use objective scoring |
| Identify risks without owners | Every risk has an owner |
| One-time assessment | Regular review and updates |
| Mitigation without verification | Track mitigation effectiveness |
| Group-think in risk sessions | Encourage diverse perspectives |
| Analysis paralysis | Focus on top risks first |

---

## Rules

```
+use-consistent-scoring        # Same scale across assessments
+assign-risk-owners            # Accountability for each risk
+define-triggers               # Know when risk is materialising
+review-regularly              # Risks change over time
+document-residual-risk        # What remains after mitigation
-ignore-low-probability-high-impact  # Black swans matter
-accept-risks-without-approval # Explicit risk acceptance
-mitigate-without-measuring    # Verify mitigation works
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 001 Executive Strategic Advisor | Strategic risk assessment |
| 008 Legal Expert | Legal/compliance risk analysis |
| 009 Software Architect | Technical risk assessment |
| 011 Project Planning | Project risk management |

---

*Frans Skill LAR-020 | Risk Assessment v1.0*
