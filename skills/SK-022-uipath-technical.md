# SK-022: UiPath Technical Architecture

## Metadata
| Field | Value |
|-------|-------|
| ID | SK-022 |
| Version | 1.0 |
| Updated | 21 January 2026 |
| Primary Persona | 020 (UiPath Specialist) |
| Triggers | "UiPath architecture", "robot types", "Orchestrator setup" |

---

## Purpose
Comprehensive technical knowledge of UiPath platform components, architecture patterns, and implementation best practices.

---

## Platform Components

### UiPath Studio Family
| Product | Target User | Use Case |
|---------|-------------|----------|
| **Studio** | Professional developers | Complex automations, full feature set |
| **StudioX** | Business users | Simple automations, Excel-centric |
| **Studio Web** | Citizen developers | Browser-based, quick automations |

### Robot Types
| Type | Execution | Use Case | Licensing Impact |
|------|-----------|----------|------------------|
| **Attended** | User-triggered, foreground | Desktop tasks, user assistance | Per named user |
| **Unattended** | Scheduled/API, background | High-volume, batch processing | Per robot/concurrent |
| **Non-Production** | Dev/Test only | Development, testing | Separate SKU |
| **Automation Cloud Robot** | Cloud-hosted VM | Serverless execution | Consumption-based |

### Orchestrator Deployment Options
| Mode | Infrastructure | Best For |
|------|---------------|----------|
| **Automation Cloud** | UiPath-hosted SaaS | Quick start, minimal IT overhead |
| **Automation Suite** | Kubernetes (customer-hosted) | Enterprise, data sovereignty |
| **Standalone** | Windows Server | Legacy, air-gapped environments |

---

## Architecture Patterns

### Small Scale (1-10 robots)
```
[Studio] → [Orchestrator Cloud] → [Attended Robots]
                                → [1-2 Unattended VMs]
```

### Medium Scale (10-50 robots)
```
[Studio/StudioX] → [Orchestrator Cloud/On-Prem]
                        ├── [Robot Pool - Attended]
                        ├── [Robot Pool - Unattended]
                        └── [High Density Robots on Terminal Server]
```

### Enterprise Scale (50+ robots)
```
[Studio Enterprise] → [Orchestrator HA Cluster]
                           ├── [Multi-Tenant Config]
                           ├── [Robot Pools by Function]
                           ├── [AI Center Integration]
                           ├── [Insights Analytics]
                           └── [DR Site (Active-Passive)]
```

---

## Key Technical Considerations

### High Availability
- **Orchestrator HA:** Multiple nodes behind load balancer
- **Database:** SQL Server AlwaysOn or Azure SQL
- **Redis:** For session state (required for multi-node)
- **Elasticsearch:** For logging (optional, recommended)

### Security
- **Machine Templates:** Standardised robot deployment
- **Credential Stores:** CyberArk, Azure Key Vault, HashiCorp integration
- **RBAC:** Folder-based permissions, fine-grained access
- **Network:** Robots → Orchestrator (outbound 443 typically sufficient)

### Performance
- **High-Density Robots:** Multiple robots per VM (requires proper sizing)
- **Robot Pools:** Dynamic allocation for load balancing
- **Queue Management:** Prioritisation, SLA tracking, retry policies

---

## Integration Capabilities

### Native Connectors (Integration Service)
- SAP, Salesforce, ServiceNow, Workday
- Microsoft 365, Google Workspace
- Databases (SQL, Oracle, etc.)

### AI/ML Integration
- **Document Understanding:** OCR, ML extraction, validation
- **AI Center:** Custom ML model deployment
- **Communications Mining:** Email/ticket analysis

### External Systems
- REST/SOAP APIs
- Database direct connections
- File shares, SFTP
- Mainframe (terminal emulation)

---

## Version Considerations

### Current LTS
- **2023.10 LTS** - Recommended for stability

### Current Fast Track
- **2024.10** - Latest features, shorter support

### Upgrade Path
- Community → Enterprise: License change, same codebase
- On-Prem → Cloud: Process migration, Orchestrator reconfiguration
- Version upgrades: Studio, Robot, and Orchestrator should align

---

## Best Practices

1. **Start with Orchestrator Cloud** unless data sovereignty requires on-prem
2. **Use Machine Templates** for consistent robot deployment
3. **Implement folder structure** aligned with business units or processes
4. **Separate Dev/Test/Prod** environments
5. **Monitor with Insights** for performance and compliance
6. **Establish naming conventions** early (processes, queues, assets)
7. **Version control** all workflows (Git integration in Studio)

---

*SK-022 UiPath Technical Architecture v1.0 | Frans MPD*
