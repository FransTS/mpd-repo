@echo off
echo ========================================
echo  Transcription MCP v2.0 Installation
echo  Device: LAPTOP
echo ========================================
echo.

REM Adjust paths for laptop
set PYTHON_PATH=C:\Users\Frans Vermaak\AppData\Local\Programs\Python\Python312\python.exe
set PROJECT_PATH=C:\GitHub\transcription-mcp

echo [0/6] Creating project directory...
if not exist "C:\GitHub" mkdir "C:\GitHub"
if not exist "%PROJECT_PATH%" (
    xcopy /E /I /Y "G:\My Drive\Shared_Download\AI_Folder\MPD\reference\transcription-mcp-v2" "%PROJECT_PATH%"
)

cd /d %PROJECT_PATH%

echo.
echo [1/6] Creating virtual environment...
if not exist "venv" (
    "%PYTHON_PATH%" -m venv venv
)

echo.
echo [2/6] Upgrading pip...
call venv\Scripts\python.exe -m pip install --upgrade pip

echo.
echo [3/6] Installing PyTorch with CUDA...
call venv\Scripts\pip.exe install torch torchaudio --index-url https://download.pytorch.org/whl/cu121

echo.
echo [4/6] Installing WhisperX...
call venv\Scripts\pip.exe install whisperx

echo.
echo [5/6] Installing MCP and utilities...
call venv\Scripts\pip.exe install mcp pydantic python-docx aiofiles python-dotenv

echo.
echo [6/6] Installing project...
call venv\Scripts\pip.exe install -e .

echo.
echo Creating .env file...
echo HF_TOKEN=YOUR_HF_TOKEN_HERE> .env
echo WORK_DIR=G:\My Drive\Shared_Download\AI_Folder\Memory\Projects\Transcription_Jobs>> .env

echo.
echo ========================================
echo  Installation Complete!
echo ========================================
echo.
echo IMPORTANT - NEXT STEPS:
echo 1. Edit .env file and replace YOUR_HF_TOKEN_HERE with actual token
echo    (Get token from: https://huggingface.co/settings/tokens)
echo 2. Open: %%APPDATA%%\Claude\claude_desktop_config.json
echo 3. Add transcription server config (see INSTALL_CHECKPOINT.md)
echo 4. Restart Claude Desktop
echo.
pause
