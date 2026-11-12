/**
 * Dictionary table reads (FR #412 / FR-030) and DDL (FR #415 / FR-033).
 * COLUMNS is OData-only. Column add needs sqlProfile; no SaaS pretend-DDL.
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

function mapColumn(row) {
  if (!row || typeof row !== 'object') return null;
  const name = String(row.CNAME || row.NAME || row.ColumnName || '').trim();
  if (!name) return null;
  return {
    name,
    type: String(row.CTYPE || row.TYPE || row.Type || '').trim(),
    title: String(row.TITLE || row.CDES || row.Title || '').trim(),
  };
}

export async function fetchTableColumns(instance, tableName, opts = {}) {
  const name = String(tableName || '').trim();
  if (!name) return { ok: false, reason: 'name_required', exists: false, columns: [] };
  const base = String(instance?.odataBase || instance?.odataUrl || '').replace(/\/+$/, '');
  if (!base) {
    return {
      ok: false,
      reason: 'no_odata_base',
      exists: false,
      columns: [],
      hint: 'Set instance.odataBase for COLUMNS reads',
    };
  }
  const entity = String(instance?.odataColumnsPath || 'COLUMNS').replace(/^\/+/, '');
  const filter = encodeURIComponent(`TNAME eq '${name.replace(/'/g, "''")}'`);
  const url = `${base}/${entity}?$filter=${filter}`;
  const headers = { Accept: 'application/json' };
  const pat = String(process.env.PRIORITY_SAAS_ODATA_PAT || process.env.PRIORITY_ODATA_PAT || '').trim();
  const bearer = String(opts.accessToken || process.env.PRIORITY_SAAS_TOKEN || '').trim();
  if (pat) {
    headers.Authorization = 'Basic ' + Buffer.from(`${pat}:PAT`).toString('base64');
  } else if (bearer) {
    headers.Authorization = 'Bearer ' + bearer;
  } else {
    return { ok: false, reason: 'no_odata_auth', exists: false, columns: [] };
  }
  const fetchImpl = opts.fetchImpl || fetch;
  let res;
  try {
    res = await fetchImpl(url, { headers });
  } catch (e) {
    return {
      ok: false,
      reason: 'odata_fetch_failed',
      exists: false,
      columns: [],
      message: String(e.message || e),
    };
  }
  const text = await res.text();
  if (!res.ok) {
    return {
      ok: false,
      reason: 'odata_http_' + res.status,
      exists: false,
      columns: [],
    };
  }
  let json;
  try {
    json = JSON.parse(text);
  } catch (e) {
    return {
      ok: false,
      reason: 'odata_invalid_json',
      exists: false,
      columns: [],
      message: String(e.message || e),
    };
  }
  const rows = json.value || json.d?.results || [];
  const columns = (Array.isArray(rows) ? rows : []).map(mapColumn).filter(Boolean);
  return {
    ok: true,
    table: name,
    exists: columns.length > 0,
    columns,
    source: 'odata',
  };
}
