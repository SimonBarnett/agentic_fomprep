/**
 * FR #396 / FR-014: form rows --filter calls setSearchFilter once then getRows(1).
 * Missing filter: zero searches. Fake SDK only.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { applySearchThenGetRows, formGetRows } from '../lib/form.mjs';

function fakeForm(rowsPack) {
  let searchCalls = 0;
  let getFrom = [];
  const form = {
    name: 'CUSTOMERS',
    setSearchFilter: async () => {
      searchCalls += 1;
    },
    getRows: async (fromRow) => {
      getFrom.push(fromRow);
      return { CUSTOMERS: rowsPack };
    },
    searchCalls: () => searchCalls,
    getFrom: () => getFrom,
  };
  return form;
}

test('filter present: one setSearchFilter then getRows from 1', async () => {
  const form = fakeForm({ 1: { CUSTNAME: 'X' } });
  const filter = {
    or: 0,
    QueryValues: [{ field: 'CUSTNAME', fromval: 'X', toval: '', op: '=', sort: 0, isdesc: 0 }],
  };
  const got = await applySearchThenGetRows(form, filter, { fromRow: 1, getRows: formGetRows });
  assert.equal(form.searchCalls(), 1);
  assert.deepEqual(form.getFrom(), [1]);
  assert.equal(got.searchCalls, 1);
  assert.equal(got.count, 1);
  assert.equal(got.rows[0].CUSTNAME, 'X');
});

test('filter absent: zero setSearchFilter; unfiltered getRows from 1', async () => {
  const form = fakeForm({ 1: { CUSTNAME: 'A' }, 2: { CUSTNAME: 'B' } });
  const got = await applySearchThenGetRows(form, null, { fromRow: 1, getRows: formGetRows });
  assert.equal(form.searchCalls(), 0);
  assert.deepEqual(form.getFrom(), [1]);
  assert.equal(got.searchCalls, 0);
  assert.equal(got.count, 2);
});
