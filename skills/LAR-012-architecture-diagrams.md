# Frans Skill: Architecture Diagrams

## Metadata

| Field | Value |
|-------|-------|
| **Name** | architecture-diagrams |
| **Version** | 1.0 |
| **ID** | LAR-012 |
| **Triggers** | "architecture diagram", "system diagram", "data flow" |
| **Google Doc Name** | `SKILL_ArchitectureDiagrams` |

---

## Purpose

Generate comprehensive architecture diagrams for RFPs, implementations, and technical documentation using Mermaid.

---

## Diagram Types

### Infrastructure & Deployment
- Cloud Architecture (Azure, AWS, GCP)
- Network Topology
- Container/Kubernetes Architecture

### Application & Solution
- Solution Architecture (High-Level)
- Microservices Architecture
- API Architecture

### Data & AI
- Data Flow Diagrams
- ETL/ELT Pipelines
- ML/AI Pipeline Architecture
- Data Lineage

### Integration & Process
- Integration Architecture
- Sequence Diagrams
- Business Process (BPMN)

---

## Output Formats

| Format | Use Case |
|--------|----------|
| **Mermaid** | Primary - renders in markdown |
| **PlantUML** | Complex diagrams, cloud icons |
| **Structured Text** | For draw.io, Lucidchart |
| **ASCII** | Simple, universal |

---

## RFP Standards

When creating architecture diagrams for RFPs, include:

1. **Context Diagram** - System in business context
2. **Solution Architecture** - High-level components
3. **Data Architecture** - Sources, processing, storage
4. **Deployment Architecture** - Infrastructure
5. **Integration Architecture** - System integrations
6. **Security Architecture** - Controls by layer

---

## Rules

```
+use-standard-notation       # Use industry-standard notation
+include-all-integrations    # Show all system integrations
+show-data-flow-direction    # Indicate data flow with arrows
-create-cluttered-diagrams   # Keep diagrams clean and readable
-mix-abstraction-levels      # Maintain consistent detail level
```

---

## Mermaid Templates

### Solution Architecture

```mermaid
graph TB
    subgraph "External"
        U[Users]
        E[External Systems]
    end

    subgraph "Presentation Layer"
        W[Web App]
        M[Mobile App]
        A[API Gateway]
    end

    subgraph "Application Layer"
        S1[Service 1]
        S2[Service 2]
        S3[Service 3]
    end

    subgraph "Data Layer"
        DB[(Database)]
        C[(Cache)]
        Q[Message Queue]
    end

    U --> W
    U --> M
    W --> A
    M --> A
    A --> S1
    A --> S2
    S1 --> DB
    S2 --> C
    S3 --> Q
    E --> A
```

### Data Flow Diagram

```mermaid
flowchart LR
    subgraph Sources
        S1[Source System 1]
        S2[Source System 2]
    end

    subgraph Ingestion
        I[Data Ingestion Layer]
    end

    subgraph Processing
        T[Transform]
        V[Validate]
        E[Enrich]
    end

    subgraph Storage
        DW[(Data Warehouse)]
        DL[(Data Lake)]
    end

    subgraph Consumption
        BI[BI Tools]
        ML[ML Models]
        API[API]
    end

    S1 --> I
    S2 --> I
    I --> T --> V --> E
    E --> DW
    E --> DL
    DW --> BI
    DL --> ML
    DW --> API
```

### Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant W as Web App
    participant A as API Gateway
    participant S as Service
    participant D as Database

    U->>W: Request
    W->>A: API Call
    A->>A: Authenticate
    A->>S: Forward Request
    S->>D: Query
    D-->>S: Data
    S-->>A: Response
    A-->>W: JSON Response
    W-->>U: Display
```

### Deployment Architecture

```mermaid
graph TB
    subgraph "Azure Cloud"
        subgraph "Production"
            LB[Load Balancer]
            subgraph "AKS Cluster"
                P1[Pod 1]
                P2[Pod 2]
                P3[Pod 3]
            end
            DB[(Azure SQL)]
            REDIS[(Redis Cache)]
        end

        subgraph "Supporting Services"
            KV[Key Vault]
            LOG[Log Analytics]
            APIM[API Management]
        end
    end

    LB --> P1
    LB --> P2
    LB --> P3
    P1 --> DB
    P2 --> REDIS
    P3 --> KV
    P1 --> LOG
    APIM --> LB
```

---

## Best Practices

### Clarity
- Use clear, descriptive labels
- Maintain consistent spacing
- Group related components

### Completeness
- Show all relevant integrations
- Include data flow directions
- Label connections where helpful

### Consistency
- Use same notation throughout
- Match abstraction levels
- Follow colour conventions

### Standards
- Follow C4 model for context/container/component
- Use UML conventions where appropriate
- Include legend for custom notation

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| 001 Executive Strategic Advisor | Strategy visualisation, org charts |
| 009 Software Architect | Full architecture documentation |
| 010 The Architect | System design, routing diagrams |

---

*Frans Skill LAR-012 | Architecture Diagrams v1.0*
