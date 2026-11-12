/**
 * FR #402 / FR-020: --fields-file UTF-8 JSON, 1 MiB cap, refuse BOM.
 * Never return or log the file body on failure.
 */
import fs from 'node:fs';

export const FIELDS_FILE_MAX_BYTES = 1024 * 1024;

export function loadFieldsFile(filePath) {
  const p = String(filePath || '').trim();
  if (!p) {
    return { ok: false, reason: 'request_invalid', detail: 'path_missing' };
  }
  let buf;
  try {
    buf = fs.readFileSync(p);
  } catch (e) {
    return {
      ok: false,
      reason: 'request_invalid',
      detail: 'read_failed',
      path: p,
    };
  }
  if (buf.length > FIELDS_FILE_MAX_BYTES) {
    return { ok: false, reason: 'fields_file_too_large', path: p, bytes: buf.length };
  }
  if (buf.length >= 3 && buf[0] === 0xef && buf[1] === 0xbb && buf[2] === 0xbf) {
    return { ok: false, reason: 'bom_refused', path: p };
  }
  let text;
  try {
    text = buf.toString('utf8');
  } catch (e) {
    return { ok: false, reason: 'bom_refused', path: p, detail: 'utf8' };
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
  const fields =
    Object.prototype.hasOwnProperty.call(doc, 'fields') &&
    doc.fields &&
    typeof doc.fields === 'object' &&
    !Array.isArray(doc.fields)
      ? { ...doc.fields }
      : { ...doc };
  return { ok: true, fields, path: p };
}
