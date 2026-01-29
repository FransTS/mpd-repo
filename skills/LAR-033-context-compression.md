# Frans Skill: Context Compression

## Metadata

| Field | Value |
|-------|-------|
| **Name** | context-compression |
| **Version** | 1.0 |
| **ID** | LAR-033 |
| **Triggers** | automatic at thresholds, "compress", "context status" |
| **Always Active** | YES |
| **Created** | 29 January 2026 |
| **Source** | LangChain Deep Agents SDK methodology |

---

## Purpose

Execute context compression operations per CTX-001 protocol. Manages the three-tier compression architecture to prevent context rot while preserving task-critical information.

---

## Compression Functions

### 1. Offload Large Tool Result

**Trigger:** Tool result > 15,000 tokens

`python
def offload_tool_result(result, tool_name):
    """
    Tier 1: Offload large tool results to filesystem
    
    Args:
        result: The full tool result content
        tool_name: Name of the tool that produced it
    
    Returns:
        Reference object with path and preview
    """
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{timestamp}_{tool_name}.md"
    path = f"cache/offloaded/{filename}"
    
    # Write full content
    write_file(path, result)
    
    # Create reference
    return {
        "path": path,
        "preview": result[:500],  # First ~10 lines
        "tokens_saved": estimate_tokens(result),
        "message": f"Full content saved to {path}"
    }
`

**In-Context Replacement:**
`markdown
## Offloaded: {tool_name} Result
**Path:** cache/offloaded/{filename}
**Tokens Saved:** {count}
**Preview:**
> {first 10 lines}

*Use file read to access full content*
`

### 2. Truncate Tool Inputs

**Trigger:** Context > 50% AND old write/edit calls exist

`python
def truncate_tool_inputs(conversation_history):
    """
    Tier 2: Truncate old tool call arguments
    
    Identifies tool calls with large inputs (file writes, edits)
    that are already persisted to filesystem
    
    Returns:
        Modified conversation with truncated tool calls
    """
    for message in conversation_history:
        if is_tool_call(message) and is_large_input(message):
            if content_persisted(message.file_path):
                message.arguments = truncate_to_reference(message)
    
    return conversation_history
`

**Truncated Format:**
`markdown
## Tool Call: {tool_name}
**Original Size:** {tokens} tokens
**Path:** {file_path}
**Summary:** {brief description of what was done}
**Status:** Content persisted to disk ÇƒÐ
`

### 3. Generate Session Summary

**Trigger:** Context > 75% AND Tiers 1-2 insufficient

`python
def generate_session_summary(conversation, session_id):
    """
    Tier 3: Summarise conversation and archive full history
    
    Creates structured summary preserving:
    - Session intent (CRITICAL)
    - Artifacts created
    - Key decisions
    - Current progress
    - Next steps
    
    Returns:
        Summary object and archive path
    """
    # Archive full conversation
    archive_path = f"cache/conversations/{session_id}_full.md"
    write_file(archive_path, format_conversation(conversation))
    
    # Generate structured summary
    summary = {
        "session_id": session_id,
        "generated": datetime.now(),
        "intent": extract_intent(conversation),
        "artifacts": list_artifacts(conversation),
        "decisions": extract_decisions(conversation),
        "progress": assess_progress(conversation),
        "next_steps": determine_next_steps(conversation),
        "recovery_refs": {
            "full_conversation": archive_path,
            "offloaded": "cache/offloaded/",
            "checkpoints": "cache/checkpoints/"
        }
    }
    
    return summary
`

**Summary Output Format:**
`markdown
## Session Summary [{session_id}]
**Generated:** {timestamp} SAST
**Context Saved:** {tokens} tokens

### Session Intent
{Original user objective - CRITICAL}

### Artifacts Created
| Artifact | Path | Status |
|----------|------|--------|
| {name} | {path} | {status} |

### Key Decisions
1. {Decision}: {rationale}

### Current Progress
- **Phase:** {phase}
- **Completed:** {list}
- **Remaining:** {list}

### Critical Facts
- {fact 1}
- {fact 2}

### Next Steps
1. {immediate action}
2. {following action}

### Recovery References
- Full conversation: {archive_path}
- Offloaded content: cache/offloaded/
- Checkpoints: cache/checkpoints/
`

---

## Context Monitoring

### Check Context Status

`python
def check_context_status():
    """
    Assess current context window usage
    
    Returns:
        Status object with level and recommendations
    """
    usage = estimate_context_usage()
    
    if usage < 0.25:
        return {"level": "GREEN", "action": "Continue normally"}
    elif usage < 0.50:
        return {"level": "YELLOW", "action": "Monitor, prepare compression"}
    elif usage < 0.75:
        return {"level": "ORANGE", "action": "Apply Tier 1 & 2"}
    elif usage < 0.85:
        return {"level": "RED", "action": "Apply Tier 3 summarisation"}
    else:
        return {"level": "CRITICAL", "action": "Checkpoint + fresh session"}
`

**Status Report Format:**
`markdown
## Context Status Report
**Timestamp:** {datetime} SAST
**Estimated Usage:** {percentage}%
**Level:** {GREEN|YELLOW|ORANGE|RED|CRITICAL}

### Current State
- **Tool results offloaded:** {count} ({tokens} tokens saved)
- **Tool inputs truncated:** {count} ({tokens} tokens saved)
- **Summarisations performed:** {count}

### Recommendation
{action recommendation}

### Compression History
| Time | Type | Tokens Saved |
|------|------|--------------|
| {time} | {tier} | {count} |
`

---

## Goal Drift Detection

### Post-Compression Verification

`python
def verify_intent_alignment(summary, current_action):
    """
    Check if current trajectory aligns with session intent
    
    Returns:
        Verification result with any drift warnings
    """
    checks = {
        "intent_match": compare_to_intent(current_action, summary.intent),
        "trajectory_valid": is_progressing_toward_goal(current_action),
        "clarification_flag": is_asking_clarification_immediately(),
        "completion_flag": is_declaring_complete_without_deliverable()
    }
    
    drift_detected = any_drift_indicators(checks)
    
    if drift_detected:
        return {
            "status": "DRIFT_DETECTED",
            "action": "RECOVER_CONTEXT",
            "details": checks
        }
    
    return {"status": "ALIGNED", "continue": True}
`

**Drift Warning Format:**
`markdown
ƒsÿ‹÷? **Goal Drift Warning**

**Detection:** {what triggered warning}
**Original Intent:** {session intent}
**Current Action:** {what we're doing now}

**Recovery Action:**
Searching archived content for original context...

**Recommendation:** {recovery suggestion}
`

---

## Recovery Operations

### Search Offloaded Content

`python
def recover_offloaded(search_query):
    """
    Search offloaded content for specific information
    
    Args:
        search_query: What to look for
    
    Returns:
        Relevant content from offloaded files
    """
    results = []
    for file in list_files("cache/offloaded/"):
        content = read_file(file)
        if matches_query(content, search_query):
            results.append({
                "file": file,
                "excerpt": extract_relevant(content, search_query)
            })
    
    return results
`

### Recover From Archive

`python
def recover_from_archive(session_id, search_context):
    """
    Search full conversation archive for specific context
    
    Returns:
        Relevant conversation excerpts
    """
    archive_path = f"cache/conversations/{session_id}_full.md"
    full_conversation = read_file(archive_path)
    
    return extract_relevant_sections(full_conversation, search_context)
`

---

## Compression Decision Tree

`
1. TOOL RESULT RECEIVED
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Is it > 15,000 tokens?
       ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª YES ƒÅ' Apply Tier 1 immediately
       ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª NO ƒÅ' Continue

2. CONTEXT THRESHOLD CHECK (periodic)
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Check current usage percentage
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª < 50% ƒÅ' Continue normally
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª 50-75% ƒÅ' Apply Tier 2
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª 75-85% ƒÅ' Apply Tier 3
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª > 85% ƒÅ' Checkpoint + recommend fresh session

3. POST-COMPRESSION
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª If Tier 3 applied ƒÅ' Run drift detection
   ÇŸ¶½Ç½ƒ'ª¶?Ç.ƒ?oÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª If drift detected ƒÅ' Recover and realign
   ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ'ª¶?ÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ªÇŸ¶½Ç½ƒ'ª¶?Ç½ƒ?s¶ª Continue with task
`

---

## Integration with Other Skills

| Skill | Integration |
|-------|-------------|
| **LAR-006** | Routing triggers compression at thresholds |
| **LAR-014** | Context tracking informs compression |
| **LAR-024** | Memory integration for persistence |
| **LAR-028** | Long context processing coordination |
| **SES-001** | Checkpointing on compression events |
| **PR-018** | Ralph Loop uses fresh context inherently |
| **PR-019** | RLM sub-calls manage context per call |

---

## Persona Integration

| Persona | Usage |
|---------|-------|
| **ALL** | Always active - automatic compression |
| 010 The Architect | Coordinates cross-persona compression |
| 017 Document Analyst | Heavy use during long document analysis |

---

## Stop Hooks

`xml
<stop-hook id="HOOK-CTX-001" type="SOFT">
  <trigger>Large tool result detected (> 15k tokens)</trigger>
  <validation>
    <check>Result can be offloaded safely</check>
    <check>Preview captures essential info</check>
  </validation>
  <on-pass>Apply Tier 1 offloading</on-pass>
  <on-fail>Keep in context with warning</on-fail>
</stop-hook>

<stop-hook id="HOOK-CTX-002" type="GATE">
  <trigger>Context exceeds 50%</trigger>
  <validation>
    <check>Old tool inputs exist to truncate</check>
    <check>Content already persisted to disk</check>
  </validation>
  <on-pass>Apply Tier 2 truncation</on-pass>
  <on-fail>Skip to Tier 3 evaluation</on-fail>
</stop-hook>

<stop-hook id="HOOK-CTX-003" type="GATE">
  <trigger>Context exceeds 75%</trigger>
  <validation>
    <check>Tier 1 and 2 exhausted or insufficient</check>
    <check>Session intent captured</check>
    <check>Artifacts documented</check>
  </validation>
  <on-pass>Apply Tier 3 summarisation</on-pass>
  <on-fail>Immediate checkpoint + fresh session</on-fail>
</stop-hook>

<stop-hook id="HOOK-CTX-004" type="SOFT">
  <trigger>Post Tier 3 summarisation</trigger>
  <validation>
    <check>Intent alignment verified</check>
    <check>No drift indicators present</check>
  </validation>
  <on-pass>Continue with task</on-pass>
  <on-fail>Recover context and realign</on-fail>
</stop-hook>

<stop-hook id="HOOK-CTX-005" type="HARD">
  <trigger>Context exceeds 85%</trigger>
  <action>Create checkpoint, recommend fresh session</action>
</stop-hook>
`

---

## Rules

`
+offload-large-results             # Always offload > 15k token results
+truncate-persisted-inputs         # Truncate tool inputs already on disk
+preserve-session-intent           # Never lose original objective
+archive-before-summarise          # Always save full conversation
+verify-post-compression           # Check for goal drift after Tier 3
+recover-on-drift                  # Actively recover if drift detected
-lose-critical-facts               # Never compress away essential info
-assume-context-available          # Always check if info needs recovery
-ignore-compression-thresholds     # Follow CTX-001 thresholds
`

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 29 January 2026 | Initial release based on LangChain Deep Agents |

---

*Frans Skill LAR-033 | Context Compression v1.0 | Always Active*
