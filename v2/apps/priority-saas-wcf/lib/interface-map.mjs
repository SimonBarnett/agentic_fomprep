/**
 * FR #419 / FR-037: one mapping-row fieldUpdate. Does not prepare (FR-29).
 */
import { formStart, formGetRows, formSetFields, safeEnd } from './form.mjs';

export const INTERFACE_MAP_FORM = 'FORMINTERFACES';

/**
 * @param {object} session
 * @param {object} instance
 * @param {{ name: string, fields: Record<string, unknown> }} spec
 */
export async function setInterfaceMap(session, instance, spec = {}) {
  const name = String(spec.name || '').trim();
  if (!name) return { ok: false, reason: 'name_required' };
  const fields = spec.fields && typeof spec.fields === 'object' && !Array.isArray(spec.fields)
    ? spec.fields
    : {};
  if (Object.keys(fields).length < 1) {
    return { ok: false, reason: 'fields_required' };
  }
  if (!session?.ok || !session.priority) {
    return { ok: false, reason: session?.reason || 'session_required' };
  }
  const start = spec.formStart || formStart;
  const getRows = spec.formGetRows || formGetRows;
  const setFields = spec.formSetFields || formSetFields;
  const end = spec.safeEnd || safeEnd;
  const catalog = spec.catalogForm || INTERFACE_MAP_FORM;
  let form;
  try {
    form = await start(session.priority, catalog, instance?.company, { messages: [] });
    if (typeof form.setSearchFilter === 'function') {
      await form.setSearchFilter({ ENAME: name });
    }
    if (typeof form.getRows === 'function' || getRows) {
      await getRows(form, 1);
    }
    const set = await setFields(form, fields);
    return {
      ok: true,
      name,
      catalog,
      fields: Object.keys(fields),
      set,
      prepared: false,
    };
  } catch (e) {
    return {
      ok: false,
      reason: 'interface_map_failed',
      message: String(e?.message || e),
    };
  } finally {
    if (form) await end(form);
  }
}
