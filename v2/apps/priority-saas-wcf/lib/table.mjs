/**
 * Dictionary table reads (FR #412 / FR-030, FR #413 / FR-031 exists) and DDL (FR #415 / FR-033, FR #416 / FR-034).
 * COLUMNS is OData-only. Column add and table create need sqlProfile; no SaaS pretend-DDL.
 * Never emit a raw CREATE statement from the agent prompt.
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

/**
 * Structured column list from --request JSON. Never a SQL string.
 * @returns {{ ok: true, columns: object[] } | { ok: false, reason: string }}
 */
export function columnsFromCreateRequest(doc) {
  const raw = doc && Object.prototype.hasOwnProperty.call(doc, 'columns') ? doc.columns : null;
  if (!Array.isArray(raw) || raw.length === 0) {
    return { ok: false, reason: 'columns_required' };
  }
  const columns = [];
  for (const c of raw) {
    if (!c || typeof c !== 'object' || Array.isArray(c)) {
      return { ok: false, reason: 'column_invalid' };
    }
    const name = String(c.name || c.column || c.CNAME || '').trim();
    const type = String(c.type || c.CTYPE || '').trim();
    const title = String(c.title || c.TITLE || '').trim();
    if (!name || !type) return { ok: false, reason: 'column_invalid' };
    if (title) {
      const tc = checkDictionaryTitle(title);
      if (!tc.ok) return tc;
    }
    const col = { name, type };
    if (title) col.title = title;
    columns.push(col);
  }
  return { ok: true, columns };
}

export async function createTable(session, instance, spec = {}) {
  if (!instanceHasSqlProfile(instance)) {
    return { ok: false, reason: 'table_ddl_needs_sql' };
  }
  const table = String(spec.table || spec.name || '').trim();
  if (!table) return { ok: false, reason: 'name_required' };
  const columns = Array.isArray(spec.columns) ? spec.columns : [];
  if (!columns.length) return { ok: false, reason: 'columns_required' };
  const payload = { table, columns };
  const fn = session?.priority?.createTable;
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

/** FR #413 / FR-031: TABLES GET; miss is exists false. */
export async function fetchTableExists(instance, tableName, opts = {}) {
  const name = String(tableName || '').trim();
  if (!name) return { ok: false, reason: 'name_required', name: '', exists: false };
  const base = String(instance?.odataBase || instance?.odataUrl || '').replace(/\/+$/, '');
  if (!base) {
    return {
      ok: false,
      reason: 'no_odata_base',
      name,
      exists: false,
      hint: 'Set instance.odataBase for TABLES reads',
    };
  }
  const headers = { Accept: 'application/json' };
  const pat = String(process.env.PRIORITY_SAAS_ODATA_PAT || process.env.PRIORITY_ODATA_PAT || '').trim();
  const bearer = String(opts.accessToken || process.env.PRIORITY_SAAS_TOKEN || '').trim();
  if (pat) {
    headers.Authorization = 'Basic ' + Buffer.from(pat + ':PAT').toString('base64');
  } else if (bearer) {
    headers.Authorization = 'Bearer ' + bearer;
  } else {
    return { ok: false, reason: 'no_odata_auth', name, exists: false };
  }
  const entity = String(instance?.odataTablesPath || 'TABLES').replace(/^\/+/, '');
  const filter = encodeURIComponent("TNAME eq '" + name.replace(/'/g, "''") + "'");
  const url = base + '/' + entity + '?$filter=' + filter + '&$top=1';
  const fetchImpl = opts.fetchImpl || fetch;
  let res;
  try {
    res = await fetchImpl(url, { method: 'GET', headers });
  } catch (e) {
    return {
      ok: false,
      reason: 'odata_fetch_failed',
      name,
      exists: false,
      message: String(e.message || e),
    };
  }
  const text = await res.text();
  if (!res.ok) {
    return { ok: false, reason: 'odata_http_' + res.status, name, exists: false };
  }
  let json;
  try {
    json = JSON.parse(text);
  } catch (e) {
    return {
      ok: false,
      reason: 'odata_invalid_json',
      name,
      exists: false,
      message: String(e.message || e),
    };
  }
  const rows = json.value || json.d?.results || [];
  const exists = Array.isArray(rows) && rows.length > 0;
  return { ok: true, name, exists, source: 'odata' };
}
