/**
 * MRB #445 hostile: --dry-run must not call login even with a bearer token present.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');
const FAKE = 'FAKE_access_token_dry_run_hostile_do_not_print';

test('CLI dry-run with FAKE token: exit 0 fast; no login failure; token absent', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'mrb445-dry-'));
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
        },
      ],
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [BIN, 'form', 'start', '--dry-run', '--instance', 'saas1', '--instances', instances],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: FAKE },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 0, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, true);
  assert.equal(body.instanceId, 'saas1');
  assert.equal(body.verb, 'form.start');
  assert.equal(body.write, false);
  assert.ok(elapsed < 5000, `dry-run must not login/probe; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED|probe_failed/i);
  assert.doesNotMatch(out, /FAKE_access_token_dry_run_hostile/);
});

test('verbIsWrite: proc.start true; form.start false (matches tip classification)', () => {
  assert.equal(verbIsWrite('proc.start'), true);
  assert.equal(verbIsWrite('form.start'), false);
  assert.equal(verbIsWrite('prepare.form'), true);
});
