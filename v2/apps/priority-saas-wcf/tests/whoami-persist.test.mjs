/**
 * MRB #431 hostile: whoami must persist identified USERLOGIN, not allowlist email.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { resolveWhoami } from '../lib/whoami.mjs';
import { rememberWhoami, lastUserPath } from '../lib/last-user.mjs';

test('identify-then-persist: loginResult USERLOGIN written; allowlist email not written', async () => {
  const profile = fs.mkdtempSync(path.join(os.tmpdir(), 'whoami-persist-'));
  const allowlistEmail = 'u@x.com';
  const r = await resolveWhoami({
    instance: { id: 'saas1', user: allowlistEmail, company: 'DEMO' },
    session: {
      ok: true,
      priority: {},
      loginResult: { userLogin: 'UserOne' },
    },
    formStart: async () => {
      throw new Error('USERS must not open when login exposes userLogin');
    },
  });
  assert.equal(r.ok, true);
  assert.equal(r.userLogin, 'UserOne');
  assert.notEqual(r.userLogin, allowlistEmail);

  const saved = rememberWhoami({
    userProfile: profile,
    instanceId: 'saas1',
    userLogin: r.userLogin,
    company: 'DEMO',
    source: r.source,
    identifiedAt: '2026-11-12T11:00:00Z',
  });
  assert.equal(saved.ok, true);
  const body = fs.readFileSync(lastUserPath(profile), 'utf8');
  assert.match(body, /"userLogin": "UserOne"/);
  assert.doesNotMatch(body, /u@x\.com/);
  assert.doesNotMatch(body, /access_token/);
});

test('unidentified whoami must not call rememberWhoami with allowlist email', async () => {
  const profile = fs.mkdtempSync(path.join(os.tmpdir(), 'whoami-persist-bad-'));
  const r = await resolveWhoami({
    instance: { id: 'saas1', user: 'nobody@x.com', company: 'DEMO' },
    session: { ok: true, priority: {}, loginResult: null },
    formStart: async () => ({
      name: 'USERS',
      setSearchFilter: async () => {},
      getRows: async () => ({ USERS: {} }),
      endCurrentForm: async () => {},
    }),
    formGetRows: async () => ({ formName: 'USERS', count: 0, rows: [] }),
    safeEnd: async () => {},
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'user_unidentified');
  // Tip bug wrote instance.user here — refuse that path.
  assert.equal(r.userLogin, undefined);
  assert.equal(fs.existsSync(lastUserPath(profile)), false);
});
