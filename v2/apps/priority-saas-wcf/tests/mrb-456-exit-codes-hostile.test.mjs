/**
 * MRB #456 hostile pins for FR-011 / #393 exit codes.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { exitCodeForFail, fail } from '../lib/json-out.mjs';

function capture(fn) {
  const prev = process.exitCode;
  let stdout = '';
  const orig = process.stdout.write;
  process.stdout.write = (chunk) => {
    stdout += String(chunk);
    return true;
  };
  try {
    fn();
    return { parsed: JSON.parse(stdout.trim()), exitCode: process.exitCode };
  } finally {
    process.stdout.write = orig;
    process.exitCode = prev;
  }
}

test('MRB-456: walk not finished + gate unavailable stays exit 2', () => {
  assert.equal(
    exitCodeForFail('prepare_walk_failed', {
      walkOk: false,
      gate: { status: 'unavailable', preparedClaim: false },
    }),
    2,
  );
});

test('MRB-456: explicit fail(exit) override beats exitCodeForFail', () => {
  assert.equal(capture(() => fail('token_expired', {}, 2)).exitCode, 2);
  assert.equal(capture(() => fail('request_invalid', {}, 3)).exitCode, 3);
});

test('MRB-456: login_failed and api_licence map to 3; crash stays 2', () => {
  assert.equal(exitCodeForFail('login_failed'), 3);
  assert.equal(exitCodeForFail('api_licence'), 3);
  assert.equal(exitCodeForFail('crash', { message: 'x' }), 2);
});

test('MRB-456: prepare_gate_failed + walkOk + unavailable is 4 (CLI shape)', () => {
  // bin/priority-wcf.mjs spreads runPrepare result into fail('prepare_gate_failed', ...)
  assert.equal(
    capture(() =>
      fail('prepare_gate_failed', {
        walkOk: true,
        preparedClaim: false,
        gate: { status: 'unavailable', preparedClaim: false },
      }),
    ).exitCode,
    4,
  );
});
