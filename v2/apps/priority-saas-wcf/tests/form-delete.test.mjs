/**
 * FR #398 / FR-016: form delete needs --confirm; allowLive false before login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { formDeletePositionedRow } from '../lib/form.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function fakeForm() {
  const counts = { deleteRow: 0, setSearch: 0 };
  const form = {
    name: 'CUSTOMERS',
    setSearchFilter: async () => {
      counts.setSearch += 1;
    },
    getRows: async () => ({ CUSTOMERS: { 1: { CUSTNAME: 'X' } } }),
    setActiveRow: async () => {},
    deleteRow: async () => {
      counts.deleteRow += 1;
    },
    counts: () => counts,
  };
  return form;
}

test('with confirm and allowLive: delete count 1', async () => {
  const form = fakeForm();
  const filter = {
    or: 0,
    QueryValues: [{ field: 'CUSTNAME', fromval: 'X', toval: '', op: '=', sort: 0, isdesc: 0 }],
  };
  const r = await formDeletePositionedRow(form, filter);
  assert.equal(r.ok, true);
  assert.equal(r.deleted, 1);
  assert.equal(form.counts().deleteRow, 1);
});

test('missing confirm: delete count 0 and exit 2 confirm_required', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'form-del-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'del-live',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          allowLive: true,
          tabulaini: 'tab.ini',
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
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
      'delete',
      '--instance',
      'del-live',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--filter',
      '{"field":"CUSTNAME","fromval":"X"}',
    ],
    { encoding: 'utf8', env, cwd: ROOT },
  );
  const out = String(run.stdout || '');
  assert.equal(run.status, 2, out + String(run.stderr || ''));
  const parsed = JSON.parse(out.trim());
  assert.equal(parsed.reason, 'confirm_required');
  assert.doesNotMatch(out, /login_connect|Can't connect/i);
  assert.equal(out.includes('FAKE_form_delete_token'), false);
});

test('allowLive false with --confirm: live_refused before login', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'form-del-deny-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'del-deny',
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
      'delete',
      '--confirm',
      '--instance',
      'del-deny',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--filter',
      '{"field":"CUSTNAME","fromval":"X"}',
    ],
    { encoding: 'utf8', env, cwd: ROOT },
  );
  const out = String(run.stdout || '');
  assert.equal(run.status, 2, out + String(run.stderr || ''));
  const parsed = JSON.parse(out.trim());
  assert.equal(parsed.reason, 'live_refused');
  assert.doesNotMatch(out, /login_connect|Can't connect/i);
});
