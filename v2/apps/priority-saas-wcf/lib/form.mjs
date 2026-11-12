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

export async function formGetRows(form, fromRow = 1) {
  const rows = await form.getRows(fromRow);
  return rowsFromGetRows(rows, form?.name);
}

/**
 * FR #396 / FR-014: optional one SDK search, then getRows (default from 1).
 * Missing filter skips setSearchFilter (unfiltered read).
 */
export async function applySearchThenGetRows(form, filter, { fromRow = 1, getRows } = {}) {
  let searchCalls = 0;
  if (filter) {
    await form.setSearchFilter(filter);
    searchCalls += 1;
  }
  const fetch = getRows || formGetRows;
  const got = await fetch(form, fromRow);
  return { ...got, searchCalls };
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

export async function formStartSubForm(parent, ename, { messages = [] } = {}) {
  const ref = { f: null, current: parent };
  const onMsg = messageHandler(messages, ref);
  const child = await parent.startSubForm(ename, onMsg, null);
  ref.f = child;
  return child;
}

export { safeEnd, packOf };
