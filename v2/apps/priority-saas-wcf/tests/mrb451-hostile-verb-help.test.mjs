/**
 * MRB #451 hostile pins for FR-008 / #390.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function runHelp(...args) {
  return spawnSync(process.execPath, [BIN, ...args], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
}

test('MRB-451: help nosuch is JSON unknown_help_topic on stdout, exit 2', () => {
  const r = runHelp('help', 'nosuch');
  assert.equal(r.status, 2);
  const parsed = JSON.parse(String(r.stdout || '').trim());
  assert.equal(parsed.ok, false);
  assert.equal(parsed.reason, 'unknown_help_topic');
  assert.equal(parsed.topic, 'nosuch');
});

test('MRB-451: help form is not the top-level banner and omits proc start', () => {
  const r = runHelp('help', 'form');
  assert.equal(r.status, 0);
  const out = String(r.stdout || '');
  assert.match(out, /^help form/m);
  assert.doesNotMatch(out, /proc\s+start/i);
  assert.doesNotMatch(out, /^priority-wcf \(SaaS Web SDK client\)/m);
});

test('MRB-451: README documents help form; no UTF-8 BOM', () => {
  const p = path.join(ROOT, 'README.md');
  const raw = fs.readFileSync(p);
  assert.notEqual(raw[0], 0xef);
  const text = raw.toString('utf8');
  assert.match(text, /help form/);
  assert.match(text, /unknown topic exits 2/i);
});
