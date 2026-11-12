/**
 * MRB #475 hostile: form.subform --set is write; bare subform is not.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { verbIsWrite, planDryRun } from '../lib/dry-run.mjs';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';

test('verbIsWrite: form.subform + --set is write; bare subform is not', () => {
  assert.equal(verbIsWrite('form.subform', ['node', 'bin', 'form', 'subform', '--set']), true);
  assert.equal(verbIsWrite('form.subform', ['node', 'bin', 'form', 'subform']), false);
});

test('planDryRun: subform --set write true for known instance', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'mrb475-dry-'));
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
  const withSet = planDryRun([
    'node',
    'bin',
    'form',
    'subform',
    '--set',
    '--instance',
    'saas1',
    '--instances',
    instances,
  ]);
  assert.equal(withSet.ok, true);
  assert.equal(withSet.write, true);
  const bare = planDryRun([
    'node',
    'bin',
    'form',
    'subform',
    '--instance',
    'saas1',
    '--instances',
    instances,
  ]);
  assert.equal(bare.ok, true);
  assert.equal(bare.write, false);
});
