import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { readAllowlist, selectInstance } from '../lib/allowlist.mjs';

function tempFile(name, obj) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'saas-wcf-mrb375-'));
  const p = path.join(dir, name);
  fs.writeFileSync(p, JSON.stringify(obj));
  return p;
}

test('MRB #375 allowlist passes odataBase and odataPrepPath', () => {
  const p = tempFile('odata.json', {
    instances: [
      {
        id: 'saas1',
        host: 'p.priority-connect.online',
        tenant: 'ten',
        company: 'co',
        user: 'u@x.com',
        tabulaini: 'tab.ini',
        odataBase: 'https://od.example/odata/tab.ini,3/co',
        odataPrepPath: 'FORMS',
      },
    ],
  });
  const allow = readAllowlist(p);
  assert.equal(allow.ok, true);
  const r = selectInstance(allow, 'saas1');
  assert.equal(r.ok, true);
  assert.equal(r.instance.odataBase, 'https://od.example/odata/tab.ini,3/co');
  assert.equal(r.instance.odataPrepPath, 'FORMS');
});

test('MRB #375 allowlist falls back odataUrl / odataPrepEntity aliases', () => {
  const p = tempFile('alias.json', {
    instances: [
      {
        id: 'saas2',
        host: 'p.priority-connect.online',
        tenant: 'ten',
        company: 'co',
        user: 'u@x.com',
        odataUrl: 'https://alias.example/odata/base',
        odataPrepEntity: 'EFORM',
      },
    ],
  });
  const r = selectInstance(readAllowlist(p), 'saas2');
  assert.equal(r.ok, true);
  assert.equal(r.instance.odataBase, 'https://alias.example/odata/base');
  assert.equal(r.instance.odataPrepPath, 'EFORM');
});

test('MRB #375 OData PAT Basic is patValue:PAT not token:pat', async () => {
  const { fetchODataPrepSnapshot } = await import('../lib/gate.mjs');
  const prev = process.env.PRIORITY_SAAS_ODATA_PAT;
  process.env.PRIORITY_SAAS_ODATA_PAT = 'FAKE_pat_value_mrb375';
  let seenAuth = '';
  try {
    const fetchImpl = async (_url, opts) => {
      seenAuth = String(opts?.headers?.Authorization || '');
      return {
        ok: true,
        status: 200,
        text: async () => JSON.stringify({ value: [{ ENAME: 'F1', UPD: 'N', LASTPREPDATE: '1' }] }),
      };
    };
    const r = await fetchODataPrepSnapshot(
      { odataBase: 'https://example.invalid/odata/tab.ini,3/co' },
      'F1',
      { fetchImpl },
    );
    assert.equal(r.ok, true);
    const expected = 'Basic ' + Buffer.from('FAKE_pat_value_mrb375:PAT').toString('base64');
    const wrong = 'Basic ' + Buffer.from('token:FAKE_pat_value_mrb375').toString('base64');
    assert.equal(seenAuth, expected);
    assert.notEqual(seenAuth, wrong);
  } finally {
    if (prev === undefined) delete process.env.PRIORITY_SAAS_ODATA_PAT;
    else process.env.PRIORITY_SAAS_ODATA_PAT = prev;
  }
});
