@echo off
echo Stopping MediaMTX and Node.js...
taskkill /IM mediamtx.exe /F >nul 2>&1
taskkill /IM node.exe /F >nul 2>&1
echo Done.
pause
