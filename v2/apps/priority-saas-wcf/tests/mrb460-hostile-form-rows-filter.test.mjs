/**
 * MRB #460 hostile pins for FR-014 / #396.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { applySearchThenGetRows } from '../lib/form.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

test('MRB-460: form rows is not a write in cmdForm write flag', () => {
  const src = fs.readFileSync(path.join(ROOT, 'bin', 'priority-wcf.mjs'), 'utf8');
  assert.match(src, /const write = sub === 'set' \|\| sub === 'save'/);
  assert.doesNotMatch(src, /write = sub === 'set' \|\| sub === 'save' \|\| sub === 'rows'/);
});

test('MRB-460: applySearchThenGetRows does not fieldUpdate', async () => {
  let updates = 0;
  const form = {
    name: 'CUSTOMERS',
    setSearchFilter: async () => {},
    fieldUpdate: async () => {
      updates += 1;
    },
    getRows: async () => ({ CUSTOMERS: { 1: { CUSTNAME: 'X' } } }),
  };
  await applySearchThenGetRows(form, { or: 0, QueryValues: [] }, { fromRow: 1 });
  assert.equal(updates, 0);
});
