import { createRequire } from 'node:module';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { probeTenant, probeTenantCached } from './probe.mjs';
import { redact } from './json-out.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const require = createRequire(path.join(__dirname, '..', 'package.json'));

export function loadSdk() {
  const mod = require('priority-web-sdk');
  return mod.default || mod;
}

/**
 * priority-web-sdk appends `/wcf/wcf/Service.svc` when url does not end in
 * `.svc` / `.v3`. On SaaS the real endpoint is usually
 * `https://<host>/wcf/service.svc` from the tenant probe. Passing the host
 * alone hits the wrong path and surfaces as "Can't connect to server."
 */
export function resolveLoginUrl(instance, probe) {
  const candidates = [
    instance?.wcfUrl,
    instance?.wcf,
    probe?.wcf,
    instance?.url,
  ];
  for (const c of candidates) {
    const u = String(c || '').trim();
    if (!u) continue;
    if (/\.svc$/i.test(u) || /\.v3$/i.test(u)) {
      return { ok: true, url: u, source: u === probe?.wcf ? 'probe.wcf' : 'allowlist' };
    }
  }
  const hostUrl = String(instance?.url || '').trim();
  if (hostUrl && /priority-connect\.online/i.test(hostUrl)) {
    return {
      ok: false,
      reason: 'wcf_url_required',
      message:
        'SaaS login needs the probed WCF URL ending in .svc (tenant.wcf). Host-only URL makes the SDK append /wcf/wcf/Service.svc and fail.',
      hostUrl,
      probeWcf: probe?.wcf || null,
    };
  }
  if (hostUrl) return { ok: true, url: hostUrl, source: 'host' };
  return { ok: false, reason: 'url_missing', message: 'No login URL on instance or probe' };
}

export function buildLoginConfig(instance, accessToken, { tabulaini, appname, devicename, url } = {}) {
  const ini = tabulaini || instance.tabulaini || '';
  const runId = Date.now().toString(36);
  return {
    url: url || instance.url,
    tabulaini: ini,
    language: instance.language || 3,
    profile: { company: instance.company },
    appname: appname || `priority-saas-wcf-${runId}`,
    username: instance.user,
    accessToken,
    devicename: devicename || `agent-${runId}`,
    appid: '',
    appkey: '',
  };
}

export async function resolveTabulaini(instance, accessToken, { probe } = {}) {
  if (instance.tabulaini) return { ok: true, tabulaini: instance.tabulaini, source: 'allowlist', probe: probe || null };
  const p = probe || (await probeTenant(instance, { accessToken }));
  if (!p.ok) return { ok: false, reason: p.reason, probe: p };
  if (!p.tabulaini) return { ok: false, reason: 'tabulaini_unknown', probe: p };
  return { ok: true, tabulaini: p.tabulaini, source: 'probe', probe: p };
}

/** FR-040 / #422: brief pause before the single login_connect retry. */
export const LOGIN_CONNECT_RETRY_MS = 400;

function classifyLoginError(message) {
  const m = String(message || '');
  if (/API License/i.test(m) || /flag the user as having an API/i.test(m)) {
    return {
      reason: 'api_licence',
      hint: 'Tick API License (USERSB.REST) on the OIDC user, or use a REST PAT + OData/MCP for dictionary reads (see SAAS_WCF_CLIENT.md Failure).',
    };
  }
  if (/Can.?t connect to server/i.test(m)) {
    return {
      reason: 'login_connect',
      hint: 'Pass probed tenant.wcf (…/wcf/service.svc) as login url; host-only URL appends /wcf/wcf/Service.svc.',
    };
  }
  return { reason: 'login_failed', hint: null };
}

export async function loginSession(instance, accessToken, opts = {}) {
  const probe =
    opts.probe ||
    (await probeTenantCached(instance, {
      accessToken,
      fetchImpl: opts.fetchImpl,
      cachePath: opts.cachePath,
      now: opts.now,
    }));
  const iniRes = await resolveTabulaini(instance, accessToken, { probe });
  if (!iniRes.ok) return iniRes;
  if (!iniRes.tabulaini) {
    return { ok: false, reason: 'tabulaini_unknown', probe };
  }
  const urlRes = resolveLoginUrl(instance, probe?.ok ? probe : iniRes.probe || probe);
  if (!urlRes.ok) return { ...urlRes, tabulaini: iniRes.tabulaini, probe };

  const priority = opts.sdk || loadSdk();
  const config = buildLoginConfig(instance, accessToken, {
    tabulaini: iniRes.tabulaini,
    appname: opts.appname,
    devicename: opts.devicename,
    url: urlRes.url,
  });
  // FR-040 / #422: one brief retry only for login_connect (not api_licence / login_failed).
  const retryMs =
    Number.isFinite(opts.loginConnectRetryMs) && opts.loginConnectRetryMs >= 0
      ? opts.loginConnectRetryMs
      : LOGIN_CONNECT_RETRY_MS;
  const sleeper =
    typeof opts.sleep === 'function'
      ? opts.sleep
      : (ms) => new Promise((resolve) => setTimeout(resolve, ms));

  let loginResult = null;
  let loginAttempts = 0;
  let lastFail = null;
  for (let attempt = 1; attempt <= 2; attempt++) {
    loginAttempts = attempt;
    try {
      loginResult = await priority.login(config);
      lastFail = null;
      break;
    } catch (e) {
      const msg = String(e?.message || e);
      const cls = classifyLoginError(msg);
      lastFail = { e, msg, cls };
      if (cls.reason === 'login_connect' && attempt < 2) {
        await sleeper(retryMs);
        continue;
      }
      break;
    }
  }
  if (lastFail) {
    const { e, msg, cls } = lastFail;
    return {
      ok: false,
      reason: cls.reason,
      message: redact(msg),
      hint: cls.hint,
      type: e?.type || null,
      code: e?.code || null,
      tabulaini: iniRes.tabulaini,
      tabulainiSource: iniRes.source,
      loginUrl: urlRes.url,
      loginUrlSource: urlRes.source,
      probe: probe?.ok ? { wcf: probe.wcf, tabulaini: probe.tabulaini } : null,
      loginAttempts,
    };
  }
  return {
    ok: true,
    priority,
    loginResult: loginResult ?? null,
    tabulaini: iniRes.tabulaini,
    tabulainiSource: iniRes.source,
    company: instance.company,
    url: urlRes.url,
    loginUrlSource: urlRes.source,
    probe: probe?.ok ? probe : iniRes.probe || null,
    loginAttempts,
  };
}


let confirmErrors = false;

/** FR #401 / FR-019: errorConfirm only when --confirm-errors (or setConfirmErrors(true)). */
export function setConfirmErrors(value) {
  confirmErrors = value === true;
}

export function getConfirmErrors() {
  return confirmErrors === true;
}

export function messageHandler(bag, formRef, opts = {}) {
  const allowErrorConfirm = opts.confirmErrors === true || (opts.confirmErrors !== false && confirmErrors);
  return (sr) => {
    try {
      bag.push({
        type: sr?.type,
        message: String(sr?.message || sr?.text || '').slice(0, 400),
      });
    } catch {
      /* ignore */
    }
    const form = formRef?.f || formRef?.current || null;
    if (sr?.type === 'warning' && form?.warningConfirm) {
      try {
        form.warningConfirm(1);
      } catch {
        /* ignore */
      }
    }
    if (sr?.type === 'information' && form?.infoMsgConfirm) {
      try {
        form.infoMsgConfirm();
      } catch {
        /* ignore */
      }
    }
    if (sr?.type === 'error' && form?.errorConfirm && allowErrorConfirm) {
      try {
        form.errorConfirm();
      } catch {
        /* ignore */
      }
    }
  };
}

export async function safeEnd(form) {
  if (!form) return;
  try {
    await form.endCurrentForm();
  } catch {
    try {
      await form.end?.();
    } catch {
      /* ignore */
    }
  }
}

export async function logout(priority) {
  try {
    await priority?.logout?.();
  } catch {
    /* ignore */
  }
}
