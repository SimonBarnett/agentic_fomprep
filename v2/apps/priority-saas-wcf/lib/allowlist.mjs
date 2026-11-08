import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';

const SECRET_KEY_RE = /(pass|password|pwd|secret|token|authorization)/i;

export function defaultInstancesPath() {
  if (process.env.PRIORITY_SAAS_WCF_INSTANCES) {
    return process.env.PRIORITY_SAAS_WCF_INSTANCES;
  }
  return path.join(os.homedir(), '.priority-saas-wcf', 'instances.json');
}

/** Strip UTF-8 BOM (PowerShell Set-Content on Windows). */
export function stripBom(text) {
  const s = String(text || '');
  return s.charCodeAt(0) === 0xfeff ? s.slice(1) : s;
}

export function readAllowlist(filePath = defaultInstancesPath()) {
  if (!filePath || !fs.existsSync(filePath)) {
    return { ok: false, reason: 'no_instances_file', path: filePath || '' };
  }
  let raw;
  try {
    raw = JSON.parse(stripBom(fs.readFileSync(filePath, 'utf8')));
  } catch (e) {
    return { ok: false, reason: 'instances_invalid_json', path: filePath, message: String(e.message || e) };
  }
  const list = Array.isArray(raw?.instances) ? raw.instances : [];
  if (list.length < 1) {
    return { ok: false, reason: 'no_instances', path: filePath };
  }
  for (const row of list) {
    const bad = Object.keys(row || {}).find((k) => SECRET_KEY_RE.test(k) && k.toLowerCase() !== 'tokenfile');
    if (bad) {
      return {
        ok: false,
        reason: 'instances_secret_key_forbidden',
        path: filePath,
        key: bad,
        message: 'Allowlist must not contain secrets; use tokenFile path or PRIORITY_SAAS_TOKEN',
      };
    }
  }
  return { ok: true, path: filePath, instances: list };
}

export function selectInstance(allow, instanceId) {
  if (!allow?.ok) {
    return { ok: false, reason: allow?.reason || 'no_instances_file', path: allow?.path, key: allow?.key, message: allow?.message };
  }
  const id = String(instanceId || '').trim();
  if (id) {
    const pick = allow.instances.find((r) => String(r.id) === id);
    if (!pick) {
      return {
        ok: false,
        reason: 'instance_unknown',
        instanceId: id,
        instanceIds: allow.instances.map((r) => r.id),
      };
    }
    return validateRow(pick);
  }
  if (allow.instances.length === 1) {
    return validateRow(allow.instances[0]);
  }
  return {
    ok: false,
    reason: 'instance_required',
    instanceIds: allow.instances.map((r) => r.id),
  };
}

function validateRow(row) {
  const id = String(row?.id || '').trim();
  const host = String(row?.host || '').trim().replace(/^https?:\/\//i, '').replace(/\/+$/, '');
  const tenant = String(row?.tenant || '').trim();
  const company = String(row?.company || '').trim();
  const user = String(row?.user || '').trim();
  if (!id || !host || !tenant || !company || !user) {
    return {
      ok: false,
      reason: 'instance_incomplete',
      instanceId: id || null,
      need: ['id', 'host', 'tenant', 'company', 'user'],
    };
  }
  if (!/^[A-Za-z0-9.-]+$/.test(host)) {
    return { ok: false, reason: 'host_invalid', host };
  }
  const language = Number(row.language) || 3;
  const tabulaini = row.tabulaini ? String(row.tabulaini).trim() : '';
  const tokenFile = row.tokenFile ? String(row.tokenFile).trim() : '';
  const allowLive = row.allowLive === true;
  const title = row.title ? String(row.title) : id;
  return {
    ok: true,
    instance: {
      id,
      title,
      host,
      tenant,
      company,
      user,
      language,
      tabulaini,
      tokenFile,
      allowLive,
      url: `https://${host}`,
      webuiUrl: `https://${host}/webui/${tenant}`,
    },
  };
}

export function refuseLiveWrite(instance, { write = false } = {}) {
  if (!write) return null;
  if (instance.allowLive === true) return null;
  const blob = [instance.id, instance.title, instance.company, instance.tenant].join(' ');
  if (/\blive\b/i.test(blob) || /\bpri\b/i.test(String(instance.company))) {
    return { ok: false, reason: 'live_refused', instanceId: instance.id };
  }
  return { ok: false, reason: 'writes_require_allowLive', instanceId: instance.id };
}
