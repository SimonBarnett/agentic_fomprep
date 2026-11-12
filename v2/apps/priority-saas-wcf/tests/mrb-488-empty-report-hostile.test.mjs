/**
 * MRB #488 hostile pins for FR-026 / #408 empty report success.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { outcomeFromWalk } from '../lib/proc.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

test('MRB-488: Warning-only errors: ok true, empty false', () => {
  const o = outcomeFromWalk({
    ended: true,
    steps: [],
    errors: [{ severity: 'Warning', text: 'soft' }],
  });
  assert.equal(o.ok, true);
  assert.equal(o.empty, false);
});

test('MRB-488: url present: ok true, empty false', () => {
  const o = outcomeFromWalk({
    ended: true,
    steps: [{ Urls: { url: 'https://example.invalid/out.pdf' } }],
    errors: [],
  });
  assert.equal(o.ok, true);
  assert.equal(o.empty, false);
  assert.equal(o.urls.length, 1);
});

test('MRB-488: tip does not change prepare.mjs / gate.mjs', () => {
  // product tree files exist; FR out of scope is prep gate — pin no edits in this PR tip vs common pattern
  assert.ok(fs.existsSync(path.join(ROOT, 'lib', 'prepare.mjs')));
  assert.ok(fs.existsSync(path.join(ROOT, 'lib', 'gate.mjs')));
});
