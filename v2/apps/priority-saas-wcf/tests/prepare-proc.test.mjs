/**
 * FR #339 Phase 2: prepare form|procedure|report + proc walk + SaaS gate helpers.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import {
  displayUrlOf,
  publicStep,
  walkProcSteps,
  typeSeverity,
} from '../lib/proc-walk.mjs';
import {
  prepareKindDefaults,
  rowToPrepError,
  rowsFromPack,
  collectFormPrepErrsFromRows,
} from '../lib/prepare.mjs';
import {
  evaluatePrepGate,
  parseODataPrepRow,
  gateUnavailable,
} from '../lib/gate.mjs';

test('prepareKindDefaults form', () => {
  const d = prepareKindDefaults('form');
  assert.equal(d.catalogForm, 'EFORM');
  assert.equal(d.proc, 'FORMPREPDRCT2');
  assert.equal(d.errorForm, 'FORMPREPERRS');
});

test('prepareKindDefaults procedure and report', () => {
  assert.equal(prepareKindDefaults('procedure').catalogForm, 'EXEC');
  assert.equal(prepareKindDefaults('procedure').proc, 'REPPREPDIRECT2');
  assert.equal(prepareKindDefaults('report').catalogForm, 'EXEC');
  assert.throws(() => prepareKindDefaults('nope'), /unknown_prepare_kind/);
});

test('rowToPrepError maps FORMPREPERRS columns', () => {
  const item = rowToPrepError(
    { TYPE: 'W', CMESSAGE: 'Missing column X on MYFORM' },
    'MYFORM',
  );
  assert.equal(item.source, 'FORMPREPERRS');
  assert.equal(item.severity, 'Warning');
  assert.match(item.text, /Missing column X/);
  assert.equal(item.formHint, 'MYFORM');
  const noHint = rowToPrepError({ TYPE: 'W', CMESSAGE: 'other' }, 'MYFORM');
  assert.equal(noHint.formHint, '');
});

test('collectFormPrepErrsFromRows skips empty message rows', () => {
  const errs = collectFormPrepErrsFromRows(
    [{ TYPE: 'I', MESSAGE: 'note' }, {}],
    'F1',
  );
  assert.equal(errs.length, 1);
  assert.equal(errs[0].severity, 'Info');
});

test('rowsFromPack flattens SDK getRows shape', () => {
  const raw = { EFORM: { 1: { ENAME: 'A' }, 2: { ENAME: 'B' }, undefined: {} } };
  const rows = rowsFromPack(raw, 'EFORM');
  assert.equal(rows.length, 2);
  assert.equal(rows[0].ENAME, 'A');
});

test('fetchODataPrepSnapshot unavailable without odataBase', async () => {
  const { fetchODataPrepSnapshot } = await import('../lib/gate.mjs');
  const r = await fetchODataPrepSnapshot({}, 'F1');
  assert.equal(r.status, 'unavailable');
  assert.equal(r.preparedClaim, false);
});

test('fetchODataPrepSnapshot parses fixture', async () => {
  const { fetchODataPrepSnapshot } = await import('../lib/gate.mjs');
  const fetchImpl = async () => ({
    ok: true,
    status: 200,
    text: async () =>
      JSON.stringify({
        value: [{ ENAME: 'F1', UPD: 'N', LASTPREPDATE: '999' }],
      }),
  });
  const r = await fetchODataPrepSnapshot(
    { odataBase: 'https://example.invalid/odata/tab.ini,3/co' },
    'F1',
    { accessToken: 'FAKE_bearer_for_test', fetchImpl },
  );
  assert.equal(r.ok, true);
  assert.equal(r.upd, 'N');
  assert.equal(r.lastPrepDate, '999');
});

test('displayUrlOf and publicStep redact shape', () => {
  assert.equal(displayUrlOf({ Urls: { url: 'https://x/y' } }), 'https://x/y');
  assert.equal(displayUrlOf({ Urls: 'https://z' }), 'https://z');
  const snap = publicStep({
    type: 'message',
    message: 'hi',
    messagetype: 'error',
    proc: { name: 'P', title: 'T', secretFn: () => 1 },
    input: {
      title: 'in',
      EditField: [{ field: 'A', title: 'Name', value: 'v', zoom: 1 }],
    },
  });
  assert.equal(snap.type, 'message');
  assert.equal(snap.proc.name, 'P');
  assert.equal(snap.input.EditField[0].field, 'A');
  assert.equal(typeof snap.proc.secretFn, 'undefined');
});

test('typeSeverity', () => {
  assert.equal(typeSeverity('error'), 'Blocker');
  assert.equal(typeSeverity('I'), 'Info');
  assert.equal(typeSeverity('W'), 'Warning');
});

test('walkProcSteps ends and continues messages', async () => {
  const steps = [];
  let n = 0;
  const proc = {
    message: async () => {
      n += 1;
      return { type: 'end', proc };
    },
  };
  const first = { type: 'message', messagetype: 'error', message: 'boom', proc };
  const result = await walkProcSteps(first, {
    onStep: (s) => steps.push(s.type),
    maxSteps: 10,
    deadlineMs: 5000,
  });
  assert.equal(result.ended, true);
  assert.equal(result.steps.length, 2);
  assert.ok(result.errors.some((e) => e.text === 'boom'));
});

test('walkProcSteps inputFields fills name-like titles', async () => {
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
        { field: 'X', title: 'Other', value: 'keep' },
      ],
    },
  };
  const result = await walkProcSteps(first, {
    nameHint: 'TARGETFORM',
    maxSteps: 5,
    deadlineMs: 5000,
  });
  assert.equal(result.ended, true);
  assert.equal(saw.EditFields[0].value, 'TARGETFORM');
  assert.equal(saw.EditFields[1].value, 'keep');
});

test('parseODataPrepRow reads UPD and LASTPREPDATE', () => {
  const g = parseODataPrepRow({
    ENAME: 'F1',
    UPD: 'N',
    LASTPREPDATE: '74000123',
  });
  assert.equal(g.upd, 'N');
  assert.equal(g.lastPrepDate, '74000123');
  assert.equal(g.ename, 'F1');
});

test('evaluatePrepGate success when UPD=N and lastprep advanced', () => {
  const before = { upd: 'Y', lastPrepDate: '100' };
  const after = { upd: 'N', lastPrepDate: '200', ename: 'F1', source: 'odata' };
  const r = evaluatePrepGate(before, after);
  assert.equal(r.ok, true);
  assert.equal(r.status, 'prepared');
});

test('evaluatePrepGate fails when lastprep did not advance', () => {
  const r = evaluatePrepGate(
    { lastPrepDate: '100', upd: 'Y' },
    { lastPrepDate: '100', upd: 'N', source: 'odata' },
  );
  assert.equal(r.ok, false);
  assert.equal(r.status, 'lastprep_unchanged');
});

test('S4 two-option step nothing selected: needs_input and no inputOptions', async () => {
  let calls = 0;
  const proc = {
    inputOptions: async () => {
      calls += 1;
      return { type: 'end', proc };
    },
  };
  const r = await walkProcSteps(
    {
      type: 'inputOptions',
      proc,
      input: { Options: [{ field: 'A' }, { field: 'B' }] },
    },
    { maxSteps: 5, deadlineMs: 5000 },
  );
  assert.equal(calls, 0);
  assert.equal(r.reason, 'needs_input');
});

test('gateUnavailable when no SQL/OData', () => {
  const g = gateUnavailable('no_sql_no_odata');
  assert.equal(g.ok, false);
  assert.equal(g.status, 'unavailable');
  assert.equal(g.preparedClaim, false);
});
