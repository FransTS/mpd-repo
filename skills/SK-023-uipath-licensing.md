# SK-023: UiPath Licensing & Deployment

## Metadata
| Field | Value |
|-------|-------|
| ID | SK-023 |
| Version | 1.0 |
| Updated | 21 January 2026 |
| Primary Persona | 020 (UiPath Specialist) |
| Triggers | "UiPath licensing", "robot licenses", "UiPath pricing", "license model" |

---

## Purpose
Comprehensive understanding of UiPath licensing models, SKUs, deployment options, and cost optimisation strategies.

---

## ⚠️ Important Disclaimer
Licensing details and pricing change frequently. This skill provides general guidance based on publicly available information. **Always verify current licensing terms with UiPath sales or official documentation** before making purchasing decisions.

---

## Licensing Models Overview

### Robot Licensing

| License Type | Description | Best For |
|--------------|-------------|----------|
| **Attended - Named User** | 1 license = 1 specific user | Consistent user base |
| **Attended - Concurrent** | Pool of licenses, any user | Shift workers, shared desktops |
| **Unattended** | 1 license = 1 robot runtime | Background processing |
| **Non-Production** | Dev/Test environments only | Development teams |
| **Automation Cloud Robot - VM** | UiPath-hosted unattended | Serverless, pay-per-use |
| **Automation Cloud Robot - Serverless** | API-triggered, no VM | Lightweight, event-driven |

### Orchestrator Licensing

| Tier | Robots Supported | Features |
|------|------------------|----------|
| **Free** | Up to 2 Attended | Basic orchestration |
| **Pro** | Varies | Full features, limited scale |
| **Enterprise** | Unlimited | HA, multi-tenancy, full suite |

### Studio Licensing

| Type | Included With | Notes |
|------|---------------|-------|
| **Studio** | Attended/Unattended licenses | Full development capability |
| **StudioX** | Some Attended licenses | Business user development |
| **Studio Web** | Automation Cloud | Browser-based, limited |

---

## Consumption-Based Licensing

### Robot Units (RU)
- Newer consumption model
- Pool of units allocated monthly
- Different robot types consume different RU amounts
- Allows flexibility between Attended/Unattended

### AI Units
- Consumed by AI Center, Document Understanding, Communications Mining
- Pre-purchased or pay-as-you-go
- Usage tracked per API call/page processed

### Action Center
- Typically included with Orchestrator Enterprise
- May have user-based licensing for heavy usage

---

## Licensing Tiers (Typical Structure)

### Free Tier / Community
- **Studio Community:** Free for individuals, small companies (<$1M revenue)
- **Orchestrator Community:** Limited to 2 robots
- **Limitations:** No production use for enterprises, limited support

### Pro Tier
- Entry-level commercial
- Fixed robot counts
- Standard support

### Enterprise Tier
- Volume licensing
- Custom terms
- Premium support options
- Full feature access

---

## Common Licensing Scenarios

### Scenario 1: Small Team (5 users, occasional automation)
**Recommendation:**
- 5 Attended Named User licenses
- Orchestrator Cloud (included)
- Estimated: Entry Pro tier

### Scenario 2: Shared Services Centre (20 processes, high volume)
**Recommendation:**
- 2-4 Unattended robots (based on volume)
- Orchestrator Enterprise
- Consider Robot Units for flexibility
- Optional: Insights for reporting

### Scenario 3: Enterprise CoE (100+ automations, multiple departments)
**Recommendation:**
- Enterprise Agreement
- Mix of Attended (Named/Concurrent) + Unattended
- Multi-tenant Orchestrator
- AI Units for Document Understanding
- Insights, Action Center, Test Manager

---

## Cost Optimisation Strategies

### Right-Sizing Robots
1. **Analyse process runtime** - Short processes may share robots
2. **High-Density Robots** - Run multiple robots per VM (saves infra cost)
3. **Schedule optimisation** - Stagger unattended processes

### License Type Selection
1. **Named vs Concurrent Attended:**
   - Named: Users run automations daily
   - Concurrent: Occasional use, shift patterns

2. **Unattended Sizing:**
   - Calculate total runtime hours needed
   - Factor in queue wait times
   - Consider SLA requirements

### Cloud vs On-Premises
| Factor | Cloud | On-Prem |
|--------|-------|---------|
| Capital cost | Lower | Higher (infrastructure) |
| Operational cost | Subscription | Licenses + maintenance |
| Flexibility | Easy scaling | Requires planning |
| Data sovereignty | Varies by region | Full control |

---

## Licensing Gotchas

### Common Mistakes
1. **Underestimating Attended licenses** - Each user needs a license, even for occasional use
2. **Forgetting Non-Production** - Dev/Test robots need separate licenses
3. **AI Units surprise** - Document Understanding can consume units quickly
4. **Orchestrator tier mismatch** - Enterprise features need Enterprise licensing

### Questions to Ask UiPath Sales
1. What's included in the base license vs add-ons?
2. How are Robot Units consumed by each robot type?
3. What are the AI Unit consumption rates for our use case?
4. Are there regional pricing differences?
5. What's the true-up policy if we exceed licensed capacity?
6. What's included in support tiers?

---

## Deployment Licensing Considerations

### Multi-Tenancy
- Single Orchestrator, multiple tenants
- Each tenant may have separate licensing
- Useful for MSPs, large enterprises

### Hybrid Deployment
- Orchestrator Cloud + On-Prem robots
- Requires connectivity consideration
- Licensing applies to robot location

### DR/HA
- Passive DR robots typically don't require separate licenses (verify!)
- HA Orchestrator nodes covered under Enterprise

---

## Migration Paths

### Community → Enterprise
- Same Studio/Robot codebase
- License key change
- Orchestrator migration if moving to Enterprise

### On-Prem → Cloud
- Process packages compatible
- Orchestrator configuration export/import
- Credential store migration required

---

## Quick Reference: What Needs Licensing?

| Component | License Required? |
|-----------|-------------------|
| Studio (development) | Yes, typically included with robot license |
| Attended Robot (production) | Yes |
| Unattended Robot (production) | Yes |
| Robot (Dev/Test) | Yes (Non-Production SKU) |
| Orchestrator | Yes (may be included/bundled) |
| AI Center | Yes + AI Units |
| Document Understanding | Yes + AI Units |
| Action Center | Typically included with Enterprise |
| Insights | Add-on or Enterprise |
| Test Manager | Add-on |
| Task Mining | Add-on |
| Process Mining | Separate product |

---

*SK-023 UiPath Licensing & Deployment v1.0 | Frans MPD*
