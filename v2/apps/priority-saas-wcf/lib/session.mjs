import { createRequire } from 'node:module';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { probeTenant } from './probe.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const require = createRequire(path.join(__dirname, '..', 'package.json'));

export function loadSdk() {
  const mod = require('priority-web-sdk');
  return mod.default || mod;
}

export function buildLoginConfig(instance, accessToken, { tabulaini, appname, devicename } = {}) {
  const ini = tabulaini || instance.tabulaini || 'tabula.ini';
  const runId = Date.now().toString(36);
  return {
    url: instance.url,
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
  if (instance.tabulaini) return { ok: true, tabulaini: instance.tabulaini, source: 'allowlist' };
  const p = probe || (await probeTenant(instance, { accessToken }));
  if (!p.ok) return { ok: false, reason: p.reason, probe: p };
  if (!p.tabulaini) return { ok: false, reason: 'tabulaini_unknown', probe: p };
  return { ok: true, tabulaini: p.tabulaini, source: 'probe', probe: p };
}

export async function loginSession(instance, accessToken, opts = {}) {
  const iniRes = await resolveTabulaini(instance, accessToken, opts);
  if (!iniRes.ok) return iniRes;
  const priority = opts.sdk || loadSdk();
  const config = buildLoginConfig(instance, accessToken, {
    tabulaini: iniRes.tabulaini,
    appname: opts.appname,
    devicename: opts.devicename,
  });
  try {
    await priority.login(config);
  } catch (e) {
    return {
      ok: false,
      reason: 'login_failed',
      message: String(e?.message || e),
      type: e?.type || null,
      tabulaini: iniRes.tabulaini,
      tabulainiSource: iniRes.source,
    };
  }
  return {
    ok: true,
    priority,
    tabulaini: iniRes.tabulaini,
    tabulainiSource: iniRes.source,
    company: instance.company,
    url: instance.url,
    probe: iniRes.probe || null,
  };
}

export function messageHandler(bag, formRef) {
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
    if (sr?.type === 'error' && form?.errorConfirm) {
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
