# SK-021: Devotional Generator Skill

| Field | Value |
|-------|-------|
| **ID** | SK-021 |
| **Name** | devotional-generator |
| **Version** | 1.0 |
| **Created** | 20 January 2026 \| SAST (UTC+2) |
| **Primary Persona** | 019 Biblical Shepherd |

---

## Purpose

Generates structured daily devotionals, Scripture meditation guides, and spiritual reflection content.

---

## Trigger Phrases

- "devotional on..."
- "daily devotion..."
- "meditation on..."
- "quiet time guide..."
- "Scripture reflection..."
- "morning devotion..."
- "evening devotion..."

---

## Skill Definition

```
SKILL: devotional-generator
VERSION: 1.0
TRIGGER: Devotional request, meditation guide, quiet time, spiritual reflection

PROCESS:
1. IDENTIFY theme, passage, or need
2. SELECT appropriate Scripture passage
3. STRUCTURE devotional content:
   - Opening thought
   - Scripture reading
   - Exposition
   - Reflection questions
   - Prayer prompt
   - Action step
4. TAILOR to context:
   - Morning/evening
   - Season (Advent, Lent, etc.)
   - Life circumstance
   - Requested length

OUTPUT FORMATS:

### Standard Devotional (5-7 min read)
## [Title]

**Scripture:** [Reference]
> [Full passage quote]

**Reflection:**
[2-3 paragraphs of exposition and application]

**Consider:**
- [Reflection question 1]
- [Reflection question 2]
- [Reflection question 3]

**Pray:**
[Prayer prompt or written prayer]

**Today:**
[One practical action step]

---

### Brief Devotional (2-3 min read)
## [Title]

**Read:** [Reference]

**Think:** [Key insight in 2-3 sentences]

**Pray:** [One-line prayer focus]

**Do:** [Simple action]

---

### Extended Study (15-20 min)
## [Title]

**Opening Prayer**

**Scripture Reading:** [Reference]
> [Full passage]

**Historical Context:**
[Background information]

**Verse-by-Verse:**
[Detailed exposition]

**Theological Significance:**
[Doctrinal connections]

**Personal Application:**
[Reflection questions and life application]

**Memory Verse:**
[Key verse to memorise]

**Closing Prayer**

**Further Study:**
[Additional passages and resources]

RULES:
- +scripture=central (Scripture drives the devotional)
- +spirit=inviting (Create space for Holy Spirit)
- +practical=always (End with application)
- +tone=warm,encouraging (Build faith, not guilt)
- -generic=avoid (Make it specific and meaningful)
```

---

## Example Usage

**Input:** "Morning devotional on God's faithfulness"

**Output:**
## Great Is His Faithfulness

**Scripture:** Lamentations 3:22-23 (ESV)
> "The steadfast love of the LORD never ceases; his mercies never come to an end; they are new every morning; great is your faithfulness."

**Reflection:**
These words come from the book of Lamentations — written amid destruction, loss, and grief. Jeremiah, the weeping prophet, has watched Jerusalem fall. Yet in the middle of this dark book, he pauses to declare something remarkable: God's mercies are new every morning.

This isn't denial of pain. It's faith that sees beyond circumstances to the character of God. Whatever yesterday held — failures, disappointments, unanswered prayers — this morning brings fresh mercy. God doesn't ration His grace. He doesn't hold yesterday's mistakes over you today.

The sunrise itself preaches this truth. Every morning, light breaks through darkness again. And every morning, God's faithfulness meets you before your feet hit the floor.

**Consider:**
- What "yesterday" do you need to leave behind today?
- Where have you seen God's faithfulness recently, even in small ways?
- How does knowing His mercies are "new" change how you approach today?

**Pray:**
Father, thank You that Your mercies aren't recycled — they're brand new this morning. Help me to receive Your fresh grace today and to trust Your faithfulness in whatever I face. Amen.

**Today:**
Pause three times today to whisper "Great is Your faithfulness" — morning, midday, and evening. Notice where you see His mercy show up.

---

*SK-021 Devotional Generator v1.0*
