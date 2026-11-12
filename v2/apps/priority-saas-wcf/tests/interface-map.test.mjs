/**
 * FR #419 / FR-037: interface map set --fields-file; write gated by allowLive.
 * Offline fakes only — no live SaaS / no secrets. Does not prepare.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { setInterfaceMap, INTERFACE_MAP_FORM } from '../lib/interface-map.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('allowLive true: fake update count 1', async () => {
  const updates = [];
  const form = {
    name: INTERFACE_MAP_FORM,
    setSearchFilter: async () => {},
    getRows: async () => ({ FORMINTERFACES: { 1: { ENAME: 'MYIFACE' } } }),
    fieldUpdate: async (field, value) => {
      updates.push({ field, value });
    },
    endCurrentForm: async () => {},
  };
  const r = await setInterfaceMap(
    { ok: true, priority: {} },
    { company: 'co', allowLive: true },
    {
      name: 'MYIFACE',
      fields: { MAPCOL: 'X' },
      formStart: async (_p, ename) => {
        assert.equal(ename, INTERFACE_MAP_FORM);
        return form;
      },
      formGetRows: async (f) => {
        await f.getRows(1);
        return { rows: [{ ENAME: 'MYIFACE' }] };
      },
      safeEnd: async () => {},
    },
  );
  assert.equal(r.ok, true);
  assert.equal(r.prepared, false);
  assert.equal(updates.length, 1);
  assert.equal(updates[0].field, 'MAPCOL');
  assert.equal(updates[0].value, 'X');
});

test('allowLive false: login count 0', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'iface-map-'));
  const instances = path.join(dir, 'instances.json');
  const fieldsFile = path.join(dir, 'fields.json');
  const tokenFile = path.join(dir, 'tokens.json');
  fs.writeFileSync(fieldsFile, JSON.stringify({ MAPCOL: 'X' }), 'utf8');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'saas-live',
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
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({
      access_token: 'FAKE_access_token_iface_map',
      obtained_at: new Date().toISOString(),
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'interface',
      'map',
      'set',
      '--instance',
      'saas-live',
      '--instances',
      instances,
      '--name',
      'MYIFACE',
      '--fields-file',
      fieldsFile,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_access_token_iface_map' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.reason, 'live_refused');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
  assert.doesNotMatch(out, /FAKE_access_token_iface_map/);
});

test('verbIsWrite: interface map set is a write', () => {
  assert.equal(
    verbIsWrite('interface.map', ['node', 'bin', 'interface', 'map', 'set']),
    true,
  );
  assert.equal(verbIsWrite('interface.list'), false);
});
