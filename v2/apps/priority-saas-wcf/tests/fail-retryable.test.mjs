import test from 'node:test';
import assert from 'node:assert/strict';
import { classifyFailRetry, fail } from '../lib/json-out.mjs';

function captureFail(reason, extra = {}) {
  const chunks = [];
  const orig = process.stdout.write;
  process.stdout.write = (c, enc, cb) => {
    chunks.push(Buffer.isBuffer(c) ? c.toString('utf8') : String(c));
    if (typeof enc === 'function') enc();
    if (typeof cb === 'function') cb();
    return true;
  };
  const prevCode = process.exitCode;
  try {
    const payload = fail(reason, extra, 2);
    const parsed = JSON.parse(chunks.join('').trim());
    return { payload, parsed };
  } finally {
    process.stdout.write = orig;
    process.exitCode = prevCode;
  }
}

test('classifier map: login_connect retryable true', () => {
  const c = classifyFailRetry('login_connect');
  assert.equal(c.retryable, true);
});

test('classifier map: api_licence retryable false with hint', () => {
  const c = classifyFailRetry('api_licence');
  assert.equal(c.retryable, false);
  assert.equal(typeof c.hint, 'string');
  assert.ok(c.hint.length > 0);
});

test('classifier map: token_expired retryable false with hint', () => {
  const c = classifyFailRetry('token_expired');
  assert.equal(c.retryable, false);
  assert.equal(typeof c.hint, 'string');
  assert.ok(c.hint.length > 0);
});

test('stdout JSON has boolean retryable for login_connect', () => {
  const { parsed } = captureFail('login_connect', { message: 'Can\'t connect to server.' });
  assert.equal(parsed.ok, false);
  assert.equal(parsed.reason, 'login_connect');
  assert.equal(parsed.retryable, true);
  assert.equal(typeof parsed.retryable, 'boolean');
});

test('stdout JSON api_licence retryable false keeps hint', () => {
  const { parsed } = captureFail('api_licence');
  assert.equal(parsed.retryable, false);
  assert.equal(typeof parsed.retryable, 'boolean');
  assert.equal(typeof parsed.hint, 'string');
  assert.ok(parsed.hint.length > 0);
});

test('stdout JSON token_expired retryable false keeps hint', () => {
  const { parsed } = captureFail('token_expired');
  assert.equal(parsed.retryable, false);
  assert.equal(typeof parsed.retryable, 'boolean');
  assert.equal(typeof parsed.hint, 'string');
  assert.ok(parsed.hint.length > 0);
});

test('other reasons are not retryable', () => {
  assert.equal(classifyFailRetry('form_required').retryable, false);
  const { parsed } = captureFail('form_required', { need: '--form' });
  assert.equal(parsed.retryable, false);
});
