<# 
.SYNOPSIS
    Ralph Loop Automation Script for Windows/Claude Code
.DESCRIPTION
    Implements the Ralph Loop technique for iterative AI task execution
    with fresh context windows to prevent context rot.
.PARAMETER PrdFile
    Path to the PRD.md file (default: PRD.md)
.PARAMETER MaxAttempts
    Maximum attempts per task (default: 10)
.PARAMETER ProjectDir
    Project directory (default: current directory)
.EXAMPLE
    .\ralph.ps1 -PrdFile "PRD.md" -MaxAttempts 10
#>

param(
    [string]$PrdFile = "PRD.md",
    [int]$MaxAttempts = 10,
    [string]$ProjectDir = "."
)

# Configuration
$ProgressFile = Join-Path $ProjectDir "progress.md"
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"

# Initialize progress file if not exists
if (-not (Test-Path $ProgressFile)) {
    @"
# Progress Log

## Project
- **PRD:** $PrdFile
- **Started:** $Timestamp
- **Max Attempts:** $MaxAttempts

## Current Status
- **Task:** None
- **Attempt:** 0
- **Status:** Initializing

## History

"@ | Out-File $ProgressFile -Encoding UTF8
    Write-Host "Created progress file: $ProgressFile" -ForegroundColor Green
}

# Function to get next pending task
function Get-NextTask {
    param([string]$PrdPath)
    
    $content = Get-Content $PrdPath -Raw
    $pattern = '### Task (\d+):.*?\n- \*\*Status:\*\* pending'
    
    if ($content -match $pattern) {
        return $Matches[1]
    }
    return $null
}

# Function to update progress
function Update-Progress {
    param(
        [int]$TaskNum,
        [int]$Attempt,
        [string]$Result,
        [string]$Details
    )
    
    $entry = @"

### [$Timestamp] Task $TaskNum, Attempt $Attempt
- **Result:** $Result
- **Details:** $Details

"@
    Add-Content $ProgressFile $entry
}

# Function to mark task complete in PRD
function Complete-Task {
    param(
        [string]$PrdPath,
        [int]$TaskNum
    )
    
    $content = Get-Content $PrdPath -Raw
    $pattern = "(### Task $TaskNum:.*?\n- \*\*Status:\*\* )pending"
    $replacement = '${1}complete'
    $content = $content -replace $pattern, $replacement
    [System.IO.File]::WriteAllText($PrdPath, $content)
}

# Main loop
Write-Host "`n=== Ralph Loop Started ===" -ForegroundColor Cyan
Write-Host "PRD: $PrdFile"
Write-Host "Max Attempts: $MaxAttempts"
Write-Host "Progress: $ProgressFile`n"

$iteration = 0
$maxIterations = 100  # Safety limit

while ($iteration -lt $maxIterations) {
    $iteration++
    
    # Find next task
    $taskNum = Get-NextTask -PrdPath (Join-Path $ProjectDir $PrdFile)
    
    if (-not $taskNum) {
        Write-Host "`n=== All Tasks Complete! ===" -ForegroundColor Green
        break
    }
    
    Write-Host "Processing Task $taskNum..." -ForegroundColor Yellow
    
    # Track attempts for this task
    $attempt = 1
    $taskComplete = $false
    
    while ($attempt -le $MaxAttempts -and -not $taskComplete) {
        Write-Host "  Attempt $attempt of $MaxAttempts" -ForegroundColor Cyan
        
        # Build prompt for Claude
        $prompt = @"
Read the following files and execute the next pending task:
1. PRD: $PrdFile
2. Progress: progress.md

Instructions:
- Find Task $taskNum in the PRD
- Execute the task requirements
- Update progress.md with your results
- If successful, respond with: TASK_COMPLETE
- If failed, respond with: TASK_FAILED: [reason]

Begin execution.
"@
        
        # Execute in Claude Code (fresh session via --print flag)
        try {
            $result = claude --print $prompt 2>&1
            
            if ($result -match "TASK_COMPLETE") {
                Write-Host "  Task $taskNum completed!" -ForegroundColor Green
                Complete-Task -PrdPath (Join-Path $ProjectDir $PrdFile) -TaskNum $taskNum
                Update-Progress -TaskNum $taskNum -Attempt $attempt -Result "SUCCESS" -Details "Task completed"
                $taskComplete = $true
            }
            elseif ($result -match "TASK_FAILED: (.*)") {
                $reason = $Matches[1]
                Write-Host "  Attempt failed: $reason" -ForegroundColor Red
                Update-Progress -TaskNum $taskNum -Attempt $attempt -Result "FAILED" -Details $reason
            }
            else {
                Update-Progress -TaskNum $taskNum -Attempt $attempt -Result "UNKNOWN" -Details "No clear result marker"
            }
        }
        catch {
            Write-Host "  Error executing Claude: $_" -ForegroundColor Red
            Update-Progress -TaskNum $taskNum -Attempt $attempt -Result "ERROR" -Details $_.Exception.Message
        }
        
        $attempt++
        
        # Small delay between attempts
        Start-Sleep -Seconds 2
    }
    
    if (-not $taskComplete) {
        Write-Host "  Task $taskNum blocked after $MaxAttempts attempts" -ForegroundColor Red
        Update-Progress -TaskNum $taskNum -Attempt $MaxAttempts -Result "BLOCKED" -Details "Max attempts reached, requires human intervention"
        
        # Mark as blocked in PRD
        $content = Get-Content (Join-Path $ProjectDir $PrdFile) -Raw
        $pattern = "(### Task $taskNum:.*?\n- \*\*Status:\*\* )pending"
        $replacement = '${1}blocked'
        $content = $content -replace $pattern, $replacement
        [System.IO.File]::WriteAllText((Join-Path $ProjectDir $PrdFile), $content)
    }
}

Write-Host "`n=== Ralph Loop Complete ===" -ForegroundColor Cyan
Write-Host "See $ProgressFile for full history"
