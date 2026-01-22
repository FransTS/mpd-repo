# Laptop Transcription MCP - Completion Script
# Run this in PowerShell as Administrator
# Created: 22 January 2026

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Transcription MCP - Laptop Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Download and install ffmpeg
Write-Host "`n[1/4] Installing ffmpeg..." -ForegroundColor Yellow

$ffmpegDir = "C:\ffmpeg"
$ffmpegUrl = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
$zipPath = "$env:TEMP\ffmpeg.zip"

if (!(Test-Path "$ffmpegDir\ffmpeg.exe")) {
    New-Item -ItemType Directory -Path $ffmpegDir -Force | Out-Null
    
    Write-Host "  Downloading ffmpeg (this may take a few minutes)..."
    Invoke-WebRequest -Uri $ffmpegUrl -OutFile $zipPath -UseBasicParsing
    
    Write-Host "  Extracting..."
    Expand-Archive -Path $zipPath -DestinationPath "$env:TEMP\ffmpeg_extract" -Force
    
    $extractedDir = Get-ChildItem "$env:TEMP\ffmpeg_extract" -Directory | Select-Object -First 1
    Copy-Item "$($extractedDir.FullName)\bin\*" "$ffmpegDir\" -Force
    
    # Add to PATH
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$ffmpegDir*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$ffmpegDir", "User")
        Write-Host "  Added to PATH" -ForegroundColor Green
    }
    
    Write-Host "  ffmpeg installed!" -ForegroundColor Green
} else {
    Write-Host "  ffmpeg already installed" -ForegroundColor Green
}

# Step 2: Verify HuggingFace token
Write-Host "`n[2/4] Checking HuggingFace token..." -ForegroundColor Yellow

$envFile = "C:\GitHub\transcription-mcp\.env"
$envContent = Get-Content $envFile -Raw -ErrorAction SilentlyContinue

if ($envContent -notmatch "HF_TOKEN=hf_") {
    Write-Host "  WARNING: HF_TOKEN not found in .env" -ForegroundColor Red
    Write-Host "  Speaker diarisation requires a HuggingFace token."
    Write-Host "  1. Get token from: https://huggingface.co/settings/tokens"
    Write-Host "  2. Accept model terms at:"
    Write-Host "     - https://huggingface.co/pyannote/segmentation-3.0"
    Write-Host "     - https://huggingface.co/pyannote/speaker-diarization-3.1"
    Write-Host "  3. Add to $envFile : HF_TOKEN=hf_your_token_here"
} else {
    Write-Host "  HF_TOKEN found" -ForegroundColor Green
}

# Step 3: Optional - GPU Setup
Write-Host "`n[3/4] GPU Setup (Optional)..." -ForegroundColor Yellow

$cudaInstalled = Test-Path "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA"
$torchVersion = & "C:\GitHub\transcription-mcp\venv\Scripts\python.exe" -c "import torch; print('cuda' if torch.cuda.is_available() else 'cpu')" 2>&1

if ($torchVersion -eq "cpu") {
    Write-Host "  Currently running CPU mode (slower but works)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  For GPU acceleration:" -ForegroundColor Cyan
    Write-Host "  1. Install CUDA Toolkit 12.x from:"
    Write-Host "     https://developer.nvidia.com/cuda-downloads"
    Write-Host "  2. Then run:"
    Write-Host '     cd C:\GitHub\transcription-mcp'
    Write-Host '     .\venv\Scripts\activate'
    Write-Host '     pip uninstall torch torchaudio -y'
    Write-Host '     pip install torch torchaudio --index-url https://download.pytorch.org/whl/cu121'
    Write-Host "  3. Update Claude Desktop config to use cuda instead of cpu"
} else {
    Write-Host "  GPU (CUDA) enabled!" -ForegroundColor Green
}

# Step 4: Test MCP Server
Write-Host "`n[4/4] Testing MCP Server..." -ForegroundColor Yellow

$testResult = & "C:\GitHub\transcription-mcp\venv\Scripts\python.exe" -c @"
try:
    from transcription_mcp.server import mcp
    print('MCP server module loads successfully')
except Exception as e:
    print(f'Error: {e}')
"@ 2>&1

Write-Host "  $testResult"

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Setup Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$ffmpegOk = Test-Path "$ffmpegDir\ffmpeg.exe"
$hfOk = $envContent -match "HF_TOKEN=hf_"
$cudaOk = $torchVersion -ne "cpu"

Write-Host "  ffmpeg:     $(if($ffmpegOk){'OK'}else{'MISSING'})" -ForegroundColor $(if($ffmpegOk){'Green'}else{'Red'})
Write-Host "  HF_TOKEN:   $(if($hfOk){'OK'}else{'MISSING (diarisation disabled)'})" -ForegroundColor $(if($hfOk){'Green'}else{'Yellow'})
Write-Host "  GPU/CUDA:   $(if($cudaOk){'OK'}else{'CPU mode (optional)'})" -ForegroundColor $(if($cudaOk){'Green'}else{'Yellow'})

Write-Host "`nRestart Claude Desktop to apply changes." -ForegroundColor Cyan
Write-Host "Then test with: 'Transcribe [video path]'" -ForegroundColor Cyan
