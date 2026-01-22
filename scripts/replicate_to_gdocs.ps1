# Replicate MPD to Google Docs
# Run from PowerShell with: .\replicate_to_gdocs.ps1

$ErrorActionPreference = "Continue"
$MPD_PATH = "G:\My Drive\Shared_Download\AI_Folder\MPD"

Write-Host "=== Creating MPD folder structure in Google Drive ===" -ForegroundColor Cyan

# Create main folder
Write-Host "Creating main folder: Frans_MPD_GDocs"
mcpl call google-docs createFolder '{"folderName": "Frans_MPD_GDocs"}'
Start-Sleep -Seconds 2

# Get the folder ID (we'll need to search for it)
Write-Host "Searching for created folder..."
$folderResult = mcpl call google-docs searchDriveFiles '{"query": "Frans_MPD_GDocs", "fileType": "folder"}'
Write-Host $folderResult

Write-Host ""
Write-Host "=== Creating subfolders ===" -ForegroundColor Cyan

# Create subfolders
$subfolders = @("Personas", "Skills", "Protocols", "Templates", "Reference")
foreach ($folder in $subfolders) {
    Write-Host "Creating subfolder: $folder"
    mcpl call google-docs createFolder "{`"folderName`": `"MPD_$folder`"}"
    Start-Sleep -Seconds 1
}

Write-Host ""
Write-Host "=== Converting key documents ===" -ForegroundColor Cyan

# Function to create a Google Doc from markdown file
function Convert-ToGoogleDoc {
    param(
        [string]$FilePath,
        [string]$DocTitle
    )
    
    if (Test-Path $FilePath) {
        $content = Get-Content $FilePath -Raw -ErrorAction SilentlyContinue
        if ($content) {
            # Escape special characters for JSON
            $content = $content -replace '\\', '\\\\' -replace '"', '\"' -replace "`r`n", '\n' -replace "`n", '\n' -replace "`t", '\t'
            
            # Truncate if too long (API limits)
            if ($content.Length -gt 50000) {
                $content = $content.Substring(0, 50000) + "\n\n[Content truncated...]"
            }
            
            Write-Host "  Creating: $DocTitle"
            $json = "{`"title`": `"$DocTitle`"}"
            mcpl call google-docs createDocument $json
            Start-Sleep -Seconds 1
        }
    }
}

# Convert Persona Registry
Write-Host "Converting Persona Registry..."
Convert-ToGoogleDoc -FilePath "$MPD_PATH\Persona_Registry_v4.9.md" -DocTitle "MPD_Persona_Registry_v4.9"

# Convert README
Write-Host "Converting README..."
Convert-ToGoogleDoc -FilePath "$MPD_PATH\README.md" -DocTitle "MPD_README"

# Convert Skill Registry
Write-Host "Converting Skill Registry..."
Convert-ToGoogleDoc -FilePath "$MPD_PATH\skills\Skill_Registry.md" -DocTitle "MPD_Skill_Registry_v2.4"

Write-Host ""
Write-Host "=== Converting Personas ===" -ForegroundColor Cyan

$personas = Get-ChildItem "$MPD_PATH\personas\*.md" | Select-Object -First 15
foreach ($file in $personas) {
    $title = "MPD_" + $file.BaseName
    Convert-ToGoogleDoc -FilePath $file.FullName -DocTitle $title
}

Write-Host ""
Write-Host "=== Converting Key Skills ===" -ForegroundColor Cyan

$keySkills = @(
    "LAR-006-autonomous-routing.md",
    "LAR-023-batch-processing.md",
    "LAR-024-memory-integration.md",
    "LAR-025-ralph-loop.md",
    "LAR-026-google-docs-integration.md"
)

foreach ($skill in $keySkills) {
    $file = "$MPD_PATH\skills\$skill"
    if (Test-Path $file) {
        $title = "MPD_" + [System.IO.Path]::GetFileNameWithoutExtension($skill)
        Convert-ToGoogleDoc -FilePath $file -DocTitle $title
    }
}

Write-Host ""
Write-Host "=== Converting Key Protocols ===" -ForegroundColor Cyan

$keyProtocols = @(
    "TDP-001-tool-discovery-protocol.md",
    "PR-018-ralph-loop-protocol.md",
    "MEM-001-memory-protocol.md",
    "session-persistence-protocol.md"
)

foreach ($protocol in $keyProtocols) {
    $file = "$MPD_PATH\protocols\$protocol"
    if (Test-Path $file) {
        $title = "MPD_" + [System.IO.Path]::GetFileNameWithoutExtension($protocol)
        Convert-ToGoogleDoc -FilePath $file -DocTitle $title
    }
}

Write-Host ""
Write-Host "=== Done! ===" -ForegroundColor Green
Write-Host "Check your Google Drive for the new MPD documents."
Write-Host "You may need to organize them into folders manually."
