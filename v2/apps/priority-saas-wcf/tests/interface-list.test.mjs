/**
 * FR #417 / FR-035: interface list is a read of the EXEC catalog.
 * Offline fakes only — no live SaaS / no secrets. Run is FR-36.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { listInterfaces, INTERFACE_CATALOG_FORM } from '../lib/interface-list.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';
import { refuseLiveWrite } from '../lib/allowlist.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('Fake catalog form returns two names', async () => {
  const started = [];
  const form = {
    name: 'EXEC',
    getRows: async () => ({
      EXEC: {
        1: { ENAME: 'IFACE1', TITLE: 'First interface' },
        2: { ENAME: 'IFACE2', TITLE: 'Second interface' },
      },
    }),
    endCurrentForm: async () => {},
  };
  const r = await listInterfaces({
    instance: { id: 'dev', company: 'co', allowLive: false },
    session: { ok: true, priority: {} },
    formStart: async (priority, ename) => {
      started.push(ename);
      return form;
    },
    formGetRows: async (f) => {
      const rows = await f.getRows(1);
      const pack = rows.EXEC || {};
      const list = Object.keys(pack).map((i) => ({ _idx: i, ...pack[i] }));
      return { formName: 'EXEC', count: list.length, rows: list };
    },
    safeEnd: async () => {},
  });
  assert.equal(r.ok, true);
  assert.deepEqual(started, [INTERFACE_CATALOG_FORM]);
  assert.equal(r.interfaces.length, 2);
  assert.deepEqual(r.interfaces[0], { name: 'IFACE1', title: 'First interface' });
  assert.deepEqual(r.interfaces[1], { name: 'IFACE2', title: 'Second interface' });
});

test('help interface stdout contains list', () => {
  const r = spawnSync(process.execPath, [BIN, 'help', 'interface'], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  assert.match(String(r.stdout || ''), /\blist\b/i);
});

test('interface list is read-only', () => {
  assert.equal(verbIsWrite('interface.list'), false);
  const live = refuseLiveWrite(
    { id: 'dev', allowLive: false, title: 'dev', company: 'x' },
    { write: false },
  );
  assert.equal(live, null);
});
