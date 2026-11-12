/**
 * FR #409 / FR-027: read procedure body from the EXEC form (read-only).
 * FR #410 / FR-028 (write) may extend this module; keep TEXT field naming shared.
 * Never log tokens or echo connection secrets.
 */
import { formStart, formGetRows, safeEnd } from './form.mjs';

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
