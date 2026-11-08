import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadAccessToken } from '../lib/token.mjs';
import { parseTabulaini, summarizeTenantJson, probeTenant } from '../lib/probe.mjs';
import { redact } from '../lib/json-out.mjs';
import { buildLoginConfig } from '../lib/session.mjs';

test('token from env', () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  process.env.PRIORITY_SAAS_TOKEN = 'env-token-value';
  try {
    const r = loadAccessToken({ tokenFile: 'C:\\nope.json' });
    assert.equal(r.ok, true);
    assert.equal(r.source, 'env:PRIORITY_SAAS_TOKEN');
    assert.equal(r.accessToken, 'env-token-value');
  } finally {
    if (prev === undefined) delete process.env.PRIORITY_SAAS_TOKEN;
    else process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('token from file', () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tok-'));
  const p = path.join(dir, 'tokens.json');
  fs.writeFileSync(p, JSON.stringify({ access_token: 'file-token', refresh_token: 'r' }));
  try {
    const r = loadAccessToken({ tokenFile: p });
    assert.equal(r.ok, true);
    assert.equal(r.accessToken, 'file-token');
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('token missing', () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  try {
    const r = loadAccessToken({});
    assert.equal(r.ok, false);
    assert.equal(r.reason, 'token_missing');
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('parse tabulaini from priorityParams', () => {
  assert.equal(parseTabulaini('_tabulaini=tabfoo.ini&x=1'), 'tabfoo.ini');
  const s = summarizeTenantJson({
    wcf: 'https://h/wcf/service.svc',
    priorityParams: '_tabulaini=tabbar.ini',
    authority: 'https://h/auth/',
  });
  assert.equal(s.tabulaini, 'tabbar.ini');
  assert.equal(s.wcf, 'https://h/wcf/service.svc');
});

test('probeTenant uses fixture fetch', async () => {
  const fixturePath = path.join(path.dirname(fileURLToPath(import.meta.url)), '..', 'fixtures', 'tenant-probe.json');
  const body = JSON.parse(fs.readFileSync(fixturePath, 'utf8'));
  const fetchImpl = async () => ({
    ok: true,
    status: 200,
    text: async () => JSON.stringify(body),
  });
  const r = await probeTenant(
    { webuiUrl: 'https://p.priority-connect.online/webui/exampletenant' },
    { fetchImpl },
  );
  assert.equal(r.ok, true);
  assert.equal(r.tabulaini, 'tabexampletenant.ini');
  assert.match(r.wcf, /service\.svc/);
});

test('redact strips jwt-like and secret keys', () => {
  const r = redact({
    access_token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.aaa.bbb',
    ok: true,
    nested: { password: 'x' },
  });
  assert.equal(r.access_token, '<redacted>');
  assert.equal(r.nested.password, '<redacted>');
  assert.equal(r.ok, true);
});

test('buildLoginConfig uses accessToken', () => {
  const cfg = buildLoginConfig(
    { url: 'https://h', user: 'u', company: 'c', language: 3, tabulaini: '' },
    'tok',
    { tabulaini: 'tabx.ini', appname: 'app', devicename: 'dev' },
  );
  assert.equal(cfg.accessToken, 'tok');
  assert.equal(cfg.tabulaini, 'tabx.ini');
  assert.equal(cfg.profile.company, 'c');
  assert.equal(cfg.password, undefined);
});
