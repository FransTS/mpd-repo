# MPD Sync Protocol (SYNC-001)

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | SYNC-001 |
| **Version** | 1.0 |
| **Created** | 15 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v4.8.5 |

---

## Purpose

Maintain synchronization between:
1. **GitHub Repository** (source of truth): `C:\GitHub\Master_Prompt_Dictionary`
2. **Google Drive** (cross-device access): `G:\My Drive\Shared_Download\AI_Folder\MPD`
3. **PDF Export** (web/mobile reference): `MPD/GDocs_Export/MPD_Consolidated_v*.pdf`

---

## Sync Architecture

```
Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â     Sync-MPD.ps1      Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â
Ã¢â€â€š     GitHub      Ã¢â€â€š Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€“Âº   Ã¢â€â€š  Google Drive   Ã¢â€â€š
Ã¢â€â€š   Repository    Ã¢â€â€š      (PowerShell)     Ã¢â€â€š      MPD/       Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ                       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ
        Ã¢â€â€š                                         Ã¢â€â€š
        Ã¢â€â€š                                         Ã¢â€â€š
        Ã¢â€“Â¼                                         Ã¢â€“Â¼
Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â                       Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â
Ã¢â€â€š  Source Files   Ã¢â€â€š                       Ã¢â€â€š  Consolidated   Ã¢â€â€š
Ã¢â€â€š  personas/      Ã¢â€â€š                       Ã¢â€â€š  .md file       Ã¢â€â€š
Ã¢â€â€š  protocols/     Ã¢â€â€š                       Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ
Ã¢â€â€š  skills/        Ã¢â€â€š                                Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ                                Ã¢â€â€š Claude converts
                                                   Ã¢â€“Â¼
                                          Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â
                                          Ã¢â€â€š   PDF Export    Ã¢â€â€š
                                          Ã¢â€â€š  (for web/mobile)Ã¢â€â€š
                                          Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ
```

---

## Trigger Phrases

| Phrase | Action |
|--------|--------|
| "Sync MPD" | Run PowerShell sync script |
| "Update MPD PDF" | Generate PDF from consolidated .md |
| "MPD sync status" | Show last sync info |
| "Full MPD refresh" | Git pull + sync + PDF |

---

## Claude Actions

### Action 1: Sync MPD (PC/Laptop Only)

When user says "Sync MPD":

```powershell
# Execute via Windows-MCP
cd C:\GitHub\Master_Prompt_Dictionary\scripts
powershell -ExecutionPolicy Bypass -File "Sync-MPD.ps1"
```

**Expected Output:**
- Files synced from GitHub to Google Drive
- Consolidated .md generated in `GDocs_Export/`
- Sync log updated in Memory

---

### Action 2: Update MPD PDF

When user says "Update MPD PDF":

**Step 1:** Read consolidated markdown
```
Filesystem:read_text_file
Path: G:\My Drive\Shared_Download\AI_Folder\MPD\GDocs_Export\MPD_Consolidated_v4.8.5.md
```

**Step 2:** Create .docx in Claude's container using docx skill

**Step 3:** Convert to PDF using LibreOffice
```bash
soffice --headless --convert-to pdf MPD_Consolidated_v4.8.5.docx
```

**Step 4:** Present PDF for download and instruct user to save to:
```
G:\My Drive\Shared_Download\AI_Folder\MPD\GDocs_Export\
```

---

### Action 3: MPD Sync Status

When user says "MPD sync status":

```
Filesystem:read_text_file
Path: G:\My Drive\Shared_Download\AI_Folder\Memory\Shared\sync_log.md
```

Report last sync date, files updated, and PDF status.

---

### Action 4: Full MPD Refresh

When user says "Full MPD refresh":

1. Execute Sync-MPD.ps1 via Windows-MCP
2. Read consolidated .md
3. Generate PDF
4. Present for download
5. Update sync log

---

## Script Locations

| Script | Location | Purpose |
|--------|----------|---------|
| Sync-MPD.ps1 | `C:\GitHub\Master_Prompt_Dictionary\scripts\` | PowerShell sync |
| Sync-MPD.bat | `C:\GitHub\Master_Prompt_Dictionary\` | Quick launcher |

---

## Sync Log Location

```
G:\My Drive\Shared_Download\AI_Folder\Memory\Shared\sync_log.md
```

Tracks:
- Sync timestamps
- Files updated count
- PDF generation status
- Device used

---

## Device-Specific Behavior

### PC/Laptop (MCP Available)
- Full sync capability
- Can run PowerShell scripts
- Can trigger PDF generation via Claude container
- Updates sync log

### Web/Mobile (No MCP)
- Read-only access to synced files
- Upload PDF manually to chat for reference
- Cannot trigger sync (inform user to use PC/Laptop)

---

## Automatic Sync Triggers

Claude should suggest "Sync MPD" when:
1. User mentions MPD updates were made
2. User asks about latest MPD version
3. Session starts and last sync > 7 days ago (check sync_log.md)

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 15 January 2026 | Initial Sync Protocol |

---

*Frans MPD Sync Protocol v1.0 | SYNC-001*
