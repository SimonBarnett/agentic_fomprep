import fs from 'node:fs';

/**
 * Load SaaS Bearer access_token.
 * Prefer PRIORITY_SAAS_TOKEN; else instance.tokenFile JSON with access_token.
 * Never return secrets in error messages.
 */
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
    raw = JSON.parse(fs.readFileSync(file, 'utf8'));
  } catch {
    return { ok: false, reason: 'token_file_invalid_json', path: file };
  }
  const accessToken = String(raw.access_token || raw.accessToken || '').trim();
  if (!accessToken) {
    return { ok: false, reason: 'token_file_no_access_token', path: file };
  }
  return { ok: true, accessToken, source: 'tokenFile', path: file };
}
