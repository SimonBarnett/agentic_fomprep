/**
 * Tenant probe: POST https://<host>/webui/<tenant>
 * Returns wcf URL, tabulaini (_tabulaini=), authority. No secrets.
 * FR-041: successful probes cache wcf+tabulaini for 60 minutes (no token).
 */

import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { stripBom } from './token.mjs';

export const PROBE_CACHE_TTL_MS = 60 * 60 * 1000;

const UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';

export function parseTabulaini(priorityParams) {
  const s = String(priorityParams || '');
  const m = s.match(/_tabulaini=([^&\s]+)/i);
  return m ? decodeURIComponent(m[1]) : '';
}

export function summarizeTenantJson(body) {
  const tabulaini = body.tabulaini || parseTabulaini(body.priorityParams) || '';
  return {
    wcf: body.wcf || null,
    server: body.server || null,
    authority: body.authority || null,
    admode: body.admode ?? null,
    tabulaini: tabulaini || null,
    h5client: body.h5client || null,
  };
}

export async function probeTenant(instance, { accessToken = '', fetchImpl = fetch } = {}) {
  const url = instance.webuiUrl;
  const headers = {
    Accept: 'application/json',
    'User-Agent': UA,
  };
  if (accessToken) headers.Authorization = `Bearer ${accessToken}`;
  let res;
  try {
    res = await fetchImpl(url, { method: 'POST', headers });
  } catch (e) {
    return { ok: false, reason: 'probe_network', message: String(e.message || e), url };
  }
  const text = await res.text();
  let body;
  try {
    body = JSON.parse(text);
  } catch {
    return {
      ok: false,
      reason: 'probe_not_json',
      httpStatus: res.status,
      url,
      preview: text.slice(0, 120),
    };
  }
  if (!res.ok) {
    return {
      ok: false,
      reason: 'probe_http',
      httpStatus: res.status,
      url,
      summary: summarizeTenantJson(body),
    };
  }
  const summary = summarizeTenantJson(body);
  if (!summary.wcf && !summary.tabulaini) {
    return { ok: false, reason: 'probe_incomplete', httpStatus: res.status, url, summary };
  }
  return {
    ok: true,
    httpStatus: res.status,
    url,
    ...summary,
  };
}

export function defaultProbeCachePath() {
  const home = process.env.USERPROFILE || process.env.HOME || os.homedir();
  return path.join(home, '.priority-agent', 'probe-cache.json');
}

function loadProbeCacheObject(filePath) {
  try {
    const raw = stripBom(fs.readFileSync(filePath, 'utf8'));
    const parsed = JSON.parse(raw);
    return parsed && typeof parsed === 'object' && !Array.isArray(parsed) ? parsed : {};
  } catch {
    return {};
  }
}

function readFreshProbeCache(filePath, instanceId, nowMs) {
  if (!instanceId) return null;
  const all = loadProbeCacheObject(filePath);
  const row = all[instanceId];
  if (!row || typeof row !== 'object') return null;
  const cachedAt = Date.parse(String(row.cachedAt || ''));
  if (!Number.isFinite(cachedAt)) return null;
  if (nowMs - cachedAt >= PROBE_CACHE_TTL_MS) return null;
  const wcf = row.wcf || null;
  const tabulaini = row.tabulaini || null;
  if (!wcf && !tabulaini) return null;
  return { wcf, tabulaini, cachedAt: row.cachedAt, source: 'cache' };
}

function writeProbeCache(filePath, instanceId, { wcf, tabulaini, cachedAt }) {
  if (!instanceId) return;
  const all = loadProbeCacheObject(filePath);
  all[instanceId] = {
    wcf: wcf || null,
    tabulaini: tabulaini || null,
    cachedAt,
  };
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, JSON.stringify(all, null, 2), 'utf8');
}

/** FR-041: reuse a successful probe for 60 minutes per instance id. */
export async function probeTenantCached(instance, opts = {}) {
  const now = opts.now ?? Date.now();
  const cachePath = opts.cachePath || defaultProbeCachePath();
  const id = String(instance?.id || '');
  const hit = readFreshProbeCache(cachePath, id, now);
  if (hit) {
    return {
      ok: true,
      url: instance.webuiUrl,
      wcf: hit.wcf,
      tabulaini: hit.tabulaini,
      source: 'cache',
      cachedAt: hit.cachedAt,
    };
  }
  const r = await probeTenant(instance, opts);
  if (r.ok) {
    writeProbeCache(cachePath, id, {
      wcf: r.wcf,
      tabulaini: r.tabulaini,
      cachedAt: new Date(now).toISOString(),
    });
  }
  return r;
}
