# Browser Security Protocol v1.0

## Metadata

| Field | Value |
|-------|-------|
| **Protocol ID** | SEC-001 |
| **Version** | 1.0 |
| **Last Updated** | 12 January 2026 |
| **Owner** | Frans Vermaak (CTGO, LarcAI) |
| **Compatible With** | Master Prompts v4.8 |

---

## Purpose

Define mandatory security requirements for all browser automation activities performed by Claude via MCP or other tools. Protect user credentials, session data, and privacy.

---

## Hard Rules (Never Violate)

```xml
<security-rules type="absolute">
  <rule id="SEC-001">+browser=chrome-incognito-only</rule>
  <rule id="SEC-002">+password=never-autonomous</rule>
  <rule id="SEC-003">-store-credentials</rule>
  <rule id="SEC-004">-autofill-sensitive</rule>
  <rule id="SEC-005">-access-saved-passwords</rule>
  <rule id="SEC-006">+mfa=user-completes</rule>
</security-rules>
```

### Rule Explanations

| Rule ID | Rule | Description |
|---------|------|-------------|
| SEC-001 | `+browser=chrome-incognito-only` | ALL browser windows opened by Claude MUST use Chrome Incognito mode |
| SEC-002 | `+password=never-autonomous` | NEVER enter passwords without explicit user consent per instance |
| SEC-003 | `-store-credentials` | NEVER save, store, or cache any credentials |
| SEC-004 | `-autofill-sensitive` | NEVER use browser autofill for passwords, payment info, or sensitive data |
| SEC-005 | `-access-saved-passwords` | NEVER access Chrome's saved passwords or password manager |
| SEC-006 | `+mfa=user-completes` | User MUST complete all MFA/2FA challenges themselves |

---

## Browser Launch Protocol

### Standard Launch Command (Windows)

```powershell
# ALWAYS use this format for browser automation
Start-Process "chrome.exe" -ArgumentList "--incognito", "[URL]"
```

### Via Windows-MCP App-Tool

```
When launching browser:
1. Use PowerShell Start-Process with --incognito flag
2. NEVER use App-Tool to launch regular Chrome window
3. Verify incognito mode before proceeding
```

### Verification

After launching, verify incognito mode by checking for:
- "Incognito" indicator in window title or UI
- Private browsing icon visible
- No access to browsing history or saved data

---

## Authentication Handling

### Passwords

```
WHEN password entry is required:
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 1. STOP automation
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 2. INFORM user: "This site requires login credentials"
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 3. REQUEST: "Please enter your password manually"
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 4. WAIT for user confirmation: "Done" or "Continue"
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ 5. RESUME automation after user completes login
```

### Multi-Factor Authentication (MFA)

```
WHEN MFA/2FA is triggered:
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 1. STOP automation
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 2. INFORM user: "MFA verification required"
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 3. WAIT for user to complete MFA
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 4. User confirms: "Done" or "Continue"
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ 5. RESUME automation
```

### OAuth/SSO Flows

```
WHEN OAuth or SSO login appears:
Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 1. INFORM user of the authentication flow
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 2. MAY click "Sign in with [Provider]" button
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 3. STOP at credential entry
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ 4. User completes authentication
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ 5. RESUME after user confirms
```

---

## Prohibited Actions

| Action | Status | Reason |
|--------|--------|--------|
| Type passwords | Ã¢ÂÅ’ PROHIBITED | Security risk |
| Access password manager | Ã¢ÂÅ’ PROHIBITED | Privacy violation |
| Save login credentials | Ã¢ÂÅ’ PROHIBITED | Data exposure risk |
| Use autofill for payments | Ã¢ÂÅ’ PROHIBITED | Financial security |
| Bypass CAPTCHA | Ã¢ÂÅ’ PROHIBITED | Terms violation |
| Complete MFA for user | Ã¢ÂÅ’ PROHIBITED | Security bypass |
| Access browser history | Ã¢ÂÅ’ PROHIBITED | Privacy violation |
| Access cookies/sessions | Ã¢ÂÅ’ PROHIBITED | Session hijacking risk |

---

## Permitted Actions

| Action | Status | Conditions |
|--------|--------|------------|
| Open incognito browser | Ã¢Å“â€¦ PERMITTED | Always use --incognito |
| Navigate to URLs | Ã¢Å“â€¦ PERMITTED | User-requested sites |
| Fill non-sensitive forms | Ã¢Å“â€¦ PERMITTED | Name, address, etc. |
| Click buttons/links | Ã¢Å“â€¦ PERMITTED | Standard navigation |
| Take screenshots | Ã¢Å“â€¦ PERMITTED | For task completion |
| Read page content | Ã¢Å“â€¦ PERMITTED | For information extraction |
| Download files | Ã¢Å¡Â Ã¯Â¸Â ASK FIRST | Requires user approval |

---

## Session Management

### Session Start

```
1. Launch Chrome with --incognito flag
2. Verify incognito mode active
3. Proceed with automation task
```

### Session End

```
1. Complete task or reach authentication barrier
2. Inform user of status
3. Close incognito window (optional, based on task)
4. No session data persists (incognito ensures this)
```

### Why Incognito?

| Benefit | Description |
|---------|-------------|
| No history | Browsing not recorded |
| No cookies persist | Session ends with window |
| No autofill | Prevents credential exposure |
| Clean state | Each session starts fresh |
| Privacy | User data protected |

---

## Error Handling

### Authentication Required Unexpectedly

```
IF login page appears unexpectedly:
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ STOP automation
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ SCREENSHOT current state
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ INFORM user: "Unexpected login required at [URL]"
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ AWAIT user instruction
```

### Sensitive Data Detected

```
IF form requests sensitive data (SSN, credit card, etc.):
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ STOP automation
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ INFORM user: "This form requests sensitive information"
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬ LIST fields requiring sensitive data
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬ USER must complete these fields manually
```

---

## Integration with Other Protocols

| Protocol | Integration Point |
|----------|-------------------|
| Governance Protocol | Level 4 (Human Control) for all credential actions |
| MCP Integration | Browser launch commands |
| Autonomous Protocols | Hard stop at authentication |
| QA Protocol | Verify incognito before proceeding |

---

## Audit Requirements

### Log for Each Browser Session

```markdown
## Browser Session Log

**Timestamp:** [DD Month YYYY HH:MM SAST]
**Mode:** Incognito Ã¢Å“â€œ
**Sites Visited:** [List]
**Authentication Events:** [None / User completed at X]
**Sensitive Data Handling:** [None / User entered at X]
**Session Outcome:** [Completed / Stopped for auth]
```

---

## Quick Reference Card

```
Ã¢â€Å’Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â
Ã¢â€â€š           BROWSER SECURITY QUICK REFERENCE          Ã¢â€â€š
Ã¢â€Å“Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Â¤
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€š  Ã¢Å“â€¦ ALWAYS                                          Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Use Chrome Incognito (--incognito)            Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Stop at password fields                       Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Let user complete MFA                         Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Verify incognito before actions               Ã¢â€â€š
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€š  Ã¢ÂÅ’ NEVER                                           Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Enter passwords                               Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Access saved credentials                      Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Complete MFA/2FA                              Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Use regular (non-incognito) browser           Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Bypass security measures                      Ã¢â€â€š
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€š  Ã¢Å¡Â Ã¯Â¸Â ASK FIRST                                       Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Download files                                Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Submit forms with personal data               Ã¢â€â€š
Ã¢â€â€š     Ã¢â‚¬Â¢ Navigate to unfamiliar sites                  Ã¢â€â€š
Ã¢â€â€š                                                     Ã¢â€â€š
Ã¢â€â€Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€â‚¬Ã¢â€Ëœ
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 12 January 2026 | Initial Browser Security Protocol |

---

*Frans Browser Security Protocol v1.0 | Compatible with Master Prompts v4.8*
