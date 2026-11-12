/**
 * MRB #494 hostile pins for FR-031 / #413 table exists.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { fetchTableExists } from '../lib/table.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('MRB-494: GET only — never POST/PUT/PATCH/DELETE', async () => {
  const methods = [];
  const fetchImpl = async (_url, init) => {
    methods.push(String(init?.method || 'GET').toUpperCase());
    return {
      ok: true,
      status: 200,
      text: async () => JSON.stringify({ value: [{ TNAME: 'X' }] }),
    };
  };
  await fetchTableExists(
    { odataBase: 'https://example.invalid/odata/x' },
    'X',
    { fetchImpl, accessToken: 'FAKE_mrb494' },
  );
  assert.deepEqual(methods, ['GET']);
  assert.ok(!methods.some((m) => ['POST', 'PUT', 'PATCH', 'DELETE'].includes(m)));
});

test('MRB-494: empty name is name_required without fetch', async () => {
  let calls = 0;
  const fetchImpl = async () => {
    calls += 1;
    return { ok: true, status: 200, text: async () => '{}' };
  };
  const r = await fetchTableExists({ odataBase: 'https://example.invalid/o' }, '  ', {
    fetchImpl,
    accessToken: 'FAKE_mrb494',
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'name_required');
  assert.equal(calls, 0);
});

test('MRB-494: CLI missing --name exits 2 before WCF login', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'mrb494-table-'));
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
          odataBase: 'https://example.invalid/odata/tab.ini,3/co',
        },
      ],
    }),
  );
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({
      access_token: 'FAKE_mrb494_cli_token',
      obtained_at: new Date().toISOString(),
    }),
  );

  // Stub global fetch via NODE_OPTIONS is hard; instead assert no_odata path is not taken
  // and that without a reachable OData host we still never hit WCF login (fast fail).
  // Unit tests cover miss ok:true; here pin CLI wiring: missing name exits 2 before login.
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [BIN, 'table', 'exists', '--instance', 'dev', '--instances', instances],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_mrb494_cli_token' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  assert.match(out, /name_required/);
  assert.ok(elapsed < 5000, `must refuse before login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
  assert.doesNotMatch(out, /FAKE_mrb494_cli_token/);
});

test('MRB-494: OData apostrophe in TNAME is doubled in filter', async () => {
  let seenUrl = '';
  const fetchImpl = async (url) => {
    seenUrl = String(url);
    return {
      ok: true,
      status: 200,
      text: async () => JSON.stringify({ value: [] }),
    };
  };
  const r = await fetchTableExists(
    { odataBase: 'https://example.invalid/odata' },
    "O'Brien",
    { fetchImpl, accessToken: 'FAKE_mrb494' },
  );
  assert.equal(r.ok, true);
  assert.equal(r.exists, false);
  assert.match(seenUrl, /O''Brien|O%27%27Brien/);
});
