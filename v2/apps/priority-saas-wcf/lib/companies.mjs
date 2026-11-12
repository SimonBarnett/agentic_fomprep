/**
 * FR #394 / FR-012: read-only company list for the logged-in user.
 * Never switches the session company. Never logs tokens.
 */
import { formStart, formGetRows, safeEnd } from './form.mjs';

function pick(obj, keys) {
  if (!obj || typeof obj !== 'object') return '';
  for (const k of keys) {
    const v = obj[k];
    if (v != null && String(v).trim()) return String(v).trim();
  }
  return '';
}

export function normalizeCompanyRow(row) {
  const name = pick(row, ['name', 'DNAME', 'COMPANY', 'company', 'Company']);
  const title = pick(row, ['title', 'TITLE', 'COMPANYDES', 'des', 'Title', 'companydes']);
  if (!name) return null;
  return { name, title: title || name };
}

export function companiesFromLoginResult(loginResult) {
  const raw =
    loginResult?.companies ||
    loginResult?.Companies ||
    loginResult?.profile?.companies ||
    [];
  if (!Array.isArray(raw)) return [];
  return raw.map(normalizeCompanyRow).filter(Boolean);
}

/**
 * @param {object} opts
 * @param {object} opts.session loginSession result
 * @param {object} [opts.instance]
 */
export async function listCompanies(opts) {
  const session = opts?.session;
  if (!session?.ok || !session.priority) {
    return { ok: false, reason: session?.reason || 'session_required' };
  }
  const fromLogin = companiesFromLoginResult(session.loginResult);
  if (fromLogin.length) {
    return { ok: true, companies: fromLogin, source: 'login', switched: false };
  }

  const start = opts.formStart || formStart;
  const getRows = opts.formGetRows || formGetRows;
  const end = opts.safeEnd || safeEnd;
  const company = opts.instance?.company;
  let form;
  try {
    form = await start(session.priority, 'COMPANIES', company, { messages: [] });
    const got = await getRows(form, 1);
    const companies = (got?.rows || []).map(normalizeCompanyRow).filter(Boolean);
    return { ok: true, companies, source: 'companies', switched: false };
  } catch (e) {
    return {
      ok: false,
      reason: 'companies_failed',
      message: String(e?.message || e),
      switched: false,
    };
  } finally {
    if (form) await end(form);
  }
}
