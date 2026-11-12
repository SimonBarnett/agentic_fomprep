/**
 * FR #401 / FR-019: do not auto-confirm error dialogs unless --confirm-errors.
 * warningConfirm / infoMsgConfirm unchanged. Does not change proc walk.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { messageHandler, setConfirmErrors } from '../lib/session.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

test('Fake message type error: errorConfirm count 0 by default', () => {
  setConfirmErrors(false);
  const calls = { error: 0, warning: 0, info: 0 };
  const form = {
    errorConfirm: () => {
      calls.error += 1;
    },
    warningConfirm: () => {
      calls.warning += 1;
    },
    infoMsgConfirm: () => {
      calls.info += 1;
    },
  };
  const onMsg = messageHandler([], { f: form });
  onMsg({ type: 'error', message: 'blocked' });
  onMsg({ type: 'warning', message: 'warn' });
  onMsg({ type: 'information', message: 'info' });
  assert.equal(calls.error, 0);
  assert.equal(calls.warning, 1);
  assert.equal(calls.info, 1);
});

test('With confirmErrors, errorConfirm count 1', () => {
  setConfirmErrors(true);
  try {
    const calls = { error: 0 };
    const form = {
      errorConfirm: () => {
        calls.error += 1;
      },
    };
    const onMsg = messageHandler([], { f: form });
    onMsg({ type: 'error', message: 'blocked' });
    assert.equal(calls.error, 1);
  } finally {
    setConfirmErrors(false);
  }
});

test('proc-walk does not call errorConfirm (FR-019 out of scope)', () => {
  const walk = fs.readFileSync(path.join(ROOT, 'lib', 'proc-walk.mjs'), 'utf8');
  assert.doesNotMatch(walk, /errorConfirm/);
});
