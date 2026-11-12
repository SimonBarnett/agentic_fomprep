/**
 * FR #408 / FR-026: ended walk with no urls and no errors is ok + empty, not a failure.
 * Prep gate unchanged.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { runProcStart } from '../lib/proc.mjs';

test('Fake ended walk with no urls: empty true', async () => {
  const r = await runProcStart(
    { priority: { procStart: async () => ({ type: 'end', proc: {} }) } },
    { company: 'co' },
    'EMPTYREP',
    { ptype: 'R' },
  );
  assert.equal(r.ok, true);
  assert.equal(r.empty, true);
  assert.equal((r.urls || []).length, 0);
});

test('Fake blocker: ok false', async () => {
  const proc = {
    message: async () => ({ type: 'end', proc }),
  };
  const r = await runProcStart(
    {
      priority: {
        procStart: async () => ({
          type: 'message',
          messagetype: 'error',
          message: 'blocked',
          proc,
        }),
      },
    },
    { company: 'co' },
    'BADREP',
    { ptype: 'R' },
  );
  assert.equal(r.ok, false);
  assert.notEqual(r.empty, true);
});
