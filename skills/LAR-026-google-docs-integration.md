# LAR-026: Google Docs Integration Skill

## Metadata

| Field | Value |
|-------|-------|
| **Skill ID** | LAR-026 |
| **Version** | 1.0 |
| **Created** | 17 January 2026 |
| **MCP Server** | google-docs-mcp |
| **Trigger** | "Google Doc", "create document", "Google Sheets" |

---

## Purpose

Create, read, write, and format Google Docs, Sheets, and Drive files directly via MCP.

---

## Capabilities

### Google Docs
| Tool | Purpose |
|------|---------|
| `createDocument` | Create new Google Doc |
| `createFromTemplate` | Create from existing template |
| `readGoogleDoc` | Read content (text/JSON/markdown) |
| `appendToGoogleDoc` | Append text to document |
| `insertText` | Insert at specific position |
| `deleteRange` | Remove content |
| `applyTextStyle` | Bold, italic, colours, etc. |
| `applyParagraphStyle` | Alignment, spacing |
| `insertTable` | Create tables |
| `insertImageFromUrl` | Add images from URL |
| `insertLocalImage` | Upload and insert local images |

### Google Sheets
| Tool | Purpose |
|------|---------|
| `createSpreadsheet` | Create new spreadsheet |
| `readSpreadsheet` | Read data from ranges |
| `writeSpreadsheet` | Write data to ranges |
| `appendSpreadsheetRows` | Add new rows |
| `clearSpreadsheetRange` | Clear cells |
| `getSpreadsheetInfo` | Get metadata |
| `addSpreadsheetSheet` | Add new sheet/tab |

### Google Drive
| Tool | Purpose |
|------|---------|
| `listGoogleDocs` | List documents |
| `searchGoogleDocs` | Search by keyword |
| `createFolder` | Create folders |
| `moveFile` | Move files |
| `copyFile` | Copy/duplicate files |
| `renameFile` | Rename files |
| `deleteFile` | Delete files |

---

## Quick Reference

```markdown
# Create a new Google Doc
"Create a Google Doc titled 'Meeting Notes'"

# Read document content
"Read Google Doc ID: 1abc123def456"

# Append content
"Append 'New section' to document 1abc123def456"

# Create spreadsheet
"Create a spreadsheet titled 'Budget 2026'"

# Read spreadsheet data
"Read range A1:D10 from spreadsheet 1xyz789"
```

---

## Document ID

The document ID is found in the URL:
```
https://docs.google.com/document/d/[DOCUMENT_ID]/edit
https://docs.google.com/spreadsheets/d/[SPREADSHEET_ID]/edit
```

---

## Setup Requirements

### One-Time Setup

1. **Google Cloud Project:**
   - Enable Google Docs API
   - Enable Google Sheets API
   - Enable Google Drive API

2. **OAuth Credentials:**
   - Create OAuth 2.0 Desktop App credentials
   - Download as `credentials.json`
   - Place in `C:\GitHub\google-docs-mcp\`

3. **First Run Authorization:**
   ```powershell
   node C:\GitHub\google-docs-mcp\dist\server.js
   ```
   - Follow URL to authorize
   - Paste authorization code
   - Creates `token.json`

---

## Integration with Frans MPD

| Component | Integration |
|-----------|-------------|
| TDP-001 | `mcpl search "google"` discovers tools |
| LAR-005 | Email drafts can be saved to Google Docs |
| LAR-023 | Batch document operations |
| 005 Document Creator | Primary user of this skill |

---

## Example Workflows

### Create Meeting Notes
```markdown
1. "Create a Google Doc titled 'Team Meeting 17 Jan 2026'"
2. "Insert a table with 3 columns: Topic, Owner, Status"
3. "Append the agenda items..."
```

### Report Generation
```markdown
1. "Create spreadsheet 'Q1 Sales Data'"
2. "Write headers to A1:D1"
3. "Append data rows"
4. "Create Google Doc 'Q1 Sales Report'"
5. "Insert summary text and charts"
```

---

## Limitations

- Comments created via API not visually anchored in UI
- Some converted documents (from Word) may have limited support
- OAuth token expires (auto-refreshes)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 17 Jan 2026 | Initial release |

---

*Frans MPD Skill LAR-026 v1.0*
