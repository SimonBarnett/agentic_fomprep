/**
 * FR #395 / FR-013: form columns returns field names and types without getRows.
 * Offline fake form only — no live SaaS / no real secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { formColumnsMeta } from '../lib/form.mjs';

test('Fake form with two columns: both names and types; getRows call count is 0', () => {
  let getRowsCalls = 0;
  const form = {
    name: 'CUSTOMERS',
    columns: {
      CUSTNAME: { type: 'string', title: 'Customer' },
      EMAIL: { type: 'string', title: 'Email' },
    },
    getRows: async () => {
      getRowsCalls += 1;
      return { CUSTOMERS: {} };
    },
  };
  const cols = formColumnsMeta(form);
  assert.equal(cols.length, 2);
  assert.deepEqual(
    cols.map((c) => c.name).sort(),
    ['CUSTNAME', 'EMAIL'],
  );
  assert.ok(cols.every((c) => c.type === 'string'));
  assert.equal(getRowsCalls, 0, 'form columns must not call getRows');
});

test('formColumnsMeta skips empty name and tolerates missing type', () => {
  const cols = formColumnsMeta({
    columns: {
      A: { type: 'int' },
      '': { type: 'string' },
      B: {},
    },
  });
  assert.deepEqual(
    cols.map((c) => ({ name: c.name, type: c.type })),
    [
      { name: 'A', type: 'int' },
      { name: 'B', type: '' },
    ],
  );
});
