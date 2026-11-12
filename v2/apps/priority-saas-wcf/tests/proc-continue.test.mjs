/**
 * FR #405 / FR-023: proc continue --from --option; no auto-pick.
 * Offline fakes only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { walkProcSteps } from '../lib/proc-walk.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('Fake two-step: continue with the second option calls inputOptions with that field', async () => {
  const fields = [];
  const proc = {
    inputOptions: async (_ok, field) => {
      fields.push(field);
      return {
        type: 'inputFields',
        proc,
        input: { EditField: [{ field: 'PAR', title: 'Name', value: '' }] },
      };
    },
    inputFields: async () => ({ type: 'end', proc }),
  };
  const first = {
    type: 'inputOptions',
    proc,
    input: {
      Options: [
        { field: 'A', title: 'One' },
        { field: 'B', title: 'Two' },
      ],
    },
  };
  const result = await walkProcSteps(first, {
    chosenOption: 'B',
    maxSteps: 8,
    deadlineMs: 5000,
  });
  assert.equal(fields.length, 1);
  assert.equal(fields[0], 'B');
  assert.equal(result.ended, true);
});

test('Missing --from exits 2 and login count 0', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'proc-cont-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'saas1',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'CO',
          user: 'u@x.com',
          wcfUrl: 'https://example.invalid/wcf/service.svc',
          tabulaini: 'tabula.ini',
        },
      ],
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [
      BIN,
      'proc',
      'continue',
      '--instance',
      'saas1',
      '--instances',
      instances,
      '--option',
      'B',
    ],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_token_proc_continue_no_from' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, false);
  assert.equal(body.reason, 'from_required');
  assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|login_connect|Can't connect/i);
  assert.doesNotMatch(out, /FAKE_token_proc_continue_no_from/);
});

test('verbIsWrite: proc.continue is a write', () => {
  assert.equal(verbIsWrite('proc.continue'), true);
});
