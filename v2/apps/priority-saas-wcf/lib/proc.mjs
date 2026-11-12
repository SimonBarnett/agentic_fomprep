/**
 * SaaS proc start / continue (FR #339) for reports and interfaces.
 */
import { walkProcSteps } from './proc-walk.mjs';

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
      urls: walk.urls || [],
    };
  }
  const blockers = walk.errors.filter((e) => e.severity === 'Blocker');
  return {
    ok: walk.ended && blockers.length === 0,
    action: 'proc.start',
    name,
    ptype,
    ended: walk.ended,
    steps: walk.stepCount,
    lastType: walk.lastType,
    errors: walk.errors,
    walkSteps: walk.steps,
    urls: walk.urls || [],
  };
}

/**
 * Resume after needs_input: restart the procedure and apply --option once.
 * Does not auto-pick Options[0] for that step.
 */
export async function runProcContinue(session, instance, opts = {}) {
  const fromSnap = opts.fromSnap || {};
  const option = String(opts.option || '').trim();
  const name =
    String(opts.name || '').trim() ||
    String((fromSnap.proc && fromSnap.proc.name) || '').trim();
  if (!name) return { ok: false, reason: 'proc_name_required' };
  if (!option) return { ok: false, reason: 'option_required' };
  const ptype = String(opts.ptype || fromSnap.ptype || 'P').trim() || 'P';
  const priority = session.priority;
  const company = instance.company;
  let step;
  try {
    step = await priority.procStart(name, ptype, null, company);
  } catch (e) {
    return {
      ok: false,
      reason: 'proc_continue_failed',
      name,
      ptype,
      message: String(e.message || e),
    };
  }
  const walk = await walkProcSteps(step, {
    nameHint: opts.nameHint || '',
    inputValues: opts.inputValues,
    chosenOption: option,
    maxSteps: opts.maxSteps,
    deadlineMs: opts.deadlineMs,
    onStep: opts.onStep,
    onInput: opts.onInput,
  });
  const blockers = walk.errors.filter((e) => e.severity === 'Blocker');
  return {
    ok: walk.ended && blockers.length === 0,
    action: 'proc.continue',
    name,
    ptype,
    option,
    ended: walk.ended,
    steps: walk.stepCount,
    lastType: walk.lastType,
    errors: walk.errors,
    walkSteps: walk.steps,
  };
}
