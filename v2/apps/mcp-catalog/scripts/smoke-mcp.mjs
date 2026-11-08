import http from 'node:http';
import { spawn } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const appRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const port = 3456;
const nextBin = path.join(appRoot, 'node_modules/next/dist/bin/next');

function raw(method, urlPath, { host = `127.0.0.1:${port}`, proto, body } = {}) {
  return new Promise((resolve, reject) => {
    const payload = body == null ? null : Buffer.from(body);
    const headers = { host };
    if (proto) headers['x-forwarded-proto'] = proto;
    if (payload) {
      headers['content-type'] = 'application/json';
      headers['content-length'] = String(payload.length);
    }
    const req = http.request({ hostname: '127.0.0.1', port, path: urlPath, method, headers }, (res) => {
      const chunks = [];
      res.on('data', (chunk) => chunks.push(chunk));
      res.on('end', () => {
        resolve({
          status: res.statusCode,
          headers: res.headers,
          text: Buffer.concat(chunks).toString('utf8'),
        });
      });
    });
    req.on('error', reject);
    if (payload) req.end(payload);
    else req.end();
  });
}

function rpc(method, params, headers) {
  return raw('POST', '/mcp', {
    ...headers,
    body: JSON.stringify({ jsonrpc: '2.0', id: 1, method, params: params || {} }),
  });
}

function assert(cond, message, detail) {
  if (!cond) {
    const extra = detail == null ? '' : `\n${typeof detail === 'string' ? detail : JSON.stringify(detail)}`;
    throw new Error(`${message}${extra}`);
  }
}

async function waitForReady() {
  const deadline = Date.now() + 30000;
  let last = '';
  while (Date.now() < deadline) {
    try {
      const res = await raw('GET', '/mcp');
      if (res.status === 200) return;
      last = `status ${res.status}`;
    } catch (error) {
      last = error instanceof Error ? error.message : String(error);
    }
    await new Promise((resolve) => setTimeout(resolve, 250));
  }
  throw new Error(`server did not become ready: ${last}`);
}

const child = spawn(process.execPath, [nextBin, 'start', '-p', String(port)], {
  cwd: appRoot,
  env: { ...process.env, CATALOG_PUBLIC_ORIGIN: 'https://mcp-priority.ntsa.uk' },
  stdio: ['ignore', 'pipe', 'pipe'],
});
let logs = '';
child.stdout.on('data', (chunk) => {
  logs += chunk.toString();
});
child.stderr.on('data', (chunk) => {
  logs += chunk.toString();
});

try {
  await waitForReady();

  const home = await raw('GET', '/');
  assert(home.status === 200, 'GET / status', home.status);
  assert(home.text.includes('http://127.0.0.1:3456/mcp'), 'landing page advertises the local origin', home.text.slice(0, 800));
  assert(home.text.includes('priority-catalog'), 'landing page names the catalog client');
  assert(home.text.includes('This host does not run them.'), 'landing page keeps execution local');
  assert(!home.text.includes('grok mcp add --transport http priority-formprep'), 'do not register the execute plugin on this host');

  const discover = await raw('GET', '/mcp');
  assert(discover.status === 200, 'GET /mcp status', discover.status);
  assert((discover.headers['cache-control'] || '').includes('no-store'), 'GET /mcp is not cached', discover.headers);
  const discoverBody = JSON.parse(discover.text);
  assert(discoverBody.transport.includes('POST JSON-RPC'), 'GET /mcp describes POST', discoverBody);
  assert(JSON.stringify(discoverBody.tools) === JSON.stringify([
    'list_catalog',
    'get_skill',
    'get_instance_schema',
    'get_runner_files',
  ]), 'GET /mcp tools', discoverBody.tools);

  const options = await raw('OPTIONS', '/mcp');
  assert(options.status === 204, 'OPTIONS /mcp', options.status);
  assert(options.headers['access-control-allow-origin'] === '*', 'CORS allow origin', options.headers);

  const init = JSON.parse((await rpc('initialize', { protocolVersion: '2024-11-05', capabilities: {} })).text);
  assert(init.result.protocolVersion === '2024-11-05', 'protocol', init);
  assert(init.result.serverInfo.name === 'mcp-priority', 'server name', init.result.serverInfo);
  assert(!JSON.stringify(init.result.capabilities).includes('prepare_form'), 'no execute capability', init);

  const tools = JSON.parse((await rpc('tools/list')).text);
  const names = tools.result.tools.map((tool) => tool.name);
  assert(names.join(',') === 'list_catalog,get_skill,get_instance_schema,get_runner_files', 'tools/list', names);

  const listed = JSON.parse((await rpc('tools/call', { name: 'list_catalog', arguments: {} })).text);
  const listedText = listed.result.content[0].text;
  const catalog = JSON.parse(listedText);
  assert(catalog.host === 'http://127.0.0.1:3456', 'list_catalog host follows request', catalog.host);
  assert(Array.isArray(catalog.skills) && catalog.skills.length > 20, 'catalog skill count', catalog.skills && catalog.skills.length);
  assert(catalog.skills.some((skill) => skill.name === 'priority-formprep'), 'priority-formprep is listed');
  assert(!listedText.includes('prepare_form'), 'list_catalog does not publish prepare_form');

  const skill = JSON.parse((await rpc('tools/call', { name: 'get_skill', arguments: { name: 'priority-formprep' } })).text);
  assert(skill.result.content[0].text.includes('FORMPREP'), 'get_skill returns the leaflet');

  const traversal = JSON.parse((await rpc('tools/call', {
    name: 'get_runner_files',
    arguments: { name: 'priority-formprep', path: '../meta.json' },
  })).text);
  assert(traversal.result.isError === true, 'path traversal is rejected', traversal);

  const example = JSON.parse((await rpc('tools/call', {
    name: 'get_runner_files',
    arguments: { name: 'priority-formprep', path: 'instances.example.json' },
  })).text);
  const exampleJson = JSON.parse(example.result.content[0].text);
  assert(exampleJson.instances[0].webBaseUrl === 'https://priority.example.com', 'example instance stays synthetic', exampleJson);
  assert(!Object.prototype.hasOwnProperty.call(exampleJson.instances[0], 'password'), 'example file has no password field');

  const noted = await rpc('notifications/initialized');
  assert(noted.status === 204, 'notification status', noted.status);

  const bad = await raw('POST', '/mcp', { body: '{' });
  assert(bad.status === 400, 'parse error status', bad.status);
  assert(JSON.parse(bad.text).error.code === -32700, 'parse error code', bad.text);

  const evil = JSON.parse((await rpc('tools/call', { name: 'list_catalog', arguments: {} }, { host: 'evil.example' })).text);
  const evilCatalog = JSON.parse(evil.result.content[0].text);
  assert(evilCatalog.host === 'https://mcp-priority.ntsa.uk', 'disallowed host uses the env fallback', evilCatalog.host);

  const custom = JSON.parse((await rpc('tools/call', { name: 'list_catalog', arguments: {} }, {
    host: 'mcp.ntsa.uk',
    proto: 'https',
  })).text);
  assert(JSON.parse(custom.result.content[0].text).host === 'https://mcp.ntsa.uk', 'custom domain host wins over env');

  process.stdout.write('smoke-mcp: ok\n');
} catch (error) {
  process.stderr.write(`${logs}\n`);
  process.stderr.write(`${error instanceof Error ? error.stack : error}\n`);
  process.exitCode = 1;
} finally {
  child.kill('SIGTERM');
  await new Promise((resolve) => {
    const timer = setTimeout(() => {
      child.kill('SIGKILL');
      resolve();
    }, 2000);
    child.on('exit', () => {
      clearTimeout(timer);
      resolve();
    });
  });
}
