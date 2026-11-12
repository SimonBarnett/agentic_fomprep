/**
 * FR #383 / FR-001: resolve Priority USERLOGIN for the allowlisted instance.
 * Never invent from OS username; never return tokens.
 */
import { formStart, formGetRows, safeEnd } from './form.mjs';

function pickLoginField(obj) {
  if (!obj || typeof obj !== 'object') return '';
  const keys = ['userLogin', 'USERLOGIN', 'UserLogin', 'username', 'Username'];
  for (const k of keys) {
    const v = obj[k];
    if (v != null && String(v).trim()) return String(v).trim();
  }
  return '';
}

/** Extract USERLOGIN from priority-web-sdk login() return value when present. */
export function extractUserLoginFromLoginResult(loginResult) {
  const direct = pickLoginField(loginResult);
  if (direct) return direct;
  if (loginResult && typeof loginResult === 'object') {
    const nested = pickLoginField(loginResult.profile) || pickLoginField(loginResult.user);
    if (nested) return nested;
  }
  return '';
}

function usersFilterForAllowlistUser(user) {
  const u = String(user || '').trim();
  return {
    or: 1,
    QueryValues: [
      { field: 'USERLOGIN', fromval: u, toval: '', op: '=', sort: 0, isdesc: 0 },
      { field: 'USER', fromval: u, toval: '', op: '=', sort: 0, isdesc: 0 },
    ],
  };
}

/**
 * @param {object} opts
 * @param {object} opts.instance allowlist row (needs .user, .company)
 * @param {object} opts.session loginSession result ({ ok, priority, loginResult })
 * @param {Function} [opts.formStart]
 * @param {Function} [opts.formGetRows]
 * @param {Function} [opts.safeEnd]
 */
export async function resolveWhoami(opts) {
  const instance = opts?.instance;
  const session = opts?.session;
  if (!session?.ok || !session.priority) {
    return { ok: false, reason: session?.reason || 'session_required' };
  }

  const fromLogin = extractUserLoginFromLoginResult(session.loginResult);
  if (fromLogin) {
    return { ok: true, userLogin: fromLogin, source: 'login' };
  }

  const start = opts.formStart || formStart;
  const getRows = opts.formGetRows || formGetRows;
  const end = opts.safeEnd || safeEnd;
  const allowUser = String(instance?.user || '').trim();
  if (!allowUser) {
    return { ok: false, reason: 'user_unidentified', detail: 'allowlist_user_missing' };
  }

  let form;
  try {
    form = await start(session.priority, 'USERS', instance.company, { messages: [] });
    if (typeof form.setSearchFilter === 'function') {
      await form.setSearchFilter(usersFilterForAllowlistUser(allowUser));
    }
    const got = await getRows(form, 1);
    const row = (got?.rows || []).find((r) => {
      const login = String(r?.USERLOGIN || r?.userLogin || '').trim();
      const user = String(r?.USER || r?.user || '').trim();
      return login || user;
    });
    const userLogin = String(row?.USERLOGIN || row?.userLogin || '').trim();
    if (userLogin) {
      return { ok: true, userLogin, source: 'users' };
    }
    return { ok: false, reason: 'user_unidentified', detail: 'users_empty' };
  } catch (e) {
    return {
      ok: false,
      reason: 'user_unidentified',
      detail: 'users_query_failed',
      message: String(e?.message || e),
    };
  } finally {
    try {
      await end(form);
    } catch {
      /* ignore */
    }
  }
}
