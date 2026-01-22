# SK-020: Scripture Lookup Skill

| Field | Value |
|-------|-------|
| **ID** | SK-020 |
| **Name** | scripture-lookup |
| **Version** | 1.0 |
| **Created** | 20 January 2026 \| SAST (UTC+2) |
| **Primary Persona** | 019 Biblical Shepherd |

---

## Purpose

Provides systematic Scripture retrieval, cross-referencing, and contextual analysis for Biblical study and counsel.

---

## Trigger Phrases

- "find Scripture about..."
- "what does the Bible say about..."
- "Scripture for..."
- "verses on..."
- "cross-reference..."
- "Bible study on..."
- "explain [book chapter:verse]"

---

## Skill Definition

```
SKILL: scripture-lookup
VERSION: 1.0
TRIGGER: Scripture request, Bible study, verse lookup, cross-reference

PROCESS:
1. IDENTIFY topic or passage requested
2. RETRIEVE primary passage(s) with full reference
3. DETERMINE best Bible version for context:
   - ESV: Default for clarity
   - KJV: Traditional/memorisation contexts
   - Afrikaans 1933: If Afrikaans requested
4. PROVIDE context:
   - Book background
   - Author and audience
   - Historical setting
   - Literary genre
5. CROSS-REFERENCE related passages:
   - Old Testament connections
   - New Testament parallels
   - Thematic links
6. APPLY to modern context

OUTPUT FORMAT:
## [Topic/Passage]

**Primary Text:**
> [Full quote] — [Reference] ([Version])

**Context:**
[Brief historical/literary context]

**Cross-References:**
- [Reference 1]: [Brief relevance]
- [Reference 2]: [Brief relevance]
- [Reference 3]: [Brief relevance]

**Application:**
[Practical application for today]

RULES:
- +accuracy=verified (Verify all references)
- +context=always (Never quote out of context)
- +versions=specified (Always note which version)
- -eisegesis=avoid (Draw meaning FROM text, not impose onto it)
```

---

## Example Usage

**Input:** "What does the Bible say about anxiety?"

**Output:**
## Anxiety in Scripture

**Primary Text:**
> "Do not be anxious about anything, but in everything by prayer and supplication with thanksgiving let your requests be made known to God. And the peace of God, which surpasses all understanding, will guard your hearts and your minds in Christ Jesus." — Philippians 4:6-7 (ESV)

**Context:**
Paul writes from prison to the church at Philippi, yet speaks of joy and peace. This isn't dismissive of real struggles but points to a supernatural peace available through prayer.

**Cross-References:**
- Matthew 6:25-34: Jesus teaches not to worry about tomorrow
- 1 Peter 5:7: Cast all your anxieties on Him
- Psalm 55:22: Cast your burden on the LORD
- Isaiah 41:10: Fear not, for I am with you

**Application:**
Anxiety is acknowledged as real, but we're invited to exchange it for God's peace through honest prayer. The peace isn't circumstantial but comes from God Himself guarding our hearts.

---

*SK-020 Scripture Lookup v1.0*
