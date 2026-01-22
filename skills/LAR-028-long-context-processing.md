# Frans Skill: Long-Context Processing

## Metadata

| Field | Value |
|-------|-------|
| **Name** | long-context-processing |
| **Version** | 1.0 |
| **ID** | LAR-028 |
| **Triggers** | "long document", "large context", "context management", "prevent context rot" |
| **Dependencies** | LAR-027 (RLM Framework) |
| **Created** | 18 January 2026 |

---

## Purpose

Manage context window usage effectively to prevent degradation (context rot) when processing large inputs or extended conversations.

**Key Metrics:**
- Context window: ~200,000 tokens (Claude)
- Effective window: Degrades after ~50% usage
- Critical threshold: >75% usage

---

## Context Rot Indicators

| Indicator | Description | Severity |
|-----------|-------------|----------|
| Instruction drift | Forgetting earlier instructions | Medium |
| Contradiction | Conflicting statements | High |
| Repetition | Recycling same content | Medium |
| Detail loss | Missing specifics from early context | High |
| Hallucination increase | Fabricating to fill gaps | Critical |

---

## Prevention Strategies

### Strategy 1: Chunked Ingestion

**When:** Single large document (30+ pages)

**Method:**
```
Document → Split into logical sections
         → Process one section at a time
         → Extract key information
         → Discard raw text, keep findings
         → Move to next section
```

**Example:**
```markdown
# Processing 100-page Contract

## Pass 1: Index Creation
- Load TOC and section headers only (~500 tokens)
- Create searchable index

## Pass 2: Targeted Extraction
- User query: "What are payment terms?"
- Search index → Section 7 (Fees and Payment)
- Load only Section 7 (~2,000 tokens)
- Extract answer
- Unload Section 7

## Result: Query answered with ~2,500 tokens instead of ~50,000
```

### Strategy 2: Progressive Summarisation

**When:** Extended conversation approaching limits

**Method:**
```
Conversation grows → Monitor token usage
                   → At 50%: Create checkpoint summary
                   → At 75%: Compress early context
                   → At 90%: Fresh session with summary
```

**Summary Template:**
```markdown
## Context Summary (Checkpoint at 50%)

### User Profile
- Name: [Name]
- Role: [Role]
- Current Task: [Task]

### Key Decisions Made
1. [Decision 1]
2. [Decision 2]

### Work Completed
- [Item 1]
- [Item 2]

### Current State
- Working on: [Current item]
- Next steps: [Pending items]

### Critical Information
- [Must-remember fact 1]
- [Must-remember fact 2]
```

### Strategy 3: External Storage

**When:** Multi-session project with persistent needs

**Method:**
```
Session 1 → Work → Save to memory/files
Session 2 → Load summary → Continue
Session 3 → Load summary → Continue
...
```

**Integration:** Use with SES-001 (Session Persistence) and MEM-001 (Memory Protocol)

### Strategy 4: Query-Driven Loading

**When:** Document available but not yet loaded

**Method:**
```
User asks question → Parse intent
                   → Identify needed sections
                   → Load ONLY those sections
                   → Answer
                   → Optionally unload
```

**Versus traditional:**
```
❌ Load entire document → User asks question → Search loaded content
✅ User asks question → Search document externally → Load relevant parts
```

---

## Token Budget Management

### Estimation Guidelines

| Content Type | Approx Tokens per Page |
|--------------|------------------------|
| Plain text | 500-700 |
| Technical/dense | 700-1000 |
| Code | 300-500 |
| Tables/structured | 200-400 |

### Budget Allocation

For a 200k token window:

| Allocation | Tokens | Purpose |
|------------|--------|---------|
| System prompt | 5,000 | Persona, instructions |
| Working context | 80,000 | Current task content |
| Conversation history | 40,000 | Prior exchanges |
| Tool outputs | 30,000 | Search results, file contents |
| Response buffer | 15,000 | Space for output |
| Safety margin | 30,000 | Overhead, unexpected |

**Total allocated:** 200,000

---

## Implementation Patterns

### Pattern: Search Before Load

```markdown
1. Receive query about document
2. Search document index/TOC (minimal tokens)
3. Identify relevant sections
4. Load only those sections
5. Process and respond
6. Consider unloading if not needed again
```

### Pattern: Incremental Depth

```markdown
1. Start with document overview (1 page)
2. If more detail needed → Load relevant section
3. If still more detail → Load specific subsection
4. Never load more than needed for current question
```

### Pattern: Result Caching

```markdown
1. Process a section
2. Extract key findings
3. Store findings in structured format
4. Discard raw content
5. Reuse findings (not raw) for synthesis
```

---

## Commands

| Command | Action |
|---------|--------|
| "Check context usage" | Report current token estimate |
| "Create checkpoint" | Generate context summary |
| "Fresh context mode" | Start with minimal loaded |
| "Load section [X]" | Targeted section loading |
| "Unload raw content" | Keep findings, discard source |

---

## Integration

| Component | Integration |
|-----------|-------------|
| LAR-027 RLM Framework | RLM enables search-before-load |
| PR-018 Ralph Loop | Fresh context per iteration |
| PR-019 RLM Protocol | Systematic context management |
| SES-001 Session Persistence | Cross-session continuity |
| LAR-023 Batch Processing | Per-batch context management |

---

## Monitoring Dashboard

When processing long content, mentally track:

```
╔════════════════════════════════════════╗
║  CONTEXT MONITOR                       ║
╠════════════════════════════════════════╣
║  Estimated Usage: [     |||||||     ]  ║
║                   35%                   ║
║                                        ║
║  Status: ✅ Healthy                    ║
║                                        ║
║  Loaded Content:                       ║
║  • System prompt: 3,500 tokens         ║
║  • Document index: 800 tokens          ║
║  • Section 7: 2,100 tokens             ║
║  • Conversation: 12,000 tokens         ║
║  • Current query: 500 tokens           ║
║                                        ║
║  Strategy Active: Search Before Load   ║
╚════════════════════════════════════════╝
```

---

## Best Practices

### DO

- ✅ Create document indices before deep processing
- ✅ Load content incrementally, on-demand
- ✅ Cache processed results, not raw content
- ✅ Create checkpoints at 50% usage
- ✅ Use fresh sessions for new major tasks

### DON'T

- ❌ Load entire large documents at once
- ❌ Accumulate context indefinitely
- ❌ Ignore signs of context rot
- ❌ Repeat information already in context
- ❌ Process sequentially without budgeting

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 18 Jan 2026 | Initial release |

---

*Frans Skill LAR-028 | Long-Context Processing v1.0*
