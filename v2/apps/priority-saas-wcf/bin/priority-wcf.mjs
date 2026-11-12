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
import { resolveAccessToken } from '../lib/token.mjs';
import { probeTenant } from '../lib/probe.mjs';
import { loginSession, logout, safeEnd, setConfirmErrors } from '../lib/session.mjs';
import {
  formStart,
  formGetRows,
  formSetFields,
  formSave,
  formStartSubForm,
  formColumnsMeta,
  formSubformSetFields,
  applySearchThenGetRows,
  formRunAction,
} from '../lib/form.mjs';
import { runPrepare } from '../lib/prepare.mjs';
import { runProcStart, runProcContinue } from '../lib/proc.mjs';
import { loadProcTextFile, writeProcTextViaExecForm, readProcTextViaExecForm } from '../lib/proc-text.mjs';
import { loadInputsFile } from '../lib/inputs-file.mjs';
import {
  defaultInterfacePrepPath,
  loadInterfacePrepConfig,
} from '../lib/interface-prep.mjs';
import { resolveWhoami } from '../lib/whoami.mjs';
import { listCompanies } from '../lib/companies.mjs';
import { listInterfaces } from '../lib/interface-list.mjs';
import { setInterfaceMap } from '../lib/interface-map.mjs';
import {
  addTableColumn,
  columnsFromCreateRequest,
  createTable,
  fetchTableColumns,
  fetchTableExists,
  instanceHasSqlProfile,
} from '../lib/table.mjs';
import { checkDictionaryTitle } from '../lib/title-check.mjs';
import { emit, fail, ok, redact } from '../lib/json-out.mjs';
import { planDryRun } from '../lib/dry-run.mjs';
import { validateBatchRequest } from '../lib/batch.mjs';
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
/** FR #403: --inputs JSON map for proc start only. */
let procInputValues = null;

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
  prepare form|procedure|report|interface --instance <id> --name <ENAME>  (see: help prepare)
  proc start|continue --instance <id>  (see: help proc)
  table exists --instance <id> --name <TNAME>  (see: help table)
  table columns --instance <id> --name <TNAME>  (see: help table)
  table column add --instance <id> --name <TNAME> --column <COL> --type <T> --title <title>  (see: help table)
  interface (see: help interface)
  report run --instance <id> --name <ENAME>  (see: help report)
  batch --request <file> --instance <id>  (see: help batch)
  Any verb: --request <path>  UTF-8 JSON; keys fields|filter|inputs|name|form|subform override flags
  --dry-run               resolve instance + verb; print instanceId, verb, write; no login
  --confirm-errors        auto-dismiss SDK error dialogs (default: leave them for the agent)
  help
  help <verb>   form|prepare|proc|table|interface|report|companies|batch

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
  batch: `help batch

  batch --request <file> --instance <id>

  Request JSON: { "reads": [ { "verb": "whoami" }, ... ] }
  Allowed: whoami, form columns, form rows, table columns, table exists,
  companies, proc text, interface list.
  Maximum 8 reads. A 9th or any write verb (for example form new) exits 2
  before login (batch_too_many / batch_write_refused).
  One login for the whole file. Writes stay single-verb.
`,
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
  prepare interface --instance <id> --name <ENAME> [--no-gate]

Prepare is a write (allowLive: true). preparedClaim needs the OData gate when odataBase is set.
prepare interface reads config/interface-prep.json; empty/missing proc => interface_prep_unknown (no login).
`,
  proc: `help proc

  proc start    --instance <id> --name <ENAME> [--ptype P|R] [--inputs <file>] [--hint <ename>]
  proc continue --instance <id> --from <step.json> --option <field> [--inputs <file>]
  proc text     --instance <id> --name <ENAME>
  proc text set --instance <id> --name <ENAME> --file <path>

proc text is read-only (EXEC TEXT); allowLive not required. Missing/empty body -> proc_text_missing exit 2.
Continue answers a needs_input snapshot. Missing --from exits 2 before login. Does not auto-pick.
proc text set writes --file through the EXEC form (allowLive). Does not prepare.
`,
  table: `help table

  table exists --instance <id> --name <TNAME>
  table columns --instance <id> --name <TNAME>
  table column add --instance <id> --name <TNAME> --column <COL> --type <T> --title <title>
  table create --instance <id> --name <TNAME> --request <file>

Column add and table create need allowLive and sqlProfile. No sqlProfile is table_ddl_needs_sql before login.
Request JSON lists columns (name/type/title). Never a raw CREATE. Title longer than 20 is title_too_long before login.
Never invent host/tenant.
`,
  interface: `help interface

  interface list   --instance <id>
  interface run    --instance <id> --name <ENAME> --inputs <file>
  interface map set --instance <id> --name <ENAME> --fields-file <path>

interface list is a read of the EXEC catalog: {interfaces:[{name,title}]}.
interface run uses the proc walker (FR-21/FR-22): ended or needs_input. ptype I. Map is FR-37.
interface map set writes one FORMINTERFACES row (allowLive). Does not prepare (FR-29).
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
    const tok = await resolveAccessToken(instance);
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

async function executeBatchRead({ instance, session, dump, tokenSource, accessToken }, read) {
  if (read.verb === 'whoami') {
    const r = await resolveWhoami({ instance, session });
    if (!r.ok) return { ok: false, reason: r.reason || 'user_unidentified', read };
    return { ok: true, result: { action: 'whoami', userLogin: r.userLogin, source: r.source } };
  }
  if (read.verb === 'companies') {
    const r = await listCompanies({ instance, session });
    if (!r.ok) return { ok: false, reason: r.reason || 'companies_failed', read };
    return {
      ok: true,
      result: { action: 'companies', companies: r.companies, switched: false },
    };
  }
  if (read.verb === 'interface.list') {
    const r = await listInterfaces({ instance, session });
    if (!r.ok) return { ok: false, reason: r.reason || 'interface_list_failed', read };
    return { ok: true, result: { action: 'interface.list', interfaces: r.interfaces } };
  }
  if (read.verb === 'form.columns') {
    const messages = [];
    const form = await formStart(session.priority, read.form, instance.company, { messages });
    const columns = formColumnsMeta(form);
    await safeEnd(form);
    return {
      ok: true,
      result: { action: 'form.columns', form: read.form, columns, messages },
    };
  }
  if (read.verb === 'form.rows') {
    const messages = [];
    const form = await formStart(session.priority, read.form, instance.company, { messages });
    const got = await applySearchThenGetRows(form, null, { fromRow: 1 });
    await safeEnd(form);
    const { searchCalls, ...rowsOut } = got;
    return {
      ok: true,
      result: { action: 'form.rows', form: read.form, searchCalls, ...rowsOut, messages },
    };
  }
  if (read.verb === 'table.exists') {
    const result = await fetchTableExists(instance, read.name, { accessToken });
    if (!result.ok) return { ok: false, reason: result.reason, read };
    return {
      ok: true,
      result: { action: 'table.exists', name: result.name, exists: result.exists },
    };
  }
  if (read.verb === 'table.columns') {
    const result = await fetchTableColumns(instance, read.name, { accessToken });
    if (!result.ok) return { ok: false, reason: result.reason, read };
    return {
      ok: true,
      result: {
        action: 'table.columns',
        table: read.name,
        exists: result.exists,
        columns: result.columns,
      },
    };
  }
  if (read.verb === 'proc.text') {
    const messages = [];
    const result = await readProcTextViaExecForm(session, instance, read.name, { messages });
    if (!result.ok) return { ok: false, reason: result.reason || 'proc_text_missing', read };
    return {
      ok: true,
      result: { action: 'proc.text', name: result.name, body: result.body, tokenSource },
    };
  }
  dump('batch-unknown.json', read);
  return { ok: false, reason: 'batch_write_refused', read };
}

async function cmdBatch() {
  const requestPath = arg('--request', '');
  if (!requestPath) {
    return fail('request_invalid', { need: '--request <file> with reads[]' }, 2);
  }
  const loaded = requestDoc
    ? { ok: true, doc: requestDoc }
    : loadRequestFile(requestPath);
  if (!loaded.ok) return fail(loaded.reason || 'request_invalid', loaded, 2);
  const v = validateBatchRequest(loaded.doc);
  if (!v.ok) return fail(v.reason, v, 2);
  return withSession(async (ctx) => {
    const results = [];
    for (const read of v.reads) {
      const one = await executeBatchRead(ctx, read);
      if (!one.ok) {
        return fail(one.reason || 'batch_read_failed', { verb: read.verb, ...one });
      }
      results.push(one.result);
    }
    return ok({ action: 'batch', results, loginCount: 1 });
  });
}

async function cmdProbe() {
  const picked = await resolveInstance();
  if (!picked.ok) return fail(picked.reason, picked);
  const instance = picked.instance;
  let accessToken = '';
  if (hasFlag('--with-token')) {
    const tok = await resolveAccessToken(instance);
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

async function cmdInterface(sub) {
  if (sub === 'run') {
    const name = reqString('name', '--name') || arg('--proc');
    if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
    return withSession(
      async ({ instance, session, dump, tokenSource }) => {
        const result = await runProcStart(session, instance, name, {
          ptype: 'I',
          nameHint: arg('--hint', ''),
          inputValues: procInputValues,
          onNeedsInput: (snap) => dump('needs-input.json', snap),
        });
        dump('interface.json', result);
        if (result.reason === 'needs_input') {
          dump('needs-input.json', result.snapshot || { options: result.options });
          return fail('needs_input', {
            action: 'interface.run',
            instanceId: instance.id,
            options: result.options,
            urls: result.urls || [],
          });
        }
        if (!result.ok) {
          return fail(result.reason || 'interface_run_failed', {
            action: 'interface.run',
            instanceId: instance.id,
            tokenSource,
            ...result,
          });
        }
        return ok({
          instanceId: instance.id,
          tokenSource,
          ...result,
          action: 'interface.run',
          ptype: 'I',
        });
      },
      { write: true },
    );
  }
  if (sub === 'map') {
    const op = String(process.argv[4] || '').toLowerCase();
    if (op !== 'set') {
      return fail('interface_map_sub_required', { need: 'set', got: op });
    }
    const name = reqString('name', '--name');
    if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
    const fieldsPath = arg('--fields-file', '');
    const loaded = loadFieldsFile(fieldsPath);
    if (!loaded.ok) {
      return fail(loaded.reason || 'fields_file_invalid', loaded, 2);
    }
    if (Object.keys(loaded.fields).length < 1) {
      return fail('fields_required', { need: '--fields-file JSON object' }, 2);
    }
    return withSession(
      async ({ instance, session }) => {
        const result = await setInterfaceMap(session, instance, {
          name,
          fields: loaded.fields,
        });
        if (!result.ok) return fail(result.reason, result);
        return ok({
          action: 'interface.map.set',
          instanceId: instance.id,
          ...result,
        });
      },
      { write: true },
    );
  }
  if (sub !== 'list') {
    return fail('interface_sub_required', { need: 'list|run|map set', got: sub });
  }
  return withSession(async ({ instance, session }) => {
    const r = await listInterfaces({ instance, session });
    if (!r.ok) return fail(r.reason || 'interface_list_failed', r);
    return ok({
      action: 'interface.list',
      instanceId: instance.id,
      interfaces: r.interfaces,
    });
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
  const write = sub === 'set' || sub === 'save' || sub === 'action' || (sub === 'subform' && hasFlag('--set'));
  return withSession(
    async ({ instance, session, dump }) => {
      const messages = [];
      let form;
      try {
        if (sub === 'action') {
          const activation = reqString('name', '--name') || arg('--activation', '');
          if (!activation) {
            return fail('activation_required', { need: '--name <activation> or request.name' });
          }
          const filterRaw = reqRawJson('filter', '--filter');
          form = await openFilteredForm(session, instance, formName, filterRaw, messages);
          if (filterRaw) {
            const got = await formGetRows(form, 1);
            if (got.count < 1) {
              await safeEnd(form);
              return fail('no_rows_for_filter', { form: formName, filter: filterRaw });
            }
            if (typeof form.setActiveRow === 'function') {
              await form.setActiveRow(Number(got.rows[0]._idx));
            }
          }
          const ran = await formRunAction(form, activation);
          dump('form-action.json', { form: formName, activation, ran, messages });
          await safeEnd(form);
          if (!ran.ok) return fail(ran.reason || 'form_action_failed', { form: formName, ...ran, messages });
          return ok({
            action: 'form.action',
            instanceId: instance.id,
            form: formName,
            activation: ran.activation,
            via: ran.via,
            messages,
          });
        }

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

        // FR #395: columns from form.columns only — no getRows / no filter.
        if (sub === 'columns') {
          form = await formStart(session.priority, formName, instance.company, { messages });
          const columns = formColumnsMeta(form);
          dump('form-columns.json', { form: formName, columns, messages });
          await safeEnd(form);
          return ok({
            action: 'form.columns',
            instanceId: instance.id,
            form: formName,
            columns,
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
  if (!['form', 'procedure', 'report', 'interface'].includes(k)) {
    return fail('prepare_kind_required', {
      need: 'prepare form|procedure|report|interface',
      got: kind,
    });
  }

  // FR #411 / FR-029: pin interface prep proc from config before any login.
  let interfaceProc;
  if (k === 'interface') {
    const prepPath =
      arg('--interface-prep', '') || defaultInterfacePrepPath(ROOT);
    const pinned = loadInterfacePrepConfig(prepPath);
    if (!pinned.ok) {
      return fail(pinned.reason || 'interface_prep_unknown', {
        action: 'prepare.interface',
        path: pinned.path,
        detail: pinned.detail,
        name,
      }, 2);
    }
    interfaceProc = pinned.proc;
  }

  // Prepare mutates dictionary compile state — treat as write.
  return withSession(
    async ({ instance, session, dump, tokenSource, accessToken }) => {
      const result = await runPrepare(session, instance, k, name, {
        proc: k === 'interface' ? interfaceProc : (arg('--proc') || undefined),
        gate: !hasFlag('--no-gate'),
        accessToken: accessToken || '',
        messages: [],
        onNeedsInput: (snap) => dump('needs-input.json', snap),
      });
      dump('prepare.json', result);
      if (result.reason === 'needs_input') {
        dump('needs-input.json', result.snapshot || { options: result.options });
        return fail('needs_input', {
          action: 'prepare.' + k,
          instanceId: instance.id,
          options: result.options,
        });
      }
      if (result.reason === 'interface_prep_unknown') {
        return fail('interface_prep_unknown', {
          action: 'prepare.' + k,
          instanceId: instance.id,
          ...result,
        }, 2);
      }
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

function loadFromStepFile(filePath) {
  const p = String(filePath || '').trim();
  if (!p) return { ok: false, reason: 'from_required' };
  let text;
  try {
    text = fs.readFileSync(p, 'utf8');
  } catch {
    return { ok: false, reason: 'from_required', path: p, detail: 'read_failed' };
  }
  if (text.charCodeAt(0) === 0xfeff) text = text.slice(1);
  try {
    const doc = JSON.parse(text);
    if (!doc || typeof doc !== 'object' || Array.isArray(doc)) {
      return { ok: false, reason: 'from_required', path: p, detail: 'not_object' };
    }
    return { ok: true, fromSnap: doc, path: p };
  } catch {
    return { ok: false, reason: 'from_required', path: p, detail: 'json_parse' };
  }
}


async function cmdProcTextRead() {
  const name = reqString('name', '--name') || arg('--proc');
  if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
  return withSession(
    async ({ instance, session, dump, tokenSource }) => {
      const messages = [];
      const result = await readProcTextViaExecForm(session, instance, name, { messages });
      dump('proc-text.json', { name, ok: result.ok, reason: result.reason, messages });
      if (!result.ok) {
        return fail(result.reason || 'proc_text_missing', {
          action: 'proc.text',
          instanceId: instance.id,
          tokenSource,
          name,
        }, 2);
      }
      return ok({
        action: 'proc.text',
        instanceId: instance.id,
        tokenSource,
        name: result.name,
        body: result.body,
      });
    },
    { write: false },
  );
}

async function cmdProcTextSet() {
  const name = reqString('name', '--name') || arg('--proc');
  if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
  const filePath = arg('--file', '');
  const loaded = loadProcTextFile(filePath);
  if (!loaded.ok) {
    return fail(loaded.reason, { path: loaded.path, detail: loaded.detail }, 2);
  }
  return withSession(
    async ({ instance, session, dump, tokenSource }) => {
      const messages = [];
      const result = await writeProcTextViaExecForm(session, instance, name, loaded.body, {
        messages,
      });
      dump('proc-text-set.json', { name, set: result.set, messages });
      if (!result.ok) {
        return fail(result.reason || 'form_failed', {
          action: 'proc.text.set',
          instanceId: instance.id,
          tokenSource,
          name,
        });
      }
      return ok({
        action: 'proc.text.set',
        instanceId: instance.id,
        name,
        set: result.set,
        form: result.form,
        messages,
      });
    },
    { write: true },
  );
}

async function cmdProc(sub) {
  if (sub === 'text') {
    const mode = String(process.argv[4] || '').toLowerCase();
    if (mode === 'set') {
      return cmdProcTextSet();
    }
    if (mode && !mode.startsWith('-')) {
      return fail('proc_sub_required', {
        need: 'start|continue|text (read); text set (write FR-028)',
        got: 'text ' + mode,
      });
    }
    return cmdProcTextRead();
  }
  if (sub === 'continue') {
    const fromPath = arg('--from', '');
    if (!fromPath) {
      return fail('from_required', { need: '--from <step.json>' }, 2);
    }
    const loaded = loadFromStepFile(fromPath);
    if (!loaded.ok) return fail(loaded.reason, loaded, 2);
    const option = reqString('option', '--option');
    if (!option) return fail('option_required', { need: '--option <field>' }, 2);
    return withSession(
      async ({ instance, session, dump, tokenSource }) => {
        const result = await runProcContinue(session, instance, {
          fromSnap: loaded.fromSnap,
          option,
          ptype: arg('--ptype', 'P'),
          name: reqString('name', '--name') || arg('--proc'),
          nameHint: arg('--hint', ''),
          inputValues: procInputValues,
        });
        dump('proc.json', result);
        if (!result.ok) {
          return fail(result.reason || 'proc_continue_failed', {
            action: 'proc.continue',
            instanceId: instance.id,
            tokenSource,
            ...result,
          });
        }
        return ok({
          action: 'proc.continue',
          instanceId: instance.id,
          tokenSource,
          ...result,
        });
      },
      { write: true },
    );
  }
  if (sub !== 'start') {
    return fail('proc_sub_required', { need: 'start|continue|text|text set', got: sub });
  }
  const name = reqString('name', '--name') || arg('--proc');
  if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
  return withSession(
    async ({ instance, session, dump, tokenSource }) => {
      const result = await runProcStart(session, instance, name, {
        ptype: arg('--ptype', 'P'),
        nameHint: arg('--hint', ''),
        inputValues: procInputValues,
        onNeedsInput: (snap) => dump('needs-input.json', snap),
      });
      dump('proc.json', result);
      if (result.reason === 'needs_input') {
        dump('needs-input.json', result.snapshot || { options: result.options });
        return fail('needs_input', {
          action: 'proc.start',
          instanceId: instance.id,
          options: result.options,
        });
      }
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

async function cmdReport(sub) {
  if (sub !== 'run') {
    return fail('report_sub_required', { need: 'run', got: sub });
  }
  const name = reqString('name', '--name') || arg('--proc');
  if (!name) return fail('name_required', { need: '--name <ENAME> or request.name' });
  return withSession(
    async ({ instance, session, dump, tokenSource }) => {
      const result = await runProcStart(session, instance, name, {
        ptype: 'R',
        nameHint: arg('--hint', ''),
        inputValues: procInputValues,
        onNeedsInput: (snap) => dump('needs-input.json', snap),
      });
      dump('report.json', result);
      if (result.reason === 'needs_input') {
        dump('needs-input.json', result.snapshot || { options: result.options });
        return fail('needs_input', {
          action: 'report.run',
          instanceId: instance.id,
          options: result.options,
          urls: result.urls || [],
        });
      }
      if (!result.ok) {
        return fail(result.reason || 'report_failed', {
          action: 'report.run',
          instanceId: instance.id,
          tokenSource,
          ...result,
        });
      }
      return ok({
        instanceId: instance.id,
        tokenSource,
        ...result,
        action: 'report.run',
        ptype: 'R',
      });
    },
    { write: true },
  );
}

async function cmdTable(sub) {
  if (sub === 'exists') {
    const name = reqString('name', '--name');
    if (!name) return fail('name_required', { need: '--name <TNAME> or request.name' });
    const picked = await resolveInstance();
    if (!picked.ok) return fail(picked.reason, picked);
    const instance = picked.instance;
    let accessToken = '';
    const tok = await resolveAccessToken(instance);
    if (!tok.ok) return fail(tok.reason, { path: tok.path, message: tok.message });
    accessToken = tok.accessToken;
    const result = await fetchTableExists(instance, name, { accessToken });
    if (!result.ok) return fail(result.reason, result);
    return ok({
      action: 'table.exists',
      instanceId: instance.id,
      name: result.name,
      exists: result.exists,
    });
  }
  if (sub === 'create') {
    const name = reqString('name', '--name');
    if (!name) return fail('name_required', { need: '--name <TNAME> or request.name' });
    const cols = columnsFromCreateRequest(requestDoc);
    if (!cols.ok) {
      return fail(cols.reason, { need: '--request JSON with columns[]' }, 2);
    }
    const picked = await resolveInstance();
    if (!picked.ok) return fail(picked.reason, picked);
    if (!instanceHasSqlProfile(picked.instance)) {
      return fail('table_ddl_needs_sql', { instanceId: picked.instance.id, need: 'sqlProfile' }, 2);
    }
    return withSession(
      async ({ instance, session }) => {
        const result = await createTable(session, instance, {
          table: name,
          columns: cols.columns,
        });
        if (!result.ok) return fail(result.reason, result);
        return ok({
          action: 'table.create',
          instanceId: instance.id,
          ...result,
        });
      },
      { write: true },
    );
  }
  if (sub === 'columns') {
    const name = reqString('name', '--name');
    if (!name) return fail('name_required', { need: '--name <TNAME> or request.name' });
    const picked = await resolveInstance();
    if (!picked.ok) return fail(picked.reason, picked);
    const instance = picked.instance;
    let accessToken = '';
    const tok = await resolveAccessToken(instance);
    if (!tok.ok) return fail(tok.reason, { path: tok.path, message: tok.message });
    accessToken = tok.accessToken;
    const result = await fetchTableColumns(instance, name, { accessToken });
    if (!result.ok) return fail(result.reason, result);
    return ok({
      action: 'table.columns',
      instanceId: instance.id,
      table: name,
      exists: result.exists,
      columns: result.columns,
    });
  }
  if (sub !== 'column') {
    return fail('table_sub_required', { need: 'exists|columns|column add|create', got: sub });
  }
  const op = (process.argv[4] || '').toLowerCase();
  if (op !== 'add') {
    return fail('table_column_sub_required', { need: 'add', got: op });
  }
  const title = reqString('title', '--title');
  const titleCheck = checkDictionaryTitle(title);
  if (!titleCheck.ok) return fail(titleCheck.reason, titleCheck, 2);
  const name = reqString('name', '--name');
  const column = reqString('column', '--column');
  const type = reqString('type', '--type');
  if (!name) return fail('name_required', { need: '--name <TNAME>' });
  if (!column) return fail('column_required', { need: '--column <COL>' });
  if (!type) return fail('type_required', { need: '--type <T>' });
  const picked = await resolveInstance();
  if (!picked.ok) return fail(picked.reason, picked);
  if (!instanceHasSqlProfile(picked.instance)) {
    return fail('table_ddl_needs_sql', { instanceId: picked.instance.id, need: 'sqlProfile' }, 2);
  }
  return withSession(
    async ({ instance, session }) => {
      const result = await addTableColumn(session, instance, {
        table: name,
        column,
        type,
        title,
      });
      if (!result.ok) return fail(result.reason, result);
      return ok({
        action: 'table.column.add',
        instanceId: instance.id,
        ...result,
      });
    },
    { write: true },
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

  // FR #403 / FR #418: --inputs JSON map for proc start/continue and interface run.
  const inputsPath = arg('--inputs', '');
  const procSub = verb === 'proc' ? (process.argv[3] || '').toLowerCase() : '';
  const ifaceSub = verb === 'interface' ? (process.argv[3] || '').toLowerCase() : '';
  if (
    inputsPath &&
    ((verb === 'proc' && (procSub === 'start' || procSub === 'continue')) ||
      (verb === 'interface' && ifaceSub === 'run'))
  ) {
    const loaded = loadInputsFile(inputsPath);
    if (!loaded.ok) {
      return fail(loaded.reason, { path: loaded.path, detail: loaded.detail }, 2);
    }
    procInputValues = loaded.inputValues;
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

  if (verb === 'batch') return cmdBatch();
  if (verb === 'probe') return cmdProbe();
  if (verb === 'session') return cmdSession();
  if (verb === 'whoami') return cmdWhoami();
  if (verb === 'companies') return cmdCompanies();
  if (verb === 'form') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('form_sub_required', { need: 'start|columns|rows|set|save|subform|action' });
    return cmdForm(sub);
  }
  if (verb === 'prepare') {
    const kind = (process.argv[3] || '').toLowerCase();
    if (!kind) {
      return fail('prepare_kind_required', { need: 'form|procedure|report|interface' });
    }
    return cmdPrepare(kind);
  }
  if (verb === 'proc') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('proc_sub_required', { need: 'start|continue|text' });
    return cmdProc(sub);
  }
  if (verb === 'report') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('report_sub_required', { need: 'run' });
    return cmdReport(sub);
  }
  if (verb === 'table') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('table_sub_required', { need: 'exists|columns|column|create' });
    return cmdTable(sub);
  }
  if (verb === 'interface') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('interface_sub_required', { need: 'list|run|map' });
    return cmdInterface(sub);
  }
  return fail('unknown_verb', {
    verb,
    hint: 'probe|session|whoami|companies|form|prepare|proc|report|table|interface|batch|help',
  });
}

main().catch((e) => {
  fail('crash', { message: String(e.message || e) });
});
