# MPD Daily Sync Script v1.0
# Syncs MPD between local files, Google Drive, and GitHub
# Schedule via Windows Task Scheduler to run daily
#
# Created: 20 January 2026
# Author: Frans Vermaak (CTGO, LarcAI)

param(
    [switch]$Verbose,
    [switch]$GitOnly,
    [switch]$GDocsOnly
)

$ErrorActionPreference = "Continue"

# Configuration
$MPD_PATH = "G:\My Drive\Shared_Download\AI_Folder\MPD"
$LOG_PATH = "G:\My Drive\Shared_Download\AI_Folder\logs"
$GITHUB_REPO_PC = "C:\Users\User\Documents\GitHub\mpd-repo"
$GITHUB_REPO_LAPTOP = "C:\Users\Frans Vermaak\Documents\GitHub\mpd-repo"

# Detect environment
if ($env:USERPROFILE -like "*Frans Vermaak*") {
    $DEVICE = "LAPTOP"
    $GITHUB_REPO = $GITHUB_REPO_LAPTOP
} else {
    $DEVICE = "PC"
    $GITHUB_REPO = $GITHUB_REPO_PC
}

# Create log directory if it doesn't exist
if (-not (Test-Path $LOG_PATH)) {
    New-Item -ItemType Directory -Path $LOG_PATH -Force | Out-Null
}

$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFile = Join-Path $LOG_PATH "mpd_sync_$timestamp.log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [$Level] $Message"
    Add-Content -Path $logFile -Value $logEntry
    if ($Verbose -or $Level -eq "ERROR") {
        switch ($Level) {
            "ERROR" { Write-Host $logEntry -ForegroundColor Red }
            "WARN" { Write-Host $logEntry -ForegroundColor Yellow }
            "SUCCESS" { Write-Host $logEntry -ForegroundColor Green }
            default { Write-Host $logEntry }
        }
    }
}

Write-Log "=== MPD Daily Sync Started ==="
Write-Log "Device: $DEVICE"
Write-Log "MPD Path: $MPD_PATH"
Write-Log "GitHub Repo: $GITHUB_REPO"

# ============================================
# SECTION 1: Git Sync
# ============================================

if (-not $GDocsOnly) {
    Write-Log "--- Git Sync ---"
    
    if (Test-Path $GITHUB_REPO) {
        try {
            Set-Location $GITHUB_REPO
            
            # Pull latest changes
            Write-Log "Pulling latest from GitHub..."
            $pullResult = git pull origin main 2>&1
            Write-Log "Git pull: $pullResult"
            
            # Copy updated files from Google Drive to repo
            Write-Log "Syncing files from Google Drive to repo..."
            
            $folders = @("personas", "skills", "protocols", "reference", "templates", "workflows")
            foreach ($folder in $folders) {
                $source = Join-Path $MPD_PATH $folder
                $dest = Join-Path $GITHUB_REPO $folder
                if (Test-Path $source) {
                    if (-not (Test-Path $dest)) {
                        New-Item -ItemType Directory -Path $dest -Force | Out-Null
                    }
                    Copy-Item -Path "$source\*" -Destination $dest -Recurse -Force
                    Write-Log "  Synced: $folder"
                }
            }
            
            # Copy root files
            $rootFiles = @("README.md", "CLAUDE.md", "Persona_Registry_v*.md")
            foreach ($pattern in $rootFiles) {
                $files = Get-ChildItem -Path $MPD_PATH -Filter $pattern -ErrorAction SilentlyContinue
                foreach ($file in $files) {
                    Copy-Item -Path $file.FullName -Destination $GITHUB_REPO -Force
                    Write-Log "  Synced: $($file.Name)"
                }
            }
            
            # Check for changes and commit
            $status = git status --porcelain 2>&1
            if ($status) {
                Write-Log "Changes detected, committing..."
                git add .
                $commitMsg = "auto-sync: MPD update $(Get-Date -Format 'yyyy-MM-dd HH:mm') from $DEVICE"
                git commit -m $commitMsg 2>&1
                
                Write-Log "Pushing to GitHub..."
                $pushResult = git push origin main 2>&1
                Write-Log "Git push: $pushResult"
                Write-Log "Git sync completed" "SUCCESS"
            } else {
                Write-Log "No changes to commit"
            }
        }
        catch {
            Write-Log "Git sync error: $_" "ERROR"
        }
    } else {
        Write-Log "GitHub repo not found at: $GITHUB_REPO" "WARN"
        Write-Log "Creating repo directory..."
        New-Item -ItemType Directory -Path $GITHUB_REPO -Force | Out-Null
        
        # Initialize repo if needed
        Set-Location $GITHUB_REPO
        if (-not (Test-Path ".git")) {
            git init
            Write-Log "Initialized new git repository"
        }
    }
}

# ============================================
# SECTION 2: Version Check
# ============================================

Write-Log "--- Version Check ---"

# Find latest Persona Registry version
$registryFiles = Get-ChildItem -Path $MPD_PATH -Filter "Persona_Registry_v*.md" | Sort-Object Name -Descending
if ($registryFiles) {
    $latestRegistry = $registryFiles[0].Name
    Write-Log "Latest Persona Registry: $latestRegistry"
}

# Find latest Skill Registry version
$skillRegistry = Get-ChildItem -Path "$MPD_PATH\skills" -Filter "Skill_Registry*.md" -ErrorAction SilentlyContinue
if ($skillRegistry) {
    Write-Log "Skill Registry: $($skillRegistry.Name)"
}

# Count personas
$personaCount = (Get-ChildItem -Path "$MPD_PATH\personas" -Filter "*.md" -ErrorAction SilentlyContinue).Count
Write-Log "Total Personas: $personaCount"

# Count skills
$skillCount = (Get-ChildItem -Path "$MPD_PATH\skills" -Filter "*.md" -ErrorAction SilentlyContinue).Count
Write-Log "Total Skills: $skillCount"

# Count protocols
$protocolCount = (Get-ChildItem -Path "$MPD_PATH\protocols" -Filter "*.md" -ErrorAction SilentlyContinue).Count
Write-Log "Total Protocols: $protocolCount"

# ============================================
# SECTION 3: Cleanup
# ============================================

Write-Log "--- Cleanup ---"

# Remove old log files (keep last 30 days)
$oldLogs = Get-ChildItem -Path $LOG_PATH -Filter "mpd_sync_*.log" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) }
if ($oldLogs) {
    $oldLogs | Remove-Item -Force
    Write-Log "Removed $($oldLogs.Count) old log files"
}

# ============================================
# SECTION 4: Summary
# ============================================

Write-Log "=== MPD Daily Sync Completed ==="
Write-Log "Log file: $logFile"

# Return summary
$summary = @{
    Device = $DEVICE
    Personas = $personaCount
    Skills = $skillCount
    Protocols = $protocolCount
    LogFile = $logFile
    Timestamp = $timestamp
}

return $summary
