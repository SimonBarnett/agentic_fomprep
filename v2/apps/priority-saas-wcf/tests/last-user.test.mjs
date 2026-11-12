import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { rememberWhoami, lastUserPath } from '../lib/last-user.mjs';

test('whoami success writes saas1; space refused; no access_token', () => {
  const profile = fs.mkdtempSync(path.join(os.tmpdir(), 'fr384-'));
  try {
    const ok = rememberWhoami({
      userProfile: profile,
      instanceId: 'saas1',
      userLogin: 'UserOne',
      company: 'DEMO',
      source: 'whoami',
      identifiedAt: '2026-11-12T11:00:00Z',
    });
    assert.equal(ok.ok, true);
    const file = lastUserPath(profile);
    const buf = fs.readFileSync(file);
    assert.notEqual(buf[0], 0xef);
    const text = buf.toString('utf8');
    assert.match(text, /"saas1"/);
    assert.match(text, /"userLogin": "UserOne"/);
    assert.doesNotMatch(text, /access_token/);
    const previous = text;
    const bad = rememberWhoami({
      userProfile: profile,
      instanceId: 'saas1',
      userLogin: 'bad login',
      company: 'DEMO',
      source: 'whoami',
    });
    assert.equal(bad.ok, false);
    assert.equal(fs.readFileSync(file, 'utf8'), previous);
  } finally {
    fs.rmSync(profile, { recursive: true, force: true });
  }
});
