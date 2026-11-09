/**
 * SaaS prepare form | procedure | report (FR #339).
 * Ports run-formprep.mjs / run-repprep-via-exec.mjs onto accessToken sessions.
 */
import { formStart, formGetRows } from './form.mjs';
import { messageHandler, safeEnd } from './session.mjs';
import { walkProcSteps } from './proc-walk.mjs';
import { evaluatePrepGate, fetchODataPrepSnapshot, gateUnavailable } from './gate.mjs';

export function prepareKindDefaults(kind) {
  const k = String(kind || '')
    .trim()
    .toLowerCase();
  if (k === 'form') {
    return {
      kind: 'form',
      catalogForm: 'EFORM',
      proc: 'FORMPREPDRCT2',
      errorForm: 'FORMPREPERRS',
      searchField: 'ENAME',
    };
  }
  if (k === 'procedure' || k === 'proc' || k === 'report') {
    return {
      kind: k === 'report' ? 'report' : 'procedure',
      catalogForm: 'EXEC',
      proc: 'REPPREPDIRECT2',
      errorForm: '',
      searchField: 'ENAME',
    };
  }
  throw new Error('unknown_prepare_kind:' + kind);
}

export function rowsFromPack(errRows, formNameHint) {
  if (!errRows || typeof errRows !== 'object') return [];
  const pack = errRows[formNameHint] || errRows[Object.keys(errRows)[0]] || {};
  const rows = [];
  for (const key of Object.keys(pack)) {
    if (key === 'undefined') continue;
    const row = pack[key];
    if (!row || typeof row !== 'object') continue;
    rows.push(row);
  }
  return rows;
}

function typeSeverityFromRow(type) {
  const t = String(type || '')
    .trim()
    .toUpperCase();
  if (t === 'I' || t === 'INFO' || t === 'INFORMATION') return 'Info';
  return 'Warning';
}

export function rowToPrepError(row, wantedName) {
  const type = row.TYPE;
  const msg = [row.CMESSAGE, row.MESSAGE, row.TEXT, row.ERRMSG, row.MSG, row.TITLE].find(
    (v) => v !== undefined && v !== null && String(v).trim() !== '',
  );
  const blob = Object.keys(row)
    .filter(
      (k) =>
        k !== 'metadata' && row[k] !== undefined && row[k] !== null && String(row[k]).trim() !== '',
    )
    .map((k) => k + '=' + String(row[k]).trim())
    .join('; ');
  const text = msg ? String(msg).trim() : blob;
  if (!text) return null;
  const line = type ? String(type).trim() + ': ' + text : text;
  const mentions = wantedName ? new RegExp(wantedName, 'i').test(line) : false;
  return {
    source: 'FORMPREPERRS',
    severity: typeSeverityFromRow(type),
    formHint: mentions ? wantedName : '',
    text: line,
  };
}

export function collectFormPrepErrsFromRows(rows, wantedName) {
  const out = [];
  for (const row of rows || []) {
    const item = rowToPrepError(row, wantedName);
    if (item) out.push(item);
  }
  return out;
}

async function collectAllRows(form) {
  const all = [];
  const seen = new Set();
  const win = Number(form.windowSize) || 20;
  let from = 1;
  for (let page = 0; page < 25; page += 1) {
    const raw = await form.getRows(from);
    const rows = rowsFromPack(raw, form.name);
    if (rows.length === 0) break;
    let added = 0;
    for (const row of rows) {
      const sig = JSON.stringify(row);
      if (seen.has(sig)) continue;
      seen.add(sig);
      all.push(row);
      added += 1;
    }
    if (rows.length < win || added === 0) break;
    from += rows.length;
  }
  return all;
}

async function scrapeFormPrepErrs(priority, company, wantedName, messages) {
  const errors = [];
  let errForm = null;
  const ref = { f: null };
  const onMsg = messageHandler(messages, ref);
  try {
    errForm = await priority.formStart('FORMPREPERRS', onMsg, null, { company }, 1);
    ref.f = errForm;
  } catch (e) {
    errors.push({
      source: 'FORMPREPERRS',
      severity: 'Info',
      text: 'FORMPREPERRS open failed: ' + String(e.message || e),
    });
    return errors;
  }
  try {
    const rows = await collectAllRows(errForm);
    errors.push(...collectFormPrepErrsFromRows(rows, wantedName));
  } catch (e) {
    errors.push({
      source: 'FORMPREPERRS',
      severity: 'Info',
      text: 'FORMPREPERRS getRows failed: ' + String(e.message || e),
    });
  }
  await safeEnd(errForm);
  return errors;
}

async function searchActivate(priority, instance, defaults, name, messages, { procOverride } = {}) {
  const catalog = defaults.catalogForm;
  const procName = procOverride || defaults.proc;
  const form = await formStart(priority, catalog, instance.company, { messages });
  const field = defaults.searchField || 'ENAME';
  await form.setSearchFilter({
    or: 0,
    QueryValues: [{ field, fromval: name, toval: '', op: '=', sort: 0, isdesc: 0 }],
  });
  const got = await formGetRows(form, 1);
  if (got.count < 1) {
    await safeEnd(form);
    return { ok: false, reason: 'name_missing', catalog, name };
  }
  let idx = Number(got.rows[0]._idx);
  for (const row of got.rows) {
    if (String(row.ENAME || row.NAME || '').trim() === name) {
      idx = Number(row._idx);
      break;
    }
  }
  if (typeof form.setActiveRow === 'function') {
    await form.setActiveRow(idx);
  }
  let step;
  try {
    step = await form.activateStart(procName, 'P', null);
  } catch (e) {
    await safeEnd(form);
    return {
      ok: false,
      reason: 'activate_failed',
      message: String(e.message || e),
      catalog,
      proc: procName,
      name,
    };
  }
  return { ok: true, form, step, catalog, proc: procName };
}

/**
 * Run prepare walk for one named form/procedure/report.
 */
export async function runPrepare(session, instance, kind, name, opts = {}) {
  const defaults = prepareKindDefaults(kind);
  if (opts.proc) defaults.proc = opts.proc;
  const messages = opts.messages || [];
  const priority = session.priority;
  const errors = [];

  let beforeGate = null;
  if (opts.gate !== false && instance.odataBase) {
    beforeGate = await fetchODataPrepSnapshot(instance, name, {
      accessToken: opts.accessToken,
      fetchImpl: opts.fetchImpl,
    });
  }

  const started = await searchActivate(priority, instance, defaults, name, messages, {
    procOverride: opts.proc,
  });
  if (!started.ok) {
    return {
      ok: false,
      walkOk: false,
      preparedClaim: false,
      stage: started.reason,
      kind: defaults.kind,
      name,
      ...started,
      messages,
      errors,
    };
  }

  const walk = await walkProcSteps(started.step, {
    nameHint: name,
    maxSteps: opts.maxSteps,
    deadlineMs: opts.deadlineMs,
    onStep: opts.onStep,
  });
  errors.push(...walk.errors);

  if (defaults.errorForm === 'FORMPREPERRS') {
    const scraped = await scrapeFormPrepErrs(priority, instance.company, name, messages);
    errors.push(...scraped);
    if (!walk.ended && scraped.length === 0) {
      errors.push({
        source: 'FORMPREPERRS',
        severity: 'Info',
        text: 'FORMPREPERRS returned no rows after failed/incomplete prep',
      });
    }
  }

  try {
    await started.form.activateEnd?.();
  } catch {
    /* ignore */
  }
  await safeEnd(started.form);

  const blockers = errors.filter((e) => e.severity === 'Blocker');
  const walkOk = walk.ended && blockers.length === 0;

  let gate = gateUnavailable('no_sql_no_odata');
  if (opts.gate === false) {
    gate = { ok: false, status: 'skipped', preparedClaim: false };
  } else if (instance.odataBase) {
    const after = await fetchODataPrepSnapshot(instance, name, {
      accessToken: opts.accessToken,
      fetchImpl: opts.fetchImpl,
    });
    if (after.ok && after.status === 'snapshot') {
      const beforeSnap =
        beforeGate && beforeGate.ok && beforeGate.status === 'snapshot'
          ? beforeGate
          : opts.beforeSnapshot || null;
      gate = evaluatePrepGate(beforeSnap, after);
    } else {
      gate = after;
    }
  }

  const preparedClaim = Boolean(gate.preparedClaim);
  return {
    ok: walkOk && preparedClaim,
    walkOk,
    preparedClaim,
    stage: walkOk ? 'walked' : 'incomplete',
    kind: defaults.kind,
    name,
    catalog: started.catalog,
    proc: started.proc,
    steps: walk.stepCount,
    lastType: walk.lastType,
    ended: walk.ended,
    formprepErrs: errors.filter((e) => e.source === 'FORMPREPERRS').length,
    errors,
    gate,
    messages,
  };
}
