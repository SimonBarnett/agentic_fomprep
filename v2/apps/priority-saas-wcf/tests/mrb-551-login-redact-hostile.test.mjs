/**
 * MRB #551 hostile pins for FR-044 / #426 login error redaction.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { fail, redact } from '../lib/json-out.mjs';
import { loginSession } from '../lib/session.mjs';

test('MRB-551: Authorization Bearer and access_token colon forms are stripped', () => {
  const a = redact('Authorization: Bearer FIXTURETOKEN extra');
  assert.equal(a.includes('FIXTURETOKEN'), false);
  const b = redact('oops access_token: FIXTURETOKEN');
  assert.equal(b.includes('FIXTURETOKEN'), false);
  assert.match(b, /access_token=<redacted>/);
});

test('MRB-551: login_connect message still redacts Bearer and keeps reason', async () => {
  const r = await loginSession(
    {
      id: 'dev1',
      tabulaini: 'tab.ini',
      url: 'https://example.invalid/wcf/service.svc',
      user: 'u',
      company: 'c',
      language: 3,
    },
    'tok-fixture',
    {
      probe: { ok: true, wcf: 'https://example.invalid/wcf/service.svc', tabulaini: 'tab.ini' },
      sdk: {
        login: async () => {
          throw new Error("Can't connect to server Bearer FIXTURETOKEN");
        },
      },
    },
  );
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'login_connect');
  assert.equal(String(r.message || '').includes('FIXTURETOKEN'), false);
});

test('MRB-551: fail() nested extra.message is redacted on stdout', () => {
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
    fail('login_failed', { extra: { message: 'Bearer FIXTURETOKEN' } });
  } finally {
    process.stdout.write = orig;
    process.exitCode = prevCode;
  }
  const text = chunks.join('');
  assert.equal(text.includes('FIXTURETOKEN'), false);
  const body = JSON.parse(text.trim().split('\n').pop());
  assert.equal(body.reason, 'login_failed');
});
