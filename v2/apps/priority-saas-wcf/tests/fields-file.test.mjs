/**
 * FR #402 / FR-020: --fields-file UTF-8, BOM refused, 1 MiB + 1 too large.
 * Does not log the file body. Does not change form save.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'os';
import path from 'path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { loadFieldsFile, FIELDS_FILE_MAX_BYTES } from '../lib/fields-file.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function tmp(name) {
  return path.join(fs.mkdtempSync(path.join(os.tmpdir(), 'fields-file-')), name);
}

test('small ASCII file parses to expected fields object', () => {
  const file = tmp('small.json');
  fs.writeFileSync(file, '{"EMAIL":"a@b.c"}', 'utf8');
  const loaded = loadFieldsFile(file);
  assert.equal(loaded.ok, true);
  assert.deepEqual(loaded.fields, { EMAIL: 'a@b.c' });
  assert.equal(JSON.stringify(loaded).includes('"a@b.c"'), true);
});

test('leading EF BB BF is bom_refused and does not include body', () => {
  const file = tmp('bom.json');
  const json = '{"SECRET":"do-not-log-this-body"}';
  fs.writeFileSync(file, Buffer.concat([Buffer.from([0xef, 0xbb, 0xbf]), Buffer.from(json, 'ascii')]));
  const loaded = loadFieldsFile(file);
  assert.equal(loaded.ok, false);
  assert.equal(loaded.reason, 'bom_refused');
  assert.equal(JSON.stringify(loaded).includes('do-not-log-this-body'), false);
});

test('1 MiB plus 1 byte is fields_file_too_large', () => {
  const file = tmp('huge.json');
  fs.writeFileSync(file, Buffer.alloc(FIELDS_FILE_MAX_BYTES + 1, 0x20));
  const loaded = loadFieldsFile(file);
  assert.equal(loaded.ok, false);
  assert.equal(loaded.reason, 'fields_file_too_large');
  assert.equal(loaded.bytes, FIELDS_FILE_MAX_BYTES + 1);
});

test('CLI BOM --fields-file exits 2 bom_refused before login', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'ff-cli-'));
  const file = path.join(dir, 'bom.json');
  fs.writeFileSync(
    file,
    Buffer.concat([Buffer.from([0xef, 0xbb, 0xbf]), Buffer.from('{"EMAIL":"x"}', 'ascii')]),
  );
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'ff-fake',
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
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'set',
      '--instance',
      'ff-fake',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--fields-file',
      file,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKESECRET_s3t4u5v6w7x8y9z0a1b2' },
    },
  );
  const out = String(run.stdout || '');
  assert.equal(run.status, 2, out + String(run.stderr || ''));
  const parsed = JSON.parse(out.trim());
  assert.equal(parsed.reason, 'bom_refused');
  assert.doesNotMatch(out, /login_connect|Can't connect/i);
  assert.equal(out.includes('FAKE_fields_file_token'), false);
});

test('MRB-470: form save with --fields-file BOM is not bom_refused', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'ff-save-'));
  const file = path.join(dir, 'bom.json');
  fs.writeFileSync(
    file,
    Buffer.concat([Buffer.from([0xef, 0xbb, 0xbf]), Buffer.from('{"EMAIL":"x"}', 'ascii')]),
  );
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'ff-save',
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
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'form',
      'save',
      '--instance',
      'ff-save',
      '--instances',
      instances,
      '--form',
      'CUSTOMERS',
      '--fields',
      '{"EMAIL":"a@b.c"}',
      '--fields-file',
      file,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKESECRET_s3t4u5v6w7x8y9z0a1b2' },
    },
  );
  const out = String(run.stdout || '');
  const parsed = JSON.parse(out.trim());
  assert.notEqual(parsed.reason, 'bom_refused', out);
  assert.ok(
    parsed.reason === 'live_refused' || parsed.reason === 'writes_require_allowLive',
    out,
  );
  assert.doesNotMatch(out, /login_connect|Can't connect/i);
});

