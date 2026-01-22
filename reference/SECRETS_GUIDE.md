# Secrets Management Guide
## HuggingFace Token Storage

**IMPORTANT:** Never commit secrets (API tokens, passwords) to Git repositories.

---

## Token Location (Local Only)

The HuggingFace token is stored in these LOCAL files only (not synced to GitHub):

### PC
- `C:\GitHub\transcription-mcp\.env`
- `%APPDATA%\Claude\claude_desktop_config.json`

### Laptop
- `C:\GitHub\transcription-mcp\.env`
- `%APPDATA%\Claude\claude_desktop_config.json`

---

## How to Get Your Token

1. Go to: https://huggingface.co/settings/tokens
2. Create a "Read" token
3. Copy the token (starts with `hf_`)

---

## Where to Use the Token

### .env File
```
HF_TOKEN=hf_your_actual_token_here
WORK_DIR=G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs
```

### Claude Desktop Config
```json
"env": {
  "HF_TOKEN": "hf_your_actual_token_here",
  "WORK_DIR": "..."
}
```

---

## Security Rules

1. ✅ Store tokens in local `.env` files
2. ✅ Add `.env` to `.gitignore`
3. ✅ Store tokens in local app configs
4. ❌ NEVER put tokens in markdown/text files that sync to Git
5. ❌ NEVER commit tokens to version control
6. ❌ NEVER share tokens in documentation

---

## If Token is Exposed

1. **Immediately** revoke the token at https://huggingface.co/settings/tokens
2. Create a new token
3. Update all local files with new token
4. If pushed to GitHub, reset repository history

---

*Last updated: 22 January 2026*
