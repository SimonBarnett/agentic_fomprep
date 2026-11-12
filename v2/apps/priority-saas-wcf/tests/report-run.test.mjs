/**
 * FR #407 / FR-025: report run is proc start with ptype R; help lists run.
 * Offline fakes only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { runProcStart } from '../lib/proc.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('Fake test: ptype passed to procStart is R', async () => {
  const seen = [];
  const session = {
    priority: {
      procStart: async (name, ptype, _x, company) => {
        seen.push({ name, ptype, company });
        return { type: 'end', proc: { name } };
      },
    },
  };
  const result = await runProcStart(session, { company: 'CO' }, 'MYREP', { ptype: 'R' });
  assert.equal(seen.length, 1);
  assert.equal(seen[0].ptype, 'R');
  assert.equal(seen[0].name, 'MYREP');
  assert.equal(result.ptype, 'R');
  assert.equal(Array.isArray(result.urls), true);
});

test('help report stdout contains run', () => {
  const r = spawnSync(process.execPath, [BIN, 'help', 'report'], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  assert.match(String(r.stdout || ''), /\brun\b/i);
});

test('verbIsWrite: report.run is a write', () => {
  assert.equal(verbIsWrite('report.run'), true);
});
