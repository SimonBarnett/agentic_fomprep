/**
 * FR #417 / FR-035: read-only interface catalog list.
 * EXEC catalog (same as prepare interface). Never runs an interface (FR-36).
 */
import { formStart, formGetRows, safeEnd } from './form.mjs';

export const INTERFACE_CATALOG_FORM = 'EXEC';

function pick(obj, keys) {
  if (!obj || typeof obj !== 'object') return '';
  for (const k of keys) {
    const v = obj[k];
    if (v != null && String(v).trim()) return String(v).trim();
  }
  return '';
}

export function normalizeInterfaceRow(row) {
  const name = pick(row, ['ENAME', 'name', 'INTERFACE', 'IFNAME', 'NAME']);
  if (!name) return null;
  const title = pick(row, ['TITLE', 'title', 'EDES', 'DES', 'CDES']) || name;
  return { name, title };
}

/**
 * @param {object} opts
 * @param {object} opts.session loginSession result
 * @param {object} [opts.instance]
 */
export async function listInterfaces(opts) {
  const session = opts?.session;
  if (!session?.ok || !session.priority) {
    return { ok: false, reason: session?.reason || 'session_required', interfaces: [] };
  }
  const start = opts.formStart || formStart;
  const getRows = opts.formGetRows || formGetRows;
  const end = opts.safeEnd || safeEnd;
  const catalog = opts.catalogForm || INTERFACE_CATALOG_FORM;
  const company = opts.instance?.company;
  let form;
  try {
    form = await start(session.priority, catalog, company, { messages: [] });
    const got = await getRows(form, 1);
    const interfaces = (got?.rows || []).map(normalizeInterfaceRow).filter(Boolean);
    return { ok: true, interfaces, catalog, source: 'catalog' };
  } catch (e) {
    return {
      ok: false,
      reason: 'interface_list_failed',
      message: String(e?.message || e),
      interfaces: [],
    };
  } finally {
    if (form) await end(form);
  }
}
