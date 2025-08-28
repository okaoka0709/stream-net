@echo off
REM === 切到專案目錄 ===
cd /d %~dp0

REM === 啟動 MediaMTX（背景）===
cd mediamtx
start "MediaMTX" mediamtx.exe mediamtx.yml
cd ..

REM === 啟動 Node.js server (npm start) ===
cd server
start "Node Proxy" cmd /k "npm start"
cd ..

REM === 開啟瀏覽器到 http://localhost:3000 ===
start "" http://localhost:3000