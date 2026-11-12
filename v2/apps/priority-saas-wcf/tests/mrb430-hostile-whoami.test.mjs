/**
 * MRB #430 hostile: FR #383 whoami contract pins.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { resolveWhoami } from '../lib/whoami.mjs';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

test('whoami sources do not write last-user.json or invent OS user', () => {
  const who = fs.readFileSync(path.join(ROOT, 'lib', 'whoami.mjs'), 'utf8');
  const bin = fs.readFileSync(path.join(ROOT, 'bin', 'priority-wcf.mjs'), 'utf8');
  assert.doesNotMatch(who, /last-user\.json/);
  assert.doesNotMatch(who, /os\.userInfo|os\.username|USERPROFILE/);
  assert.match(bin, /fail\([\s\S]*user_unidentified[\s\S]*,\s*3\)/);
  assert.match(bin, /return ok\(\{\s*userLogin: r\.userLogin,\s*source: r\.source\s*\}\)/);
});

test('unidentified result has no userLogin and no osUser', async () => {
  const r = await resolveWhoami({
    instance: { id: 't', user: 'x@y.z', company: 'co' },
    session: { ok: true, priority: {}, loginResult: {} },
    formStart: async () => ({ setSearchFilter: async () => {} }),
    formGetRows: async () => ({ rows: [] }),
    safeEnd: async () => {},
  });
  assert.equal(r.ok, false);
  assert.equal(r.reason, 'user_unidentified');
  assert.equal(Object.prototype.hasOwnProperty.call(r, 'userLogin'), false);
});
