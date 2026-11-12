/**
 * Shared Priority Web SDK procedure step walker (Phase 2 / FR #339).
 * Used by prepare (activateStart) and proc (procStart).
 */

export function displayUrlOf(step) {
  const urls = step && (step.Urls || step.urls);
  if (!urls) return '';
  if (typeof urls === 'string') return urls;
  if (urls.url) return String(urls.url);
  if (Array.isArray(urls) && urls[0]) return String(urls[0].url || urls[0]);
  return '';
}

export function publicStep(step) {
  if (!step) return step;
  return {
    type: step.type,
    message: step.message,
    messagetype: step.messagetype,
    input: step.input
      ? {
          title: step.input.title,
          Options: step.input.Options,
          EditField: (step.input.EditField || []).map((f) => ({
            field: f.field,
            title: f.title,
            value: f.value,
            zoom: f.zoom,
          })),
        }
      : undefined,
    proc: step.proc ? { name: step.proc.name, title: step.proc.title } : undefined,
    Urls: step.Urls,
    formats: step.formats,
  };
}

export function typeSeverity(typeOrMsgType, messagetype) {
  const t = String(messagetype || typeOrMsgType || '')
    .trim()
    .toUpperCase();
  if (t === 'ERROR' || t === 'E' || t === 'BLOCKER') return 'Blocker';
  if (t === 'I' || t === 'INFO' || t === 'INFORMATION') return 'Info';
  return 'Warning';
}

function valueFromInputMap(inputValues, field) {
  if (!inputValues || typeof inputValues !== 'object') return undefined;
  const want = String(field || '');
  if (Object.prototype.hasOwnProperty.call(inputValues, want)) {
    return String(inputValues[want]);
  }
  const up = want.toUpperCase();
  for (const [k, v] of Object.entries(inputValues)) {
    if (String(k).toUpperCase() === up) return String(v);
  }
  return undefined;
}

function fillNameHint(fields, nameHint, inputValues) {
  return (fields || []).map((f) => {
    const title = String(f.title || '');
    const key = String(f.field || '').toUpperCase();
    let value = String(f.value || '');
    const fromFile = valueFromInputMap(inputValues, f.field);
    if (fromFile !== undefined) {
      value = fromFile;
    } else if (
      nameHint &&
      (key === 'PAR' ||
        key === 'FNM' ||
        key === 'ENAME' ||
        /form|ename|exec|name|procedure|report/i.test(title))
    ) {
      value = nameHint;
    }
    return { field: f.field, op: 0, value };
  });
}

/**
 * Walk SDK procedure steps until end / cancel / deadline.
 * @param {object} firstStep
 * @param {object} [opts]
 * @param {string} [opts.nameHint] fill name-like input fields
 * @param {number} [opts.maxSteps=60]
 * @param {number} [opts.deadlineMs=300000]
 * @param {(snap: object) => void} [opts.onStep]
 * @param {(data: object) => void} [opts.onInput]
 */
export async function walkProcSteps(firstStep, opts = {}) {
  const maxSteps = Number(opts.maxSteps) > 0 ? Number(opts.maxSteps) : 60;
  const deadlineMs = Number(opts.deadlineMs) > 0 ? Number(opts.deadlineMs) : 300000;
  const deadline = Date.now() + deadlineMs;
  const errors = [];
  const steps = [];
  let step = firstStep;
  let ended = false;
  let n = 0;
  let appliedInputValues = false;

  while (step && Date.now() < deadline && n < maxSteps) {
    n += 1;
    const snap = publicStep(step);
    steps.push(snap);
    if (typeof opts.onStep === 'function') opts.onStep(snap);

    const type = step.type;
    const proc = step.proc;
    if (type === 'end') {
      ended = true;
      break;
    }
    if (!proc) {
      errors.push({ source: 'sdk', severity: 'Blocker', text: 'step missing proc: ' + type });
      break;
    }
    if (type === 'message') {
      const sev = step.messagetype === 'error' ? 'Blocker' : 'Info';
      errors.push({ source: 'sdk', severity: sev, text: String(step.message || '') });
      step = await proc.message(1);
      continue;
    }
    if (type === 'inputHelp') {
      step = await proc.inputHelp(1);
      continue;
    }
    if (type === 'inputOptions') {
      const optionList = (step.input && step.input.Options) || [];
      const selected = optionList.find((o) => o && o.selected);
      if (optionList.length > 1 && !selected) {
        if (typeof opts.onNeedsInput === 'function') opts.onNeedsInput(snap);
        return {
          ok: false,
          ended: false,
          reason: 'needs_input',
          options: optionList,
          snapshot: snap,
          steps,
          errors,
          lastType: 'inputOptions',
          stepCount: n,
        };
      }
      const sel = (selected || optionList[0] || {}).field;
      step = await proc.inputOptions(1, sel);
      continue;
    }
    if (type === 'inputFields') {
      const fields = (step.input && step.input.EditField) || [];
      const fileValues = appliedInputValues ? undefined : opts.inputValues;
      appliedInputValues = true;
      const data = { EditFields: fillNameHint(fields, opts.nameHint, fileValues) };
      if (typeof opts.onInput === 'function') opts.onInput(data);
      step = await proc.inputFields(1, data);
      continue;
    }
    if (type === 'reportOptions') {
      const formats = step.formats || [];
      const sel = (formats.find((f) => f.selected) || formats[0] || {}).format;
      step = await proc.reportOptions(1, sel || 0);
      continue;
    }
    if (type === 'documentOptions') {
      const formats = step.formats || [];
      const sel = (formats.find((f) => f.selected) || formats[0] || {}).format;
      step = await proc.documentOptions(1, sel || 0, 2);
      continue;
    }
    if (type === 'displayUrl' || type === 'displayURL') {
      const u = displayUrlOf(step);
      if (u) errors.push({ source: 'PREPMSG', severity: 'Info', text: String(u).slice(0, 500) });
      step = await proc.continueProc();
      continue;
    }
    if (type === 'client') {
      step = await proc.clientContinue('');
      continue;
    }
    errors.push({ source: 'sdk', severity: 'Warning', text: 'unsupported step ' + type });
    try {
      await proc.cancel();
    } catch {
      /* ignore */
    }
    break;
  }

  return {
    ended,
    steps,
    errors,
    lastType: step ? step.type : null,
    stepCount: n,
  };
}
