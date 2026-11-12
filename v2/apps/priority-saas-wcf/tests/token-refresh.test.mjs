/**
 * FR #421 / FR-039: refresh expired access token once via stored tokenUrl.
 * Offline fixtures only — fake HTTP, no live SaaS.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawn, spawnSync } from 'node:child_process';
import http from 'node:http';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  attemptLoginIfTokenFresh,
  resolveAccessToken,
} from '../lib/token.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

const FAKE_REFRESH = 'FAKE_refresh_token_fixture';
const FAKE_OLD_ACCESS = 'FAKE_access_token_expired';
const FAKE_NEW_ACCESS = 'FAKE_access_token_refreshed';

function writeHarness(tokenDoc) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tok-ref-'));
  const instances = path.join(dir, 'instances.json');
  const tokenFile = path.join(dir, 'tokens.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'dev',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          tokenFile,
          allowLive: false,
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  const body = JSON.stringify(tokenDoc);
  fs.writeFileSync(tokenFile, body);
  return { dir, instances, tokenFile, originalBody: body };
}

function startTokenServer(handler) {
  return new Promise((resolve) => {
    const s = http.createServer(handler);
    s.listen(0, '127.0.0.1', () => {
      const { port } = s.address();
      resolve({ server: s, url: `http://127.0.0.1:${port}/token` });
    });
  });
}

function expiredDoc(extra = {}) {
  return {
    access_token: FAKE_OLD_ACCESS,
    refresh_token: FAKE_REFRESH,
    expires_at: '2020-01-01T00:00:00.000Z',
    ...extra,
  };
}

test('Fake token endpoint 200: login sees the new access token', async () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const srv = await startTokenServer((req, res) => {
    let buf = '';
    req.on('data', (c) => {
      buf += c;
    });
    req.on('end', () => {
      assert.equal(req.method, 'POST');
      assert.match(buf, /grant_type=refresh_token/);
      assert.match(buf, new RegExp(`refresh_token=${FAKE_REFRESH}`));
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ access_token: FAKE_NEW_ACCESS, expires_in: 1800 }));
    });
  });
  const h = writeHarness(expiredDoc({ tokenUrl: srv.url }));
  try {
    let seen;
    const r = await attemptLoginIfTokenFresh({ tokenFile: h.tokenFile }, {
      login: async (_inst, tok) => {
        seen = tok;
        return { ok: true };
      },
    });
    assert.equal(r.ok, true);
    assert.equal(r.loginCount, 1);
    assert.equal(seen, FAKE_NEW_ACCESS);
    const written = JSON.parse(fs.readFileSync(h.tokenFile, 'utf8'));
    assert.equal(written.access_token, FAKE_NEW_ACCESS);
    const raw = fs.readFileSync(h.tokenFile);
    assert.notEqual(raw[0], 0xef);
  } finally {
    srv.server.close();
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('Fake 400: exit 3 and the old file body is unchanged', async () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  // Child HTTP server: parent spawnSync would block the event loop and deadlock
  // an in-process listener.
  const srvProc = spawn(
    process.execPath,
    [
      '-e',
      "require('http').createServer((q,s)=>{s.writeHead(400);s.end('{}')}).listen(0,'127.0.0.1',function(){process.stdout.write(String(this.address().port))})",
    ],
    { stdio: ['ignore', 'pipe', 'inherit'] },
  );
  const port = await new Promise((resolve, reject) => {
    const t = setTimeout(() => reject(new Error('no port')), 5000);
    srvProc.stdout.once('data', (b) => {
      clearTimeout(t);
      resolve(String(b).trim());
    });
    srvProc.once('error', reject);
  });
  const h = writeHarness(expiredDoc({ tokenUrl: `http://127.0.0.1:${port}/token` }));
  try {
    const env = { ...process.env };
    delete env.PRIORITY_SAAS_TOKEN;
    const run = spawnSync(
      process.execPath,
      [BIN, 'whoami', '--instance', 'dev', '--instances', h.instances],
      { encoding: 'utf8', cwd: ROOT, env },
    );
    const out = String(run.stdout || '') + String(run.stderr || '');
    assert.equal(run.status, 3, out);
    const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
    assert.equal(body.reason, 'token_expired');
    assert.equal(fs.readFileSync(h.tokenFile, 'utf8'), h.originalBody);
    assert.doesNotMatch(out, new RegExp(FAKE_REFRESH));
    assert.doesNotMatch(out, new RegExp(FAKE_OLD_ACCESS));
  } finally {
    srvProc.kill();
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('Missing tokenUrl with refresh_token: token_expired and no POST', async () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  let fetches = 0;
  const h = writeHarness(expiredDoc());
  try {
    const r = await resolveAccessToken({ tokenFile: h.tokenFile }, {
      fetch: async () => {
        fetches += 1;
        throw new Error('must not fetch');
      },
    });
    assert.equal(r.ok, false);
    assert.equal(r.reason, 'token_expired');
    assert.equal(fetches, 0);
    assert.equal(fs.readFileSync(h.tokenFile, 'utf8'), h.originalBody);
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});
