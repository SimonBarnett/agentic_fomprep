/**
 * FR #420 / FR-038: expired access token fails closed before login.
 * Offline fixtures only — no live SaaS. Refresh is FR-39.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { attemptLoginIfTokenFresh, loadAccessToken } from '../lib/token.mjs';
import { classifyFailRetry, exitCodeForFail } from '../lib/json-out.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

function writeHarness(tokenDoc) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tok-exp-'));
  const instances = path.join(dir, 'instances.json');
  const tokenFile = path.join(dir, 'tokens.json');
  fs.writeFileSync(
    instances,
    JSON.stringify({
      instances: [
        {
          id: 'dev',
          host: 'example.invalid',
          tenant: 'ten',
          company: 'co',
          user: 'u@x.com',
          tokenFile,
          allowLive: false,
          wcfUrl: 'https://example.invalid/wcf/service.svc',
        },
      ],
    }),
  );
  fs.writeFileSync(tokenFile, JSON.stringify(tokenDoc));
  return { dir, instances, tokenFile };
}

test('Fixture expires_at in the past: login count 0', async () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const h = writeHarness({
    access_token: 'FAKE_access_token_expired_at',
    expires_at: '2020-01-01T00:00:00.000Z',
  });
  try {
    let loginCount = 0;
    const r = await attemptLoginIfTokenFresh({ tokenFile: h.tokenFile }, {
      login: async () => {
        loginCount += 1;
        return { ok: true };
      },
    });
    assert.equal(r.ok, false);
    assert.equal(r.reason, 'token_expired');
    assert.equal(r.loginCount, 0);
    assert.equal(loginCount, 0);
    assert.equal(classifyFailRetry('token_expired').retryable, false);
    assert.equal(exitCodeForFail('token_expired'), 3);

    const env = { ...process.env };
    delete env.PRIORITY_SAAS_TOKEN;
    const started = Date.now();
    const run = spawnSync(
      process.execPath,
      [BIN, 'whoami', '--instance', 'dev', '--instances', h.instances],
      { encoding: 'utf8', cwd: ROOT, env },
    );
    const elapsed = Date.now() - started;
    const out = String(run.stdout || '') + String(run.stderr || '');
    assert.equal(run.status, 3, out);
    const body = JSON.parse(String(run.stdout || '').trim().split('\n').pop());
    assert.equal(body.reason, 'token_expired');
    assert.equal(body.retryable, false);
    assert.ok(elapsed < 4000, `must not login; took ${elapsed}ms`);
    assert.doesNotMatch(out, /login_failed|Can't connect|ECONNREFUSED/i);
    assert.doesNotMatch(out, /FAKE_access_token_expired_at/);
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('Fixture expiry in the future: login is attempted on the fake', async () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const h = writeHarness({
    access_token: 'FAKE_access_token_fresh',
    expires_at: new Date(Date.now() + 3600_000).toISOString(),
  });
  try {
    const loaded = loadAccessToken({ tokenFile: h.tokenFile });
    assert.equal(loaded.ok, true);
    let loginCount = 0;
    const r = await attemptLoginIfTokenFresh({ tokenFile: h.tokenFile }, {
      login: async (_inst, tok) => {
        loginCount += 1;
        assert.equal(tok, 'FAKE_access_token_fresh');
        return { ok: true };
      },
    });
    assert.equal(r.ok, true);
    assert.equal(r.loginCount, 1);
    assert.equal(loginCount, 1);
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});

test('token with no expiry still attempts login', async () => {
  const prev = process.env.PRIORITY_SAAS_TOKEN;
  delete process.env.PRIORITY_SAAS_TOKEN;
  const h = writeHarness({ access_token: 'FAKE_access_token_noexp' });
  try {
    let loginCount = 0;
    const r = await attemptLoginIfTokenFresh({ tokenFile: h.tokenFile }, {
      login: async () => {
        loginCount += 1;
        return { ok: true };
      },
    });
    assert.equal(r.ok, true);
    assert.equal(loginCount, 1);
  } finally {
    if (prev !== undefined) process.env.PRIORITY_SAAS_TOKEN = prev;
  }
});
