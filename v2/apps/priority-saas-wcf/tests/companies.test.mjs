/**
 * FR #394 / FR-012: companies --instance lists {name,title}; allowLive false still ok.
 * Fake SDK only. Does not switch company. No secrets on stdout.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { refuseLiveWrite } from '../lib/allowlist.mjs';
import { listCompanies, companiesFromLoginResult } from '../lib/companies.mjs';
import { ok } from '../lib/json-out.mjs';

function captureOk(payload) {
  const chunks = [];
  const orig = process.stdout.write;
  const prevCode = process.exitCode;
  process.stdout.write = (c, enc, cb) => {
    chunks.push(Buffer.isBuffer(c) ? c.toString('utf8') : String(c));
    if (typeof enc === 'function') enc();
    if (typeof cb === 'function') cb();
    return true;
  };
  try {
    ok(payload);
    return JSON.parse(chunks.join('').trim());
  } finally {
    process.stdout.write = orig;
    process.exitCode = prevCode;
  }
}

test('Fake SDK: two companies on login result; stdout lists both names', async () => {
  const loginResult = {
    companies: [
      { name: 'CO1', title: 'Alpha Ltd' },
      { name: 'CO2', title: 'Beta Ltd' },
    ],
  };
  const r = await listCompanies({
    instance: { id: 't', company: 'CO1', allowLive: false },
    session: { ok: true, priority: {}, loginResult },
    formStart: async () => {
      throw new Error('COMPANIES form must not open when login lists companies');
    },
  });
  assert.equal(r.ok, true);
  assert.equal(r.switched, false);
  assert.equal(r.companies.length, 2);
  assert.deepEqual(r.companies[0], { name: 'CO1', title: 'Alpha Ltd' });
  assert.deepEqual(r.companies[1], { name: 'CO2', title: 'Beta Ltd' });
  const parsed = captureOk({ action: 'companies', companies: r.companies, switched: false });
  assert.equal(parsed.ok, true);
  assert.equal(typeof parsed.retryable, 'undefined');
  assert.equal(parsed.companies.length, 2);
  const text = JSON.stringify(parsed);
  assert.ok(text.includes('CO1') && text.includes('CO2'));
  assert.equal(parsed.switched, false);
});

test('allowLive false still returns ok (read-only)', async () => {
  const live = refuseLiveWrite({ id: 'dev', allowLive: false, title: 'dev', company: 'x' }, { write: false });
  assert.equal(live, null);
  const r = await listCompanies({
    instance: { id: 'dev', allowLive: false, company: 'x' },
    session: {
      ok: true,
      priority: {},
      loginResult: { companies: [{ name: 'X', title: 'X Co' }] },
    },
  });
  assert.equal(r.ok, true);
  assert.equal(r.companies[0].name, 'X');
});

test('Fake SDK COMPANIES form rows when login has none', async () => {
  const form = {
    name: 'COMPANIES',
    getRows: async () => ({
      COMPANIES: {
        1: { DNAME: 'A', TITLE: 'One' },
        2: { DNAME: 'B', TITLE: 'Two' },
      },
    }),
    endCurrentForm: async () => {},
  };
  const r = await listCompanies({
    instance: { company: 'A', allowLive: false },
    session: { ok: true, priority: {}, loginResult: {} },
    formStart: async () => form,
    formGetRows: async (f) => {
      const rows = await f.getRows(1);
      const pack = rows.COMPANIES || {};
      const list = Object.keys(pack).map((i) => ({ _idx: i, ...pack[i] }));
      return { formName: 'COMPANIES', count: list.length, rows: list };
    },
    safeEnd: async () => {},
  });
  assert.equal(r.ok, true);
  assert.equal(r.source, 'companies');
  assert.equal(r.companies.map((c) => c.name).join(','), 'A,B');
});

test('companiesFromLoginResult ignores empty names', () => {
  assert.deepEqual(companiesFromLoginResult({ companies: [{ title: 'x' }] }), []);
});
