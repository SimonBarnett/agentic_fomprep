/**
 * FR #393 / FR-011: stable process exit codes.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { exitCodeForFail, fail, ok } from '../lib/json-out.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');
const README = path.join(ROOT, 'README.md');

function capture(fn) {
  const prev = process.exitCode;
  let stdout = '';
  const orig = process.stdout.write;
  process.stdout.write = (chunk, ...rest) => {
    stdout += String(chunk);
    return true;
  };
  try {
    const ret = fn();
    return { parsed: JSON.parse(stdout.trim()), exitCode: process.exitCode, ret };
  } finally {
    process.stdout.write = orig;
    process.exitCode = prev;
  }
}

test('exitCodeForFail: auth reasons are 3', () => {
  for (const r of [
    'login_failed',
    'api_licence',
    'login_connect',
    'token_expired',
    'user_unidentified',
  ]) {
    assert.equal(exitCodeForFail(r), 3, r);
  }
});

test('exitCodeForFail: usage/allowlist/request_invalid are 2', () => {
  for (const r of [
    'unknown_verb',
    'request_invalid',
    'instance_unknown',
    'instance_required',
    'no_instances_file',
    'form_required',
  ]) {
    assert.equal(exitCodeForFail(r), 2, r);
  }
});

test('exitCodeForFail: prepare walk + gate unavailable is 4', () => {
  assert.equal(
    exitCodeForFail('prepare_gate_failed', {
      walkOk: true,
      gate: { status: 'unavailable', preparedClaim: false },
    }),
    4,
  );
  // other gate failures stay 2
  assert.equal(
    exitCodeForFail('prepare_gate_failed', {
      walkOk: true,
      gate: { status: 'still_unprepared', preparedClaim: false },
    }),
    2,
  );
});

test('fail()/ok() set process.exitCode for the four bands', () => {
  assert.equal(capture(() => ok({ ping: true })).exitCode, 0);
  assert.equal(capture(() => fail('request_invalid', { detail: 'bad json' })).exitCode, 2);
  assert.equal(capture(() => fail('token_expired')).exitCode, 3);
  assert.equal(capture(() => fail('login_connect')).exitCode, 3);
  assert.equal(capture(() => fail('user_unidentified')).exitCode, 3);
  assert.equal(
    capture(() =>
      fail('prepare_gate_failed', {
        walkOk: true,
        gate: { status: 'unavailable', preparedClaim: false },
      }),
    ).exitCode,
    4,
  );
});

test('CLI unknown instance exits 2 (allowlist)', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'exit-codes-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'only-one',
          host: 'example.invalid',
          tenant: 't',
          company: 'co',
          user: 'u@x.com',
          tokenFile: path.join(dir, 'missing-tokens.json'),
        },
      ],
    }),
  );
  const r = spawnSync(
    process.execPath,
    [BIN, 'probe', '--instance', 'nosuch', '--instances', instances],
    { encoding: 'utf8', cwd: ROOT, env: { ...process.env } },
  );
  assert.equal(r.status, 2, r.stdout + r.stderr);
  assert.match(String(r.stdout || ''), /instance_unknown|ok"\s*:\s*false/);
});

test('CLI help nosuch / unknown_verb style usage exits 2', () => {
  const r = spawnSync(process.execPath, [BIN, 'not-a-real-verb'], {
    encoding: 'utf8',
    cwd: ROOT,
  });
  assert.equal(r.status, 2, r.stdout + r.stderr);
});

test('README documents exit 0, exit 2, exit 3, exit 4', () => {
  const text = fs.readFileSync(README, 'utf8');
  for (const needle of ['exit 0', 'exit 2', 'exit 3', 'exit 4']) {
    assert.match(text, new RegExp(needle.replace(' ', '\\s+'), 'i'), needle);
  }
});
