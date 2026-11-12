import fs from 'node:fs';
import http from 'node:http';
import https from 'node:https';

/**
 * Load SaaS Bearer access_token.
 * Prefer PRIORITY_SAAS_TOKEN; else instance.tokenFile JSON with access_token.
 * Never return secrets in error messages.
 *
 * Windows agents often write UTF-8 BOM via PowerShell Set-Content; strip it.
 * Expiry: accept expires_at (ISO) or expires_in (+ obtained_at / created_at).
 */

export function stripBom(text) {
  const s = String(text || '');
  return s.charCodeAt(0) === 0xfeff ? s.slice(1) : s;
}

export function parseTokenExpiry(raw, nowMs = Date.now()) {
  if (!raw || typeof raw !== 'object') return { ok: true, expired: false };
  const skewMs = 60_000;
  const expiresAt = raw.expires_at || raw.expiresAt;
  if (expiresAt) {
    const t = Date.parse(String(expiresAt));
    if (!Number.isNaN(t)) {
      return { ok: true, expired: nowMs >= t - skewMs, expiresAtMs: t };
    }
  }
  const expiresIn = Number(raw.expires_in ?? raw.expiresIn);
  if (Number.isFinite(expiresIn) && expiresIn > 0) {
    const obtained = raw.obtained_at || raw.obtainedAt || raw.created_at || raw.createdAt;
    const base = obtained ? Date.parse(String(obtained)) : NaN;
    if (!Number.isNaN(base)) {
      const t = base + expiresIn * 1000;
      return { ok: true, expired: nowMs >= t - skewMs, expiresAtMs: t };
    }
  }
  return { ok: true, expired: false };
}

export function loadAccessToken(instance) {
  const envTok = String(process.env.PRIORITY_SAAS_TOKEN || '').trim();
  if (envTok) {
    return { ok: true, accessToken: envTok, source: 'env:PRIORITY_SAAS_TOKEN' };
  }
  const file = String(instance?.tokenFile || '').trim();
  if (!file) {
    return {
      ok: false,
      reason: 'token_missing',
      message: 'Set PRIORITY_SAAS_TOKEN or instance.tokenFile (OIDC via priority-saas-oidc-login first)',
    };
  }
  if (!fs.existsSync(file)) {
    return { ok: false, reason: 'token_file_missing', path: file };
  }
  let raw;
  try {
    raw = JSON.parse(stripBom(fs.readFileSync(file, 'utf8')));
  } catch {
    return { ok: false, reason: 'token_file_invalid_json', path: file };
  }
  const accessToken = String(raw.access_token || raw.accessToken || '').trim();
  if (!accessToken) {
    return { ok: false, reason: 'token_file_no_access_token', path: file };
  }
  const exp = parseTokenExpiry(raw);
  if (exp.expired) {
    return {
      ok: false,
      reason: 'token_expired',
      path: file,
      message: 'OIDC access_token expired; re-run priority-saas-oidc-login',
      raw,
    };
  }
  return { ok: true, accessToken, source: 'tokenFile', path: file, raw };
}

function tokenExpired(path) {
  return {
    ok: false,
    reason: 'token_expired',
    path,
    message: 'OIDC access_token expired; re-run priority-saas-oidc-login',
  };
}

function writeTokenFileUtf8(file, doc) {
  const json = `${JSON.stringify(doc, null, 2)}\n`;
  fs.writeFileSync(file, json, { encoding: 'utf8' });
}

function postFormUrlencoded(tokenUrl, body, timeoutMs = 8000) {
  return new Promise((resolve, reject) => {
    let u;
    try {
      u = new URL(tokenUrl);
    } catch (e) {
      reject(e);
      return;
    }
    const lib = u.protocol === 'https:' ? https : http;
    const req = lib.request(
      {
        hostname: u.hostname,
        port: u.port || (u.protocol === 'https:' ? 443 : 80),
        path: `${u.pathname}${u.search}`,
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Content-Length': Buffer.byteLength(body),
        },
      },
      (res) => {
        const chunks = [];
        res.on('data', (c) => chunks.push(c));
        res.on('end', () => {
          const text = Buffer.concat(chunks).toString('utf8');
          resolve({
            status: res.statusCode,
            json: async () => JSON.parse(text),
          });
        });
      },
    );
    req.on('error', reject);
    req.setTimeout(timeoutMs, () => {
      req.destroy(new Error('token_refresh_timeout'));
    });
    req.end(body);
  });
}

/**
 * FR #421 / FR-039: POST refresh_token once to tokenUrl stored in the token file.
 * Missing tokenUrl: no network. Failure: leave file unchanged.
 */
export async function refreshExpiredTokenFile(file, raw, opts = {}) {
  const refreshToken = String(raw?.refresh_token || raw?.refreshToken || '').trim();
  if (!refreshToken) return tokenExpired(file);
  const tokenUrl = String(raw?.tokenUrl || raw?.token_url || '').trim();
  if (!tokenUrl) return tokenExpired(file);

  const params = new URLSearchParams();
  params.set('grant_type', 'refresh_token');
  params.set('refresh_token', refreshToken);
  params.set('client_id', String(raw.client_id || raw.clientId || 'priority-web'));
  const body = params.toString();

  let res;
  try {
    if (typeof opts.fetch === 'function') {
      res = await opts.fetch(tokenUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body,
      });
    } else {
      res = await postFormUrlencoded(tokenUrl, body);
    }
  } catch {
    return tokenExpired(file);
  }
  if (!res || Number(res.status) !== 200) return tokenExpired(file);

  let next;
  try {
    next = typeof res.json === 'function' ? await res.json() : JSON.parse(String(res.body || ''));
  } catch {
    return tokenExpired(file);
  }
  const accessToken = String(next?.access_token || next?.accessToken || '').trim();
  if (!accessToken) return tokenExpired(file);

  const merged = {
    ...raw,
    ...next,
    access_token: accessToken,
    obtained_at: new Date().toISOString(),
  };
  if (!next.refresh_token && raw.refresh_token) merged.refresh_token = raw.refresh_token;
  if (raw.tokenUrl && !merged.tokenUrl) merged.tokenUrl = raw.tokenUrl;
  writeTokenFileUtf8(file, merged);
  return { ok: true, accessToken, source: 'tokenFile', path: file, refreshed: true };
}

/** Load token; if expired, refresh once then continue. */
export async function resolveAccessToken(instance, opts = {}) {
  const tok = loadAccessToken(instance);
  if (tok.ok || tok.reason !== 'token_expired') {
    const { raw, ...rest } = tok;
    return rest;
  }
  const refreshed = await refreshExpiredTokenFile(tok.path, tok.raw, opts);
  return refreshed;
}

/**
 * FR #420 / FR-038: refuse expired tokens before any login call.
 * @param {object} instance
 * @param {{ login?: (instance, accessToken) => Promise<unknown> }} [opts]
 */
export async function attemptLoginIfTokenFresh(instance, opts = {}) {
  const tok = await resolveAccessToken(instance, opts);
  if (!tok.ok) {
    return { ...tok, loginCount: 0 };
  }
  const login = opts.login;
  if (typeof login !== 'function') {
    return { ...tok, loginCount: 0, deferred: true };
  }
  const session = await login(instance, tok.accessToken);
  return {
    ok: session?.ok !== false,
    loginCount: 1,
    session,
    tokenSource: tok.source,
  };
}
