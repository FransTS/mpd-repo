# Frans Skill: Autonomous Routing

## Metadata

| Field | Value |
|-------|-------|
| **Name** | autonomous-routing |
| **Version** | 1.2 |
| **ID** | LAR-006 |
| **Triggers** | "handle this", "figure out", complex tasks |
| **Always Active** | YES |
| **Updated** | 29 January 2026 |

---

## Purpose

Self-select personas, decompose tasks, chain operations, detect when **Ralph Loop (PR-018)** or **RLM (PR-019)** is appropriate without user intervention.

---

## Complexity Classification

| Level | Personas | Action |
|-------|----------|--------|
| **SIMPLE** | 1 persona, 1 skill | Direct execution |
| **MODERATE** | 1-2 personas | Sequential, brief plan |
| **COMPLEX** | 2+ personas | Full decomposition |
| **RALPH LOOP** | Any | Fresh context per task (PR-018) |
| **RLM** | Any | Recursive document processing (PR-019) |

---

## RLM Auto-Detection (NEW in v1.2)

### When to Apply RLM

| Condition | Threshold | Action |
|-----------|-----------|--------|
| Single document length | > 30 pages | Apply LAR-027 |
| Multiple documents | > 3 related documents | Apply LAR-027 + LAR-029 |
| Document suite | Master + exhibits/amendments | Apply LAR-027 + LAR-029 |
| Cross-reference complexity | Many "see Section X" references | Apply LAR-027 |
| Code repository size | > 20 files to analyse | Apply LAR-027 |
| Research sources | > 5 sources to synthesise | Apply LAR-027 |
| Due diligence request | Any | **Route to Persona 017** |

### RLM Detection Keywords

Auto-apply RLM when request contains:
- "analyse this contract" + document > 30 pages
- "review these documents" + multiple files
- "due diligence", "document review"
- "contract suite", "master agreement with exhibits"
- "understand this codebase", "trace the code"
- "synthesise these reports", "compare across sources"
- "cross-reference", "dependency mapping"

### RLM Persona Routing

| Scenario | Route To | Skills Applied |
|----------|----------|----------------|
| Single complex contract | 008 Legal Expert | LAR-002 v2.0, LAR-027 |
| Contract suite (5+ docs) | **017 Document Analyst** | LAR-027, LAR-029, PR-019 |
| Due diligence | **017 Document Analyst** | LAR-027, LAR-029, PR-019 |
| Multi-source research | 003 Market Research | LAR-001, LAR-027 |
| Large codebase | 009 Software Architect | LAR-012, LAR-027 |
| General complex docs | **017 Document Analyst** | LAR-027, LAR-028, LAR-029 |

### RLM Application Format

When RLM detected, respond:

```markdown
This requires **RLM (Recursive Language Model)** processing due to [document length / multiple documents / complex cross-references].

**Approach:**
1. Index documents (create searchable structure)
2. Decompose query into sub-queries
3. Process each with fresh context
4. Synthesise findings with citations

Proceeding with RLM methodology...
```

### Document Complexity Assessment

Before processing documents, assess:

```
1. DOCUMENT COUNT
   â”œâ”€â”€ Single document â†’ Check length
   â””â”€â”€ Multiple documents â†’ Check relationships

2. DOCUMENT LENGTH (single)
   â”œâ”€â”€ < 15 pages â†’ Standard processing
   â”œâ”€â”€ 15-30 pages â†’ Consider RLM
   â””â”€â”€ > 30 pages â†’ **Apply RLM**

3. DOCUMENT RELATIONSHIPS (multiple)
   â”œâ”€â”€ Independent â†’ Process sequentially
   â”œâ”€â”€ Cross-referenced â†’ **Apply RLM**
   â””â”€â”€ Suite (master + exhibits) â†’ **Route to 017**

4. QUERY COMPLEXITY
   â”œâ”€â”€ Single fact lookup â†’ Standard
   â”œâ”€â”€ Multi-hop reasoning â†’ **Apply RLM**
   â””â”€â”€ Aggregation/comparison â†’ **Apply RLM**
```


---

## Context Compression Routing (NEW v1.3)

### Context Thresholds (CTX-001)

| Context Usage | State | Routing Action |
|---------------|-------|----------------|
| < 25% | GREEN | Normal routing |
| 25-50% | YELLOW | Monitor, prepare |
| **50-75%** | **ORANGE** | **Activate Tier 1 & 2 compression** |
| **75-85%** | **RED** | **Tier 3 + checkpoint + drift check** |
| **> 85%** | **CRITICAL** | **Checkpoint + fresh session** |

### Goal Drift Detection

After Tier 3 summarisation:
- Verify intent alignment
- Check for clarification/completion drift
- Recover from archive if needed

See: CTX-001-context-compression.md, LAR-033-context-compression.md

---

## Ralph Loop Auto-Detection

### When to Suggest Ralph Loop

| Condition | Threshold | Action |
|-----------|-----------|--------|
| Discrete tasks identified | > 5 tasks | Suggest Ralph Loop |
| Project scope keywords | "build app", "full system", "complete project" | Suggest Ralph Loop |
| Multi-session estimate | > 3 sessions expected | Suggest Ralph Loop |
| Context rot detected | Repetitive/declining responses | **Recommend fresh session** |
| Long conversation | > 50% context (~100k tokens) | **Recommend fresh session** |

### Detection Keywords

Auto-suggest Ralph Loop when request contains:
- "build entire", "full application", "complete system"
- "from scratch", "end-to-end", "comprehensive"
- "multi-phase", "multiple stages", "project plan"
- "website with multiple pages", "app with features"
- Any request estimating > 2 hours of work

### Ralph Loop Suggestion Format

When detected, respond:

```markdown
This looks like a **Ralph Loop candidate** - a multi-step project that benefits from fresh context per task.

**Recommended approach:**
1. Create PRD with [N] discrete tasks
2. Execute each in a fresh session
3. Track progress in progress.md

Shall I initialise Ralph Loop for this project?
```

---

## Context Monitoring

### Context Rot Detection

Monitor for signs of degradation:
- Repeating previous responses
- Forgetting earlier constraints
- Declining code/output quality
- Ignoring stated requirements
- Hallucinating file contents

**On detection:** Immediately recommend:
```markdown
âš ï¸ Context approaching capacity. Recommend:
1. Checkpoint current progress
2. Start fresh session
3. Continue from progress.md
```

### Context Thresholds

| Usage | Action |
|-------|--------|
| < 25% | Continue normally |
| 25-50% | Monitor, consider RLM sub-calls |
| 50-75% | **Apply RLM sub-calls for remaining work** |
| > 75% | **Checkpoint + fresh session (Ralph Loop)** |

---

## Persona Selection Matrix (Updated v1.2)

| Domain | Persona ID | RLM Auto-Load |
|--------|------------|---------------|
| Strategic/Board-level | 001 Executive Strategic Advisor | No |
| Admin/Scheduling | 002 Executive Assistant | No |
| Market/Competitor | 003 Market Research | **Yes** |
| Sales/Revenue | 004 Sales Enablement | No |
| Documents/Reports | 005 Document Creator | No |
| Technical Docs | 006 Technical Writer | No |
| Brand/Campaigns | 007 Marketing Advisor | No |
| Contracts/Legal | 008 Legal Expert | **Yes** |
| Code/Architecture | 009 Software Architect | **Yes** |
| Meta/Routing | 010 The Architect | No |
| Fitness | 011 Endurance Coach | No |
| Prompts/AI | 012 Prompt Engineer | No |
| AI Detection | 013 Authenticity Reviewer | No |
| ERP/Sage | 014 Sage Intacct Support | No |
| Transcription | 015 Transcript Specialist | No |
| Airbnb | 016 Airbnb Host | No |
| **Complex Documents** | **017 Document Analyst** | **Primary** |

---

## Routing Algorithm (Updated v1.2)

```
1. PARSE REQUEST
   â”œâ”€â”€ Identify objective(s)
   â”œâ”€â”€ Identify domain(s)
   â”œâ”€â”€ Identify output format(s)
   â”œâ”€â”€ Identify constraints
   â”œâ”€â”€ **Estimate document complexity**
   â””â”€â”€ **Estimate task count and scope**

2. DOCUMENT CHECK (NEW)
   â”œâ”€â”€ IF document attached or referenced:
   â”‚   â”œâ”€â”€ Assess length (pages/tokens)
   â”‚   â”œâ”€â”€ Assess relationships (single/suite)
   â”‚   â”œâ”€â”€ Assess query complexity (single-hop/multi-hop)
   â”‚   â””â”€â”€ **Determine RLM applicability**
   â””â”€â”€ Continue to complexity classification

3. CLASSIFY COMPLEXITY
   â”œâ”€â”€ Count distinct domains
   â”œâ”€â”€ Count required outputs
   â”œâ”€â”€ Assess interdependencies
   â”œâ”€â”€ **Check RLM criteria**
   â”œâ”€â”€ **Check Ralph Loop criteria**
   â””â”€â”€ Assign: SIMPLE | MODERATE | COMPLEX | RLM | RALPH_LOOP

4. RLM CHECK
   â”œâ”€â”€ IF document > 30 pages â†’ Apply RLM
   â”œâ”€â”€ IF multiple related docs â†’ Apply RLM
   â”œâ”€â”€ IF due diligence/doc suite â†’ Route to 017
   â”œâ”€â”€ IF multi-hop query on docs â†’ Apply RLM
   â””â”€â”€ ELSE â†’ Continue normal routing

5. RALPH LOOP CHECK
   â”œâ”€â”€ IF task_count > 5 â†’ Suggest Ralph Loop
   â”œâ”€â”€ IF scope_keywords detected â†’ Suggest Ralph Loop
   â”œâ”€â”€ IF multi-session likely â†’ Suggest Ralph Loop
   â””â”€â”€ ELSE â†’ Continue normal routing

6. SELECT PERSONA(S)
   â”œâ”€â”€ Match domain to persona matrix
   â”œâ”€â”€ **Apply RLM routing if triggered**
   â”œâ”€â”€ Identify primary persona
   â”œâ”€â”€ Identify supporting personas (if needed)
   â””â”€â”€ Load required skills

7. PLAN EXECUTION
   â”œâ”€â”€ SIMPLE: Execute directly
   â”œâ”€â”€ MODERATE: Brief plan, then execute
   â”œâ”€â”€ COMPLEX: Full decomposition, state plan
   â”œâ”€â”€ **RLM: Index â†’ Decompose â†’ Recursive Execute â†’ Synthesise**
   â””â”€â”€ **RALPH_LOOP: Create PRD, initialise progress.md**

8. EXECUTE
   â”œâ”€â”€ Follow plan
   â”œâ”€â”€ Chain as needed
   â”œâ”€â”€ **Monitor context usage**
   â”œâ”€â”€ **Apply RLM sub-calls if context heavy**
   â”œâ”€â”€ Maintain quality standards
   â””â”€â”€ Consolidate outputs
```

---

## Decision Examples

### SIMPLE Task
**Request:** "Draft a meeting agenda for Monday's standup"
```
Domain: Admin/Scheduling
Persona: 002 Executive Assistant
Skill: meeting-mastery
Action: Direct execution
```

### MODERATE Task
**Request:** "Create a sales proposal for our new product"
```
Domains: Sales + Documents
Personas: 004 Sales Enablement â†’ 005 Document Creator
Skills: sales-playbook, docx
Action: Sequential chain with brief plan
```

### RLM Task (NEW)
**Request:** "Review this 50-page master agreement and its 3 exhibits for risks"
```
Detection: Document > 30 pages + exhibits = suite
Classification: RLM
Persona: 008 Legal Expert (with LAR-027)
Skills: LAR-002 v2.0, LAR-027, LAR-028
Action: Apply RLM methodology
Response: "This requires RLM processing due to document length and exhibits..."
```

### RLM + Route to 017
**Request:** "Conduct due diligence on these 20 documents for the acquisition"
```
Detection: Due diligence + 20 documents
Classification: RLM + Complex
Persona: **017 Document Analyst**
Skills: LAR-027, LAR-028, LAR-029, PR-019
Action: Full RLM workflow
```

### RALPH LOOP Task
**Request:** "Build me a complete portfolio website with homepage, projects page, blog, and contact form"
```
Detection: "complete website", 4+ distinct pages, multi-session scope
Classification: RALPH_LOOP
Action: Suggest Ralph Loop
Response: "This looks like a Ralph Loop candidate..."
```

---

## Chaining Rules

```
+chain=sequential-when-dependent   # Chain tasks that depend on each other
+chain=parallel-when-independent   # Run independent tasks in parallel
+handoff=seamless                  # Smooth transitions between personas
-ask-permission-each-phase         # Don't interrupt for each step
+ralph-loop=auto-suggest           # Suggest PR-018 when criteria met
+rlm=auto-apply                    # Apply PR-019 when criteria met
```

---

## Integration with Other Skills

| Skill | Integration |
|-------|-------------|
| LAR-007 self-assessment | Quality check after routing |
| LAR-008 escalation-protocol | Determine ask vs. proceed |
| LAR-025 ralph-loop | Auto-suggest for complex projects |
| **LAR-027 rlm-framework** | **Auto-apply for document complexity** |
| **LAR-028 long-context** | **Auto-apply for context management** |
| **LAR-029 complex-docs** | **Auto-load for multi-doc analysis** |
| PR-018 | Protocol for fresh context execution |
| **PR-019** | **Protocol for recursive processing** |
| All persona skills | Load based on selection |

---

## Stop Hooks

```xml
<stop-hook id="HOOK-RTE-001" type="SOFT">
  <trigger>Multi-persona task (COMPLEX classification)</trigger>
  <validation>
    <check>All required personas identified</check>
    <check>Execution order logical</check>
    <check>Dependencies mapped</check>
    <check>Output consolidation planned</check>
  </validation>
  <on-pass>State plan briefly, execute</on-pass>
  <on-fail>Default to The Architect for analysis</on-fail>
</stop-hook>

<stop-hook id="HOOK-RTE-004" type="SOFT">
  <trigger>Ralph Loop criteria detected</trigger>
  <validation>
    <check>Task count > 5 OR scope keywords present</check>
    <check>Multi-session work estimated</check>
  </validation>
  <on-pass>Suggest Ralph Loop to user</on-pass>
  <on-fail>Continue with COMPLEX routing</on-fail>
</stop-hook>

<stop-hook id="HOOK-RTE-005" type="GATE">
  <trigger>Context usage > 50%</trigger>
  <validation>
    <check>Current task can complete in remaining context</check>
  </validation>
  <on-pass>Continue with warning</on-pass>
  <on-fail>Checkpoint and recommend fresh session</on-fail>
</stop-hook>

<stop-hook id="HOOK-RTE-006" type="SOFT">
  <trigger>RLM criteria detected</trigger>
  <validation>
    <check>Document > 30 pages OR multiple related docs</check>
    <check>Multi-hop reasoning required</check>
  </validation>
  <on-pass>Apply RLM methodology (LAR-027, PR-019)</on-pass>
  <on-fail>Continue with standard processing</on-fail>
</stop-hook>

<stop-hook id="HOOK-RTE-007" type="GATE">
  <trigger>Due diligence or document suite detected</trigger>
  <validation>
    <check>Multiple documents with relationships</check>
    <check>Complex analysis required</check>
  </validation>
  <on-pass>Route to Persona 017</on-pass>
  <on-fail>Handle with domain persona + RLM</on-fail>
</stop-hook>
```

---

## Fail-Safe

If routing is unclear:
1. Default to **010 The Architect**
2. Analyse and re-route from there
3. Ask ONE clarifying question if still unclear

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| **1.3** | **29 Jan 2026** | **CTX-001 integration, compression routing, goal drift** |
| **1.2** | **18 Jan 2026** | **Added RLM auto-detection, Persona 017 routing, context thresholds** |
| 1.1 | 17 Jan 2026 | Added Ralph Loop auto-detection |
| 1.0 | - | Initial release |

---

*Frans Skill LAR-006 | Autonomous Routing v1.2 | Always Active*
