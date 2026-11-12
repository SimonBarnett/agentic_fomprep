/**
 * FR-043 / #425: form rows --limit default 50, max 500; 501 exits 2 before login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  applySearchThenGetRows,
  formGetRows,
  FORM_ROWS_DEFAULT_LIMIT,
  parseFormRowsLimit,
} from '../lib/form.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function packN(n) {
  const pack = {};
  for (let i = 1; i <= n; i += 1) pack[i] = { CUSTNAME: 'r' + i };
  return pack;
}

function fakeForm(n) {
  return {
    name: 'CUSTOMERS',
    setSearchFilter: async () => {},
    getRows: async () => ({ CUSTOMERS: packN(n) }),
  };
}

test('Fake 1000-row form with --limit 10 returns 10', async () => {
  const got = await applySearchThenGetRows(fakeForm(1000), null, {
    fromRow: 1,
    getRows: formGetRows,
    limit: 10,
  });
  assert.equal(got.count, 10);
  assert.equal(got.rows.length, 10);
  assert.equal(got.limit, 10);
});

test('Omitted limit returns 50 from a long fake', async () => {
  const parsed = parseFormRowsLimit('');
  assert.equal(parsed.ok, true);
  assert.equal(parsed.limit, FORM_ROWS_DEFAULT_LIMIT);
  const got = await applySearchThenGetRows(fakeForm(1000), null, {
    fromRow: 1,
    getRows: formGetRows,
    limit: parsed.limit,
  });
  assert.equal(got.count, 50);
  assert.equal(got.rows.length, 50);
});

test('--limit 501 exits 2', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'fr425-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'saas1',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'CO',
          user: 'u@x.com',
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'rows',
      '--form',
      'CUSTOMERS',
      '--limit',
      '501',
      '--instance',
      'saas1',
      '--instances',
      instances,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_limit_token' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.reason, 'limit_too_high');
  assert.ok(elapsed < 5000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
});
