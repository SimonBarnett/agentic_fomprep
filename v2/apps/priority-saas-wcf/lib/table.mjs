/**
 * Dictionary table reads (FR #413 / FR-031 exists). OData GET only; no writes.
 */

function odataHeaders(opts = {}) {
  const headers = { Accept: 'application/json' };
  const pat = String(process.env.PRIORITY_SAAS_ODATA_PAT || process.env.PRIORITY_ODATA_PAT || '').trim();
  const bearer = String(opts.accessToken || process.env.PRIORITY_SAAS_TOKEN || '').trim();
  if (pat) {
    headers.Authorization = 'Basic ' + Buffer.from(`${pat}:PAT`).toString('base64');
  } else if (bearer) {
    headers.Authorization = 'Bearer ' + bearer;
  }
  return headers;
}

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
  const headers = odataHeaders(opts);
  if (!headers.Authorization) {
    return { ok: false, reason: 'no_odata_auth', name, exists: false };
  }
  const entity = String(instance?.odataTablesPath || 'TABLES').replace(/^\/+/, '');
  const filter = encodeURIComponent(`TNAME eq '${name.replace(/'/g, "''")}'`);
  const url = `${base}/${entity}?$filter=${filter}&$top=1`;
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
