/**
 * FR #411 / FR-029: prepare interface refuses until config/interface-prep.json pins a proc.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  defaultInterfacePrepPath,
  loadInterfacePrepConfig,
} from '../lib/interface-prep.mjs';
import { prepareKindDefaults, runPrepare } from '../lib/prepare.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('shipped config/interface-prep.json has empty proc (no guessed ENAME)', () => {
  const shipped = defaultInterfacePrepPath(ROOT);
  assert.ok(fs.existsSync(shipped), 'config/interface-prep.json must ship');
  const doc = JSON.parse(fs.readFileSync(shipped, 'utf8'));
  assert.equal(doc.proc, '');
});

test('loadInterfacePrepConfig: missing or empty proc => interface_prep_unknown', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'iface-prep-'));
  const missing = loadInterfacePrepConfig(path.join(dir, 'nope.json'));
  assert.equal(missing.ok, false);
  assert.equal(missing.reason, 'interface_prep_unknown');

  const emptyPath = path.join(dir, 'empty.json');
  fs.writeFileSync(emptyPath, JSON.stringify({ proc: '' }));
  const empty = loadInterfacePrepConfig(emptyPath);
  assert.equal(empty.ok, false);
  assert.equal(empty.reason, 'interface_prep_unknown');

  const blankPath = path.join(dir, 'blank.json');
  fs.writeFileSync(blankPath, JSON.stringify({ proc: '   ' }));
  const blank = loadInterfacePrepConfig(blankPath);
  assert.equal(blank.ok, false);
  assert.equal(blank.reason, 'interface_prep_unknown');
});

test('loadInterfacePrepConfig: fixture REPPREPDIRECT2 returns that proc', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'iface-prep-ok-'));
  const p = path.join(dir, 'interface-prep.json');
  fs.writeFileSync(p, JSON.stringify({ proc: 'REPPREPDIRECT2' }));
  const r = loadInterfacePrepConfig(p);
  assert.equal(r.ok, true);
  assert.equal(r.proc, 'REPPREPDIRECT2');
});

test('prepareKindDefaults interface: EXEC catalog, never invents a proc', () => {
  const d = prepareKindDefaults('interface');
  assert.equal(d.kind, 'interface');
  assert.equal(d.catalogForm, 'EXEC');
  assert.equal(d.proc, '');
});

test('CLI prepare interface with empty proc: exit 2, interface_prep_unknown, login count 0', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'iface-cli-'));
  const instances = path.join(dir, 'instances.json');
  const prep = path.join(dir, 'interface-prep.json');
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
          tokenFile: path.join(dir, 'tokens.json'),
          allowLive: true,
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  fs.writeFileSync(
    path.join(dir, 'tokens.json'),
    JSON.stringify({
      access_token: 'FAKE_access_token_iface_prep',
      obtained_at: new Date().toISOString(),
    }),
  );
  fs.writeFileSync(prep, JSON.stringify({ proc: '' }));

  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'prepare',
      'interface',
      '--instance',
      'dev',
      '--instances',
      instances,
      '--name',
      'SOMEIFACE',
      '--interface-prep',
      prep,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_access_token_iface_prep' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  assert.match(out, /interface_prep_unknown/);
  assert.ok(elapsed < 5000, `must refuse before login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
  assert.doesNotMatch(out, /FAKE_access_token_iface_prep/);
});

test('Fixture config proc REPPREPDIRECT2: prepare runner activates that proc name', async () => {
  const activated = [];
  const form = {
    name: 'EXEC',
    setSearchFilter: async () => {},
    getRows: async () => ({ EXEC: { 1: { ENAME: 'IFACE1', _idx: 1 } } }),
    setActiveRow: async () => {},
    activateStart: async (procName) => {
      activated.push(procName);
      return {
        type: 'end',
        proc: {
          message: async () => ({ type: 'end', proc: {} }),
        },
      };
    },
    activateEnd: async () => {},
    end: async () => {},
  };
  const session = {
    priority: {
      formStart: async () => form,
    },
  };
  const result = await runPrepare(session, { company: 'co' }, 'interface', 'IFACE1', {
    proc: 'REPPREPDIRECT2',
    gate: false,
    messages: [],
  });
  assert.deepEqual(activated, ['REPPREPDIRECT2']);
  assert.equal(result.proc, 'REPPREPDIRECT2');
  assert.equal(result.kind, 'interface');
  assert.equal(result.walkOk, true);
});
