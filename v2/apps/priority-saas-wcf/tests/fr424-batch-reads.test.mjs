/**
 * FR-042 / #424: batch --request reads[] share one login; writes and 9th refused before login.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { validateBatchRequest, runBatchReads } from '../lib/batch.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function harness() {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'fr424-'));
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
  return { dir, instances };
}

test('three reads: login count 1 and three result objects', async () => {
  const v = validateBatchRequest({
    reads: [{ verb: 'whoami' }, { verb: 'companies' }, { verb: 'interface list' }],
  });
  assert.equal(v.ok, true);
  let logins = 0;
  const out = await runBatchReads({
    reads: v.reads,
    login: async () => {
      logins += 1;
      return { ok: true };
    },
    runRead: async (_session, read) => ({ ok: true, action: read.verb }),
  });
  assert.equal(logins, 1);
  assert.equal(out.results.length, 3);
  assert.deepEqual(
    out.results.map((r) => r.action),
    ['whoami', 'companies', 'interface.list'],
  );
});

test('form new inside the file: login count 0 and exit 2', () => {
  const h = harness();
  const req = path.join(h.dir, 'req.json');
  fs.writeFileSync(
    req,
    JSON.stringify({
      reads: [{ verb: 'whoami' }, { verb: 'form.new', form: 'USERS' }],
    }),
  );
  const started = Date.now();
  const run = spawnSync(
    process.execPath,
    [BIN, 'batch', '--request', req, '--instance', 'saas1', '--instances', h.instances],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_batch_token' },
    },
  );
  const elapsed = Date.now() - started;
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, false);
  assert.equal(body.reason, 'batch_write_refused');
  assert.ok(elapsed < 5000, `must not login; took ${elapsed}ms`);
  assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
});

test('nine reads: exit 2', () => {
  const h = harness();
  const req = path.join(h.dir, 'nine.json');
  const reads = Array.from({ length: 9 }, () => ({ verb: 'whoami' }));
  fs.writeFileSync(req, JSON.stringify({ reads }));
  const run = spawnSync(
    process.execPath,
    [BIN, 'batch', '--request', req, '--instance', 'saas1', '--instances', h.instances],
    {
      encoding: 'utf8',
      cwd: ROOT,
      env: { ...process.env, PRIORITY_SAAS_TOKEN: 'FAKE_batch_token' },
    },
  );
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(run.status, 2, out);
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, false);
  assert.equal(body.reason, 'batch_too_many');
});
