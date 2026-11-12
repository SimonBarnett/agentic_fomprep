/**
 * MRB #480 hostile pins for FR-021 / #403 proc --inputs.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { walkProcSteps } from '../lib/proc-walk.mjs';
import { loadInputsFile } from '../lib/inputs-file.mjs';

test('MRB-480: file values apply only on the first inputFields step', async () => {
  const saw = [];
  const proc = {
    inputFields: async (_ok, data) => {
      saw.push(data);
      if (saw.length === 1) {
        return {
          type: 'inputFields',
          proc,
          input: {
            EditField: [{ field: 'PAR', title: 'Form name', value: '' }],
          },
        };
      }
      return { type: 'end', proc };
    },
  };
  const first = {
    type: 'inputFields',
    proc,
    input: {
      EditField: [{ field: 'PAR', title: 'Form name', value: '' }],
    },
  };
  await walkProcSteps(first, {
    nameHint: 'HINTNAME',
    inputValues: { PAR: 'FROMFILE' },
    maxSteps: 10,
    deadlineMs: 5000,
  });
  assert.equal(saw.length, 2);
  assert.equal(saw[0].EditFields[0].value, 'FROMFILE');
  // second step: file map not reapplied; name-hint fills PAR
  assert.equal(saw[1].EditFields[0].value, 'HINTNAME');
});

test('MRB-480: input map keys match EditField case-insensitively', async () => {
  let saw;
  const proc = {
    inputFields: async (_ok, data) => {
      saw = data;
      return { type: 'end', proc };
    },
  };
  await walkProcSteps(
    {
      type: 'inputFields',
      proc,
      input: { EditField: [{ field: 'PAR', title: 'Form', value: '' }] },
    },
    { inputValues: { par: 'LOWER' }, maxSteps: 5, deadlineMs: 3000 },
  );
  assert.equal(saw.EditFields[0].value, 'LOWER');
});

test('MRB-480: nested object values skipped; scalars kept', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'inputs-h-'));
  const p = path.join(dir, 'map.json');
  fs.writeFileSync(p, JSON.stringify({ PAR: 'OK', nested: { x: 1 }, n: 3 }), 'utf8');
  const loaded = loadInputsFile(p);
  assert.equal(loaded.ok, true);
  assert.deepEqual(loaded.inputValues, { PAR: 'OK', n: '3' });
});
