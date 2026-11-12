/**
 * FR #384: persist whoami USERLOGIN per instance.
 * Login rule matches launcher BobHours.UserLoginPattern / IsPriorityUserLogin.
 */
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';

export const USER_LOGIN_PATTERN = /^[A-Za-z0-9][A-Za-z0-9._@-]{0,63}$/;

export function isPriorityUserLogin(value) {
  return typeof value === 'string' && value.length > 0 && USER_LOGIN_PATTERN.test(value);
}

export function lastUserPath(userProfile) {
  const root = userProfile || process.env.USERPROFILE || os.homedir();
  return path.join(root, '.priority-agent', 'last-user.json');
}

export function rememberWhoami({
  userProfile,
  instanceId,
  userLogin,
  company,
  source,
  identifiedAt,
} = {}) {
  const file = lastUserPath(userProfile);
  const instance = String(instanceId || '').trim();
  if (!instance || /[\\/]/.test(instance)) {
    return { ok: false, detail: 'instance id is not usable', path: file };
  }
  const login = String(userLogin || '').trim();
  if (!isPriorityUserLogin(login)) {
    return { ok: false, detail: 'Priority USERLOGIN is not a usable login', path: file };
  }
  let root = {};
  if (fs.existsSync(file)) {
    try {
      const parsed = JSON.parse(fs.readFileSync(file, 'utf8'));
      if (parsed && typeof parsed === 'object' && !Array.isArray(parsed)) root = parsed;
    } catch {
      root = {};
    }
  }
  const at = identifiedAt || new Date().toISOString().replace(/\.\d{3}Z$/, 'Z');
  root[instance] = {
    userLogin: login,
    company: String(company || '').trim(),
    identifiedAt: at,
    source: String(source || 'whoami').trim() || 'whoami',
  };
  const json = JSON.stringify(root, null, 2);
  if (/\baccess_token\b/.test(json) || /\brefresh_token\b/.test(json)) {
    return { ok: false, detail: 'refusing to write token keys', path: file };
  }
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, json, { encoding: 'utf8' });
  return { ok: true, detail: 'whoami saved', path: file };
}
