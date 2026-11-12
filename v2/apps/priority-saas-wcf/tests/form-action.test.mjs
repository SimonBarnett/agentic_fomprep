/**
 * FR #399 / FR-017: form action --name <activation>; allowLive required before login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { formRunAction } from '../lib/form.mjs';
import { refuseLiveWrite } from '../lib/allowlist.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('Fake SDK: activation SAVE is invoked once via activateStart', async () => {
  const calls = [];
  const form = {
    activateStart: async (name, ...rest) => {
      calls.push({ name, rest });
      return { ok: true };
    },
  };
  const r = await formRunAction(form, 'SAVE');
  assert.equal(r.ok, true);
  assert.equal(r.activation, 'SAVE');
  assert.equal(r.via, 'activateStart');
  assert.equal(calls.length, 1);
  assert.equal(calls[0].name, 'SAVE');
});

test('Fake SDK: falls back to invoke when activateStart missing', async () => {
  const calls = [];
  const form = {
    invoke: async (name) => {
      calls.push(name);
    },
  };
  const r = await formRunAction(form, 'SAVE');
  assert.equal(r.ok, true);
  assert.equal(r.via, 'invoke');
  assert.deepEqual(calls, ['SAVE']);
});

test('allowLive false: refuseLiveWrite before any login', () => {
  const live = refuseLiveWrite(
    { id: 'dev', allowLive: false, title: 'dev', company: 'x' },
    { write: true },
  );
  assert.equal(live.reason, 'writes_require_allowLive');
});

test('CLI form action allowLive false: exit 2, login count 0 (fast, no login fail)', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'form-action-'));
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
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({
      access_token: 'FAKE_access_token_form_action',
      obtained_at: new Date().toISOString(),
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'action',
      '--instance',
      'dev',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--name',
      'SAVE',
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_access_token_form_action' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  assert.match(out, /writes_require_allowLive|live_refused/);
  assert.ok(elapsed < 5000, `must refuse before login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
  assert.doesNotMatch(out, /FAKE_access_token_form_action/);
});
