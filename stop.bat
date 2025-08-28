@echo off
echo Stopping MediaMTX and Node.js proxy...

REM 嘗試殺掉 MediaMTX (Windows 會顯示為 mediamtx.exe)
taskkill /IM mediamtx.exe /F >nul 2>&1

REM 嘗試殺掉 Node.js (node.exe 就是跑 npm start 那個)
taskkill /IM node.exe /F >nul 2>&1

echo Done.
pause