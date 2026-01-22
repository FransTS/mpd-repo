# Convert MPD to Google Docs
# Run from PowerShell: .\create_gdocs_mpd.ps1

Write-Host "=== Creating Frans MPD Google Docs ===" -ForegroundColor Cyan

# Main consolidated document
Write-Host "`nCreating main MPD document..."
mcpl call google-docs createDocument '{"title": "Frans_MPD_v4.9_Consolidated"}'
Start-Sleep -Seconds 2

# Individual documents for key sections
$docs = @(
    @{title="MPD_01_Persona_Registry"; file="Persona_Registry_v4.9.md"},
    @{title="MPD_02_Skill_Registry"; file="skills\Skill_Registry.md"},
    @{title="MPD_03_README"; file="README.md"}
)

foreach ($doc in $docs) {
    Write-Host "Creating $($doc.title)..."
    $json = "{`"title`": `"$($doc.title)`"}"
    mcpl call google-docs createDocument $json
    Start-Sleep -Seconds 1
}

# Create personas folder and documents
Write-Host "`nCreating Persona documents..."
$personas = @(
    "001-executive-strategic-advisor",
    "002-executive-assistant",
    "003-market-research-specialist",
    "004-sales-enablement",
    "005-document-creator",
    "006-technical-writer",
    "007-marketing-advisor",
    "008-legal-expert",
    "009-software-architect",
    "010-the-architect",
    "011-elite-endurance-coach",
    "012-advanced-prompt-engineer",
    "013-authenticity-reviewer",
    "014-sage-intacct-support-specialist",
    "015-bilingual-transcript-specialist"
)

foreach ($persona in $personas) {
    $title = "MPD_Persona_$persona"
    Write-Host "  Creating $title..."
    $json = "{`"title`": `"$title`"}"
    mcpl call google-docs createDocument $json
    Start-Sleep -Seconds 1
}

# Create key skills
Write-Host "`nCreating Skill documents..."
$skills = @(
    "LAR-006-autonomous-routing",
    "LAR-023-batch-processing",
    "LAR-024-memory-integration",
    "LAR-025-ralph-loop",
    "LAR-026-google-docs-integration"
)

foreach ($skill in $skills) {
    $title = "MPD_Skill_$skill"
    Write-Host "  Creating $title..."
    $json = "{`"title`": `"$title`"}"
    mcpl call google-docs createDocument $json
    Start-Sleep -Seconds 1
}

# Create key protocols
Write-Host "`nCreating Protocol documents..."
$protocols = @(
    "TDP-001-tool-discovery-protocol",
    "PR-018-ralph-loop-protocol",
    "MEM-001-memory-protocol"
)

foreach ($protocol in $protocols) {
    $title = "MPD_Protocol_$protocol"
    Write-Host "  Creating $title..."
    $json = "{`"title`": `"$title`"}"
    mcpl call google-docs createDocument $json
    Start-Sleep -Seconds 1
}

Write-Host "`n=== Done! ===" -ForegroundColor Green
Write-Host "Created Google Docs for Frans MPD v4.9"
Write-Host "Check your Google Drive for documents starting with 'MPD_'"
Write-Host "`nTo populate with content, open each in Google Drive and paste from:"
Write-Host "G:\My Drive\Shared_Download\AI_Folder\MPD\"
