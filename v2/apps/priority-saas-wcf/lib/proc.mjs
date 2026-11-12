/**
 * SaaS proc start / continue (FR #339) for reports and interfaces.
 */
import { walkProcSteps, displayUrlOf } from './proc-walk.mjs';

/** FR #408 / FR-026: ended + no urls + no errors => empty success. */
export function outcomeFromWalk(walk) {
  const urls = [];
  for (const s of walk.steps || []) {
    const u = displayUrlOf(s);
    if (u) urls.push(u);
  }
  const errors = walk.errors || [];
  const blockers = errors.filter((e) => e.severity === 'Blocker');
  const empty = walk.ended === true && urls.length === 0 && errors.length === 0;
  const ok = walk.ended === true && blockers.length === 0;
  return { ok, empty, urls };
}

/**
 * @param {object} session - loginSession result
 * @param {object} instance
 * @param {string} ename - procedure / report ENAME
 * @param {object} [opts]
 * @param {string} [opts.ptype='P'] procedure type P/R/…
 * @param {object} [opts.inputValues] map of field -> value for first inputFields
 */
export async function runProcStart(session, instance, ename, opts = {}) {
  const name = String(ename || '').trim();
  if (!name) return { ok: false, reason: 'proc_name_required' };
  const ptype = String(opts.ptype || 'P').trim() || 'P';
  const priority = session.priority;
  const company = instance.company;
  let step;
  try {
    step = await priority.procStart(name, ptype, null, company);
  } catch (e) {
    return {
      ok: false,
      reason: 'proc_start_failed',
      name,
      ptype,
      message: String(e.message || e),
    };
  }

  const nameHint = opts.nameHint || '';
  const walk = await walkProcSteps(step, {
    nameHint,
    inputValues: opts.inputValues,
    maxSteps: opts.maxSteps,
    deadlineMs: opts.deadlineMs,
    onStep: opts.onStep,
    onInput: opts.onInput,
    onNeedsInput: opts.onNeedsInput,
  });
  if (walk.reason === 'needs_input') {
    return {
      ok: false,
      reason: 'needs_input',
      action: 'proc.start',
      name,
      ptype,
      options: walk.options,
      snapshot: walk.snapshot,
      ended: false,
      steps: walk.stepCount,
      lastType: walk.lastType,
      errors: walk.errors,
      walkSteps: walk.steps,
    };
  }
  const outcome = outcomeFromWalk(walk);
  return {
    ok: outcome.ok,
    empty: outcome.empty,
    urls: outcome.urls,
    action: 'proc.start',
    name,
    ptype,
    ended: walk.ended,
    steps: walk.stepCount,
    lastType: walk.lastType,
    errors: walk.errors,
    walkSteps: walk.steps,
  };
}
