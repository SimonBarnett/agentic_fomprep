/**
 * MRB #485 hostile: urls[] on walk; no download; collectStepUrls skips empty.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { collectStepUrls, displayUrlOf, walkProcSteps } from '../lib/proc-walk.mjs';

test('collectStepUrls skips steps without Urls; keeps order', () => {
  const urls = collectStepUrls([
    { type: 'message', message: 'x' },
    { type: 'displayUrl', Urls: { url: 'https://example.invalid/a' } },
    { type: 'displayUrl', Urls: { url: 'https://example.invalid/b' } },
  ]);
  assert.deepEqual(urls, ['https://example.invalid/a', 'https://example.invalid/b']);
});

test('displayUrlOf never implies a fetch (string/object/array shapes only)', () => {
  assert.equal(displayUrlOf({ Urls: 'https://example.invalid/s' }), 'https://example.invalid/s');
  assert.equal(displayUrlOf({ urls: [{ url: 'https://example.invalid/arr' }] }), 'https://example.invalid/arr');
  assert.equal(displayUrlOf(null), '');
});

test('needs_input early return still includes urls[]', async () => {
  const proc = {
    inputOptions: async () => {
      throw new Error('must not call inputOptions when ambiguous');
    },
  };
  const first = {
    type: 'inputOptions',
    proc,
    Urls: { url: 'https://example.invalid/pending' },
    input: {
      Options: [
        { field: 'A', title: 'One' },
        { field: 'B', title: 'Two' },
      ],
    },
  };
  const r = await walkProcSteps(first, { maxSteps: 3, deadlineMs: 3000 });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'needs_input');
  assert.deepEqual(r.urls, ['https://example.invalid/pending']);
});
