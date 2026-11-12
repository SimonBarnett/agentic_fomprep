/**
 * FR #400 / FR-018: form subform --set --fields-file writes the child row.
 * Offline fake only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { formSubformSetFields } from '../lib/form.mjs';
import { loadFieldsFile } from '../lib/request-file.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('Fake: --set path calls fieldUpdate on the child (not parent)', async () => {
  const parentUpdates = [];
  const childUpdates = [];
  const child = {
    name: 'CUSTPERSONNEL',
    fieldUpdate: async (field, value) => {
      childUpdates.push({ field, value });
    },
  };
  const parent = {
    name: 'CUSTOMERS',
    fieldUpdate: async (field, value) => {
      parentUpdates.push({ field, value });
    },
    startSubForm: async () => child,
  };
  const { set } = await formSubformSetFields(parent, 'CUSTPERSONNEL', {
    EMAIL: 'a@b.c',
    NAME: 'Pat',
  });
  assert.equal(set.set, 2);
  assert.deepEqual(
    childUpdates.map((u) => u.field).sort(),
    ['EMAIL', 'NAME'],
  );
  assert.equal(parentUpdates.length, 0, 'parent must not be fieldUpdated');
});

test('loadFieldsFile reads UTF-8 JSON object', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'fields-file-'));
  const p = path.join(dir, 'fields.json');
  fs.writeFileSync(p, JSON.stringify({ EMAIL: 'x@y.z' }), 'utf8');
  const loaded = loadFieldsFile(p);
  assert.equal(loaded.ok, true);
  assert.deepEqual(loaded.fields, { EMAIL: 'x@y.z' });
});

test('allowLive false with --set: login never runs (writes_require_allowLive)', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'subform-set-'));
  const instances = path.join(dir, 'instances.json');
  const fieldsFile = path.join(dir, 'fields.json');
  fs.writeFileSync(fieldsFile, JSON.stringify({ EMAIL: 'a@b.c' }), 'utf8');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'ro-only',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'CO',
          user: 'u@x.com',
          allowLive: false,
          tokenFile: path.join(dir, 'missing-tokens.json'),
        },
      ],
    }),
  );
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'subform',
      '--instance',
      'ro-only',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--subform',
      'CUSTPERSONNEL',
      '--set',
      '--fields-file',
      fieldsFile,
    ],
    { encoding: 'utf8', cwd: ROOT, env: { ...process.env } },
  );
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, false);
  assert.equal(body.reason, 'writes_require_allowLive');
  // refuseLiveWrite runs before loadAccessToken/login — token_missing would mean login path started
  assert.notEqual(body.reason, 'token_missing');
  assert.notEqual(body.reason, 'token_expired');
  assert.equal(run.status, 2);
});
