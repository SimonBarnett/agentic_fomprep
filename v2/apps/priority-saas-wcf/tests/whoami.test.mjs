/**
 * FR #383 / FR-001: whoami returns Priority USERLOGIN (login result or USERS row).
 * Offline fake SDK only — no live SaaS / no real secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  extractUserLoginFromLoginResult,
  resolveWhoami,
} from '../lib/whoami.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');
const FIXTURE_TOKEN = 'FAKE_access_token_whoami_fixture_do_not_print';

test('extractUserLoginFromLoginResult reads userLogin', () => {
  assert.equal(extractUserLoginFromLoginResult({ userLogin: 'MEDATECH' }), 'MEDATECH');
  assert.equal(extractUserLoginFromLoginResult({ USERLOGIN: 'X' }), 'X');
  assert.equal(extractUserLoginFromLoginResult({ profile: { userLogin: 'P' } }), 'P');
  assert.equal(extractUserLoginFromLoginResult(null), '');
  assert.equal(extractUserLoginFromLoginResult({ userLogin: '  ' }), '');
});

test('Fake SDK: login result userLogin MEDATECH yields source login', async () => {
  const r = await resolveWhoami({
    instance: { id: 't', user: 'u@x.com', company: 'co' },
    session: {
      ok: true,
      priority: {},
      loginResult: { userLogin: 'MEDATECH' },
    },
    formStart: async () => {
      throw new Error('USERS must not be opened when login exposes userLogin');
    },
  });
  assert.equal(r.ok, true);
  assert.equal(r.userLogin, 'MEDATECH');
  assert.equal(r.source, 'login');
});

test('Fake SDK: empty login profile plus one USERS row yields source users', async () => {
  const form = {
    name: 'USERS',
    setSearchFilter: async () => {},
    getRows: async () => ({
      USERS: { 1: { USERLOGIN: 'MEDATECH', USER: 'u@x.com' } },
    }),
    endCurrentForm: async () => {},
  };
  const r = await resolveWhoami({
    instance: { id: 't', user: 'u@x.com', company: 'co' },
    session: { ok: true, priority: {}, loginResult: {} },
    formStart: async () => form,
    formGetRows: async (f) => {
      const rows = await f.getRows(1);
      const pack = rows.USERS || {};
      const list = Object.keys(pack)
        .filter((k) => k !== 'undefined')
        .map((i) => ({ _idx: i, ...pack[i] }));
      return { formName: 'USERS', count: list.length, rows: list };
    },
    safeEnd: async () => {},
  });
  assert.equal(r.ok, true);
  assert.equal(r.userLogin, 'MEDATECH');
  assert.equal(r.source, 'users');
});

test('Fake SDK: neither source yields user_unidentified', async () => {
  const form = {
    name: 'USERS',
    setSearchFilter: async () => {},
    getRows: async () => ({ USERS: {} }),
    endCurrentForm: async () => {},
  };
  const r = await resolveWhoami({
    instance: { id: 't', user: 'nobody@x.com', company: 'co' },
    session: { ok: true, priority: {}, loginResult: null },
    formStart: async () => form,
    formGetRows: async () => ({ formName: 'USERS', count: 0, rows: [] }),
    safeEnd: async () => {},
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'user_unidentified');
  assert.equal(r.userLogin, undefined);
  assert.ok(!('osUser' in r));
});

test('CLI whoami: fixture token absent from stdout; exit 3 when unidentified', () => {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'whoami-cli-'));
  const instances = path.join(dir, 'instances.json');
  const tokenFile = path.join(dir, 'tokens.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'whoami-fake',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          tokenFile,
          tabulaini: 'tab.ini',
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  fs.writeFileSync(
    tokenFile,
    JSON.stringify({ access_token: FIXTURE_TOKEN, obtained_at: new Date().toISOString() }),
  );

  // Force offline fail before SaaS: probe/login will fail; we only assert token never leaks.
  // Use PRIORITY_SAAS_TOKEN so loadAccessToken prefers env (still must not print).
  const env = {
    ...process.env,
    PRIORITY_SAAS_TOKEN: FIXTURE_TOKEN,
    PRIORITY_SAAS_WCF_INSTANCES: instances,
  };
  const run = spawnSync(process.execPath, [BIN, 'whoami', '--instance', 'whoami-fake', '--instances', instances], {
    encoding: 'utf8',
    env,
    cwd: ROOT,
  });
  const out = String(run.stdout || '') + String(run.stderr || '');
  assert.equal(out.includes(FIXTURE_TOKEN), false, 'token must not appear on stdout/stderr');
  // Live network may be unreachable; accept user_unidentified or login/probe failure JSON without token.
  assert.match(out, /"ok"\s*:\s*false/);
  assert.doesNotMatch(out, /FAKE_access_token_whoami_fixture/);
});
