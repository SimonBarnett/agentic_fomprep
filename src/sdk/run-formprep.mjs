/**
 * Headless Web SDK: EFORM → FORMPREPDRCT for one named form.
 * Password: env PRIORITY_SDK_PASSWORD. Never log it.
 */
import fs from 'node:fs';
import path from 'node:path';

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

const formName = arg('--name');
const procName = arg('--proc', 'FORMPREPDRCT2');
const company = arg('--company', 'base');
const url = arg('--url', 'https://prioritydev.clarksonevans.co.uk');
const tabulaini = arg('--tabulaini', 'tabula.ini');
const username = arg('--user', 'Si');
const outDir = arg('--out', path.join('C:\\Priority\\tmp\\agent-formprep', 'sdk-run'));
const password = process.env.PRIORITY_SDK_PASSWORD || '';
const language = Number(arg('--language', '2')) || 2;

if (!formName || !password) {
  console.error(JSON.stringify({ ok: false, stage: 'args', message: 'need --name and PRIORITY_SDK_PASSWORD' }));
  process.exit(2);
}
fs.mkdirSync(outDir, { recursive: true });

function dump(name, obj) {
  fs.writeFileSync(path.join(outDir, name), JSON.stringify(obj, (k, v) => (typeof v === 'function' ? undefined : v), 2));
}

function publicStep(step) {
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
          })),
        }
      : undefined,
    proc: step.proc ? { name: step.proc.name, title: step.proc.title } : undefined,
  };
}

const sdkMod = await import('priority-web-sdk');
const priority = sdkMod.default || sdkMod;
const errors = [];
const steps = [];

try {
  await priority.login({
    url,
    tabulaini,
    language,
    profile: { company },
    appname: 'ce-formprep-agent',
    username,
    password,
    devicename: 'agentic_fomprep',
  });
} catch (e) {
  dump('login-error.json', { message: e.message, type: e.type });
  console.log(JSON.stringify({ ok: false, stage: 'login', message: e.message }));
  process.exit(2);
}

let eform;
try {
  eform = await priority.formStart(
    'EFORM',
    (sr) => {
      if (sr && sr.message) errors.push({ source: 'sdk', severity: sr.type === 'error' ? 'Warning' : 'Info', text: String(sr.message) });
      if (sr && sr.type === 'warning' && eform.warningConfirm) eform.warningConfirm(1);
      if (sr && sr.type === 'information' && eform.infoMsgConfirm) eform.infoMsgConfirm();
    },
    null,
    { company },
    0
  );
} catch (e) {
  dump('formstart-error.json', { message: e.message, type: e.type });
  console.log(JSON.stringify({ ok: false, stage: 'formStart', message: e.message }));
  process.exit(2);
}

try {
  await eform.setSearchFilter({
    or: 0,
    QueryValues: [{ field: 'ENAME', fromval: formName, toval: '', op: '=', sort: 0, isdesc: 0 }],
  });
  const rows = await eform.getRows(1);
  dump('eform-rows.json', rows);
  const pack = rows && rows.EFORM ? rows.EFORM : {};
  const idxs = Object.keys(pack).filter((k) => k !== 'undefined');
  if (idxs.length < 1) {
    console.log(JSON.stringify({ ok: false, stage: 'search', message: 'form not found in EFORM: ' + formName }));
    process.exit(2);
  }
  const idx = Number(idxs[0]);
  await eform.setActiveRow(idx);
} catch (e) {
  dump('search-error.json', { message: e.message, type: e.type });
  console.log(JSON.stringify({ ok: false, stage: 'search', message: e.message }));
  process.exit(2);
}

let step;
try {
  step = await eform.activateStart(procName, 'P', null);
} catch (e) {
  dump('activate-error.json', { message: e.message, type: e.type });
  console.log(JSON.stringify({ ok: false, stage: 'activateStart', message: e.message }));
  process.exit(3);
}

const deadline = Date.now() + 180000;
let n = 0;
while (step && Date.now() < deadline && n < 40) {
  n += 1;
  const snap = publicStep(step);
  steps.push(snap);
  dump(`step-${String(n).padStart(2, '0')}.json`, snap);
  const type = step.type;
  const proc = step.proc;
  if (type === 'end') break;
  if (type === 'message') {
    const sev = step.messagetype === 'error' ? 'Warning' : 'Info';
    errors.push({ source: 'sdk', severity: sev, text: String(step.message || '') });
    step = await proc.message(1);
    continue;
  }
  if (type === 'inputHelp') {
    step = await proc.inputHelp(1);
    continue;
  }
  if (type === 'inputOptions') {
    const opts = (step.input && step.input.Options) || [];
    const sel = (opts.find((o) => o.selected) || opts[0] || {}).field;
    step = await proc.inputOptions(1, sel);
    continue;
  }
  if (type === 'inputFields') {
    const fields = (step.input && step.input.EditField) || [];
    const data = {
      EditFields: fields.map((f) => ({
        field: f.field,
        op: 0,
        value: /form|ename|exec|name/i.test(String(f.title || '')) ? formName : String(f.value || ''),
      })),
    };
    step = await proc.inputFields(1, data);
    continue;
  }
  if (type === 'client') {
    step = await proc.clientContinue('');
    continue;
  }
  errors.push({ source: 'sdk', severity: 'Warning', text: 'unsupported step ' + type });
  try { await proc.cancel(); } catch { /* ignore */ }
  break;
}

try { await eform.activateEnd(); } catch { /* ignore */ }
try { await eform.endCurrentForm(); } catch { /* ignore */ }

dump('steps.json', steps);
dump('errors.json', errors);
const last = steps.length ? steps[steps.length - 1] : {};
console.log(JSON.stringify({
  ok: true,
  stage: 'walked',
  steps: steps.length,
  lastType: last.type || null,
  lastMessage: last.message || null,
  errors,
  outDir,
}));
process.exit(0);
