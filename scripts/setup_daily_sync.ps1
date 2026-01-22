# Setup MPD Daily Sync Scheduled Task
# Run this script once with Administrator privileges to create the scheduled task
#
# Created: 20 January 2026
# Author: Frans Vermaak (CTGO, LarcAI)

$ErrorActionPreference = "Stop"

$taskName = "MPD_Daily_Sync"
$scriptPath = "G:\My Drive\Shared_Download\AI_Folder\MPD\scripts\daily_sync.ps1"

Write-Host "=== Setting up MPD Daily Sync Scheduled Task ===" -ForegroundColor Cyan
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "WARNING: This script should be run as Administrator for best results." -ForegroundColor Yellow
    Write-Host "The task will be created but may have limited permissions." -ForegroundColor Yellow
    Write-Host ""
}

# Remove existing task if it exists
$existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Write-Host "Removing existing task: $taskName" -ForegroundColor Yellow
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

# Create the action
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`" -Verbose"

# Create the trigger (daily at 6:00 AM)
$trigger = New-ScheduledTaskTrigger -Daily -At "06:00"

# Create the principal (run as current user)
$principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Limited

# Create settings
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -DontStopOnIdleEnd -ExecutionTimeLimit (New-TimeSpan -Minutes 30)

# Register the task
try {
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Description "Daily sync of MPD between Google Drive and GitHub (6:00 AM)"
    
    Write-Host "Created scheduled task: $taskName" -ForegroundColor Green
    Write-Host "  Schedule: Daily at 6:00 AM" -ForegroundColor Gray
    Write-Host "  Script: $scriptPath" -ForegroundColor Gray
    Write-Host ""
}
catch {
    Write-Host "Failed to create scheduled task: $_" -ForegroundColor Red
    exit 1
}

# Verify the task
$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($task) {
    Write-Host "=== Task Created Successfully ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Task Details:" -ForegroundColor Cyan
    Write-Host "  Name: $($task.TaskName)"
    Write-Host "  State: $($task.State)"
    Write-Host ""
    Write-Host "Manual Commands:" -ForegroundColor Cyan
    Write-Host "  Run now:    Start-ScheduledTask -TaskName $taskName"
    Write-Host "  Disable:    Disable-ScheduledTask -TaskName $taskName"
    Write-Host "  Remove:     Unregister-ScheduledTask -TaskName $taskName"
    Write-Host ""
    
    # Offer to run now
    $runNow = Read-Host "Run the sync task now? (y/n)"
    if ($runNow -eq "y") {
        Write-Host "Running sync task..." -ForegroundColor Yellow
        Start-ScheduledTask -TaskName $taskName
        Start-Sleep -Seconds 5
        Write-Host "Task started. Check the logs folder for results." -ForegroundColor Green
    }
}
else {
    Write-Host "Task was not created successfully." -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Green
