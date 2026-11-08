/**
 * Tenant probe: POST https://<host>/webui/<tenant>
 * Returns wcf URL, tabulaini (_tabulaini=), authority. No secrets.
 */

const UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';

export function parseTabulaini(priorityParams) {
  const s = String(priorityParams || '');
  const m = s.match(/_tabulaini=([^&\s]+)/i);
  return m ? decodeURIComponent(m[1]) : '';
}

export function summarizeTenantJson(body) {
  const tabulaini = body.tabulaini || parseTabulaini(body.priorityParams) || '';
  return {
    wcf: body.wcf || null,
    server: body.server || null,
    authority: body.authority || null,
    admode: body.admode ?? null,
    tabulaini: tabulaini || null,
    h5client: body.h5client || null,
  };
}

export async function probeTenant(instance, { accessToken = '', fetchImpl = fetch } = {}) {
  const url = instance.webuiUrl;
  const headers = {
    Accept: 'application/json',
    'User-Agent': UA,
  };
  if (accessToken) headers.Authorization = `Bearer ${accessToken}`;
  let res;
  try {
    res = await fetchImpl(url, { method: 'POST', headers });
  } catch (e) {
    return { ok: false, reason: 'probe_network', message: String(e.message || e), url };
  }
  const text = await res.text();
  let body;
  try {
    body = JSON.parse(text);
  } catch {
    return {
      ok: false,
      reason: 'probe_not_json',
      httpStatus: res.status,
      url,
      preview: text.slice(0, 120),
    };
  }
  if (!res.ok) {
    return {
      ok: false,
      reason: 'probe_http',
      httpStatus: res.status,
      url,
      summary: summarizeTenantJson(body),
    };
  }
  const summary = summarizeTenantJson(body);
  if (!summary.wcf && !summary.tabulaini) {
    return { ok: false, reason: 'probe_incomplete', httpStatus: res.status, url, summary };
  }
  return {
    ok: true,
    httpStatus: res.status,
    url,
    ...summary,
  };
}
