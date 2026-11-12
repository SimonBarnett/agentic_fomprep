/**
 * MRB #468 hostile pins for FR-019 / #401.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { messageHandler, setConfirmErrors, getConfirmErrors } from '../lib/session.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

test('MRB-468: CLI usage lists --confirm-errors', () => {
  const src = fs.readFileSync(path.join(ROOT, 'bin', 'priority-wcf.mjs'), 'utf8');
  assert.match(src, /setConfirmErrors\(hasFlag\('--confirm-errors'\)\)/);
});

test('MRB-468: warning still confirms when errors are not opted in', () => {
  setConfirmErrors(false);
  assert.equal(getConfirmErrors(), false);
  let warn = 0;
  const form = {
    warningConfirm: () => {
      warn += 1;
    },
  };
  messageHandler([], { f: form })({ type: 'warning', message: 'w' });
  assert.equal(warn, 1);
});
