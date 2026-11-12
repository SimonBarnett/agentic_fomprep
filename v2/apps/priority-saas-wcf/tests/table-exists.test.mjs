/**
 * FR #413 / FR-031: table exists is a GET; miss is exists false exit 0.
 * Offline fakes only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { fetchTableExists } from '../lib/table.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const instance = {
  odataBase: 'https://example.invalid/odata/tab.ini,3/co',
};

test('Fake hit: exists true', async () => {
  const methods = [];
  const fetchImpl = async (url, init) => {
    methods.push(String(init?.method || 'GET').toUpperCase());
    return {
      ok: true,
      status: 200,
      text: async () => JSON.stringify({ value: [{ TNAME: 'CUSTOMERS' }] }),
    };
  };
  const r = await fetchTableExists(instance, 'CUSTOMERS', {
    fetchImpl,
    accessToken: 'FAKE_odata_token',
  });
  assert.equal(r.ok, true);
  assert.equal(r.name, 'CUSTOMERS');
  assert.equal(r.exists, true);
  assert.deepEqual(methods, ['GET']);
});

test('Fake miss: exists false and ok true', async () => {
  const methods = [];
  const fetchImpl = async (_url, init) => {
    methods.push(String(init?.method || 'GET').toUpperCase());
    return {
      ok: true,
      status: 200,
      text: async () => JSON.stringify({ value: [] }),
    };
  };
  const r = await fetchTableExists(instance, 'NOSUCH', {
    fetchImpl,
    accessToken: 'FAKE_odata_token',
  });
  assert.equal(r.ok, true);
  assert.equal(r.exists, false);
  assert.equal(r.name, 'NOSUCH');
  assert.ok(!methods.some((m) => m !== 'GET'));
});

test('verbIsWrite: table.exists is not a write', () => {
  assert.equal(verbIsWrite('table.exists'), false);
  assert.equal(verbIsWrite('table.create'), false);
});
