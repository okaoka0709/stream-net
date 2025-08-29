@echo off
setlocal
cd /d %~dp0

REM === 1) 首次啟動自動安裝 server 依賴 ===
if not exist server\node_modules (
  echo [setup] Installing Node deps...
  pushd server
  npm ci || (echo [error] npm install failed & pause & exit /b 1)
  popd
)

REM === 2) 啟動 MediaMTX ===
if exist mediamtx\mediamtx.exe (
  echo [mediamtx] starting...
  start "MediaMTX" mediamtx\mediamtx.exe mediamtx\mediamtx.yml
) else (
  echo [error] mediamtx\mediamtx.exe not found. Edit package for your OS.
  pause & exit /b 1
)

REM === 3) 啟動 Node 代理 ===
echo [server] starting at http://localhost:3000 ...
start "Node Proxy" cmd /k "cd /d %~dp0server && npm start"

REM === 4) 開啟瀏覽器 ===
timeout /t 2 >nul
start "" http://localhost:3000/
endlocal
