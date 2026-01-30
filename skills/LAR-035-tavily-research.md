# Frans Skill: Tavily Research

## Metadata

| Field | Value |
|-------|-------|
| **Name** | tavily-research |
| **Version** | 1.0 |
| **ID** | LAR-035 |
| **Triggers** | "deep research", "tavily search", "research report", "comprehensive research" |
| **MCP Required** | tavily (optional - can use API directly) |
| **Updated** | 30 January 2026 |

---

## Purpose

Integrate Tavily's AI-powered research capabilities for comprehensive web research, content extraction, and research report generation. Provides structured, citation-rich research output optimised for LLM consumption.

---

## Tavily Capabilities

| Feature | Description |
|---------|-------------|
| **Search** | AI-optimised web search with relevance ranking |
| **Extract** | Content extraction from specific URLs |
| **Research** | Comprehensive research reports with citations |
| **Crawl** | Deep website crawling for complete data |

---

## Setup Options

### Option 1: MCP Server (Recommended)

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "tavily": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-tavily"],
      "env": {
        "TAVILY_API_KEY": "tvly-YOUR_API_KEY"
      }
    }
  }
}
```

### Option 2: Environment Variable

Add to `~/.claude/settings.json`:

```json
{
  "env": {
    "TAVILY_API_KEY": "tvly-YOUR_API_KEY"
  }
}
```

### Option 3: Python SDK

```bash
pip install tavily-python
```

```python
from tavily import TavilyClient

client = TavilyClient(api_key="tvly-YOUR_API_KEY")
response = client.search("query")
```

---

## API Key

**Centralised location:** `G:\My Drive\Shared_Download\AI_Folder\config\.env`

```bash
TAVILY_API_KEY=tvly-your-key
```

Get free API key: [tavily.com](https://tavily.com)

Free tier: 1,000 searches/month

See: LAR-038 (env-loader) for loading keys.

---

## Research Modes

### Quick Search (search)

Fast, surface-level results.

```python
response = client.search(
    query="React Server Components best practices 2026",
    search_depth="basic",
    max_results=5
)
```

### Deep Search (search_depth="advanced")

Comprehensive, in-depth results.

```python
response = client.search(
    query="Enterprise authentication patterns",
    search_depth="advanced",
    max_results=10,
    include_domains=["auth0.com", "okta.com"],
    include_answer=True
)
```

### Research Report (research)

Full research report with citations.

```python
response = client.research(
    query="State of AI code assistants 2026",
    model="pro",  # mini, pro, or auto
    citation_format="numbered"  # numbered, mla, apa, chicago
)
```

### Content Extraction (extract)

Extract content from specific URLs.

```python
response = client.extract(
    urls=["https://example.com/article"]
)
```

---

## Claude Integration Patterns

### Pattern 1: Research-Then-Synthesise

```markdown
## Research Task

1. **Gather** - Use Tavily to collect sources
2. **Filter** - Remove low-relevance results
3. **Extract** - Get full content from top sources
4. **Synthesise** - Create coherent summary with citations
5. **Verify** - Cross-reference claims
```

### Pattern 2: Competitive Analysis

```markdown
## Competitive Research

Query: "[Company] vs competitors [year]"

Domains to include:
- Industry review sites
- Tech publications
- Analyst reports

Output: Comparison matrix with citations
```

### Pattern 3: Technical Documentation

```markdown
## Documentation Research

Query: "[Technology] implementation guide"

Focus areas:
- Official documentation
- Best practices
- Common pitfalls
- Example implementations
```

---

## Output Formats

### Search Response

```json
{
  "query": "search query",
  "answer": "AI-generated answer",
  "results": [
    {
      "title": "Page Title",
      "url": "https://example.com",
      "content": "Relevant excerpt...",
      "score": 0.95
    }
  ],
  "response_time": 1.2
}
```

### Research Report

```markdown
# Research Report: [Topic]

## Executive Summary
[AI-generated summary]

## Key Findings
1. Finding 1 [1]
2. Finding 2 [2]

## Detailed Analysis
[In-depth analysis with inline citations]

## Sources
[1] Source Title - https://example.com
[2] Source Title - https://example.com
```

---

## Domain Filtering

### Include Specific Domains

```python
response = client.search(
    query="query",
    include_domains=["github.com", "stackoverflow.com"]
)
```

### Exclude Domains

```python
response = client.search(
    query="query",
    exclude_domains=["reddit.com", "quora.com"]
)
```

---

## Integration with MPD Personas

| Persona | Tavily Use Case |
|---------|-----------------|
| 003 Market Research | Competitive analysis, market trends |
| 008 Legal Expert | Legal precedent research, regulation updates |
| 009 Software Architect | Technology evaluation, best practices |
| 012 Prompt Engineer | AI/LLM research, technique discovery |

---

## Research Workflow

```
1. DEFINE SCOPE
   ├── What question needs answering?
   ├── What sources are authoritative?
   └── What timeframe is relevant?

2. EXECUTE SEARCH
   ├── Run Tavily search with appropriate depth
   ├── Apply domain filters
   └── Request AI-generated answer

3. EXTRACT DETAILS
   ├── Get full content from top results
   ├── Extract specific data points
   └── Capture citations

4. SYNTHESISE
   ├── Combine findings coherently
   ├── Highlight key insights
   ├── Note contradictions
   └── Provide citations

5. DELIVER
   ├── Executive summary
   ├── Detailed findings
   ├── Source list
   └── Recommendations
```

---

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| 401 Unauthorized | Invalid API key | Check TAVILY_API_KEY |
| 429 Rate Limited | Too many requests | Wait or upgrade plan |
| 400 Bad Request | Invalid parameters | Check query format |

---

## Rate Limits

| Plan | Searches/Month | Search Depth |
|------|----------------|--------------|
| Free | 1,000 | Basic |
| Pro | 10,000 | Advanced |
| Enterprise | Unlimited | Advanced + Research |

---

## Comparison with WebSearch

| Feature | WebSearch (Built-in) | Tavily |
|---------|---------------------|--------|
| Speed | Fast | Fast |
| Depth | Surface | Configurable |
| Research Reports | No | Yes |
| Citations | Basic | Structured |
| Content Extraction | Limited | Full |
| Domain Filtering | No | Yes |
| Cost | Included | API credits |

**Recommendation:** Use WebSearch for quick lookups, Tavily for deep research.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 30 Jan 2026 | Initial Tavily Research skill |

---

*Frans Skill LAR-035 | Tavily Research v1.0*
