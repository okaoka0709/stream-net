// server/index.js
const express = require('express');
const cors = require('cors');
const { createProxyMiddleware } = require('http-proxy-middleware');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;
const MEDIA_HTTP = process.env.MEDIA_HTTP || 'http://localhost:8888';

// 反代 HLS：/hls/cam1/index.m3u8 -> http://localhost:8888/cam1/index.m3u8
app.use('/hls', createProxyMiddleware({
  target: MEDIA_HTTP,
  changeOrigin: true,
  pathRewrite: { '^/hls': '' },
  ws: true,
}));

// 發靜態檔（前端待會放 web/ 內）
app.use(express.static(path.join(__dirname, '../web')));

app.use(cors());

app.listen(PORT, () => {
  console.log(`[server] http://localhost:${PORT}`);
  console.log(`[server] proxy -> ${MEDIA_HTTP}`);
});