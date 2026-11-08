#!/usr/bin/env node
/**
 * Priority SaaS WCF client (Phase 1).
 * Allowlist-gated; Bearer accessToken from PRIORITY_SAAS_TOKEN or tokenFile.
 * Usage: node bin/priority-wcf.mjs <verb> [args] --instance <id>
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { readAllowlist, selectInstance, refuseLiveWrite, defaultInstancesPath } from '../lib/allowlist.mjs';
import { loadAccessToken } from '../lib/token.mjs';
import { probeTenant } from '../lib/probe.mjs';
import { loginSession, logout, safeEnd } from '../lib/session.mjs';
import { formStart, formGetRows, formSetFields, formSave, formStartSubForm } from '../lib/form.mjs';
import { emit, fail, ok, redact } from '../lib/json-out.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

function hasFlag(name) {
  return process.argv.includes(name);
}

function usage() {
  const text = `priority-wcf (SaaS Web SDK client)

  probe   --instance <id> [--with-token]
  session --instance <id> [--form <ENAME>]
  form start   --instance <id> --form <ENAME>
  form rows    --instance <id> --form <ENAME> [--from <n>]
  form set     --instance <id> --form <ENAME> --fields '{"COL":"v"}' [--filter '{"field":"X","fromval":"y"}']
  form save    --instance <id> --form <ENAME> --fields '{...}' [--filter ...]
  form subform --instance <id> --form <PARENT> --subform <CHILD> [--rows]
  help

Env:
  PRIORITY_SAAS_WCF_INSTANCES  allowlist JSON (default %USERPROFILE%\\.priority-saas-wcf\\instances.json)
  PRIORITY_SAAS_TOKEN          Bearer access_token (else instance.tokenFile)

CAST IRON: never invent host/tenant/company; never log tokens.
OIDC first: skill priority-saas-oidc-login -> token file -> this client.
`;
  process.stdout.write(text);
  process.exitCode = 0;
}

function parseFieldsJson(raw) {
  if (!raw) return {};
  return JSON.parse(raw);
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
    return await fn({ instance, session, dump, tokenSource });
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

async function cmdSession() {
  const formName = arg('--form', '');
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
  const formName = arg('--form');
  if (!formName) return fail('form_required', { need: '--form <ENAME>' });
  const write = sub === 'set' || sub === 'save';
  return withSession(
    async ({ instance, session, dump }) => {
      const messages = [];
      let form;
      try {
        if (sub === 'subform') {
          const childName = arg('--subform');
          if (!childName) return fail('subform_required', { need: '--subform <ENAME>' });
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

        form = await openFilteredForm(session, instance, formName, arg('--filter'), messages);

        if (sub === 'start') {
          const cols = form.columns ? Object.keys(form.columns) : [];
          dump('form-start.json', { form: formName, columns: cols, messages });
          await safeEnd(form);
          return ok({ action: 'form.start', instanceId: instance.id, form: formName, columns: cols, messages });
        }

        if (sub === 'rows') {
          const got = await formGetRows(form, Number(arg('--from', '1')) || 1);
          dump('form-rows.json', { form: formName, ...got, messages });
          await safeEnd(form);
          return ok({ action: 'form.rows', instanceId: instance.id, form: formName, ...got, messages });
        }

        if (sub === 'set' || sub === 'save') {
          const fields = parseFieldsJson(arg('--fields', '{}'));
          if (Object.keys(fields).length < 1) {
            await safeEnd(form);
            return fail('fields_required', { need: '--fields JSON object' });
          }
          const got = await formGetRows(form, 1);
          if (got.count < 1 && arg('--filter')) {
            await safeEnd(form);
            return fail('no_rows_for_filter', { form: formName, filter: arg('--filter') });
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

async function main() {
  const verb = (process.argv[2] || 'help').toLowerCase();
  if (verb === 'help' || verb === '-h' || verb === '--help') return usage();
  if (verb === 'probe') return cmdProbe();
  if (verb === 'session') return cmdSession();
  if (verb === 'form') {
    const sub = (process.argv[3] || '').toLowerCase();
    if (!sub) return fail('form_sub_required', { need: 'start|rows|set|save|subform' });
    return cmdForm(sub);
  }
  if (verb === 'prepare' || verb === 'proc') {
    return fail('not_implemented', {
      verb,
      message: 'Phase 2: prepare form|procedure|report and proc start. Use form/session for now.',
      phase: 2,
    });
  }
  return fail('unknown_verb', { verb, hint: 'probe|session|form|help' });
}

main().catch((e) => {
  fail('crash', { message: String(e.message || e) });
});
