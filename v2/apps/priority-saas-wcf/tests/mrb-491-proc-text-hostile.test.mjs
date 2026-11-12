/**
 * MRB #491 hostile pins for FR-028 / #410 proc text set.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadProcTextFile } from '../lib/proc-text.mjs';
import { verbIsWrite, verbFromArgv } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

test('MRB-491: loadProcTextFile missing path does not echo a body', () => {
  const loaded = loadProcTextFile('');
  assert.equal(loaded.ok, false);
  assert.equal(Object.prototype.hasOwnProperty.call(loaded, 'body'), false);
});

test('MRB-491: load fail object has no body key (file contents never attached)', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'pt-h-'));
  const p = path.join(dir, 'missing.txt');
  const loaded = loadProcTextFile(p);
  assert.equal(loaded.ok, false);
  assert.equal(Object.prototype.hasOwnProperty.call(loaded, 'body'), false);
});

test('MRB-491: proc text set is a write; proc text alone is not enough without set', () => {
  const argv = ['node', 'bin', 'proc', 'text', 'set', '--file', 'x'];
  assert.equal(verbFromArgv(argv), 'proc.text');
  assert.equal(verbIsWrite('proc.text', argv), true);
  assert.equal(verbIsWrite('proc.text', ['node', 'bin', 'proc', 'text']), false);
});

test('MRB-491: proc-text module does not import prepare', () => {
  const src = fs.readFileSync(path.join(ROOT, 'lib', 'proc-text.mjs'), 'utf8');
  assert.doesNotMatch(src, /runPrepare|from '\.\/prepare/);
  assert.match(src, /formStart/);
  assert.match(src, /'EXEC'|\"EXEC\"/);
});
