// Wait until Elasticsearch (cluster health yellow or better), RabbitMQ, Redis and the
// S3 store answer, so OpenCTI's first start doesn't fail its dependency check while
// Railway is still starting the other services. Gives up after WAIT_DEPS_TIMEOUT seconds.
import net from 'node:net';

const env = process.env;
const deadline = Date.now() + 1000 * Number(env.WAIT_DEPS_TIMEOUT || 900);
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const tcp = (host, port) => new Promise((resolve) => {
  const s = net.connect({ host, port: Number(port), timeout: 3000 });
  s.once('connect', () => { s.destroy(); resolve(true); });
  s.once('timeout', () => { s.destroy(); resolve(false); });
  s.once('error', () => resolve(false));
});

const esHealthy = async () => {
  try {
    const url = new URL('/_cluster/health', env.ELASTICSEARCH__URL);
    const auth = Buffer.from(`${env.ELASTICSEARCH__USERNAME}:${env.ELASTICSEARCH__PASSWORD}`).toString('base64');
    const res = await fetch(url, { headers: { Authorization: `Basic ${auth}` }, signal: AbortSignal.timeout(5000) });
    if (!res.ok) return false;
    const body = await res.json();
    return body.status === 'green' || body.status === 'yellow';
  } catch {
    return false;
  }
};

const checks = [
  ['Elasticsearch', esHealthy],
  ['RabbitMQ', () => tcp(env.RABBITMQ__HOSTNAME, env.RABBITMQ__PORT)],
  ['Redis', () => tcp(env.REDIS__HOSTNAME, env.REDIS__PORT)],
  ['S3 (Silo)', () => tcp(env.MINIO__ENDPOINT, env.MINIO__PORT)],
];

for (const [name, check] of checks) {
  let logged = 0;
  while (!(await check())) {
    if (Date.now() > deadline) {
      console.error(`railway-template: ${name} did not answer in time`);
      process.exit(1);
    }
    if (Date.now() - logged > 30000) {
      console.log(`railway-template: waiting for ${name}`);
      logged = Date.now();
    }
    await sleep(3000);
  }
  console.log(`railway-template: ${name} is up`);
}
