/**
 * FR #406 / FR-024: proc/prepare JSON urls[] from displayUrlOf; no download.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { walkProcSteps } from '../lib/proc-walk.mjs';

test('Fake step with Urls.url https://example.invalid/r is in urls', async () => {
  const proc = {
    continueProc: async () => ({ type: 'end', proc }),
  };
  const first = {
    type: 'displayUrl',
    proc,
    Urls: { url: 'https://example.invalid/r' },
  };
  const result = await walkProcSteps(first, { maxSteps: 5, deadlineMs: 5000 });
  assert.deepEqual(result.urls, ['https://example.invalid/r']);
});

test('A step with no Urls yields urls length 0', async () => {
  const proc = {
    message: async () => ({ type: 'end', proc }),
  };
  const first = { type: 'message', messagetype: 'I', message: 'ok', proc };
  const result = await walkProcSteps(first, { maxSteps: 5, deadlineMs: 5000 });
  assert.equal(Array.isArray(result.urls), true);
  assert.equal(result.urls.length, 0);
});
