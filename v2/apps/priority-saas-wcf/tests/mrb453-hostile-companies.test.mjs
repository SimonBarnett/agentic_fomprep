/**
 * MRB #453 hostile pins for FR-012 / #394.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { listCompanies } from '../lib/companies.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('MRB-453: listCompanies never reports switched true', async () => {
  const r = await listCompanies({
    instance: { company: 'CO1', allowLive: false },
    session: {
      ok: true,
      priority: {},
      loginResult: { companies: [{ name: 'CO1', title: 'A' }] },
    },
  });
  assert.equal(r.ok, true);
  assert.equal(r.switched, false);
});

test('MRB-453: help companies is one screen', () => {
  const r = spawnSync(process.execPath, [BIN, 'help', 'companies'], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  const out = String(r.stdout || '');
  assert.match(out, /^help companies/m);
  assert.match(out, /allowLive/i);
  assert.doesNotMatch(out, /^priority-wcf \(SaaS Web SDK client\)/m);
});
