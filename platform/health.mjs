// Railway health check relay. Railway's health check path can't carry a query string,
// and OpenCTI's /health needs ?health_access_key=<key>. This answers GET /health on PORT
// with OpenCTI's own health result, so the access key stays a generated secret.
import http from 'node:http';

const port = Number(process.env.PORT || 8081);
const appPort = Number(process.env.APP__PORT || 8080);
const key = encodeURIComponent(process.env.APP__HEALTH_ACCESS_KEY || '');

http.createServer(async (req, res) => {
  if (req.method !== 'GET' || req.url !== '/health') {
    res.writeHead(404);
    res.end();
    return;
  }
  let ok = false;
  try {
    const r = await fetch(`http://127.0.0.1:${appPort}/health?health_access_key=${key}`, { signal: AbortSignal.timeout(5000) });
    ok = r.status === 200;
  } catch {
    ok = false;
  }
  res.writeHead(ok ? 200 : 503, { 'Content-Type': 'application/json', 'Cache-Control': 'no-store' });
  res.end(JSON.stringify({ status: ok ? 'success' : 'unavailable' }));
}).listen(port, '::', () => console.log(`railway-template: health relay on port ${port}/health`));
