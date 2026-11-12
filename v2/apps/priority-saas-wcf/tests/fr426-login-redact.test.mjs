/**
 * FR-044 / #426: login error stdout must not echo Bearer tokens.
 * Fixture token is FIXTURETOKEN (not a real secret).
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { fail, redact } from '../lib/json-out.mjs';
import { loginSession } from '../lib/session.mjs';

test('Fixture error message containing Bearer FIXTURETOKEN is emitted without FIXTURETOKEN', () => {
  const raw = 'login rejected Bearer FIXTURETOKEN from SDK';
  assert.equal(redact(raw).includes('FIXTURETOKEN'), false);
  assert.match(redact(raw), /Bearer <redacted>/);
  assert.match(redact('access_token=FIXTURETOKEN'), /access_token=<redacted>/);
  assert.equal(redact('access_token=FIXTURETOKEN').includes('FIXTURETOKEN'), false);

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
    fail('login_failed', { message: raw });
  } finally {
    process.stdout.write = orig;
    process.exitCode = prevCode;
  }
  const text = chunks.join('');
  assert.equal(text.includes('FIXTURETOKEN'), false);
  const body = JSON.parse(text.trim().split('\n').pop());
  assert.equal(body.reason, 'login_failed');
  assert.equal(body.ok, false);
});

test('loginSession catch redacts Bearer FIXTURETOKEN and keeps login_failed', async () => {
  const instance = {
    id: 'dev1',
    tabulaini: 'tab.ini',
    url: 'https://example.invalid/wcf/service.svc',
    user: 'u',
    company: 'c',
    language: 3,
  };
  const r = await loginSession(instance, 'tok-fixture', {
    probe: { ok: true, wcf: instance.url, tabulaini: 'tab.ini' },
    sdk: {
      login: async () => {
        throw new Error('SDK: Bearer FIXTURETOKEN invalid');
      },
    },
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'login_failed');
  assert.equal(String(r.message || '').includes('FIXTURETOKEN'), false);
});
