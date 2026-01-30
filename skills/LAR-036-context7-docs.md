# Frans Skill: Context7 Documentation

## Metadata

| Field | Value |
|-------|-------|
| **Name** | context7-docs |
| **Version** | 1.0 |
| **ID** | LAR-036 |
| **Triggers** | "use context7", "library docs", "API documentation", "latest docs" |
| **MCP Required** | context7 |
| **Updated** | 30 January 2026 |

---

## Purpose

Fetch up-to-date, version-specific library documentation and code examples directly into prompts. Eliminates outdated API references and hallucinated methods by pulling from official sources.

---

## Why Context7?

| Problem | Context7 Solution |
|---------|-------------------|
| Outdated training data | Fetches live documentation |
| Hallucinated APIs | Real, verified methods |
| Version mismatches | Version-specific docs |
| Missing examples | Official code samples |

---

## Setup

### Claude Code CLI

```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
```

### Claude Desktop Config

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

### Optional: API Key for Higher Rate Limits

**Centralised location:** `G:\My Drive\Shared_Download\AI_Folder\config\.env`

```bash
CONTEXT7_API_KEY=your-key
```

Get free key: [context7.com/dashboard](https://context7.com/dashboard)

See: LAR-038 (env-loader) for loading keys.

---

## Usage

### Trigger Phrase

Add `use context7` to any prompt:

```
How do I create a server component in Next.js 15? use context7
```

### Auto-Invoke Rule

Add to Claude settings for automatic invocation:

```
Always use Context7 MCP when I need library/API documentation,
code generation, setup or configuration steps.
```

---

## Available Tools

### resolve-library-id

Resolves a library name to Context7-compatible ID.

**Input:** General library name (e.g., "react", "nextjs")
**Output:** Context7 library ID for documentation lookup

### get-library-docs

Fetches documentation for a specific library.

**Input:** Context7 library ID + topic
**Output:** Relevant documentation sections + code examples

---

## Supported Libraries

Context7 supports 1000+ libraries including:

| Category | Libraries |
|----------|-----------|
| **Frontend** | React, Vue, Angular, Svelte, Next.js, Nuxt |
| **Backend** | Express, Fastify, NestJS, Django, FastAPI |
| **Database** | Prisma, Drizzle, TypeORM, Mongoose |
| **AI/ML** | LangChain, LlamaIndex, OpenAI SDK, Anthropic SDK |
| **Cloud** | AWS SDK, Firebase, Supabase, Vercel |
| **Testing** | Jest, Vitest, Playwright, Cypress |

---

## Integration Patterns

### Pattern 1: Implementation Guidance

```markdown
## Task: Implement feature X

1. Query Context7 for library docs
2. Get official patterns and examples
3. Implement following official guidance
4. Verify against documentation
```

### Pattern 2: Version Migration

```markdown
## Task: Migrate from v1 to v2

1. Get v2 documentation via Context7
2. Identify breaking changes
3. Get migration guide examples
4. Apply changes with official patterns
```

### Pattern 3: Error Resolution

```markdown
## Task: Fix "X is not a function" error

1. Query Context7 for correct API
2. Compare with current usage
3. Get correct signature and examples
4. Fix implementation
```

---

## Example Workflows

### React Server Components

```
Prompt: "How do I fetch data in a React Server Component? use context7"

Context7 provides:
- Official RSC documentation
- Data fetching patterns
- Caching strategies
- Code examples
```

### Prisma Schema

```
Prompt: "Show me Prisma schema relations for many-to-many use context7"

Context7 provides:
- Relation syntax
- Implicit vs explicit relations
- Migration commands
- Query examples
```

### Next.js App Router

```
Prompt: "How do I create dynamic routes in Next.js App Router? use context7"

Context7 provides:
- Folder structure
- Dynamic segment syntax
- generateStaticParams
- Loading and error states
```

---

## Best Practices

### Do

- Include `use context7` for any library-specific questions
- Specify version when relevant: "Next.js 15 use context7"
- Ask for specific features: "Prisma transactions use context7"

### Don't

- Use for general programming concepts
- Expect it to replace reading full documentation
- Assume all edge cases are covered

---

## Integration with MPD

### With LAR-006 (Autonomous Routing)

```markdown
When code generation involves:
- New library APIs
- Version-specific features
- Unknown method signatures

Auto-invoke Context7 for verification.
```

### With Persona 009 (Software Architect)

```markdown
Architecture decisions requiring:
- Current library capabilities
- Latest best practices
- Official patterns

Use Context7 for authoritative guidance.
```

---

## Rate Limits

| Tier | Requests/Day |
|------|--------------|
| Free (no key) | 100 |
| Free (with key) | 1,000 |
| Pro | 10,000 |

---

## Troubleshooting

### MCP Not Connecting

```bash
# Verify installation
npx -y @upstash/context7-mcp@latest --version

# Check Claude MCP list
claude mcp list
```

### Library Not Found

```markdown
If library not found:
1. Try alternative names (nextjs vs next.js)
2. Check if library is in Context7 index
3. Fall back to WebSearch for newer libraries
```

### Outdated Results

```markdown
Context7 updates documentation regularly.
For bleeding-edge features:
1. Check library's GitHub directly
2. Use WebSearch for recent announcements
3. Combine with official changelog
```

---

## Comparison with Alternatives

| Feature | Context7 | WebSearch | Manual Docs |
|---------|----------|-----------|-------------|
| Speed | Fast | Fast | Slow |
| Accuracy | High | Variable | High |
| Version-specific | Yes | No | Yes |
| Code examples | Yes | Sometimes | Yes |
| Integration | Native | Native | Manual |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 30 Jan 2026 | Initial Context7 Documentation skill |

---

*Frans Skill LAR-036 | Context7 Documentation v1.0*
