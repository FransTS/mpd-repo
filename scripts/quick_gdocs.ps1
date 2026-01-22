# Quick MPD to Google Docs
# Creates main consolidated document with content

$ErrorActionPreference = "Continue"
$MPD = "G:\My Drive\Shared_Download\AI_Folder\MPD"

Write-Host "Creating Frans MPD v4.9 in Google Docs..." -ForegroundColor Cyan

# Read the consolidated content
$content = Get-Content "$MPD\GDocs_Export\MPD_Consolidated_v4.9.md" -Raw

# Create the document
Write-Host "Creating document..."
$result = mcpl call google-docs createDocument '{"title": "Frans_MPD_v4.9"}'
Write-Host $result

# Extract document ID from result
if ($result -match '"documentId":\s*"([^"]+)"') {
    $docId = $Matches[1]
    Write-Host "Document ID: $docId"
    
    # Append content (escape for JSON)
    $escaped = $content -replace '\\', '\\\\' -replace '"', '\"' -replace "`r`n", '\n' -replace "`n", '\n'
    
    Write-Host "Adding content..."
    mcpl call google-docs appendToGoogleDoc "{`"documentId`": `"$docId`", `"content`": `"$escaped`"}"
    
    Write-Host "`nDone! Document created: Frans_MPD_v4.9" -ForegroundColor Green
} else {
    Write-Host "Could not extract document ID. Check Google Drive manually." -ForegroundColor Yellow
}
