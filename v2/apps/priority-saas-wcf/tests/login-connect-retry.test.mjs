/**
 * FR #422 / FR-040: retry login_connect once inside loginSession.
 * Offline fake SDK only — no live SaaS / no real secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { loginSession } from '../lib/session.mjs';
import { classifyFailRetry, exitCodeForFail } from '../lib/json-out.mjs';

const INSTANCE = {
  id: 'dev',
  user: 'u@x.com',
  company: 'co',
  tabulaini: 'tab.ini',
  wcfUrl: 'https://example.invalid/wcf/service.svc',
  url: 'https://example.invalid',
};

const PROBE = {
  ok: true,
  wcf: 'https://example.invalid/wcf/service.svc',
  tabulaini: 'tab.ini',
};

function connectErr() {
  const e = new Error("Can't connect to server.");
  e.type = 'connect';
  return e;
}

function apiLicenceErr() {
  return new Error('API License: flag the user as having an API license');
}

test('FR-040: first connect throw then ok -> result ok, login count 2', async () => {
  let loginCount = 0;
  const sleeps = [];
  const sdk = {
    login: async () => {
      loginCount += 1;
      if (loginCount === 1) throw connectErr();
      return { userLogin: 'MEDATECH' };
    },
  };
  const r = await loginSession(INSTANCE, 'FAKE_access_token_retry_ok', {
    sdk,
    probe: PROBE,
    sleep: async (ms) => {
      sleeps.push(ms);
    },
  });
  assert.equal(r.ok, true);
  assert.equal(loginCount, 2);
  assert.equal(sleeps.length, 1);
  assert.ok(sleeps[0] > 0);
  assert.equal(r.loginResult?.userLogin, 'MEDATECH');
});

test('FR-040: two connect throws -> login_connect, login count 2, exit 3 retryable', async () => {
  let loginCount = 0;
  const sdk = {
    login: async () => {
      loginCount += 1;
      throw connectErr();
    },
  };
  const r = await loginSession(INSTANCE, 'FAKE_access_token_retry_fail', {
    sdk,
    probe: PROBE,
    sleep: async () => {},
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'login_connect');
  assert.equal(loginCount, 2);
  assert.equal(classifyFailRetry(r.reason).retryable, true);
  assert.equal(exitCodeForFail(r.reason), 3);
});

test('FR-040: api_licence is not retried (login count 1)', async () => {
  let loginCount = 0;
  const sdk = {
    login: async () => {
      loginCount += 1;
      throw apiLicenceErr();
    },
  };
  const r = await loginSession(INSTANCE, 'FAKE_access_token_api_licence', {
    sdk,
    probe: PROBE,
    sleep: async () => {
      throw new Error('sleep must not run for api_licence');
    },
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'api_licence');
  assert.equal(loginCount, 1);
  assert.equal(classifyFailRetry(r.reason).retryable, false);
  assert.equal(exitCodeForFail(r.reason), 3);
});

test('FR-040: login_failed is not retried', async () => {
  let loginCount = 0;
  const sdk = {
    login: async () => {
      loginCount += 1;
      throw new Error('Invalid credentials');
    },
  };
  const r = await loginSession(INSTANCE, 'FAKE_access_token_login_failed', {
    sdk,
    probe: PROBE,
    sleep: async () => {
      throw new Error('sleep must not run for login_failed');
    },
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'login_failed');
  assert.equal(loginCount, 1);
});
