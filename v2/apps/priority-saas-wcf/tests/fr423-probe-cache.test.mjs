import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { probeTenantCached, PROBE_CACHE_TTL_MS } from '../lib/probe.mjs';
import { loginSession } from '../lib/session.mjs';

function tmpCache() {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'fr423-'));
  return path.join(dir, 'probe-cache.json');
}

function fixtureFetch(counter) {
  return async () => {
    counter.n += 1;
    return {
      ok: true,
      status: 200,
      text: async () =>
        JSON.stringify({
          wcf: 'https://p.priority-connect.online/wcf/service.svc',
          priorityParams: '_tabulaini=tabexample.ini',
        }),
    };
  };
}

const instance = {
  id: 'dev1',
  webuiUrl: 'https://p.priority-connect.online/webui/example',
  url: 'https://p.priority-connect.online',
  user: 'u',
  company: 'c',
  language: 3,
};

test('two logins within one hour probe once', async () => {
  const cachePath = tmpCache();
  const counter = { n: 0 };
  const fetchImpl = fixtureFetch(counter);
  const now = Date.parse('2026-11-12T12:00:00Z');
  const sdk = { login: async () => ({}) };
  const a = await loginSession(instance, 'FAKESECRET_c3d4e5f6g7h8i9j0k1l2', {
    fetchImpl,
    cachePath,
    now,
    sdk,
  });
  const b = await loginSession(instance, 'FAKESECRET_c3d4e5f6g7h8i9j0k1l2', {
    fetchImpl,
    cachePath,
    now: now + 10 * 60 * 1000,
    sdk,
  });
  assert.equal(a.ok, true);
  assert.equal(b.ok, true);
  assert.equal(counter.n, 1);
});

test('cachedAt older than 60 minutes probes again', async () => {
  const cachePath = tmpCache();
  const counter = { n: 0 };
  const fetchImpl = fixtureFetch(counter);
  const now = Date.parse('2026-11-12T12:00:00Z');
  const sdk = { login: async () => ({}) };
  await loginSession(instance, 'FAKESECRET_c3d4e5f6g7h8i9j0k1l2', { fetchImpl, cachePath, now, sdk });
  await loginSession(instance, 'FAKESECRET_c3d4e5f6g7h8i9j0k1l2', {
    fetchImpl,
    cachePath,
    now: now + PROBE_CACHE_TTL_MS + 1000,
    sdk,
  });
  assert.equal(counter.n, 2);
});

test('probe cache file has no access_token key', async () => {
  const cachePath = tmpCache();
  const counter = { n: 0 };
  const now = Date.parse('2026-11-12T12:00:00Z');
  await probeTenantCached(instance, {
    fetchImpl: fixtureFetch(counter),
    cachePath,
    now,
  });
  const text = fs.readFileSync(cachePath, 'utf8');
  assert.equal(text.includes('access_token'), false);
  const json = JSON.parse(text);
  assert.equal(json.dev1.wcf.includes('service.svc'), true);
  assert.equal(json.dev1.tabulaini, 'tabexample.ini');
  assert.ok(json.dev1.cachedAt);
  assert.equal(json.dev1.access_token, undefined);
});
