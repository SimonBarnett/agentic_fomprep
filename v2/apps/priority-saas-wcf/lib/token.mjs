import fs from 'node:fs';

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
    };
  }
  return { ok: true, accessToken, source: 'tokenFile', path: file };
}

/**
 * FR #420 / FR-038: refuse expired tokens before any login call.
 * @param {object} instance
 * @param {{ login?: (instance, accessToken) => Promise<unknown> }} [opts]
 */
export async function attemptLoginIfTokenFresh(instance, opts = {}) {
  const tok = loadAccessToken(instance);
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
