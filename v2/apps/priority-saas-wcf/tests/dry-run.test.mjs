/**
 * FR #391 / FR-009: --dry-run resolves instance, never logs in.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { planDryRun, verbFromArgv, verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

let loginCalls = 0;

test('verbFromArgv form columns; write false', () => {
  assert.equal(verbFromArgv(['node', 'bin', 'form', 'columns', '--dry-run']), 'form.columns');
  assert.equal(verbIsWrite('form.columns'), false);
  assert.equal(verbIsWrite('form.save'), true);
});

test('Fake SDK: form columns --dry-run calls login zero times', () => {
  loginCalls = 0;
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'dry-run-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'saas1',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'CO',
          user: 'u@x.com',
        },
      ],
    }),
  );
  const argv = [
    'node',
    BIN,
    'form',
    'columns',
    '--dry-run',
    '--instance',
    'saas1',
    '--instances',
    instances,
  ];
  const plan = planDryRun(argv);
  assert.equal(plan.ok, true);
  assert.equal(plan.instanceId, 'saas1');
  assert.equal(plan.verb, 'form.columns');
  assert.equal(plan.write, false);
  assert.equal(loginCalls, 0);
  const run = spawnSync(
    process.execPath,
    [BIN, 'form', 'columns', '--dry-run', '--instance', 'saas1', '--instances', instances],
    { encoding: 'utf8', cwd: ROOT, env: { ...process.env } },
  );
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, true);
  assert.equal(body.instanceId, 'saas1');
  assert.equal(body.verb, 'form.columns');
  assert.equal(body.write, false);
  assert.equal(run.status, 0);
  assert.equal(loginCalls, 0);
});

test('Unknown instance still reason instance_unknown', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'dry-run-miss-'));
  const instances = path.join(dir, 'instances.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'saas1',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'CO',
          user: 'u@x.com',
        },
      ],
    }),
  );
  const plan = planDryRun([
    'node',
    BIN,
    'form',
    'columns',
    '--dry-run',
    '--instance',
    'nope',
    '--instances',
    instances,
  ]);
  assert.equal(plan.ok, false);
  assert.equal(plan.reason, 'instance_unknown');
  const run = spawnSync(
    process.execPath,
    [BIN, 'form', 'columns', '--dry-run', '--instance', 'nope', '--instances', instances],
    { encoding: 'utf8', cwd: ROOT },
  );
  const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
  assert.equal(body.ok, false);
  assert.equal(body.reason, 'instance_unknown');
  assert.equal(run.status, 2);
});
