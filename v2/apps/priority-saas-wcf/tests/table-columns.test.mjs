/**
 * FR #412 / FR-030: table columns from OData COLUMNS; unknown table empty.
 * Offline fakes only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { fetchTableColumns } from '../lib/table.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

const instance = {
  odataBase: 'https://example.invalid/odata/tab.ini,3/co',
};

test('Fake OData value array of two columns is returned', async () => {
  const fetchImpl = async () => ({
    ok: true,
    status: 200,
    text: async () =>
      JSON.stringify({
        value: [
          { CNAME: 'CUST', CTYPE: 'CHAR', TITLE: 'Customer' },
          { CNAME: 'QTY', CTYPE: 'INT', TITLE: 'Qty' },
        ],
      }),
  });
  const r = await fetchTableColumns(instance, 'CUSTOMERS', {
    fetchImpl,
    accessToken: 'FAKE_odata_token',
  });
  assert.equal(r.ok, true);
  assert.equal(r.exists, true);
  assert.equal(r.columns.length, 2);
  assert.equal(r.columns[0].name, 'CUST');
  assert.equal(r.columns[0].type, 'CHAR');
  assert.equal(r.columns[0].title, 'Customer');
  assert.equal(r.columns[1].name, 'QTY');
});

test('Empty value returns columns length 0', async () => {
  const fetchImpl = async () => ({
    ok: true,
    status: 200,
    text: async () => JSON.stringify({ value: [] }),
  });
  const r = await fetchTableColumns(instance, 'NOSUCH', {
    fetchImpl,
    accessToken: 'FAKE_odata_token',
  });
  assert.equal(r.ok, true);
  assert.equal(r.exists, false);
  assert.equal(r.columns.length, 0);
});

test('help table lists columns', () => {
  const r = spawnSync(process.execPath, [BIN, 'help', 'table'], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  assert.match(String(r.stdout || ''), /\bcolumns\b/i);
});

test('verbIsWrite: table.columns is not a write', () => {
  assert.equal(verbIsWrite('table.columns'), false);
});
