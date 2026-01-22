# Frans Skill: Contract Analysis

## Metadata

| Field | Value |
|-------|-------|
| **Name** | contract-analysis |
| **Version** | 1.0 |
| **ID** | LAR-002 |
| **Triggers** | "review contract", "legal review", "risk assessment" |
| **Google Doc Name** | `SKILL_ContractAnalysis` |

---

## MANDATORY DISCLAIMER

> **âš ï¸ IMPORTANT:** This analysis constitutes legal information only, NOT legal advice. For matters requiring legal decisions, consult a qualified attorney in your jurisdiction.

This disclaimer MUST be included in every contract analysis output.

---

## Purpose

Provide comprehensive contract review with risk identification, gap analysis, and negotiation guidance.

---

## Risk Levels

| Level | Icon | Meaning |
|-------|------|---------|
| **HIGH** | ðŸ”´ | Immediate commercial/legal exposure |
| **MEDIUM** | ðŸŸ¡ | Potential issues under conditions |
| **LOW** | ðŸŸ¢ | Minor concerns, standard provisions |

---

## Common Risk Areas

### High Priority Review
- Unlimited liability
- Broad indemnification
- IP assignment issues
- One-sided termination rights
- Auto-renewal traps
- Missing limitation of liability

### Additional Areas
- Data protection and privacy
- Confidentiality scope
- Force majeure provisions
- Warranty limitations
- Jurisdiction and governing law
- Dispute resolution mechanisms

---

## Analysis Output Structure

### 1. Contract Overview
```
Type:           [Contract Type]
Parties:        [Party A] and [Party B]
Effective Date: [Date]
Term:           [Duration]
Value:          [If applicable]
Governing Law:  [Jurisdiction]
```

### 2. Risk Register

| Clause | Section | Risk Level | Issue | Recommendation |
|--------|---------|------------|-------|----------------|
| Liability | 8.1 | ðŸ”´ HIGH | Unlimited liability | Cap at contract value |
| Indemnity | 9.2 | ðŸŸ¡ MEDIUM | Broad scope | Limit to direct damages |
| Term | 3.1 | ðŸŸ¢ LOW | Standard provision | Acceptable |

### 3. Missing Provisions Check

```
â˜ Limitation of Liability
â˜ Data Protection / POPIA compliance
â˜ Force Majeure
â˜ IP Ownership clarity
â˜ Audit rights
â˜ Exit/Transition assistance
â˜ SLA definitions
â˜ Change control process
```

### 4. Negotiation Strategy

| Priority | Item | Current | Target | Rationale |
|----------|------|---------|--------|-----------|
| **MUST HAVE** | Liability cap | Unlimited | 12 months fees | Unacceptable exposure |
| **SHOULD HAVE** | IP ownership | Silent | Explicit client ownership | Protect deliverables |
| **NICE TO HAVE** | Warranty | 30 days | 90 days | Industry standard |

---

## Rules

```
+always-include-disclaimer    # Legal disclaimer mandatory
+identify-all-risk-areas      # Comprehensive risk identification
+cite-clause-references       # Reference specific sections
+provide-alternatives         # Suggest improved language
-provide-legal-advice         # Information only, not advice
-fabricate-legal-precedents   # No invented case law
-guarantee-outcomes           # No promises about legal results
```

---

## Contract Types Supported

- Service Agreements
- Software Licenses (SaaS, On-premise)
- Employment Contracts
- NDAs / Confidentiality Agreements
- Partnership Agreements
- Vendor/Supplier Contracts
- Lease Agreements
- Consultancy Agreements

---

## South African Context

When reviewing contracts under South African law, consider:

- **POPIA** - Protection of Personal Information Act compliance
- **CPA** - Consumer Protection Act implications
- **BCEA** - Basic Conditions of Employment Act (employment)
- **NCA** - National Credit Act (if credit involved)
- **Electronic Communications Act** - For electronic agreements

---

## Output Template

```markdown
# Contract Analysis Report

**Date:** [Date]
**Contract:** [Contract Name/Reference]
**Prepared for:** [Client Name]

---

## âš ï¸ Disclaimer
This analysis constitutes legal information only, NOT legal advice.
For matters requiring legal decisions, consult a qualified attorney.

---

## 1. Contract Overview
[Overview details]

## 2. Executive Summary
[Key findings and overall risk assessment]

## 3. Risk Register
[Detailed risk table]

## 4. Missing Provisions
[Checklist of gaps]

## 5. Negotiation Strategy
[Prioritised negotiation points]

## 6. Recommendations
[Actionable next steps]

---

*Analysis prepared using Frans Contract Analysis Skill v1.0*
```

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 008 Legal Expert | Primary user - full contract review |
| 001 Executive Strategic Advisor | Strategic implications of terms |
| 004 Sales Enablement | Commercial contract negotiation |

---

*Frans Skill LAR-002 | Contract Analysis v1.0*
