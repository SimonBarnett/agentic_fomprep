import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadAccessToken, stripBom, parseTokenExpiry } from '../lib/token.mjs';
import { parseTabulaini, summarizeTenantJson, probeTenant } from '../lib/probe.mjs';
import { redact } from '../lib/json-out.mjs';
import { buildLoginConfig, resolveLoginUrl } from '../lib/session.mjs';
import { stripBom as stripBomAllow, readAllowlist } from '../lib/allowlist.mjs';

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
    { tabulaini: 'tabx.ini', appname: 'app', devicename: 'dev', url: 'https://h/wcf/service.svc' },
  );
  assert.equal(cfg.accessToken, 'tok');
  assert.equal(cfg.tabulaini, 'tabx.ini');
  assert.equal(cfg.profile.company, 'c');
  assert.equal(cfg.url, 'https://h/wcf/service.svc');
  assert.equal(cfg.password, undefined);
});

test('stripBom removes UTF-8 BOM', () => {
  assert.equal(stripBom('\uFEFF{"a":1}'), '{"a":1}');
  assert.equal(stripBomAllow('\uFEFF{"a":1}'), '{"a":1}');
});

test('token file with BOM loads', () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tok-'));
  const p = path.join(dir, 'bom.json');
  fs.writeFileSync(p, '\uFEFF' + JSON.stringify({ access_token: 'bom-token', expires_in: 3600, obtained_at: new Date().toISOString() }));
  try {
    const r = loadAccessToken({ tokenFile: p });
    assert.equal(r.ok, true);
    assert.equal(r.accessToken, 'bom-token');
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('token_expired when expires_in elapsed', () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tok-'));
  const p = path.join(dir, 'old.json');
  fs.writeFileSync(
    p,
    JSON.stringify({
      access_token: 'old',
      expires_in: 1800,
      obtained_at: new Date(Date.now() - 3600_000).toISOString(),
    }),
  );
  try {
    const r = loadAccessToken({ tokenFile: p });
    assert.equal(r.ok, false);
    assert.equal(r.reason, 'token_expired');
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('parseTokenExpiry skew', () => {
  const now = Date.parse('2026-11-08T12:00:00Z');
  const r = parseTokenExpiry(
    { expires_in: 1800, obtained_at: '2026-11-08T11:30:00Z' },
    now,
  );
  assert.equal(r.expired, true);
});

test('resolveLoginUrl prefers probe.wcf ending in .svc', () => {
  const r = resolveLoginUrl(
    { url: 'https://p.priority-connect.online' },
    { wcf: 'https://p.priority-connect.online/wcf/service.svc' },
  );
  assert.equal(r.ok, true);
  assert.equal(r.url, 'https://p.priority-connect.online/wcf/service.svc');
  assert.equal(r.source, 'probe.wcf');
});

test('resolveLoginUrl refuses SaaS host-only without .svc', () => {
  const r = resolveLoginUrl({ url: 'https://p.priority-connect.online' }, { wcf: null });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'wcf_url_required');
});

test('allowlist JSON with BOM', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'al-'));
  const p = path.join(dir, 'inst.json');
  fs.writeFileSync(
    p,
    '\uFEFF' +
      JSON.stringify({
        instances: [
          {
            id: 'x',
            host: 'p.priority-connect.online',
            tenant: 't',
            company: 'c',
            user: 'u',
          },
        ],
      }),
  );
  const allow = readAllowlist(p);
  assert.equal(allow.ok, true);
  assert.equal(allow.instances.length, 1);
});
