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

export function fail(reason, extra = {}, exit = 2) {
  return emit({ ok: false, reason, ...extra }, { exit });
}

export function ok(extra = {}) {
  return emit({ ok: true, ...extra }, { exit: 0 });
}
