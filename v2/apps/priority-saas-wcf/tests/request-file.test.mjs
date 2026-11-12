/**
 * FR #389 / FR-007: --request <path> UTF-8 JSON overrides verb flags.
 * Offline only — broken file must exit 2 without login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import {
  loadRequestFile,
  valueFromRequest,
  fieldsFromRequestOrFlag,
} from '../lib/request-file.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('fixture request.json fields.EMAIL matches --fields object form set uses', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'req-ok-'));
  const file = path.join(dir, 'request.json');
  fs.writeFileSync(file, JSON.stringify({ fields: { EMAIL: 'a@b.c' } }), 'utf8');
  const loaded = loadRequestFile(file);
  assert.equal(loaded.ok, true);
  const fromFile = fieldsFromRequestOrFlag(loaded.doc, '');
  const fromFlag = fieldsFromRequestOrFlag(null, JSON.stringify({ EMAIL: 'a@b.c' }));
  assert.deepEqual(fromFile, { EMAIL: 'a@b.c' });
  assert.deepEqual(fromFile, fromFlag);
});

test('request keys override matching CLI flags when present', () => {
  const doc = {
    fields: { EMAIL: 'from-file' },
    filter: { field: 'CUSTNAME', fromval: 'X' },
    name: 'FROMFILE',
    form: 'CUSTOMERS',
    subform: 'CONTACTS',
    inputs: { A: 1 },
  };
  assert.deepEqual(fieldsFromRequestOrFlag(doc, '{"EMAIL":"from-cli"}'), {
    EMAIL: 'from-file',
  });
  assert.equal(valueFromRequest(doc, 'form', 'CLI'), 'CUSTOMERS');
  assert.equal(valueFromRequest(doc, 'name', 'CLI'), 'FROMFILE');
  assert.equal(valueFromRequest(doc, 'subform', 'CLI'), 'CONTACTS');
  assert.deepEqual(valueFromRequest(doc, 'filter', null), {
    field: 'CUSTNAME',
    fromval: 'X',
  });
  assert.deepEqual(valueFromRequest(doc, 'inputs', null), { A: 1 });
  assert.equal(valueFromRequest({}, 'form', 'CLI'), 'CLI');
});

test('broken request file: loadRequestFile returns request_invalid', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'req-bad-'));
  const file = path.join(dir, 'broken.json');
  fs.writeFileSync(file, '{not-json', 'utf8');
  const loaded = loadRequestFile(file);
  assert.equal(loaded.ok, false);
  assert.equal(loaded.reason, 'request_invalid');
});

test('CLI broken --request exits 2 request_invalid and does not call login', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'req-cli-'));
  const broken = path.join(dir, 'broken.json');
  fs.writeFileSync(broken, '{nope', 'utf8');
  const instances = path.join(dir, 'instances.json');
  const tokenFile = path.join(dir, 'tokens.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'req-fake',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          tokenFile,
          tabulaini: 'tab.ini',
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({
      access_token: 'FAKE_access_token_request_fixture',
      obtained_at: new Date().toISOString(),
    }),
  );

  const env = {
    ...process.env,
    PRIORITY_SAAS_TOKEN: 'FAKE_access_token_request_fixture',
    PRIORITY_SAAS_WCF_INSTANCES: instances,
  };
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'set',
      '--instance',
      'req-fake',
      '--instances',
      instances,
      '--request',
      broken,
      '--form',
      'CUSTOMERS',
    ],
    { encoding: 'utf8', env, cwd: ROOT },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  assert.match(out, /"reason"\s*:\s*"request_invalid"/);
  // Fail before login/probe: must be fast and must not surface network/login reasons.
  assert.ok(elapsed < 5000, `expected fast fail before login, took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|probe_failed|ECONNREFUSED/i);
  assert.doesNotMatch(out, /FAKE_access_token_request_fixture/);
});
