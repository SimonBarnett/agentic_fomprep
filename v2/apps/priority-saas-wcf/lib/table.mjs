/**
 * Dictionary table reads (FR #412 / FR-030). OData COLUMNS only; no writes.
 */

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
