/** FR-042 / FR-424: batch --request with up to 8 read verbs on one login. */

export const BATCH_MAX_READS = 8;

export const BATCH_READ_VERBS = Object.freeze([
  'whoami',
  'form.columns',
  'form.rows',
  'table.columns',
  'table.exists',
  'companies',
  'proc.text',
  'interface.list',
]);

const ALLOWED = new Set(BATCH_READ_VERBS);

export function normalizeBatchVerb(raw) {
  const s = String(raw || '')
    .trim()
    .toLowerCase()
    .replace(/\s+/g, '.');
  return s;
}

export function parseBatchRead(item) {
  if (!item || typeof item !== 'object' || Array.isArray(item)) {
    return { ok: false, reason: 'batch_write_refused', detail: 'read_not_object' };
  }
  const verb = normalizeBatchVerb(item.verb || item.action || '');
  if (!verb) {
    return { ok: false, reason: 'batch_write_refused', detail: 'verb_missing' };
  }
  if (!ALLOWED.has(verb)) {
    return { ok: false, reason: 'batch_write_refused', verb };
  }
  const read = { verb, form: item.form || '', name: item.name || item.table || '' };
  if ((verb === 'form.columns' || verb === 'form.rows') && !read.form) {
    return { ok: false, reason: 'batch_write_refused', verb, need: 'form' };
  }
  if ((verb === 'table.columns' || verb === 'table.exists' || verb === 'proc.text') && !read.name) {
    return { ok: false, reason: 'batch_write_refused', verb, need: 'name' };
  }
  return { ok: true, read };
}

export function validateBatchRequest(doc) {
  const readsRaw = doc && Array.isArray(doc.reads) ? doc.reads : null;
  if (!readsRaw) {
    return { ok: false, reason: 'request_invalid', detail: 'reads_required' };
  }
  if (readsRaw.length > BATCH_MAX_READS) {
    return {
      ok: false,
      reason: 'batch_too_many',
      max: BATCH_MAX_READS,
      count: readsRaw.length,
    };
  }
  const reads = [];
  for (const item of readsRaw) {
    const parsed = parseBatchRead(item);
    if (!parsed.ok) return parsed;
    reads.push(parsed.read);
  }
  return { ok: true, reads };
}

/** One login, then each read. Tests count login() calls. */
export async function runBatchReads({ reads, login, runRead }) {
  const session = await login();
  const results = [];
  for (const read of reads) {
    results.push(await runRead(session, read));
  }
  return { ok: true, results, loginCount: 1 };
}
