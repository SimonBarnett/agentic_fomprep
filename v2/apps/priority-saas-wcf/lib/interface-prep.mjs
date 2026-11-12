/**
 * FR #411 / FR-029: interface prepare proc pin (config/interface-prep.json).
 * Never invent a procedure ENAME — empty/missing proc refuses before login.
 */
import fs from 'node:fs';
import path from 'node:path';

export function defaultInterfacePrepPath(root) {
  return path.join(root, 'config', 'interface-prep.json');
}

/**
 * @returns {{ ok: true, proc: string, path: string } | { ok: false, reason: 'interface_prep_unknown', path: string, detail?: string }}
 */
export function loadInterfacePrepConfig(filePath) {
  const p = String(filePath || '').trim();
  if (!p) {
    return { ok: false, reason: 'interface_prep_unknown', path: '', detail: 'path_missing' };
  }
  let text;
  try {
    text = fs.readFileSync(p, 'utf8');
  } catch {
    return { ok: false, reason: 'interface_prep_unknown', path: p, detail: 'read_failed' };
  }
  if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
  let doc;
  try {
    doc = JSON.parse(text);
  } catch {
    return { ok: false, reason: 'interface_prep_unknown', path: p, detail: 'json_invalid' };
  }
  if (!doc || typeof doc !== 'object' || Array.isArray(doc)) {
    return { ok: false, reason: 'interface_prep_unknown', path: p, detail: 'not_object' };
  }
  const proc = String(doc.proc == null ? '' : doc.proc).trim();
  if (!proc) {
    return { ok: false, reason: 'interface_prep_unknown', path: p, detail: 'proc_empty' };
  }
  return { ok: true, proc, path: p };
}
