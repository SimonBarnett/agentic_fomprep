/**
 * Spike B: formStart(EFORM) → find form → activateStart(FORMPREPDRCT).
 * Password from PRIORITY_SDK_PASSWORD.
 */
import fs from 'node:fs';
import path from 'node:path';

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

const formName = arg('--name');
const company = arg('--company', 'base');
const url = arg('--url', 'https://prioritydev.clarksonevans.co.uk');
const tabulaini = arg('--tabulaini', 'tabula.ini');
const username = arg('--user', 'Si');
const outDir = arg('--out', path.join('C:\\Priority\\tmp\\agent-formprep', 'sdk-eform'));
const password = process.env.PRIORITY_SDK_PASSWORD || '';
const language = Number(arg('--language', '2')) || 2;

if (!formName || !password) {
  console.error('need --name and PRIORITY_SDK_PASSWORD');
  process.exit(2);
}
fs.mkdirSync(outDir, { recursive: true });

const sdkMod = await import('priority-web-sdk');
const priority = sdkMod.default || sdkMod;

function dump(name, obj) {
  const json = JSON.stringify(obj, (k, v) => (typeof v === 'function' ? undefined : v), 2);
  fs.writeFileSync(path.join(outDir, name), json);
}

const config = {
  url,
  tabulaini,
  language,
  profile: { company },
  appname: 'ce-formprep-agent',
  username,
  password,
  devicename: 'agentic_fomprep',
};

try {
  await priority.login(config);
} catch (e) {
  dump('login-error.json', { message: e.message, type: e.type });
  console.log(JSON.stringify({ ok: false, stage: 'login', message: e.message }));
  process.exit(2);
}

let eform;
const messages = [];
try {
  eform = await priority.formStart(
    'EFORM',
    (serverResponse) => {
      messages.push({ type: serverResponse.type, message: serverResponse.message, code: serverResponse.code });
      if (serverResponse.type === 'warning' && eform && eform.warningConfirm) {
        eform.warningConfirm(1);
      }
      if (serverResponse.type === 'information' && eform && eform.infoMsgConfirm) {
        eform.infoMsgConfirm();
      }
    },
    null,
    { company },
    0
  );
} catch (e) {
  dump('formstart-error.json', { message: e.message, type: e.type, messages });
  console.log(JSON.stringify({ ok: false, stage: 'formStart', message: e.message }));
  process.exit(3);
}

dump('eform-meta.json', {
  name: eform.name,
  columnKeys: eform.columns ? Object.keys(eform.columns) : [],
  messages,
});

console.log(JSON.stringify({ ok: true, stage: 'formStart', columns: eform.columns ? Object.keys(eform.columns) : [], messages: messages.length }));
process.exit(0);
