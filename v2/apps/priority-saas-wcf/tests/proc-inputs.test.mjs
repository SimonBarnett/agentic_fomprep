/**
 * FR #403 / FR-021: --inputs JSON map into runProcStart inputValues.
 * File values win; name-hint only for fields the file did not set.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { walkProcSteps } from '../lib/proc-walk.mjs';
import { loadInputsFile } from '../lib/inputs-file.mjs';

test('file sets PAR to FROMFILE in inputFields payload', async () => {
  let saw;
  const proc = {
    inputFields: async (_ok, data) => {
      saw = data;
      return { type: 'end', proc };
    },
  };
  const first = {
    type: 'inputFields',
    proc,
    input: {
      EditField: [
        { field: 'PAR', title: 'Form name', value: '' },
        { field: 'FNM', title: 'Exec name', value: '' },
      ],
    },
  };
  const result = await walkProcSteps(first, {
    nameHint: 'HINTNAME',
    inputValues: { PAR: 'FROMFILE' },
    maxSteps: 5,
    deadlineMs: 5000,
  });
  assert.equal(result.ended, true);
  assert.equal(saw.EditFields[0].value, 'FROMFILE');
  assert.equal(saw.EditFields[1].value, 'HINTNAME');
});

test('loadInputsFile small map does not include body on json fail', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'inputs-'));
  const bad = path.join(dir, 'bad.json');
  fs.writeFileSync(bad, '{not-json SECRET_BODY}', 'utf8');
  const loaded = loadInputsFile(bad);
  assert.equal(loaded.ok, false);
  assert.equal(JSON.stringify(loaded).includes('SECRET_BODY'), false);
});
