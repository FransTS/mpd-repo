# Frans Skill: Autonomous Routing

## Metadata

| Field | Value |
|-------|-------|
| **Name** | autonomous-routing |
| **Version** | 1.3 |
| **ID** | LAR-006 |
| **Triggers** | "handle this", "figure out", complex tasks |
| **Always Active** | YES |
| **Updated** | 29 January 2026 |

---

> **NEW in v1.3:**
> - Context compression routing (CTX-001 integration)
> - Enhanced context threshold management
> - Goal drift detection triggers
> - Compression-aware persona routing
> - Based on LangChain Deep Agents methodology

---

## Purpose

Self-select personas, decompose tasks, chain operations, detect when **Ralph Loop (PR-018)**, **RLM (PR-019)**, or **Context Compression (CTX-001)** is appropriate without user intervention.

---

## Complexity Classification (Updated v1.3)

| Level | Personas | Action |
|-------|----------|--------|
| **SIMPLE** | 1 persona, 1 skill | Direct execution |
| **MODERATE** | 1-2 personas | Sequential, brief plan |
| **COMPLEX** | 2+ personas | Full decomposition |
| **RALPH LOOP** | Any | Fresh context per task (PR-018) |
| **RLM** | Any | Recursive document processing (PR-019) |
| **COMPRESSION** | Any | **Context management active (CTX-001)** |

---

## Context Compression Routing (NEW v1.3)

### Context Thresholds (CTX-001)

| Context Usage | State | Routing Action |
|---------------|-------|----------------|
| < 25% | GREEN | Normal routing |
| 25-50% | YELLOW | Monitor, prepare compression |
| **50-75%** | **ORANGE** | **Activate Tier 1 & 2 compression** |
| **75-85%** | **RED** | **Trigger Tier 3 + checkpoint + drift check** |
| **> 85%** | **CRITICAL** | **Checkpoint + recommend fresh session** |

### Compression-Aware Routing

`
WHEN context threshold crossed:

AT 50%:
  1. Log context level ORANGE
  2. Route to LAR-033 for Tier 2 truncation
  3. Check if RLM sub-calls would help remaining work
  4. Continue with compression active

AT 75%:
  1. Log context level RED
  2. Create checkpoint BEFORE compression
  3. Route to LAR-033 for Tier 3 summarisation
  4. Run goal drift detection
  5. Recover if drift detected

AT 85%:
  1. Log context level CRITICAL
  2. Create final checkpoint
  3. Preserve all state
  4. RECOMMEND: "Context at critical level. Recommend fresh session to continue."
`

### Goal Drift Detection (NEW)

After ANY Tier 3 summarisation:

`
CHECK 1: Intent Alignment
- Current action aligns with preserved Session Intent?
- Would user recognise this as their task?

CHECK 2: Drift Indicators
- Immediately asking for clarification? ƒÅ' WARN
- Declaring complete without deliverable? ƒÅ' WARN
- Working on unrelated subtask? ƒÅ' WARN

ON DRIFT:
1. Route to recovery operation
2. Search offloaded/archived content
3. Realign with original intent
4. Inform user if deviation prevented
`

---

## RLM Auto-Detection

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
| **Context > 50%** | **With remaining document work** | **Use RLM sub-calls (NEW)** |

### RLM Persona Routing

| Scenario | Route To | Skills Applied |
|----------|----------|----------------|
| Single complex contract | 008 Legal Expert | LAR-002 v2.0, LAR-027 |
| Contract suite (5+ docs) | **017 Document Analyst** | LAR-027, LAR-029, PR-019 |
| Due diligence | **017 Document Analyst** | LAR-027, LAR-029, PR-019 |
| Multi-source research | 003 Market Research | LAR-001, LAR-027 |
| Large codebase | 009 Software Architect | LAR-012, LAR-027 |
| General complex docs | **017 Document Analyst** | LAR-027, LAR-028, LAR-029 |

---

## Ralph Loop Auto-Detection

### When to Suggest Ralph Loop

| Condition | Threshold | Action |
|-----------|-----------|--------|
| Discrete tasks identified | > 5 tasks | Suggest Ralph Loop |
| Project scope keywords | "build app", "full system", "complete project" | Suggest Ralph Loop |
| Multi-session estimate | > 3 sessions expected | Suggest Ralph Loop |
| Context rot detected | Repetitive/declining responses | **Recommend fresh session** |
| **Context > 85%** | **Any (NEW)** | **Recommend fresh session** |
| Long conversation | > 75% context | **Checkpoint + recommend (NEW)** |

---

## Context Monitoring (Enhanced v1.3)

### Context Rot Detection

Monitor for signs of degradation:
- Repeating previous responses
- Forgetting earlier constraints
- Declining code/output quality
- Ignoring stated requirements
- Hallucinating file contents
- **Asking clarification immediately after compression (NEW)**
- **Declaring complete without deliverable (NEW)**

**On detection:** Immediately:
`markdown
ƒsÿ‹÷? Context issue detected. Actions:
1. Checkpoint current progress
2. Search offloaded/archived content for missing context
3. If recovery insufficient: recommend fresh session
4. Continue from checkpoint in new session
`

### Context Thresholds (Detailed v1.3)

| Usage | Routing Action |
|-------|----------------|
| < 25% | Continue normally |
| 25-50% | Monitor, activate LAR-033 monitoring |
| **50-75%** | **Apply Tier 1 & 2 via LAR-033, consider RLM sub-calls** |
| **75-85%** | **Apply Tier 3 via LAR-033, checkpoint, drift check** |
| **> 85%** | **Final checkpoint, recommend fresh session (Ralph Loop)** |

---

## Routing Algorithm (Updated v1.3)

`
1. PARSE REQUEST
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Identify objective(s)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Identify domain(s)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Estimate document complexity
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Estimate task count and scope

2. CONTEXT CHECK (NEW v1.3)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Check current context usage percentage
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF > 50% ƒÅ' Activate compression (CTX-001)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF > 75% ƒÅ' Checkpoint + summarise
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF > 85% ƒÅ' Recommend fresh session

3. DOCUMENT CHECK
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF document attached or referenced:
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Assess length (pages/tokens)
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Assess relationships (single/suite)
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª­   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Determine RLM applicability
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Continue to complexity classification

4. CLASSIFY COMPLEXITY
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Count distinct domains
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Check RLM criteria
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Check Ralph Loop criteria
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª **Check compression criteria (NEW)**
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Assign: SIMPLE | MODERATE | COMPLEX | RLM | RALPH_LOOP | COMPRESSION

5. COMPRESSION CHECK (NEW v1.3)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF large tool result (> 15k tokens) ƒÅ' Apply Tier 1
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF context > 50% ƒÅ' Apply Tier 2
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF context > 75% ƒÅ' Apply Tier 3 + checkpoint
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF context > 85% ƒÅ' Recommend fresh session

6. RLM CHECK
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF document > 30 pages ƒÅ' Apply RLM
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF multiple related docs ƒÅ' Apply RLM
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª IF due diligence/doc suite ƒÅ' Route to 017
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª ELSE ƒÅ' Continue normal routing

7. SELECT PERSONA(S)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Match domain to persona matrix
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Apply RLM routing if triggered
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª **Apply compression routing if triggered (NEW)**
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Load required skills + LAR-033 if compression active

8. EXECUTE
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Follow plan
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª **Monitor context throughout (NEW)**
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª **Apply compression as needed (NEW)**
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª **Check goal drift post-compression (NEW)**
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Consolidate outputs
`

---

## Stop Hooks (Updated v1.3)

`xml
<stop-hook id="HOOK-RTE-005" type="GATE">
  <trigger>Context usage > 50%</trigger>
  <validation>
    <check>Compression options available</check>
    <check>Current task can benefit from compression</check>
  </validation>
  <on-pass>Apply Tier 1 & 2 compression, continue</on-pass>
  <on-fail>Monitor and prepare for Tier 3</on-fail>
</stop-hook>

<stop-hook id="HOOK-RTE-008" type="GATE">
  <trigger>Context usage > 75%</trigger>
  <validation>
    <check>Tier 1 & 2 applied</check>
    <check>Session intent captured</check>
  </validation>
  <on-pass>Apply Tier 3, checkpoint, drift check</on-pass>
  <on-fail>Immediate checkpoint and fresh session</on-fail>
</stop-hook>

<stop-hook id="HOOK-RTE-009" type="HARD">
  <trigger>Context usage > 85%</trigger>
  <action>Final checkpoint, recommend fresh session</action>
</stop-hook>

<stop-hook id="HOOK-RTE-010" type="SOFT">
  <trigger>Post Tier 3 compression</trigger>
  <validation>
    <check>Intent alignment verified</check>
    <check>No drift indicators</check>
  </validation>
  <on-pass>Continue with task</on-pass>
  <on-fail>Recover context and realign</on-fail>
</stop-hook>
`

---

## Integration with Other Skills (Updated v1.3)

| Skill | Integration |
|-------|-------------|
| **LAR-033 context-compression** | **Execute compression operations (NEW)** |
| **CTX-001 protocol** | **Compression thresholds and tiers (NEW)** |
| LAR-007 self-assessment | Quality check after routing |
| LAR-008 escalation-protocol | Determine ask vs. proceed |
| LAR-014 context-management | Context tracking informs routing |
| LAR-025 ralph-loop | Auto-suggest for complex projects |
| LAR-027 rlm-framework | Auto-apply for document complexity |
| LAR-028 long-context | Auto-apply for context management |
| SES-001 | Checkpointing on compression events |
| PR-018 | Protocol for fresh context execution |
| PR-019 | Protocol for recursive processing |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| **1.3** | **29 Jan 2026** | **CTX-001 integration, compression routing, goal drift detection** |
| 1.2 | 18 Jan 2026 | Added RLM auto-detection, Persona 017 routing |
| 1.1 | 17 Jan 2026 | Added Ralph Loop auto-detection |
| 1.0 | - | Initial release |

---

*Frans Skill LAR-006 | Autonomous Routing v1.3 | Always Active*
