/**
 * MRB #471 hostile pins for FR-017 / #399 form action.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { formRunAction } from '../lib/form.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

test('MRB-471: empty activation is activation_required', async () => {
  const r = await formRunAction({ activateStart: async () => ({}) }, '  ');
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'activation_required');
});

test('MRB-471: neither activateStart nor invoke is activation_unsupported', async () => {
  const r = await formRunAction({}, 'SAVE');
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'activation_unsupported');
});

test('MRB-471: form.action is a write; form.subform alone is not', () => {
  assert.equal(verbIsWrite('form.action'), true);
  assert.equal(verbIsWrite('form.subform'), false);
});

test('MRB-471: cmdForm write flag includes action', () => {
  const src = fs.readFileSync(path.join(ROOT, 'bin', 'priority-wcf.mjs'), 'utf8');
  const line = (src.match(/const write = [^\n]+/) || [''])[0];
  assert.match(line, /sub === 'action'/);
});
