/**
 * FR #404 / FR-022: ambiguous inputOptions return needs_input; do not pick Options[0].
 * Single option may still be taken. --out snapshot is for FR-23.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'os';
import path from 'path';
import { walkProcSteps } from '../lib/proc-walk.mjs';

test('Fake two-option step: inputOptions call count 0 and reason needs_input', async () => {
  let calls = 0;
  const proc = {
    inputOptions: async () => {
      calls += 1;
      return { type: 'end', proc };
    },
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
  const result = await walkProcSteps(first, { maxSteps: 5, deadlineMs: 5000 });
  assert.equal(calls, 0);
  assert.equal(result.ok, false);
  assert.equal(result.reason, 'needs_input');
  assert.equal(result.options.length, 2);
  assert.equal(result.ended, false);
});

test('Fake one-option step: inputOptions call count 1', async () => {
  let calls = 0;
  const proc = {
    inputOptions: async () => {
      calls += 1;
      return { type: 'end', proc };
    },
  };
  const first = {
    type: 'inputOptions',
    proc,
    input: { Options: [{ field: 'ONLY', title: 'Solo' }] },
  };
  const result = await walkProcSteps(first, { maxSteps: 5, deadlineMs: 5000 });
  assert.equal(calls, 1);
  assert.equal(result.ended, true);
  assert.notEqual(result.reason, 'needs_input');
});

test('needs_input snapshot writes when onNeedsInput is set (--out / FR-23)', async () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'needs-in-'));
  const dest = path.join(dir, 'needs-input.json');
  const proc = { inputOptions: async () => ({ type: 'end', proc: {} }) };
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
    maxSteps: 5,
    deadlineMs: 5000,
    onNeedsInput: (snap) => {
      fs.writeFileSync(dest, JSON.stringify(snap));
    },
  });
  assert.equal(result.reason, 'needs_input');
  assert.equal(fs.existsSync(dest), true);
  const saved = JSON.parse(fs.readFileSync(dest, 'utf8'));
  assert.equal(saved.type, 'inputOptions');
});
