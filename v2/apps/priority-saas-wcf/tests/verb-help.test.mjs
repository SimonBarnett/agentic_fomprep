/**
 * FR #390 / FR-008: per-verb help text.
 * Offline spawn only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
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

test('help form: one screen lists columns/rows/new/delete/action; not proc start', () => {
  const r = runHelp('help', 'form');
  assert.equal(r.status, 0, r.stderr || r.stdout);
  const out = String(r.stdout || '');
  assert.match(out, /\bcolumns\b/i);
  assert.match(out, /\brows\b/i);
  assert.match(out, /\bnew\b/i);
  assert.match(out, /\bdelete\b/i);
  assert.match(out, /\baction\b/i);
  assert.doesNotMatch(out, /proc\s+start/i);
  // Must be form-only: no prepare/proc/table dump
  assert.doesNotMatch(out, /\bprepare form\|procedure\|report\b/i);
  assert.doesNotMatch(out, /^priority-wcf \(SaaS Web SDK client\)/m);
});

test('help nosuch: exits 2', () => {
  const r = runHelp('help', 'nosuch');
  assert.equal(r.status, 2, r.stdout + r.stderr);
});

test('help alone keeps top-level summary with five object kinds', () => {
  const r = runHelp('help');
  assert.equal(r.status, 0, r.stderr || r.stdout);
  const out = String(r.stdout || '');
  assert.match(out, /priority-wcf \(SaaS Web SDK client\)/);
  for (const kind of ['table', 'form', 'report', 'procedure', 'interface']) {
    assert.match(out, new RegExp(`\\b${kind}\\b`, 'i'), `missing ${kind}`);
  }
});

test('help prepare|proc|table|interface|report: exit 0 and topic-scoped', () => {
  for (const topic of ['prepare', 'proc', 'table', 'interface', 'report']) {
    const r = runHelp('help', topic);
    assert.equal(r.status, 0, topic + ': ' + (r.stderr || r.stdout));
    const out = String(r.stdout || '');
    assert.match(out, new RegExp(`\\b${topic}\\b`, 'i'), topic);
    assert.doesNotMatch(out, /^priority-wcf \(SaaS Web SDK client\)/m);
  }
});
