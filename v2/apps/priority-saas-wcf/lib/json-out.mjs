/** Stable JSON stdout helpers. Never print tokens. */

const SECRET_KEYS = new Set([
  'access_token',
  'refresh_token',
  'password',
  'pwd',
  'token',
  'authorization',
  'otp',
  'totp',
  'secret',
]);

export function redact(value) {
  if (value == null) return value;
  if (typeof value === 'string') {
    if (/^eyJ[A-Za-z0-9_-]+\./.test(value)) return '<redacted-jwt>';
    if (value.length > 40 && /^[A-Za-z0-9._~+/-]+=*$/.test(value)) return '<redacted>';
    return value;
  }
  if (Array.isArray(value)) return value.map(redact);
  if (typeof value === 'object') {
    const out = {};
    for (const [k, v] of Object.entries(value)) {
      if (SECRET_KEYS.has(String(k).toLowerCase())) out[k] = '<redacted>';
      else out[k] = redact(v);
    }
    return out;
  }
  return value;
}

export function emit(obj, { exit = 0 } = {}) {
  const payload = redact(obj);
  process.stdout.write(JSON.stringify(payload) + '\n');
  if (exit !== null && exit !== undefined) process.exitCode = exit;
  return payload;
}

/** FR-010 / #392: retryable is true only for login_connect. No retry inside fail(). */
export const FAIL_RETRY = Object.freeze({
  login_connect: {
    retryable: true,
    hint: 'Pass probed tenant.wcf (…/wcf/service.svc) as login url; host-only URL appends /wcf/wcf/Service.svc.',
  },
  api_licence: {
    retryable: false,
    hint: 'Tick API License (USERSB.REST) on the OIDC user, or use a REST PAT + OData/MCP for dictionary reads (see SAAS_WCF_CLIENT.md Failure).',
  },
  token_expired: {
    retryable: false,
    hint: 'OIDC access_token expired; re-run priority-saas-oidc-login',
  },
});

export function classifyFailRetry(reason) {
  const row = FAIL_RETRY[String(reason || '')];
  if (row) return { retryable: row.retryable === true, hint: row.hint };
  return { retryable: false, hint: undefined };
}

export function fail(reason, extra = {}, exit = 2) {
  const cls = classifyFailRetry(reason);
  const payload = { ok: false, reason, ...extra, retryable: cls.retryable };
  if (cls.hint && (payload.hint == null || payload.hint === '')) payload.hint = cls.hint;
  return emit(payload, { exit });
}

export function ok(extra = {}) {
  return emit({ ok: true, ...extra }, { exit: 0 });
}
