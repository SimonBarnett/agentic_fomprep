import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { readAllowlist, selectInstance, refuseLiveWrite } from '../lib/allowlist.mjs';

function tempFile(name, obj) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'saas-wcf-'));
  const p = path.join(dir, name);
  fs.writeFileSync(p, JSON.stringify(obj));
  return p;
}

test('missing allowlist file', () => {
  const r = readAllowlist(path.join(os.tmpdir(), 'no-such-priority-saas-wcf.json'));
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'no_instances_file');
});

test('empty instances refused', () => {
  const p = tempFile('empty.json', { instances: [] });
  const r = readAllowlist(p);
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'no_instances');
});

test('secret key in allowlist refused', () => {
  const p = tempFile('bad.json', {
    instances: [{ id: 'x', host: 'h', tenant: 't', company: 'c', user: 'u', password: 'nope' }],
  });
  const r = readAllowlist(p);
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'instances_secret_key_forbidden');
});

test('select by id', () => {
  const p = tempFile('ok.json', {
    instances: [
      {
        id: 'a',
        host: 'p.priority-connect.online',
        tenant: 'ten',
        company: 'co',
        user: 'u@x.com',
        tokenFile: 'C:\\passwords\\a.json',
      },
      {
        id: 'b',
        host: 'other.example.invalid',
        tenant: 't2',
        company: 'c2',
        user: 'u2',
      },
    ],
  });
  const allow = readAllowlist(p);
  const r = selectInstance(allow, 'a');
  assert.equal(r.ok, true);
  assert.equal(r.instance.url, 'https://p.priority-connect.online');
  assert.equal(r.instance.webuiUrl, 'https://p.priority-connect.online/webui/ten');
});

test('unknown id', () => {
  const p = tempFile('one.json', {
    instances: [
      { id: 'only', host: 'h.example.invalid', tenant: 't', company: 'c', user: 'u' },
    ],
  });
  const allow = readAllowlist(p);
  const r = selectInstance(allow, 'missing');
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'instance_unknown');
});

test('writes require allowLive', () => {
  const live = refuseLiveWrite({ id: 'dev', allowLive: false, title: 'dev', company: 'x' }, { write: true });
  assert.equal(live.reason, 'writes_require_allowLive');
  assert.equal(refuseLiveWrite({ id: 'x', allowLive: true }, { write: true }), null);
});
