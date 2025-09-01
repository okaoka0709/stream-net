# CAM-LOCAL 使用說明

這個專案提供一個本地方案，將 **RTSP 攝影機串流** 透過 [MediaMTX](https://github.com/bluenviron/mediamtx) 轉換為 **HLS**，再透過 **Node.js Proxy** 發布到網頁前端，最後用 Vue 2 + hls.js 播放。

---

## 專案結構
stream-net/
├─ mediamtx/
│ ├─ mediamtx.exe #MediaMTX 執行檔
│ └─ mediamtx.yml #攝影機來源設定
│
├─ node/
│ └─ node-v22.11.0-x64.msi #node.js 安裝檔
│
├─ server/
│ ├─ index.js #Node.js 反向代理 (Express)
│ ├─ start.js #一鍵啟動 (同時跑 MediaMTX + Proxy)
│ ├─ package.json #相依套件定義
│ └─ package-lock.json
│
├─ web/
│ └─ index.html #前端頁面 (Vue 2 + hls.js)
│
├─ start-all.bat #一鍵啟動
├─ stop-all.bat #一鍵停止
└─ README.md # 本文件

---

## 修改攝影機設定
編輯檔案：`mediamtx/mediamtx.yml`

```yaml
    surce: rtsp://Admin:1234@192.168.0.250:554/stream2
```

## 修改攝影機設定
改成你自己的攝影機 RTSP URL。帳號/密碼/IP/Port 必須正確，若密碼含有特殊字元（@、# 等），請用 URL encode。

## 啟動方式
雙擊 start-all.bat 首次啟動會自動安裝 Node.js 相依套件，預設瀏覽器約 5 秒後會自動打開 http://localhost:3000。

## 關閉方式
雙擊 stop-all.bat

## 注意事項
攝影機請輸出 H.264 編碼（不是 H.265）建議 GOP 設定為 1–2 秒，避免起播延遲或畫面卡頓並確保這台電腦能直接存取攝影機的 RTSP 554 埠

預設埠號：
- Node.js Proxy → 3000
- MediaMTX HTTP → 8888

如有衝突，可修改 server/index.js 或 mediamtx.yml

## 常見問題
- 打不開網頁: 請確認 Node.js 已安裝，並且沒有其他服務佔用 3000 埠。
- 沒有影像: 請檢查 RTSP URL 是否正確，或確認攝影機設為 H.264。
- 延遲太高: 已預設使用 fMP4 HLS，延遲約 2–4 秒。若需要更低延遲，可考慮改用 WebRTC（MediaMTX 也支援）。