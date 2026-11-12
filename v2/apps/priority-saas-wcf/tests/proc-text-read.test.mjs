/**
 * FR #409 / FR-027: proc text --name returns {name, body}; missing/empty -> proc_text_missing exit 2.
 * Read-only (allowLive not required). Stdout has no token.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { refuseLiveWrite } from '../lib/allowlist.mjs';
import { bodyFromExecRow, readProcTextViaExecForm } from '../lib/proc-text.mjs';
import { ok, fail } from '../lib/json-out.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function captureEmit(fn) {
  const chunks = [];
  const orig = process.stdout.write;
  const prevCode = process.exitCode;
  process.stdout.write = (c, enc, cb) => {
    chunks.push(Buffer.isBuffer(c) ? c.toString('utf8') : String(c));
    if (typeof enc === 'function') enc();
    if (typeof cb === 'function') cb();
    return true;
  };
  try {
    fn();
    return { text: chunks.join(''), code: process.exitCode };
  } finally {
    process.stdout.write = orig;
    process.exitCode = prevCode;
  }
}

test('Fake EXEC row returns the fixture body', async () => {
  const form = {
    name: 'EXEC',
    setSearchFilter: async () => {},
    getRows: async () => ({
      EXEC: {
        1: { ENAME: 'MYPROC', TEXT: 'SELECT 1 FROM DUMMY', _idx: 1 },
      },
    }),
    endCurrentForm: async () => {},
  };
  const r = await readProcTextViaExecForm(
    { ok: true, priority: {} },
    { id: 't', company: 'CO', allowLive: false },
    'MYPROC',
    {
      formStart: async () => form,
      formGetRows: async (f) => {
        const pack = (await f.getRows(1)).EXEC || {};
        const list = Object.keys(pack).map((i) => ({ _idx: Number(i), ...pack[i] }));
        return { formName: 'EXEC', count: list.length, rows: list };
      },
      safeEnd: async () => {},
    },
  );
  assert.equal(r.ok, true);
  assert.equal(r.name, 'MYPROC');
  assert.equal(r.body, 'SELECT 1 FROM DUMMY');
  const live = refuseLiveWrite({ id: 't', allowLive: false }, { write: false });
  assert.equal(live, null);
  const captured = captureEmit(() => ok({ action: 'proc.text', name: r.name, body: r.body }));
  const parsed = JSON.parse(captured.text.trim());
  assert.equal(parsed.name, 'MYPROC');
  assert.equal(parsed.body, 'SELECT 1 FROM DUMMY');
});

test('Empty body exits 2 with proc_text_missing', async () => {
  assert.equal(bodyFromExecRow({ ENAME: 'X', TEXT: '   ' }), null);
  const form = {
    name: 'EXEC',
    setSearchFilter: async () => {},
    getRows: async () => ({
      EXEC: { 1: { ENAME: 'EMPTYPROC', TEXT: '', _idx: 1 } },
    }),
    endCurrentForm: async () => {},
  };
  const r = await readProcTextViaExecForm(
    { ok: true, priority: {} },
    { company: 'CO', allowLive: false },
    'EMPTYPROC',
    {
      formStart: async () => form,
      formGetRows: async (f) => {
        const pack = (await f.getRows(1)).EXEC || {};
        const list = Object.keys(pack).map((i) => ({ _idx: Number(i), ...pack[i] }));
        return { formName: 'EXEC', count: list.length, rows: list };
      },
      safeEnd: async () => {},
    },
  );
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'proc_text_missing');
  const captured = captureEmit(() => fail('proc_text_missing', { action: 'proc.text', name: 'EMPTYPROC' }, 2));
  assert.equal(captured.code, 2);
  const parsed = JSON.parse(captured.text.trim());
  assert.equal(parsed.reason, 'proc_text_missing');
});

test('Stdout has no token (CLI dry path with fake token env)', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'proc-text-read-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'pt-read',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          allowLive: false,
          tabulaini: 'tab.ini',
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  const token = 'FAKE_proc_text_read_token_xyz';
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'proc',
      'text',
      '--instance',
      'pt-read',
      '--instances',
      instances,
      '--name',
      'MYPROC',
      '--dry-run',
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: token },
    },
  );
  const out = String(run.stdout || '');
  assert.equal(run.status, 0, out + String(run.stderr || ''));
  assert.equal(out.includes(token), false, out);
  const parsed = JSON.parse(out.trim());
  assert.equal(parsed.verb, 'proc.text');
  assert.equal(parsed.write, false);
});
