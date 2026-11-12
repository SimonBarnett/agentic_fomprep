/**
 * FR #414 / FR-032: dictionary titles longer than 20 characters are refused.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { checkDictionaryTitle, DICTIONARY_TITLE_MAX } from '../lib/dictionary-title.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('20-character title passes the checker', () => {
  const t = '12345678901234567890';
  assert.equal(t.length, DICTIONARY_TITLE_MAX);
  const r = checkDictionaryTitle(t);
  assert.equal(r.ok, true);
  assert.equal(r.length, 20);
  assert.equal(r.max, 20);
});

test('21-character title is title_too_long', () => {
  const t = '123456789012345678901';
  assert.equal(t.length, 21);
  const r = checkDictionaryTitle(t);
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'title_too_long');
  assert.equal(r.length, 21);
});

test('CLI 21-character title exits 2 with login count 0', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'title-len-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'ttl',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          allowLive: true,
          wcfUrl: 'https://example.invalid/wcf/service.svc',
          tabulaini: 'tab.ini',
        },
      ],
    }),
  );
  const longTitle = '123456789012345678901';
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'table',
      'column',
      'add',
      '--instance',
      'ttl',
      '--instances',
      instances,
      '--name',
      'MYTABLE',
      '--column',
      'C1',
      '--type',
      'CHAR',
      '--title',
      longTitle,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_title_len_token' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, false);
  assert.equal(body.reason, 'title_too_long');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|login_connect|Can't connect/i);
  assert.doesNotMatch(out, /FAKE_title_len_token/);
});
