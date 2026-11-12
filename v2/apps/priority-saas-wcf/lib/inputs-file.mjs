/**
 * FR #403 / FR-021: --inputs UTF-8 JSON map. Never return the file body on failure.
 */
import fs from 'node:fs';

export function loadInputsFile(filePath) {
  const p = String(filePath || '').trim();
  if (!p) {
    return { ok: false, reason: 'request_invalid', detail: 'path_missing' };
  }
  let text;
  try {
    text = fs.readFileSync(p, 'utf8');
  } catch {
    return { ok: false, reason: 'request_invalid', detail: 'read_failed', path: p };
  }
  if (text.charCodeAt(0) === 0xfeff) {
    text = text.slice(1);
  }
  let doc;
  try {
    doc = JSON.parse(text);
  } catch {
    return { ok: false, reason: 'request_invalid', path: p, detail: 'json_parse' };
  }
  if (!doc || typeof doc !== 'object' || Array.isArray(doc)) {
    return { ok: false, reason: 'request_invalid', path: p, detail: 'not_object' };
  }
  const inputValues = {};
  for (const [k, v] of Object.entries(doc)) {
    if (v === null || v === undefined) continue;
    if (typeof v === 'object') continue;
    inputValues[k] = String(v);
  }
  return { ok: true, inputValues, path: p };
}
