/**
 * FR #410 / FR-028: write procedure body through the EXEC form (not raw SQL).
 * Never return the file body on failure.
 */
import fs from 'node:fs';
import { formStart, formGetRows, formSave, safeEnd } from './form.mjs';

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
