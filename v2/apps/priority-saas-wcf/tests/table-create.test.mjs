/**
 * FR #416 / FR-034: table create uses the same SQL gate as column add.
 * Offline fakes only — no live SaaS / no secrets. Never emit raw CREATE.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { createTable } from '../lib/table.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function writeHarness(opts) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tbl-create-'));
  const instances = path.join(dir, 'instances.json');
  const tokenFile = path.join(dir, 'tokens.json');
  const request = path.join(dir, 'request.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: opts.id || 'dev',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          tokenFile,
          allowLive: opts.allowLive === true,
          wcfUrl: 'https://example.invalid/wcf/service.svc',
          ...(opts.sqlProfile ? { sqlProfile: opts.sqlProfile } : {}),
        },
      ],
    }),
  );
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({
      access_token: 'FAKE_access_token_table_create',
      obtained_at: new Date().toISOString(),
      expires_in: 3600,
    }),
  );
  fs.writeFileSync(
    request,
    JSON.stringify({
      columns: [{ name: 'C1', type: 'CHAR', title: 'Cust' }],
    }),
  );
  return { dir, instances, request };
}

function runCreate(h) {
  return spawnSync(
    process.execPath,
    [
      BIN,
      'table',
      'create',
      '--instance',
      h.id || 'dev',
      '--instances',
      h.instances,
      '--name',
      'T1',
      '--request',
      h.request,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_access_token_table_create' },
    },
  );
}

test('sqlProfile plus allowLive: one create call on the fake (no raw CREATE)', async () => {
  const calls = [];
  const session = {
    priority: {
      createTable: async (spec) => {
        calls.push(spec);
      },
    },
  };
  const r = await createTable(
    session,
    { sqlProfile: { name: 'dev-sql' }, allowLive: true },
    {
      table: 'T1',
      columns: [{ name: 'C1', type: 'CHAR', title: 'Cust' }],
    },
  );
  assert.equal(r.ok, true);
  assert.equal(calls.length, 1);
  assert.equal(calls[0].table, 'T1');
  assert.equal(calls[0].columns[0].name, 'C1');
  assert.equal(JSON.stringify(calls[0]).includes('CREATE'), false);
});

test('No sqlProfile: login count 0 and reason table_ddl_needs_sql', () => {
  const h = writeHarness({ allowLive: true, id: 'dev' });
  const started = Date.now();
  const run = runCreate({ ...h, id: 'dev' });
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.reason, 'table_ddl_needs_sql');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|login_connect|Can't connect/i);
  assert.doesNotMatch(out, /FAKE_access_token_table_create/);
});

test('allowLive false: live_refused before login', () => {
  const h = writeHarness({
    allowLive: false,
    id: 'saas-live',
    sqlProfile: { name: 'dev-sql' },
  });
  const started = Date.now();
  const run = runCreate({ ...h, id: 'saas-live' });
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.reason, 'live_refused');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
  assert.doesNotMatch(out, /FAKE_access_token_table_create/);
});

test('verbIsWrite: table.create is a write', () => {
  assert.equal(verbIsWrite('table.create'), true);
});

test('MRB 500: 21-char column title on create is title_too_long before login', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tbl-create-ttl-'));
  const instances = path.join(dir, 'instances.json');
  const request = path.join(dir, 'request.json');
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
          allowLive: true,
          sqlProfile: { name: 'dev-sql' },
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  fs.writeFileSync(
    request,
    JSON.stringify({
      columns: [{ name: 'C1', type: 'CHAR', title: '123456789012345678901' }],
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'table',
      'create',
      '--instance',
      'dev',
      '--instances',
      instances,
      '--name',
      'T1',
      '--request',
      request,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_access_token_table_create' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.reason, 'title_too_long');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
});
