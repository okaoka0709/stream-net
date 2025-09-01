@echo off
setlocal
cd /d %~dp0

REM === 1) 檢查 Node.js，沒有就啟動安裝檔並離開 ===
where node >nul 2>&1
if errorlevel 1 (
  echo [setup] 未偵測到 Node.js。將啟動安裝程式：node\node-v22.11.0-x64.msi
  if exist ".\node\node-v22.11.0-x64.msi" (
    start "" ".\node\node-v22.11.0-x64.msi"
    echo 請完成安裝後再重新執行 start-all.bat
  ) else (
    echo [error] 找不到 .\node\node-v22.11.0-x64.msi，請確認檔案是否存在。
  )
  pause
  exit /b 1
)

REM === 2) 啟動 MediaMTX ===
if exist ".\mediamtx\mediamtx.exe" (
  echo [mediamtx] starting...
  start "MediaMTX" ".\mediamtx\mediamtx.exe" ".\mediamtx\mediamtx.yml"
) else (
  echo [error] 找不到 mediamtx\mediamtx.exe
)

REM === 3) 啟動 Node 代理 (npm start) ===
echo [server] starting at http://localhost:3000 ...
start "Node Proxy" cmd /k "cd /d %~dp0server && npm start"

REM === 4) 等 6 秒再開瀏覽器 ===
timeout /t 6 >nul
start "" http://localhost:3000