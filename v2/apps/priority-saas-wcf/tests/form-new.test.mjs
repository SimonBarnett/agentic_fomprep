/**
 * FR #397 / FR-015: form new inserts one row when allowLive is true.
 * allowLive false: live_refused, exit 2, no login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { formInsertRow } from '../lib/form.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('allowLive true: insert path newRow once then save', async () => {
  const calls = { newRow: 0, fieldUpdate: 0, saveRow: 0, saveArg: null };
  const form = {
    newRow: async () => {
      calls.newRow += 1;
    },
    fieldUpdate: async () => {
      calls.fieldUpdate += 1;
    },
    saveRow: async (n) => {
      calls.saveRow += 1;
      calls.saveArg = n;
    },
  };
  const r = await formInsertRow(form, { CUSTNAME: 'X', EMAIL: 'a@b.c' });
  assert.equal(calls.newRow, 1);
  assert.equal(calls.fieldUpdate, 2);
  assert.equal(calls.saveRow, 1);
  assert.equal(r.set, 2);
  assert.equal(r.saved, true);
});

test('allowLive false: login count 0 and exit 2 live_refused', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'form-new-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'new-deny',
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
  let loginCount = 0;
  const env = {
    ...process.env,
    PRIORITY_SAAS_WCF_INSTANCES: instances,
    PRIORITY_SAAS_TOKEN: 'FAKESECRET_s3t4u5v6w7x8y9z0a1b2',
  };
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'new',
      '--instance',
      'new-deny',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--fields',
      '{"CUSTNAME":"X"}',
    ],
    { encoding: 'utf8', env, cwd: ROOT },
  );
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const parsed = JSON.parse(String(run.stdout || '').trim());
  assert.equal(parsed.ok, false);
  assert.equal(parsed.reason, 'live_refused');
  assert.equal(out.includes('FAKE_form_new_token_not_for_login'), false);
  assert.equal(loginCount, 0);
  assert.doesNotMatch(out, /login_connect|Can't connect/i);
});
