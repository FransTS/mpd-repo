# Frans Skill: NotebookLM Context Aggregation

## Metadata

| Field | Value |
|-------|-------|
| **Name** | notebooklm-context |
| **Version** | 1.0 |
| **ID** | LAR-037 |
| **Triggers** | "aggregate context", "notebooklm", "pre-synthesise", "context prep" |
| **Integration** | Google NotebookLM, notebooklm-py CLI |
| **Updated** | 30 January 2026 |

---

## Purpose

Pre-aggregate and synthesise context from multiple sources (Google Drive, documents, websites) using NotebookLM before Claude Code sessions. Creates focused, distilled context that maximises effective use of Claude's context window.

---

## Why Pre-Aggregation?

| Challenge | Solution |
|-----------|----------|
| Context window limits | Pre-synthesised summaries |
| Scattered information | Unified notebook |
| Repeated context loading | Cached synthesis |
| Multi-document analysis | Cross-reference insights |

---

## Access Options

### Option 1: NotebookLM Web (Consumer)

URL: [notebooklm.google.com](https://notebooklm.google.com)

- Free to use
- Manual source upload
- Audio overview generation
- Export notes

### Option 2: NotebookLM Enterprise API

For Google Workspace Enterprise users.

```python
from google.cloud import notebooklm_v1

client = notebooklm_v1.NotebookLMClient()
notebook = client.notebooks.create(name="Project Context")
notebook.sources.add(google_drive_id="...")
```

### Option 3: notebooklm-py CLI (Unofficial)

Community tool for programmatic access.

```bash
pip install notebooklm-py

# Authenticate
notebooklm auth login

# Create notebook
notebooklm notebook create "Project Context"

# Add sources
notebooklm source add --url "https://docs.example.com"
notebooklm source add --file "./requirements.md"
notebooklm source add --gdrive "1abc123def456"
```

---

## Integration Workflow

### Pre-Session Context Preparation

```
1. CREATE NOTEBOOK
   └── Topic-specific notebook in NotebookLM

2. ADD SOURCES
   ├── Google Drive documents
   ├── PDF files
   ├── Websites
   └── Pasted text

3. GENERATE INSIGHTS
   ├── Ask NotebookLM synthesis questions
   ├── Generate FAQ
   └── Create briefing document

4. EXPORT CONTEXT
   ├── Copy key insights
   ├── Download summary
   └── Generate audio overview

5. USE IN CLAUDE
   ├── Paste synthesised context
   ├── Reference audio for background
   └── Start with focused understanding
```

---

## Source Types Supported

| Source Type | Method |
|-------------|--------|
| Google Docs | Direct link |
| Google Slides | Direct link |
| PDF files | Upload |
| Websites | URL paste |
| YouTube videos | URL paste |
| Text | Copy/paste |

**Limit:** 50 sources per notebook, 500k words per source

---

## Use Cases for MPD

### Project Onboarding

```markdown
## New Project Context

Sources to add:
- Project PRD
- Technical architecture doc
- Meeting notes
- Slack thread summaries
- Related code documentation

NotebookLM synthesis:
- "What are the key requirements?"
- "What technical decisions were made?"
- "What are the open questions?"

Export: 2-page briefing for Claude session
```

### Research Synthesis

```markdown
## Research Aggregation

Sources to add:
- Industry reports (PDFs)
- Competitor websites
- News articles
- Expert interviews (transcripts)

NotebookLM synthesis:
- "What are the main trends?"
- "Compare competitor approaches"
- "What opportunities exist?"

Export: Research brief with citations
```

### Document Review Prep

```markdown
## Due Diligence Context

Sources to add:
- Contract documents
- Amendment history
- Related correspondence
- Industry standards

NotebookLM synthesis:
- "What are the key terms?"
- "What risks are present?"
- "What's unusual compared to standards?"

Export: Risk summary for LAR-002 analysis
```

---

## Audio Overview Feature

NotebookLM generates AI podcast-style audio overviews.

**Use for:**
- Background listening while coding
- Team briefing distribution
- Passive context absorption

**Generate via:**
1. Click "Audio Overview" in NotebookLM
2. Wait for generation (2-5 minutes)
3. Download or share link

---

## Integration with Claude Code

### Pattern 1: Pre-Session Briefing

```markdown
Before starting complex task:

1. Create NotebookLM notebook with all relevant sources
2. Ask: "Generate a comprehensive briefing for implementing X"
3. Copy synthesis to Claude session
4. Begin work with full context
```

### Pattern 2: Continuous Context

```markdown
For ongoing projects:

1. Maintain project notebook in NotebookLM
2. Add new documents as created
3. Before each session, ask for "updates since last check"
4. Bring fresh synthesis to Claude
```

### Pattern 3: Multi-Source Research

```markdown
For research tasks:

1. Add all research sources to notebook
2. Ask synthesis questions
3. Generate structured report
4. Use as input for Persona 003 analysis
```

---

## notebooklm-py Commands

### Authentication

```bash
notebooklm auth login
notebooklm auth status
```

### Notebook Management

```bash
# List notebooks
notebooklm notebook list

# Create notebook
notebooklm notebook create "Name" --description "Purpose"

# Delete notebook
notebooklm notebook delete <notebook-id>
```

### Source Management

```bash
# Add sources
notebooklm source add --url "https://..."
notebooklm source add --file "./document.pdf"
notebooklm source add --gdrive "drive-file-id"
notebooklm source add --text "Direct text content"

# List sources
notebooklm source list --notebook <id>

# Remove source
notebooklm source remove <source-id>
```

### Querying

```bash
# Ask question
notebooklm ask "What are the key points?" --notebook <id>

# Generate summary
notebooklm summarise --notebook <id> --format markdown

# Export notes
notebooklm export --notebook <id> --output ./context.md
```

---

## Context Compression Synergy

Combine with CTX-001 (Context Compression):

```markdown
1. BEFORE SESSION
   └── Pre-aggregate in NotebookLM (external compression)

2. DURING SESSION
   └── CTX-001 monitors and compresses (internal compression)

3. BETWEEN SESSIONS
   └── NotebookLM maintains persistent context
```

---

## Best Practices

### Do

- Create topic-specific notebooks
- Update sources as project evolves
- Generate synthesis before Claude sessions
- Use audio overviews for passive learning
- Export key insights for session context

### Don't

- Add irrelevant sources (noise)
- Expect real-time sync with Drive
- Use for sensitive/confidential data (review privacy policy)
- Replace Claude analysis with NotebookLM (complementary tools)

---

## Limitations

| Limitation | Workaround |
|------------|------------|
| 50 source limit | Create multiple notebooks |
| No real-time API (consumer) | Use Enterprise or notebooklm-py |
| Google account required | Use alternative aggregation |
| Processing delay | Prepare notebooks in advance |

---

## Alternative: Manual Aggregation

If NotebookLM unavailable:

```markdown
## Manual Context Prep

1. Create summary document in Google Docs
2. Extract key points from each source
3. Synthesise into briefing format
4. Paste into Claude session

Format:
- Executive summary (1 paragraph)
- Key facts (bullet points)
- Open questions
- Source references
```

---

## Integration with Personas

| Persona | NotebookLM Use |
|---------|----------------|
| 003 Market Research | Aggregate competitor data |
| 008 Legal Expert | Pre-synthesise contract context |
| 017 Document Analyst | Prepare multi-doc context |
| 010 The Architect | Aggregate project requirements |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 30 Jan 2026 | Initial NotebookLM Context skill |

---

*Frans Skill LAR-037 | NotebookLM Context v1.0*
