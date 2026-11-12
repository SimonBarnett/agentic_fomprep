/**
 * FR #415 / FR-033: table column add; SaaS without sqlProfile refuses before login.
 * Offline fakes only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'os';
import path from 'path';
import { fileURLToPath } from 'node:url';
import { addTableColumn } from '../lib/table.mjs';
import { checkDictionaryTitle } from '../lib/title-check.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('sqlProfile plus allowLive: one add call on the fake', async () => {
  const calls = [];
  const session = {
    priority: {
      addTableColumn: async (spec) => {
        calls.push(spec);
      },
    },
  };
  const r = await addTableColumn(
    session,
    { sqlProfile: { name: 'dev-sql' }, allowLive: true },
    { table: 'T1', column: 'C1', type: 'CHAR', title: 'Cust' },
  );
  assert.equal(r.ok, true);
  assert.equal(calls.length, 1);
  assert.equal(calls[0].column, 'C1');
  assert.equal(calls[0].title, 'Cust');
});

test('21-character title is title_too_long; 20 passes the checker', () => {
  assert.equal(checkDictionaryTitle('123456789012345678901').reason, 'title_too_long');
  assert.equal(checkDictionaryTitle('12345678901234567890').ok, true);
});

test('No sqlProfile: login count 0 and reason table_ddl_needs_sql', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tbl-col-'));
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
          allowLive: true,
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({
      access_token: 'FAKE_access_token_table_column_add',
      obtained_at: new Date().toISOString(),
      expires_in: 3600,
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'table',
      'column',
      'add',
      '--instance',
      'dev',
      '--instances',
      instances,
      '--name',
      'T1',
      '--column',
      'C1',
      '--type',
      'CHAR',
      '--title',
      'Cust',
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_access_token_table_column_add' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.reason, 'table_ddl_needs_sql');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|login_connect|Can't connect/i);
  assert.doesNotMatch(out, /FAKE_access_token_table_column_add/);
});

test('verbIsWrite: table.column add is a write', () => {
  assert.equal(
    verbIsWrite('table.column', ['node', 'bin', 'table', 'column', 'add']),
    true,
  );
});

test('MRB 497 fold: help table lists columns and column add', () => {
  const r = spawnSync(process.execPath, [BIN, 'help', 'table'], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  const out = String(r.stdout || '');
  assert.match(out, /table columns/);
  assert.match(out, /table column add/);
});
