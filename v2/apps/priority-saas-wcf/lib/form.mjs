import { messageHandler, safeEnd } from './session.mjs';

function packOf(rows, preferred) {
  const formName = Object.keys(rows || {}).find((k) => typeof rows[k] === 'object') || preferred;
  const pack = (rows && rows[formName]) || {};
  const idxs = Object.keys(pack).filter((k) => k !== 'undefined');
  return { formName, pack, idxs };
}

export function rowsFromGetRows(rows, preferred) {
  const { formName, pack, idxs } = packOf(rows, preferred);
  const list = idxs.map((i) => {
    const row = pack[i] || {};
    const out = { _idx: i };
    for (const [k, v] of Object.entries(row)) {
      if (k === 'metadata' || typeof v === 'function') continue;
      out[k] = v;
    }
    return out;
  });
  return { formName, count: list.length, rows: list };
}

export async function formStart(priority, ename, company, { messages = [] } = {}) {
  const ref = { f: null };
  const onMsg = messageHandler(messages, ref);
  const form = await priority.formStart(ename, onMsg, null, { company }, 0);
  ref.f = form;
  return form;
}

/**
 * FR #395 / FR-013: field names + types from form.columns only (never getRows).
 * @returns {{ name: string, type: string }[]}
 */
export function formColumnsMeta(form) {
  const cols = form?.columns;
  if (!cols || typeof cols !== 'object') return [];
  const out = [];
  for (const [name, meta] of Object.entries(cols)) {
    const n = String(name || '').trim();
    if (!n || n === 'undefined') continue;
    let type = '';
    if (meta != null && typeof meta === 'object' && !Array.isArray(meta)) {
      const t = meta.type ?? meta.datatype ?? meta.dataType ?? meta.fieldType;
      if (t != null && t !== '') type = String(t);
    } else if (typeof meta === 'string' || typeof meta === 'number') {
      type = String(meta);
    }
    out.push({ name: n, type });
  }
  return out;
}

export async function formGetRows(form, fromRow = 1) {
  const rows = await form.getRows(fromRow);
  return rowsFromGetRows(rows, form?.name);
}

/** FR-043 / #425: form rows --limit, default 50, max 500. */
export const FORM_ROWS_DEFAULT_LIMIT = 50;
export const FORM_ROWS_MAX_LIMIT = 500;

export function parseFormRowsLimit(raw) {
  if (raw === '' || raw == null) {
    return { ok: true, limit: FORM_ROWS_DEFAULT_LIMIT, defaulted: true };
  }
  const n = Number(raw);
  if (!Number.isFinite(n)) {
    return { ok: false, reason: 'limit_too_high', got: raw, max: FORM_ROWS_MAX_LIMIT };
  }
  const i = Math.trunc(n);
  if (i > FORM_ROWS_MAX_LIMIT) {
    return { ok: false, reason: 'limit_too_high', limit: i, max: FORM_ROWS_MAX_LIMIT };
  }
  if (i < 1) {
    return { ok: false, reason: 'limit_too_high', limit: i, max: FORM_ROWS_MAX_LIMIT };
  }
  return { ok: true, limit: i };
}

function applyRowLimit(got, limit) {
  if (limit == null) return got;
  const rows = Array.isArray(got.rows) ? got.rows.slice(0, limit) : [];
  return { ...got, rows, count: rows.length, limit };
}

/**
 * FR #396 / FR-014: optional one SDK search, then getRows (default from 1).
 * Missing filter skips setSearchFilter (unfiltered read).
 * FR-043: optional limit slices the client-side row list.
 */
export async function applySearchThenGetRows(form, filter, { fromRow = 1, getRows, limit } = {}) {
  let searchCalls = 0;
  if (filter) {
    await form.setSearchFilter(filter);
    searchCalls += 1;
  }
  const fetch = getRows || formGetRows;
  const got = await fetch(form, fromRow);
  return applyRowLimit({ ...got, searchCalls }, limit);
}

export async function formSetFields(form, fields) {
  const entries = Object.entries(fields || {});
  for (const [field, value] of entries) {
    await form.fieldUpdate(field, String(value ?? ''), true);
  }
  return { set: entries.length };
}

export async function formSave(form) {
  if (typeof form.saveRow === 'function') {
    await form.saveRow(0);
    return { saved: true, via: 'saveRow' };
  }
  if (typeof form.invoke === 'function') {
    await form.invoke('Save');
    return { saved: true, via: 'invoke:Save' };
  }
  throw new Error('form has no saveRow/invoke Save');
}

/** FR #398 / FR-016: one positioned row; caller must already have --confirm. */
export async function formDeletePositionedRow(form, filter, { getRows } = {}) {
  if (filter) await form.setSearchFilter(filter);
  const fetch = getRows || formGetRows;
  const got = await fetch(form, 1);
  if (!got || got.count < 1) {
    return { ok: false, reason: 'no_rows_for_filter', deleted: 0 };
  }
  if (typeof form.setActiveRow === 'function') {
    await form.setActiveRow(Number(got.rows[0]._idx));
  }
  if (typeof form.deleteRow === 'function') {
    await form.deleteRow();
  } else if (typeof form.invoke === 'function') {
    await form.invoke('Delete');
  } else {
    throw new Error('form has no deleteRow/invoke Delete');
  }
  return { ok: true, deleted: 1 };
}

/** FR #397 / FR-015: one new row. newRow (or startRow) once, then fieldUpdate, then saveRow(1). */
export async function formInsertRow(form, fields) {
  if (typeof form.newRow === 'function') {
    await form.newRow();
  } else if (typeof form.startRow === 'function') {
    await form.startRow(1);
  } else {
    throw new Error('form has no newRow/startRow');
  }
  const set = await formSetFields(form, fields);
  if (typeof form.saveRow === 'function') {
    await form.saveRow(1);
    return { set: set.set, saved: true, via: 'saveRow' };
  }
  if (typeof form.invoke === 'function') {
    await form.invoke('Save');
    return { set: set.set, saved: true, via: 'invoke:Save' };
  }
  throw new Error('form has no saveRow/invoke Save');
}

/**
 * FR #399 / FR-017: run one named form activation (e.g. SAVE).
 * Prefer activateStart; fall back to invoke. Caller owns message handler bag.
 */
export async function formRunAction(form, activationName) {
  const name = String(activationName || '').trim();
  if (!name) return { ok: false, reason: 'activation_required' };
  if (typeof form.activateStart === 'function') {
    const step = await form.activateStart(name, null, null);
    return { ok: true, activation: name, via: 'activateStart', step: step || null };
  }
  if (typeof form.invoke === 'function') {
    await form.invoke(name);
    return { ok: true, activation: name, via: 'invoke', step: null };
  }
  return { ok: false, reason: 'activation_unsupported', activation: name };
}

export async function formStartSubForm(parent, ename, { messages = [] } = {}) {
  const ref = { f: null, current: parent };
  const onMsg = messageHandler(messages, ref);
  const child = await parent.startSubForm(ename, onMsg, null);
  ref.f = child;
  return child;
}

/**
 * FR #400 / FR-018: open child subform and fieldUpdate on the child only.
 */
export async function formSubformSetFields(parent, childName, fields, { messages = [] } = {}) {
  const child = await formStartSubForm(parent, childName, { messages });
  const set = await formSetFields(child, fields);
  return { child, set };
}

export { safeEnd, packOf };
