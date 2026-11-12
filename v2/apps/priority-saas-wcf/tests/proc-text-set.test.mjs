/**
 * FR #410 / FR-028: proc text set --file through EXEC form; allowLive before login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { applyProcTextToForm } from '../lib/proc-text.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('allowLive true: fake form receives the file text once', async () => {
  const seen = [];
  const form = {
    fieldUpdate: async (field, value) => {
      seen.push({ field, value });
    },
    saveRow: async () => {},
  };
  const r = await applyProcTextToForm(form, 'SELECT 1 FROM DUMMY');
  assert.equal(r.ok, true);
  assert.equal(seen.length, 1);
  assert.equal(seen[0].field, 'TEXT');
  assert.equal(seen[0].value, 'SELECT 1 FROM DUMMY');
});

test('allowLive false: login count 0', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'proc-text-'));
  const file = path.join(dir, 'body.txt');
  fs.writeFileSync(file, 'SELECT 1 FROM DUMMY', 'utf8');
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'pt-deny',
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
      'proc',
      'text',
      'set',
      '--instance',
      'pt-deny',
      '--instances',
      instances,
      '--name',
      'MYPROC',
      '--file',
      file,
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKESECRET_w2x3y4z5a6b7c8d9e0f1' },
    },
  );
  const out = String(run.stdout || '');
  assert.equal(run.status, 2, out + String(run.stderr || ''));
  const parsed = JSON.parse(out.trim());
  assert.ok(
    parsed.reason === 'live_refused' || parsed.reason === 'writes_require_allowLive',
    out,
  );
  assert.doesNotMatch(out, /login_connect|Can't connect/i);
  assert.equal(out.includes('FAKE_proc_text_token'), false);
});
