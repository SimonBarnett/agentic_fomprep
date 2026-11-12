/**
 * FR #389 / FR-007: --request <path> UTF-8 JSON for verb arguments.
 * Keys fields, filter, inputs, name, form, subform override matching flags.
 * Invalid JSON -> reason request_invalid (caller exits 2 before login).
 */
import fs from 'node:fs';

const OVERRIDE_KEYS = ['fields', 'filter', 'inputs', 'name', 'form', 'subform'];

export function loadRequestFile(filePath) {
  const p = String(filePath || '').trim();
  if (!p) {
    return { ok: false, reason: 'request_invalid', detail: 'path_missing' };
  }
  let text;
  try {
    text = fs.readFileSync(p, 'utf8');
  } catch (e) {
    return {
      ok: false,
      reason: 'request_invalid',
      detail: 'read_failed',
      message: String(e?.message || e),
      path: p,
    };
  }
  if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
  let doc;
  try {
    doc = JSON.parse(text);
  } catch (e) {
    return {
      ok: false,
      reason: 'request_invalid',
      detail: 'json_parse',
      message: String(e?.message || e),
      path: p,
    };
  }
  if (!doc || typeof doc !== 'object' || Array.isArray(doc)) {
    return {
      ok: false,
      reason: 'request_invalid',
      detail: 'not_object',
      path: p,
    };
  }
  return { ok: true, doc, path: p, keys: OVERRIDE_KEYS.filter((k) => k in doc) };
}

/**
 * Prefer requestDoc[key] when the key is present; else fallback (CLI value).
 */
export function valueFromRequest(requestDoc, key, fallback) {
  if (requestDoc && Object.prototype.hasOwnProperty.call(requestDoc, key)) {
    return requestDoc[key];
  }
  return fallback;
}

export function parseFieldsJson(raw) {
  if (!raw) return {};
  if (typeof raw === 'object' && !Array.isArray(raw)) return { ...raw };
  return JSON.parse(String(raw));
}

/** fields object for form set/save: request.fields wins when present. */
export function fieldsFromRequestOrFlag(requestDoc, fieldsFlagRaw) {
  if (requestDoc && Object.prototype.hasOwnProperty.call(requestDoc, 'fields')) {
    return parseFieldsJson(requestDoc.fields);
  }
  return parseFieldsJson(fieldsFlagRaw || '{}');
}

/** Serialize object filter/fields for helpers that still expect a JSON string. */
export function rawJsonFromRequestOrFlag(requestDoc, key, flagRaw) {
  if (requestDoc && Object.prototype.hasOwnProperty.call(requestDoc, key)) {
    const v = requestDoc[key];
    if (v == null) return '';
    if (typeof v === 'string') return v;
    return JSON.stringify(v);
  }
  return flagRaw || '';
}

export function stringFromRequestOrFlag(requestDoc, key, flagRaw, fallback = '') {
  if (requestDoc && Object.prototype.hasOwnProperty.call(requestDoc, key)) {
    const v = requestDoc[key];
    if (v == null) return fallback;
    return String(v);
  }
  if (flagRaw != null && String(flagRaw) !== '') return String(flagRaw);
  return fallback;
}
