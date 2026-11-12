/**
 * MRB #545 hostile pins for FR-041 / #423 tenant probe cache.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { probeTenantCached, PROBE_CACHE_TTL_MS } from '../lib/probe.mjs';

function tmpCache() {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'mrb545-'));
  return path.join(dir, 'probe-cache.json');
}

const instance = {
  id: 'dev1',
  webuiUrl: 'https://example.invalid/webui/example',
};

test('MRB-545: failed probe does not write a cache file', async () => {
  const cachePath = tmpCache();
  const r = await probeTenantCached(instance, {
    cachePath,
    now: Date.parse('2026-11-12T12:00:00Z'),
    fetchImpl: async () => {
      throw new Error('offline');
    },
  });
  assert.equal(r.ok, false);
  assert.equal(fs.existsSync(cachePath), false);
});

test('MRB-545: probe JSON access_token is not written to cache', async () => {
  const cachePath = tmpCache();
  await probeTenantCached(instance, {
    cachePath,
    now: Date.parse('2026-11-12T12:00:00Z'),
    fetchImpl: async () => ({
      ok: true,
      status: 200,
      text: async () =>
        JSON.stringify({
          wcf: 'https://example.invalid/wcf/service.svc',
          priorityParams: '_tabulaini=tabexample.ini',
          access_token: 'FAKE_probe_body_token',
        }),
    }),
  });
  const text = fs.readFileSync(cachePath, 'utf8');
  assert.equal(text.includes('access_token'), false);
  assert.equal(text.includes('FAKE_probe_body_token'), false);
});

test('MRB-545: TTL boundary — exactly 60 minutes is a miss; 59:59 is a hit', async () => {
  const cachePath = tmpCache();
  const now = Date.parse('2026-11-12T12:00:00Z');
  const counter = { n: 0 };
  const fetchImpl = async () => {
    counter.n += 1;
    return {
      ok: true,
      status: 200,
      text: async () =>
        JSON.stringify({
          wcf: 'https://example.invalid/wcf/service.svc',
          priorityParams: '_tabulaini=tabexample.ini',
        }),
    };
  };
  await probeTenantCached(instance, { cachePath, now, fetchImpl });
  await probeTenantCached(instance, { cachePath, now: now + PROBE_CACHE_TTL_MS - 1, fetchImpl });
  assert.equal(counter.n, 1);
  await probeTenantCached(instance, { cachePath, now: now + PROBE_CACHE_TTL_MS, fetchImpl });
  assert.equal(counter.n, 2);
});

test('MRB-545: other instance id does not reuse the cache row', async () => {
  const cachePath = tmpCache();
  const now = Date.parse('2026-11-12T12:00:00Z');
  const counter = { n: 0 };
  const fetchImpl = async () => {
    counter.n += 1;
    return {
      ok: true,
      status: 200,
      text: async () =>
        JSON.stringify({
          wcf: 'https://example.invalid/wcf/service.svc',
          priorityParams: '_tabulaini=tabexample.ini',
        }),
    };
  };
  await probeTenantCached(instance, { cachePath, now, fetchImpl });
  await probeTenantCached({ ...instance, id: 'dev2' }, { cachePath, now, fetchImpl });
  assert.equal(counter.n, 2);
});
