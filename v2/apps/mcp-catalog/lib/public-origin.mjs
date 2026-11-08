const DEFAULT_ORIGIN = 'https://mcp.ntsa.uk';
const EXACT_HOSTS = new Set(['mcp.ntsa.uk', 'mcp-priority.ntsa.uk']);

function firstToken(value) {
  return (value || '').split(',')[0].trim();
}

function originFromHost(hostHeader, protoHeader) {
  const host = firstToken(hostHeader);
  if (!host || host.startsWith('[')) return null;

  let hostname = host;
  let port = '';
  const colon = host.lastIndexOf(':');
  if (colon > -1 && host.indexOf(':') === colon) {
    hostname = host.slice(0, colon);
    port = host.slice(colon + 1);
    if (!/^\d+$/.test(port)) return null;
  }

  hostname = hostname.toLowerCase().replace(/\.$/, '');
  if (!hostname) return null;

  const local = hostname === 'localhost' || hostname === '127.0.0.1';
  const amplify = hostname.endsWith('.amplifyapp.com') && hostname !== 'amplifyapp.com';
  if (!local && !amplify && !EXACT_HOSTS.has(hostname)) return null;

  const proto = firstToken(protoHeader).toLowerCase().replace(/:$/, '');
  let scheme;
  if (proto === 'http') {
    if (!local) return null;
    scheme = 'http';
  } else if (proto === 'https') {
    scheme = 'https';
  } else if (proto === '') {
    scheme = local ? 'http' : 'https';
  } else {
    return null;
  }

  if (port) {
    if (!local) return null;
    return `${scheme}://${hostname}:${port}`;
  }
  return `${scheme}://${hostname}`;
}

function originFromEnv(raw) {
  const text = (raw || '').trim();
  if (!text) return null;
  let url;
  try {
    url = new URL(text);
  } catch {
    return null;
  }
  if (url.username || url.password || url.search || url.hash) return null;
  if (url.pathname !== '/' && url.pathname !== '') return null;
  const proto = url.protocol === 'https:' ? 'https' : url.protocol === 'http:' ? 'http' : '';
  if (!proto) return null;
  return originFromHost(url.host, proto);
}

/**
 * Public origin advertised by the landing page and list_catalog.
 * Request Host wins when it is an allowlisted catalog host. CATALOG_PUBLIC_ORIGIN
 * is only a fallback. Anything else becomes https://mcp.ntsa.uk.
 */
export function catalogPublicOrigin(input = {}) {
  const fromHost = originFromHost(input.host, input.proto);
  if (fromHost) return fromHost;
  const fromForwarded = originFromHost(input.forwardedHost, input.proto);
  if (fromForwarded) return fromForwarded;
  const env = input.env !== undefined ? input.env : process.env.CATALOG_PUBLIC_ORIGIN;
  const fromEnv = originFromEnv(env);
  if (fromEnv) return fromEnv;
  return DEFAULT_ORIGIN;
}
