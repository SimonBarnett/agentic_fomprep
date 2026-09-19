/**
 * Walk a pinned TYPE=P Priority procedure over WCF (priority-web-sdk).
 * ENAME, type, and step names are CLI args from pin.json — never guessed here.
 * Password: env PRIORITY_SDK_PASSWORD. Never log it.
 */
import fs from 'node:fs';
import path from 'node:path';
import { createRequire } from 'node:module';
import { pathToFileURL } from 'node:url';

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

const ename = arg('--ename');
const ptype = (arg('--type', 'P') || 'P').trim().toUpperCase();
const company = arg('--company');
const url = arg('--url');
const tabulaini = arg('--tabulaini', 'tabula.ini');
const username = arg('--user');
const outDir = arg('--out', path.join(process.env.TEMP || '/tmp', 'priority-shell-wcf'));
const password = process.env.PRIORITY_SDK_PASSWORD || '';
const language = Number(arg('--language', '2')) || 2;
const role = arg('--role', 'compile');
const revision = arg('--revision');
const filePath = arg('--file');
const revisionStep = (arg('--revisionStep') || '').trim().toUpperCase();
const fileStep = (arg('--fileStep') || '').trim().toUpperCase();
const nameStep = (arg('--nameStep') || 'NAM').trim().toUpperCase();
const errorForm = arg('--errorForm');
const wcfFileStep = arg('--wcfFileStep').trim().toLowerCase();

fs.mkdirSync(outDir, { recursive: true });

function dump(name, obj) {
  fs.writeFileSync(
    path.join(outDir, name),
    JSON.stringify(obj, (k, v) => (typeof v === 'function' ? undefined : v), 2)
  );
}

function fail(stage, message, extra = {}) {
  const payload = {
    ok: false,
    ended: false,
    reason: stage,
    lastType: extra.lastType || null,
    fileStepSeen: !!extra.fileStepSeen,
    fileStepFilled: !!extra.fileStepFilled,
    revisionStepFilled: !!extra.revisionStepFilled,
    steps: extra.steps || [],
    errors: extra.errors || [{ source: 'sdk', severity: 'Blocker', text: message }],
    ename,
    type: ptype,
    role,
  };
  dump('walk.json', payload);
  console.log(JSON.stringify(payload));
  process.exit(extra.exitCode || 3);
}

if (!ename || !password || !url || !company || !username) {
  fail('args', 'need --ename --url --company --user and PRIORITY_SDK_PASSWORD', { exitCode: 2 });
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
            zoom: f.zoom,
            code: f.code || f.columntype,
          })),
        }
      : undefined,
    proc: step.proc ? { name: step.proc.name, title: step.proc.title } : undefined,
    hyperlinks: step.hyperlinks,
    Urls: step.Urls,
    formats: step.formats,
  };
}

function typeSeverity(type, messagetype) {
  const t = String(messagetype || type || '').trim().toLowerCase();
  if (t === 'error') return 'Blocker';
  if (t === 'warning') return 'Warning';
  return 'Info';
}

function fieldKey(f) {
  return String(f && f.field != null ? f.field : '').trim();
}

function fieldTitle(f) {
  return String(f && f.title != null ? f.title : '').trim();
}

function isAttachField(f) {
  const z = String(f && f.zoom ? f.zoom : '').toLowerCase();
  return z === 'attach' || z === 'linkfile' || z === 'specialattach';
}

function looksRevisionTitle(title) {
  return /revision/i.test(title);
}

function looksFullPathTitle(title) {
  return /full\s+file\s+name/i.test(title) || /optional\s+\.rv/i.test(title);
}

function looksFileNameTitle(title) {
  return /^file\s+name$/i.test(title) || /just\s+file\s+name/i.test(title) || /file\s+name/i.test(title);
}

function basenameOf(p) {
  if (!p) return '';
  return path.basename(p);
}

function valueForField(f) {
  const key = fieldKey(f).toUpperCase();
  const title = fieldTitle(f);
  if (revisionStep && key === revisionStep && revision) return revision;
  if (fileStep && key === fileStep && filePath) return filePath;
  if (nameStep && key === nameStep && filePath) return role === 'install' ? filePath : basenameOf(filePath);
  if (role === 'compile' && looksRevisionTitle(title) && revision) return revision;
  if (looksFullPathTitle(title) && filePath) return filePath;
  if (looksFileNameTitle(title) && filePath) {
    return role === 'install' ? filePath : basenameOf(filePath);
  }
  if (f && f.value != null && String(f.value) !== '') return String(f.value);
  return '';
}

function markFieldHits(f, hits) {
  const key = fieldKey(f).toUpperCase();
  const title = fieldTitle(f);
  if ((revisionStep && key === revisionStep) || looksRevisionTitle(title)) hits.revisionStepSeen = true;
  if (
    (fileStep && key === fileStep) ||
    (nameStep && key === nameStep) ||
    looksFullPathTitle(title) ||
    looksFileNameTitle(title) ||
    isAttachField(f)
  ) {
    hits.fileStepSeen = true;
  }
}

async function loadSdk() {
  const require = createRequire(import.meta.url);
  let resolved;
  try {
    resolved = require.resolve('priority-web-sdk');
  } catch {
    resolved = null;
  }
  if (!resolved) {
    fail('sdk_missing', 'priority-web-sdk is not installed next to the walker', { exitCode: 2 });
  }
  const mod = await import(pathToFileURL(resolved).href);
  return mod.default || mod;
}

function displayUrlOf(step) {
  const urls = step && (step.Urls || step.urls);
  if (!urls) return '';
  if (typeof urls === 'string') return urls;
  if (urls.url) return String(urls.url);
  if (Array.isArray(urls) && urls[0]) return String(urls[0].url || urls[0]);
  return '';
}

async function uploadLocalFile(proc, localPath) {
  if (!localPath || !fs.existsSync(localPath)) {
    throw new Error('upload file missing: ' + localPath);
  }
  const buf = fs.readFileSync(localPath);
  const b64 = buf.toString('base64');
  const ext = path.extname(localPath) || '.sh';
  const dataUri = 'data:application/octet-stream;base64,' + b64;
  if (typeof proc.uploadDataUrl === 'function') {
    return proc.uploadDataUrl(dataUri, ext);
  }
  if (typeof proc.uploadDataUri === 'function') {
    return proc.uploadDataUri(dataUri, ext);
  }
  throw new Error('SDK has no uploadDataUrl/uploadDataUri');
}

const errors = [];
const steps = [];
const hits = {
  fileStepSeen: false,
  fileStepFilled: false,
  revisionStepSeen: false,
  revisionStepFilled: false,
};

const priority = await loadSdk();

try {
  await priority.login({
    url,
    tabulaini,
    language,
    profile: { company },
    appname: 'ce-shell-upgrade-agent',
    username,
    password,
    devicename: 'agentic_fomprep',
  });
} catch (e) {
  dump('login-error.json', { message: e.message, type: e.type });
  fail('login', 'WCF login failed: ' + e.message, { errors: [{ source: 'sdk', severity: 'Blocker', text: 'login: ' + e.message }], exitCode: 2 });
}

let step;
try {
  step = await priority.procStart(ename, ptype, null, company);
} catch (e) {
  dump('procstart-error.json', { message: e.message, type: e.type });
  fail('procStart', 'procStart failed: ' + e.message, {
    errors: [{ source: 'sdk', severity: 'Blocker', text: 'procStart: ' + e.message }],
  });
}

const deadline = Date.now() + 180000;
let n = 0;
let ended = false;
while (step && Date.now() < deadline && n < 40) {
  n += 1;
  const snap = publicStep(step);
  steps.push(snap);
  dump(`step-${String(n).padStart(2, '0')}.json`, snap);
  const type = step.type;
  const proc = step.proc;
  if (type === 'end') {
    ended = true;
    break;
  }
  if (type === 'message') {
    const sev = typeSeverity(step.type, step.messagetype);
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
  if (type === 'upload') {
    hits.fileStepSeen = true;
    if (!filePath || wcfFileStep === 'false') {
      errors.push({ source: 'sdk', severity: 'Blocker', text: 'upload step but no file (or WcfFileStepWorks=false)' });
      try { await proc.cancel(); } catch { /* ignore */ }
      break;
    }
    try {
      step = await uploadLocalFile(proc, filePath);
      hits.fileStepFilled = true;
      continue;
    } catch (e) {
      errors.push({ source: 'sdk', severity: 'Blocker', text: 'upload failed: ' + e.message });
      try { await proc.cancel(); } catch { /* ignore */ }
      break;
    }
  }
  if (type === 'inputFields') {
    const fields = (step.input && step.input.EditField) || [];
    fields.forEach((f) => markFieldHits(f, hits));
    const attach = fields.find((f) => isAttachField(f));
    if (attach && filePath && wcfFileStep !== 'false') {
      hits.fileStepSeen = true;
      try {
        step = await uploadLocalFile(proc, filePath);
        hits.fileStepFilled = true;
        continue;
      } catch (e) {
        errors.push({ source: 'sdk', severity: 'Warning', text: 'attach upload failed, trying path field: ' + e.message });
      }
    }
    const data = {
      EditFields: fields.map((f) => {
        const value = valueForField(f);
        if ((revisionStep && fieldKey(f).toUpperCase() === revisionStep) || looksRevisionTitle(fieldTitle(f))) {
          if (value) hits.revisionStepFilled = true;
        }
        if (
          (fileStep && fieldKey(f).toUpperCase() === fileStep) ||
          (nameStep && fieldKey(f).toUpperCase() === nameStep) ||
          looksFullPathTitle(fieldTitle(f)) ||
          looksFileNameTitle(fieldTitle(f))
        ) {
          if (value) hits.fileStepFilled = true;
        }
        return { field: f.field, op: 0, value };
      }),
    };
    dump(`input-${String(n).padStart(2, '0')}.json`, data);
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
    if (u) errors.push({ source: 'sdk', severity: 'Info', text: 'displayUrl ' + u });
    step = await proc.continueProc();
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

async function scrapeErrorForm() {
  if (!errorForm) return;
  let form = null;
  const onMsg = (sr) => {
    if (sr && sr.type === 'warning' && form && form.warningConfirm) form.warningConfirm(1);
    if (sr && sr.type === 'information' && form && form.infoMsgConfirm) form.infoMsgConfirm();
  };
  try {
    form = await priority.formStart(errorForm, onMsg, null, { company }, 1);
  } catch (e) {
    dump('error-form-open.json', { message: e.message, type: e.type, ename: errorForm });
    errors.push({ source: 'sdk', severity: 'Info', text: errorForm + ' open failed: ' + e.message });
    return;
  }
  try {
    const raw = await form.getRows(1);
    dump('error-form-rows.json', raw);
    const pack = raw && (raw[errorForm] || raw[Object.keys(raw || {})[0]] || {});
    for (const key of Object.keys(pack || {})) {
      if (key === 'undefined') continue;
      const row = pack[key];
      if (!row || typeof row !== 'object') continue;
      const msg = [row.CMESSAGE, row.MESSAGE, row.TEXT, row.ERRMSG, row.MSG, row.TITLE]
        .find((v) => v !== undefined && v !== null && String(v).trim() !== '');
      if (msg) {
        errors.push({ source: 'sdk', severity: typeSeverity(row.TYPE), text: String(msg).trim(), entityHint: errorForm });
      }
    }
  } catch (e) {
    errors.push({ source: 'sdk', severity: 'Info', text: errorForm + ' getRows failed: ' + e.message });
  }
  try { await form.endCurrentForm(); } catch { /* ignore */ }
}

await scrapeErrorForm();

const hasBlocker = errors.some((e) => e && e.severity === 'Blocker');
const ok = ended && !hasBlocker;
const payload = {
  ok,
  ended,
  reason: ok ? 'walked' : (ended ? 'proc_failed' : 'proc_failed'),
  lastType: steps.length ? steps[steps.length - 1].type : null,
  fileStepSeen: !!hits.fileStepSeen,
  fileStepFilled: !!hits.fileStepFilled,
  revisionStepFilled: !!hits.revisionStepFilled,
  steps,
  errors,
  ename,
  type: ptype,
  role,
};
dump('walk.json', payload);
dump('errors.json', errors);
console.log(JSON.stringify({
  ok: payload.ok,
  ended: payload.ended,
  reason: payload.reason,
  lastType: payload.lastType,
  fileStepSeen: payload.fileStepSeen,
  fileStepFilled: payload.fileStepFilled,
  revisionStepFilled: payload.revisionStepFilled,
  steps: steps.length,
  errors,
  ename,
  type: ptype,
  role,
  outDir,
}));
process.exit(ok ? 0 : 3);
