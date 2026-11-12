/**
 * FR #409 / FR-027: read procedure body from the EXEC form (read-only).
 * FR #410 / FR-028: write procedure body through the EXEC form (not raw SQL).
 * Keep TEXT field naming shared. Never log tokens or echo connection secrets.
 * Never return the file body on write failure.
 */
import fs from 'node:fs';
import { formStart, formGetRows, formSave, safeEnd } from './form.mjs';

function pick(obj, keys) {
  if (!obj || typeof obj !== 'object') return '';
  for (const k of keys) {
    const v = obj[k];
    if (v != null && String(v).length) return String(v);
  }
  return '';
}

/** Return trimmed body text, or null when missing/blank. */
export function bodyFromExecRow(row) {
  const raw = pick(row, ['TEXT', 'Text', 'text', 'TRIGTEXT', 'BODY', 'body']);
  const body = String(raw ?? '').replace(/^\uFEFF/, '');
  if (!body.trim()) return null;
  return body;
}

/**
 * Read-only: open EXEC, search ENAME, return {name, body}.
 * Missing row or empty TEXT -> reason proc_text_missing.
 */
export async function readProcTextViaExecForm(session, instance, name, {
  messages = [],
  formStart: startFn,
  formGetRows: getRowsFn,
  safeEnd: endFn,
} = {}) {
  const ename = String(name || '').trim();
  if (!ename) return { ok: false, reason: 'name_required' };
  if (!session?.ok || !session.priority) {
    return { ok: false, reason: session?.reason || 'session_required' };
  }
  const start = startFn || formStart;
  const getRows = getRowsFn || formGetRows;
  const end = endFn || safeEnd;
  let form;
  try {
    form = await start(session.priority, 'EXEC', instance?.company, { messages });
    if (typeof form.setSearchFilter === 'function') {
      await form.setSearchFilter({
        or: 0,
        QueryValues: [
          { field: 'ENAME', fromval: ename, toval: '', op: '=', sort: 0, isdesc: 0 },
        ],
      });
    }
    const got = await getRows(form, 1);
    if (!got || got.count < 1 || !got.rows?.length) {
      return { ok: false, reason: 'proc_text_missing', name: ename };
    }
    let row = got.rows[0];
    for (const candidate of got.rows) {
      const rowName = String(candidate.ENAME || candidate.NAME || '').trim();
      if (rowName === ename) {
        row = candidate;
        break;
      }
    }
    const body = bodyFromExecRow(row);
    if (body == null) {
      return { ok: false, reason: 'proc_text_missing', name: ename };
    }
    return { ok: true, name: ename, body, form: 'EXEC' };
  } catch (e) {
    return {
      ok: false,
      reason: 'form_failed',
      name: ename,
      message: String(e?.message || e),
    };
  } finally {
    if (form) await end(form);
  }
}

export function loadProcTextFile(filePath) {
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
  if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
  return { ok: true, body: text, path: p };
}

export async function applyProcTextToForm(form, body) {
  const text = String(body ?? '');
  if (typeof form.fieldUpdate !== 'function') {
    return { ok: false, reason: 'form_failed', detail: 'no_fieldUpdate' };
  }
  await form.fieldUpdate('TEXT', text, true);
  if (typeof formSave === 'function') {
    await formSave(form);
  }
  return { ok: true, set: 1 };
}

export async function writeProcTextViaExecForm(session, instance, name, body, { messages = [] } = {}) {
  const ename = String(name || '').trim();
  if (!ename) return { ok: false, reason: 'name_required' };
  let form;
  try {
    form = await formStart(session.priority, 'EXEC', instance.company, { messages });
    if (typeof form.setSearchFilter === 'function') {
      await form.setSearchFilter({
        or: 0,
        QueryValues: [
          { field: 'ENAME', fromval: ename, toval: '', op: '=', sort: 0, isdesc: 0 },
        ],
      });
    }
    const got = await formGetRows(form, 1);
    if (!got || got.count < 1) {
      return { ok: false, reason: 'proc_text_missing', name: ename };
    }
    if (typeof form.setActiveRow === 'function') {
      await form.setActiveRow(Number(got.rows[0]._idx));
    }
    const applied = await applyProcTextToForm(form, body);
    return { ...applied, name: ename, form: 'EXEC' };
  } finally {
    if (form) await safeEnd(form);
  }
}
