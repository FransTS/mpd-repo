# Transcription MCP Server v2.0 - Installation Script
# Run this in PowerShell as Administrator (for CUDA setup)
# Author: Frans Vermaak, CTGO @ LarcAI

param(
    [string]$HF_TOKEN = "",
    [switch]$SkipCuda,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$PROJECT_DIR = "C:\GitHub\transcription-mcp"
$SOURCE_DIR = "G:\My Drive\Shared_Download\AI_Folder\MPD\reference\transcription-mcp-v2"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Transcription MCP Server v2.0 Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check prerequisites
Write-Host "[1/7] Checking prerequisites..." -ForegroundColor Yellow

# Python
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    Write-Host "ERROR: Python not found. Install Python 3.10+ first." -ForegroundColor Red
    exit 1
}
$pythonVersion = python --version
Write-Host "  Python: $pythonVersion" -ForegroundColor Green

# ffmpeg
$ffmpeg = Get-Command ffmpeg -ErrorAction SilentlyContinue
if (-not $ffmpeg) {
    Write-Host "  WARNING: ffmpeg not found. Install from https://ffmpeg.org/download.html" -ForegroundColor Yellow
} else {
    Write-Host "  ffmpeg: Found" -ForegroundColor Green
}

# CUDA
if (-not $SkipCuda) {
    $nvcc = Get-Command nvcc -ErrorAction SilentlyContinue
    if (-not $nvcc) {
        Write-Host "  WARNING: CUDA not found. Install from https://developer.nvidia.com/cuda-downloads" -ForegroundColor Yellow
        Write-Host "  (Use -SkipCuda to continue anyway)" -ForegroundColor Yellow
    } else {
        $cudaVersion = nvcc --version | Select-String "release" | ForEach-Object { $_.ToString().Split(",")[1].Trim() }
        Write-Host "  CUDA: $cudaVersion" -ForegroundColor Green
    }
}

# Copy project files
Write-Host ""
Write-Host "[2/7] Copying project files..." -ForegroundColor Yellow

if (Test-Path $PROJECT_DIR) {
    if ($Force) {
        Remove-Item -Recurse -Force $PROJECT_DIR
    } else {
        Write-Host "  Project directory exists. Use -Force to overwrite." -ForegroundColor Yellow
        Write-Host "  Skipping copy..." -ForegroundColor Yellow
    }
}

if (-not (Test-Path $PROJECT_DIR)) {
    New-Item -ItemType Directory -Path $PROJECT_DIR -Force | Out-Null
    Copy-Item -Recurse "$SOURCE_DIR\*" $PROJECT_DIR
    Write-Host "  Copied to: $PROJECT_DIR" -ForegroundColor Green
}

# Create virtual environment
Write-Host ""
Write-Host "[3/7] Creating virtual environment..." -ForegroundColor Yellow

Set-Location $PROJECT_DIR

if (-not (Test-Path "venv")) {
    python -m venv venv
    Write-Host "  Created: venv\" -ForegroundColor Green
} else {
    Write-Host "  venv already exists" -ForegroundColor Green
}

# Activate and install
Write-Host ""
Write-Host "[4/7] Installing PyTorch with CUDA..." -ForegroundColor Yellow

& .\venv\Scripts\Activate.ps1

pip install --upgrade pip | Out-Null
pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu118

Write-Host "  PyTorch installed" -ForegroundColor Green

# Install WhisperX
Write-Host ""
Write-Host "[5/7] Installing WhisperX and dependencies..." -ForegroundColor Yellow

pip install whisperx
pip install mcp pydantic python-docx aiofiles python-dotenv
pip install -e .

Write-Host "  All dependencies installed" -ForegroundColor Green

# Configure .env
Write-Host ""
Write-Host "[6/7] Configuring environment..." -ForegroundColor Yellow

$envContent = @"
# Transcription MCP Server Configuration
HF_TOKEN=$HF_TOKEN
WORK_DIR=G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs
"@

if ($HF_TOKEN) {
    Set-Content -Path ".env" -Value $envContent
    Write-Host "  .env created with HuggingFace token" -ForegroundColor Green
} else {
    if (-not (Test-Path ".env")) {
        Copy-Item ".env.example" ".env"
    }
    Write-Host "  .env created (add HF_TOKEN manually)" -ForegroundColor Yellow
}

# Claude Desktop config
Write-Host ""
Write-Host "[7/7] Configuring Claude Desktop..." -ForegroundColor Yellow

$claudeConfigPath = "$env:APPDATA\Claude\claude_desktop_config.json"

if (Test-Path $claudeConfigPath) {
    $config = Get-Content $claudeConfigPath | ConvertFrom-Json
    
    if (-not $config.mcpServers) {
        $config | Add-Member -NotePropertyName "mcpServers" -NotePropertyValue @{}
    }
    
    $config.mcpServers.transcription = @{
        command = "$PROJECT_DIR\venv\Scripts\python.exe"
        args = @("-m", "transcription_mcp.server")
        cwd = $PROJECT_DIR
        env = @{
            HF_TOKEN = $HF_TOKEN
            WORK_DIR = "G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs"
        }
    }
    
    $config | ConvertTo-Json -Depth 10 | Set-Content $claudeConfigPath
    Write-Host "  Updated: $claudeConfigPath" -ForegroundColor Green
} else {
    Write-Host "  Claude Desktop config not found" -ForegroundColor Yellow
    Write-Host "  Manually add transcription server to config" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Installation Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Add HuggingFace token to .env (if not provided)" -ForegroundColor White
Write-Host "2. Accept pyannote model terms on HuggingFace:" -ForegroundColor White
Write-Host "   - https://huggingface.co/pyannote/segmentation-3.0" -ForegroundColor Gray
Write-Host "   - https://huggingface.co/pyannote/speaker-diarization-3.1" -ForegroundColor Gray
Write-Host "3. Restart Claude Desktop" -ForegroundColor White
Write-Host ""
Write-Host "Test with: 'Transcribe D:\path\to\meeting.mp4'" -ForegroundColor Green
