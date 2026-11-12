#!/usr/bin/env node
/**
 * Priority SaaS WCF client (Phase 1 + Phase 2 prepare/proc).
 * Allowlist-gated; Bearer accessToken from PRIORITY_SAAS_TOKEN or tokenFile.
 * Usage: node bin/priority-wcf.mjs <verb> [args] --instance <id>
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { readAllowlist, selectInstance, refuseLiveWrite, defaultInstancesPath } from '../lib/allowlist.mjs';
import { loadAccessToken } from '../lib/token.mjs';
import { probeTenant } from '../lib/probe.mjs';
import { loginSession, logout, safeEnd, setConfirmErrors } from '../lib/session.mjs';
import {
  formStart,
  formGetRows,
  formSetFields,
  formSave,
  formStartSubForm,
  formSubformSetFields,
  applySearchThenGetRows,
} from '../lib/form.mjs';
import { runPrepare } from '../lib/prepare.mjs';
import { runProcStart } from '../lib/proc.mjs';
import { resolveWhoami } from '../lib/whoami.mjs';
import { listCompanies } from '../lib/companies.mjs';
import { emit, fail, ok, redact } from '../lib/json-out.mjs';
import { planDryRun } from '../lib/dry-run.mjs';
import {
  loadRequestFile,
  fieldsFromRequestOrFlag,
  rawJsonFromRequestOrFlag,
  stringFromRequestOrFlag,
  loadFieldsFile,
} from '../lib/request-file.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

/** FR #389: loaded --request JSON; keys override matching flags. */
let requestDoc = null;

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

function hasFlag(name) {
  return process.argv.includes(name);
}

function reqString(key, cliFlag, fallback = '') {
  return stringFromRequestOrFlag(requestDoc, key, arg(cliFlag, ''), fallback);
}

function reqRawJson(key, cliFlag) {
  return rawJsonFromRequestOrFlag(requestDoc, key, arg(cliFlag, ''));
}

/** Top-level summary (FR-008: keep this; use help <verb> for one screen). */
function usage() {
  const text = `priority-wcf (SaaS Web SDK client)

Object kinds: table, form, report, procedure, interface.

  probe   --instance <id> [--with-token]
  session --instance <id> [--form <ENAME>]
  whoami  --instance <id>
  companies --instance <id>  (see: help companies)
  form start|rows|set|save|subform|columns|new|delete|action  (see: help form)
  prepare form|procedure|report --instance <id> --name <ENAME>  (see: help prepare)
  proc start --instance <id> --name <ENAME> [--ptype P|R]  (see: help proc)
  table   (see: help table)
  interface (see: help interface)
  report  (see: help report)
  Any verb: --request <path>  UTF-8 JSON; keys fields|filter|inputs|name|form|subform override flags
  --dry-run               resolve instance + verb; print instanceId, verb, write; no login
  --confirm-errors        auto-dismiss SDK error dialogs (default: leave them for the agent)
  help
  help <verb>   form|prepare|proc|table|interface|report|companies

Env:
  PRIORITY_SAAS_WCF_INSTANCES  allowlist JSON (default %USERPROFILE%\\.priority-saas-wcf\\instances.json)
  PRIORITY_SAAS_TOKEN          Bearer access_token (else instance.tokenFile)
  PRIORITY_SAAS_ODATA_PAT      optional PAT for SaaS prep gate OData re-read (instance.odataBase)

CAST IRON: never invent host/tenant/company; never log tokens.
OIDC first: skill priority-saas-oidc-login -> token file -> this client.
Prepare success on SaaS requires an independent gate (OData when odataBase set);
without it walkOk may be true but preparedClaim stays false.
Request files stay outside the repo (temp / profile); never commit them.
`;
  process.stdout.write(text);
  process.exitCode = 0;
}

const HELP_TOPICS = {
  companies: `help companies

  companies --instance <id>

Read-only JSON {companies:[{name,title}]}. Does not require allowLive.
Does not switch the session company. Never log tokens.
`,
  form: `help form

Form verbs (one screen):

  form columns --instance <id> --form <ENAME>
  form rows    --instance <id> --form <ENAME> [--from <n>] [--filter ...]
  form new     --instance <id> --form <ENAME> --fields '{...}'
  form delete  --instance <id> --form <ENAME> --filter ... --confirm
  form action  --instance <id> --form <ENAME> --name <ACT> [--filter ...]
  form start   --instance <id> --form <ENAME>
  form set     --instance <id> --form <ENAME> --fields '{...}' [--filter ...]
  form save    --instance <id> --form <ENAME> --fields '{...}' [--filter ...]
  form subform --instance <id> --form <PARENT> --subform <CHILD> [--rows]
  form subform --instance <id> --form <PARENT> --subform <CHILD> --set --fields-file <path>

Writes need allowLive: true. Never invent ENAME. Never log tokens.
`,
  prepare: `help prepare

  prepare form      --instance <id> --name <ENAME> [--proc FORMPREPDRCT2] [--no-gate]
  prepare procedure --instance <id> --name <ENAME> [--proc REPPREPDIRECT2] [--no-gate]
  prepare report    --instance <id> --name <ENAME> [--proc REPPREPDIRECT2] [--no-gate]

Prepare is a write (allowLive: true). preparedClaim needs the OData gate when odataBase is set.
`,
  proc: `help proc

  proc start --instance <id> --name <ENAME> [--ptype P|R]

P = procedure, R = report. Does not prepare; use help prepare for prep verbs.
`,
  table: `help table

  table exists --instance <id> --name <TNAME>
  table columns --instance <id> --name <TNAME>
  table create  --instance <id> --name <TNAME>  (refuses without SQL profile)

Dictionary reads only until create is allowlisted. Never invent host/tenant.
`,
  interface: `help interface

  interface list   --instance <id>
  interface run    --instance <id> --name <ENAME> --inputs <file>
  interface map    --instance <id> --name <ENAME> ...

Prepare-interface refuses until config/interface-prep.json pins a proc name.
`,
  report: `help report

  report run --instance <id> --name <ENAME>
    (same as: proc start --ptype R --name <ENAME>)

  prepare report --instance <id> --name <ENAME>

Empty report output is empty, not a failure. See also: help proc, help prepare.
`,
};

function helpTopic(topic) {
  const key = String(topic || '').toLowerCase();
  if (!key) {
    usage();
    return;
  }
  const text = HELP_TOPICS[key];
  if (!text) {
    return fail('unknown_help_topic', {
      topic: key,
      need: Object.keys(HELP_TOPICS).join('|'),
    });
  }
  process.stdout.write(text);
  process.exitCode = 0;
}

function parseFilter(raw) {
  if (!raw) return null;
  const f = JSON.parse(raw);
  if (f.QueryValues) return f;
  return {
    or: 0,
    QueryValues: [
      {
        field: f.field,
        fromval: f.fromval ?? f.value ?? '',
        toval: f.toval ?? '',
        op: f.op || '=',
        sort: f.sort ?? 0,
        isdesc: f.isdesc ?? 0,
      },
    ],
  };
}

async function resolveInstance() {
  const instancesPath = arg('--instances', defaultInstancesPath());
  const allow = readAllowlist(instancesPath);
  return selectInstance(allow, arg('--instance'));
}

async function withSession(fn, { write = false, needToken = true } = {}) {
  const picked = await resolveInstance();
  if (!picked.ok) return fail(picked.reason, picked);
  const instance = picked.instance;
  const live = refuseLiveWrite(instance, { write });
  if (live) return fail(live.reason, live);

  let accessToken = '';
  let tokenSource = 'none';
  if (needToken) {
    const tok = loadAccessToken(instance);
    if (!tok.ok) return fail(tok.reason, { path: tok.path, message: tok.message });
    accessToken = tok.accessToken;
    tokenSource = tok.source;
  }

  const outDir = arg('--out', '');
  if (outDir) fs.mkdirSync(outDir, { recursive: true });
  const dump = (name, obj) => {
    if (!outDir) return;
    fs.writeFileSync(path.join(outDir, name), JSON.stringify(redact(obj), null, 2));
  };

  const session = await loginSession(instance, accessToken);
  if (!session.ok) {
    dump('login-error.json', session);
    return fail(session.reason, session);
  }
  dump('session.json', {
    ok: true,
    instanceId: instance.id,
    company: instance.company,
    tabulaini: session.tabulaini,
    tokenSource,
  });

  try {
    return await fn({ instance, session, dump, tokenSource, accessToken });
  } finally {
    await logout(session.priority);
  }
}

async function cmdProbe() {
  const picked = await resolveInstance();
  if (!picked.ok) return fail(picked.reason, picked);
  const instance = picked.instance;
  let accessToken = '';
  if (hasFlag('--with-token')) {
    const tok = loadAccessToken(instance);
    if (!tok.ok) return fail(tok.reason, { path: tok.path, message: tok.message });
    accessToken = tok.accessToken;
  }
  const result = await probeTenant(instance, { accessToken });
  if (!result.ok) return fail(result.reason, result);
  return ok({
    action: 'probe',
    instanceId: instance.id,
    host: instance.host,
    tenant: instance.tenant,
    wcf: result.wcf,
    tabulaini: result.tabulaini,
    authority: result.authority,
    server: result.server,
    httpStatus: result.httpStatus,
  });
}

async function cmdWhoami() {
  return withSession(async ({ instance, session }) => {
    const r = await resolveWhoami({ instance, session });
    if (!r.ok) {
      // FR #383: unidentified Priority user is exit 3 (not OS username fallback).
      return fail(r.reason || 'user_unidentified', {
        action: 'whoami',
        instanceId: instance.id,
        detail: r.detail,
        message: r.message,
      }, 3);
    }
    // FR #383 contract: { ok, userLogin, source } only (no token fields).
    return ok({ userLogin: r.userLogin, source: r.source });
  });
}

async function cmdCompanies() {
  return withSession(async ({ instance, session }) => {
    const r = await listCompanies({ instance, session });
    if (!r.ok) return fail(r.reason || 'companies_failed', r);
    return ok({
      action: 'companies',
      instanceId: instance.id,
      companies: r.companies,
      switched: false,
    });
  });
}

async function cmdSession() {
  const formName = reqString('form', '--form', '');
  return withSession(async ({ instance, session }) => {
    const messages = [];
    let formSmoke = null;
    if (formName) {
      let form;
      try {
        form = await formStart(session.priority, formName, instance.company, { messages });
        const got = await formGetRows(form, 1);
        formSmoke = { form: formName, columns: form.columns ? Object.keys(form.columns) : [], ...got };
        await safeEnd(form);
      } catch (e) {
        return fail('form_smoke_failed', {
          action: 'session',
          instanceId: instance.id,
          form: formName,
          message: String(e.message || e),
          messages,
          tabulaini: session.tabulaini,
        });
      }
    }
    return ok({
      action: 'session',
      instanceId: instance.id,
      company: instance.company,
      url: instance.url,
      tabulaini: session.tabulaini,
      tabulainiSource: session.tabulainiSource,
      formSmoke,
      messages,
    });
  });
}

async function openFilteredForm(session, instance, formName, filterRaw, messages) {
  const form = await formStart(session.priority, formName, instance.company, { messages });
  const filter = parseFilter(filterRaw);
  if (filter) {
    await form.setSearchFilter(filter);
  }
  return form;
}

async function cmdForm(sub) {
  const formName = reqString('form', '--form');
  if (!formName) return fail('form_required', { need: '--form <ENAME> or request.form' });
  const write = sub === 'set' || sub === 'save' || (sub === 'subform' && hasFlag('--set'));
  return withSession(
    async ({ instance, session, dump }) => {
      const messages = [];
      let form;
      try {
        if (sub === 'subform') {
          const childName = reqString('subform', '--subform');
          if (!childName) return fail('subform_required', { need: '--subform <ENAME> or request.subform' });

          // FR #400: --set writes the child via fields-file (allowLive gated by write flag).
          if (hasFlag('--set')) {
            const fieldsPath = arg('--fields-file', '');
            let fields = {};
            if (fieldsPath) {
              const loaded = loadFieldsFile(fieldsPath);
              if (!loaded.ok) {
                return fail(loaded.reason || 'fields_file_invalid', loaded);
              }
              fields = loaded.fields;
            } else {
              fields = fieldsFromRequestOrFlag(requestDoc, arg('--fields', '{}'));
            }
            if (Object.keys(fields).length < 1) {
              return fail('fields_required', {
                need: '--fields-file <path> or --fields JSON / request.fields',
              });
            }
            form = await formStart(session.priority, formName, instance.company, { messages });
            const { child, set } = await formSubformSetFields(form, childName, fields, { messages });
            dump('subform-set.json', {
              parent: formName,
              child: childName,
              fields: Object.keys(fields),
              set,
              messages,
            });
            await safeEnd(child);
            await safeEnd(form);
            return ok({
              action: 'form.subform.set',
              instanceId: instance.id,
              parent: formName,
              subform: childName,
              fields: Object.keys(fields),
              set,
              messages,
            });
          }

          form = await formStart(session.priority, formName, instance.company, { messages });
          const child = await formStartSubForm(form, childName, { messages });
          let rows = null;
          if (hasFlag('--rows')) rows = await formGetRows(child, Number(arg('--from', '1')) || 1);
          dump('subform.json', { parent: formName, child: childName, rows, messages });
          await safeEnd(child);
          await safeEnd(form);
          return ok({
            action: 'form.subform',
            instanceId: instance.id,
            parent: formName,
            subform: childName,
            rows,
            messages,
          });
        }

        const filterRaw = reqRawJson('filter', '--filter');

        if (sub === 'rows') {
          form = await formStart(session.priority, formName, instance.company, { messages });
          const filter = parseFilter(filterRaw);
          const fromRow = Number(arg('--from', '1')) || 1;
          const got = await applySearchThenGetRows(form, filter, { fromRow });
          dump('form-rows.json', { form: formName, ...got, messages });
          await safeEnd(form);
          const { searchCalls, ...rowsOut } = got;
          return ok({
            action: 'form.rows',
            instanceId: instance.id,
            form: formName,
            searchCalls,
            ...rowsOut,
            messages,
          });
        }

        form = await openFilteredForm(session, instance, formName, filterRaw, messages);

        if (sub === 'start') {
          const cols = form.columns ? Object.keys(form.columns) : [];
          dump('form-start.json', { form: formName, columns: cols, messages });
          await safeEnd(form);
          return ok({ action: 'form.start', instanceId: instance.id, form: formName, columns: cols, messages });
        }

        if (sub === 'set' || sub === 'save') {
          const fields = fieldsFromRequestOrFlag(requestDoc, arg('--fields', '{}'));
          if (Object.keys(fields).length < 1) {
            await safeEnd(form);
            return fail('fields_required', { need: '--fields JSON object or request.fields' });
          }
          const got = await formGetRows(form, 1);
          if (got.count < 1 && filterRaw) {
            await safeEnd(form);
            return fail('no_rows_for_filter', { form: formName, filter: filterRaw });
          }
          if (got.count >= 1 && typeof form.setActiveRow === 'function') {
            await form.setActiveRow(Number(got.rows[0]._idx));
          }
          const set = await formSetFields(form, fields);
          let saved = null;
          if (sub === 'save') saved = await formSave(form);
          dump('form-edit.json', { form: formName, fields: Object.keys(fields), set, saved, messages });
          await safeEnd(form);
          return ok({
            action: sub === 'save' ? 'form.save' : 'form.set',
            instanceId: instance.id,
            form: formName,
            fields: Object.keys(fields),
            set,
            saved,
            messages,
          });
        }

        await safeEnd(form);
        return fail('form_sub_unknown', { sub });
      } catch (e) {
        dump('form-error.json', { message: String(e.message || e), messages });
        try {
          await safeEnd(form);
        } catch {
          /* ignore */
        }
        return fail('form_failed', {
          action: `form.${sub}`,
          form: formName,
          message: String(e.message || e),
          messages,
        });
      }
    },
    { write },
  );
}

async function cmdPrepare(kind) {
  const name =
    reqString('name', '--name') || reqString('form', '--form') || arg('--form');
  if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
  const k = String(kind || '').toLowerCase();
  if (!['form', 'procedure', 'report'].includes(k)) {
    return fail('prepare_kind_required', { need: 'prepare form|procedure|report', got: kind });
  }
  // Prepare mutates dictionary compile state — treat as write.
  return withSession(
    async ({ instance, session, dump, tokenSource, accessToken }) => {
      const result = await runPrepare(session, instance, k, name, {
        proc: arg('--proc') || undefined,
        gate: !hasFlag('--no-gate'),
        accessToken: accessToken || '',
        messages: [],
      });
      dump('prepare.json', result);
      if (!result.walkOk) {
        return fail('prepare_walk_failed', {
          action: 'prepare.' + k,
          instanceId: instance.id,
          tokenSource,
          ...result,
        });
      }
      if (!result.preparedClaim && !hasFlag('--no-gate')) {
        return fail('prepare_gate_failed', {
          action: 'prepare.' + k,
          instanceId: instance.id,
          tokenSource,
          ...result,
        });
      }
      return ok({
        action: 'prepare.' + k,
        instanceId: instance.id,
        tokenSource,
        ...result,
      });
    },
    { write: true },
  );
}

async function cmdProc(sub) {
  if (sub !== 'start') {
    return fail('proc_sub_required', { need: 'start', got: sub });
  }
  const name = reqString('name', '--name') || arg('--proc');
  if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
  return withSession(
    async ({ instance, session, dump, tokenSource }) => {
      const result = await runProcStart(session, instance, name, {
        ptype: arg('--ptype', 'P'),
        nameHint: arg('--hint', ''),
      });
      dump('proc.json', result);
      if (!result.ok) {
        return fail(result.reason || 'proc_failed', {
          action: 'proc.start',
          instanceId: instance.id,
          tokenSource,
          ...result,
        });
      }
      return ok({
        action: 'proc.start',
        instanceId: instance.id,
        tokenSource,
        ...result,
      });
    },
    { write: hasFlag('--write') },
  );
}

async function main() {
  setConfirmErrors(hasFlag('--confirm-errors'));
  const verb = (process.argv[2] || 'help').toLowerCase();
  if (verb === 'help' || verb === '-h' || verb === '--help') {
    const topic = (process.argv[3] || '').toLowerCase();
    if (topic) return helpTopic(topic);
    return usage();
  }

  // FR #389: load --request before any verb that may login.
  const requestPath = arg('--request', '');
  if (requestPath) {
    const loaded = loadRequestFile(requestPath);
    if (!loaded.ok) return fail(loaded.reason || 'request_invalid', loaded, 2);
    requestDoc = loaded.doc;
  }

  // FR #391: resolve instance + verb without login.
  if (hasFlag('--dry-run')) {
    const plan = planDryRun(process.argv);
    if (!plan.ok) return fail(plan.reason, plan);
    return ok({
      instanceId: plan.instanceId,
      verb: plan.verb,
      write: plan.write,
    });
  }

  if (verb === 'probe') return cmdProbe();
  if (verb === 'session') return cmdSession();
  if (verb === 'whoami') return cmdWhoami();
  if (verb === 'companies') return cmdCompanies();
  if (verb === 'form') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('form_sub_required', { need: 'start|rows|set|save|subform' });
    return cmdForm(sub);
  }
  if (verb === 'prepare') {
    const kind = (process.argv[3] || '').toLowerCase();
    if (!kind) return fail('prepare_kind_required', { need: 'form|procedure|report' });
    return cmdPrepare(kind);
  }
  if (verb === 'proc') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('proc_sub_required', { need: 'start' });
    return cmdProc(sub);
  }
  return fail('unknown_verb', {
    verb,
    hint: 'probe|session|whoami|companies|form|prepare|proc|help',
  });
}

main().catch((e) => {
  fail('crash', { message: String(e.message || e) });
});
