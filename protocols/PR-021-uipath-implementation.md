# PR-021: UiPath Implementation Protocol

## Metadata
| Field | Value |
|-------|-------|
| ID | PR-021 |
| Version | 1.0 |
| Updated | 21 January 2026 |
| Primary Persona | 020 (UiPath Specialist) |
| Triggers | "UiPath implementation", "automation assessment", "RPA roadmap" |

---

## Purpose
Structured approach to UiPath implementation planning, from initial assessment through deployment and scaling.

---

## Phase 1: Discovery & Assessment

### 1.1 Current State Analysis
- Existing automation tools/platforms
- IT infrastructure (cloud readiness, security policies)
- Development capabilities (internal vs partner)
- Budget constraints and approval processes

### 1.2 Process Identification
| Criteria | Weight | Notes |
|----------|--------|-------|
| Volume (transactions/month) | High | ROI driver |
| Stability (rule-based vs exceptions) | High | Automation suitability |
| Systems involved | Medium | Integration complexity |
| Business impact | High | Prioritisation |
| Current pain points | Medium | Stakeholder buy-in |

### 1.3 Output
- Process candidates ranked by automation potential
- High-level architecture recommendation
- Preliminary licensing estimate

---

## Phase 2: Solution Design

### 2.1 Architecture Decisions
```
Decision Tree:
├── Data Sovereignty Required?
│   ├── Yes → On-Premises / Automation Suite
│   └── No → Automation Cloud (recommended)
├── Scale (robots needed)?
│   ├── <10 → Pro tier
│   └── 10+ → Enterprise tier
├── AI/ML Required?
│   ├── Yes → Include AI Center + AI Units
│   └── No → Standard platform
└── Human-in-the-Loop?
    ├── Yes → Include Action Center
    └── No → Standard workflow
```

### 2.2 Licensing Model Selection
1. Estimate robot counts by type
2. Calculate AI Unit consumption (if applicable)
3. Compare Named vs Concurrent for Attended
4. Factor in Non-Production for Dev/Test
5. Request UiPath quote for validation

### 2.3 Output
- Detailed architecture diagram
- Licensing bill of materials
- Infrastructure requirements
- Security/compliance checklist

---

## Phase 3: Pilot Implementation

### 3.1 Pilot Scope
- 1-3 processes (varying complexity)
- Limited user base
- Controlled environment

### 3.2 Success Criteria
| Metric | Target |
|--------|--------|
| Process success rate | >95% |
| User adoption | Positive feedback |
| Infrastructure stability | No critical issues |
| Time savings validated | As projected ±20% |

### 3.3 Output
- Pilot results report
- Lessons learned
- Refined estimates for scale

---

## Phase 4: Production Deployment

### 4.1 Pre-Production Checklist
- [ ] Orchestrator configured (folders, permissions, assets)
- [ ] Robot machines provisioned and secured
- [ ] Credential stores integrated
- [ ] Monitoring/alerting configured
- [ ] Backup/DR procedures documented
- [ ] Support procedures established

### 4.2 Go-Live
1. Deploy packages to Production
2. Configure schedules/triggers
3. Monitor initial executions closely
4. Document any issues and resolutions

### 4.3 Output
- Production runbook
- Incident response procedures
- Performance baseline

---

## Phase 5: Scale & Optimise

### 5.1 CoE Establishment
- Governance model (who can build, deploy, approve)
- Development standards (naming, error handling, logging)
- Reusable component library
- Training programme

### 5.2 Continuous Improvement
- Regular license utilisation review
- Process performance optimisation
- Pipeline management for new automations
- Periodic architecture review

### 5.3 Output
- CoE charter
- Automation backlog
- Quarterly business review template

---

## Response Protocol (for Persona 020)

When answering UiPath questions:

### Technical Questions
1. Identify the specific component/feature
2. Provide factual technical details
3. Include version considerations if relevant
4. Reference official documentation concepts
5. Flag any assumptions clearly

### Licensing Questions
1. Clarify the scenario (scale, use case, constraints)
2. Explain applicable licensing models
3. Provide general guidance (not specific pricing)
4. **Always recommend verification with UiPath sales**
5. Highlight potential gotchas

### Architecture Questions
1. Understand requirements (scale, security, budget)
2. Present options with trade-offs
3. Recommend approach with rationale
4. Include infrastructure considerations
5. Suggest validation steps

---

## Red Flags to Escalate

- Licensing questions requiring specific pricing
- Compliance/regulatory requirements (HIPAA, SOX, etc.)
- Complex multi-region deployments
- Legacy UiPath version support questions
- Contract/SLA disputes

**Action:** Recommend engaging UiPath sales, support, or certified implementation partner.

---

## Quick Assessment Questions

For any UiPath engagement, gather:

1. **Scale:** How many users? How many processes? Expected transaction volume?
2. **Infrastructure:** Cloud-ready? On-prem requirements? Security constraints?
3. **Timeline:** Pilot date? Production date? Urgency drivers?
4. **Budget:** Approved? Estimated range? CapEx vs OpEx preference?
5. **Resources:** Internal team capabilities? Partner involvement?

---

*PR-021 UiPath Implementation Protocol v1.0 | Frans MPD*
