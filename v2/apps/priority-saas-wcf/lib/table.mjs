/**
 * Dictionary table DDL (FR #415 / FR-033). SQL profile required; no SaaS pretend-DDL.
 */
import { checkDictionaryTitle } from './title-check.mjs';

export function instanceHasSqlProfile(instance) {
  const p = instance && instance.sqlProfile;
  if (!p) return false;
  if (p === true) return true;
  if (typeof p === 'string') return p.trim().length > 0;
  if (typeof p === 'object') return true;
  return false;
}

export async function addTableColumn(session, instance, spec = {}) {
  const titleCheck = checkDictionaryTitle(spec.title);
  if (!titleCheck.ok) return titleCheck;
  if (!instanceHasSqlProfile(instance)) {
    return { ok: false, reason: 'table_ddl_needs_sql' };
  }
  const table = String(spec.table || '').trim();
  const column = String(spec.column || '').trim();
  const type = String(spec.type || '').trim();
  if (!table) return { ok: false, reason: 'name_required' };
  if (!column) return { ok: false, reason: 'column_required' };
  if (!type) return { ok: false, reason: 'type_required' };
  const payload = { table, column, type, title: titleCheck.title };
  const fn = session?.priority?.addTableColumn;
  if (typeof fn !== 'function') {
    return { ok: false, reason: 'table_ddl_unsupported' };
  }
  await fn(payload);
  return { ok: true, ...payload };
}
