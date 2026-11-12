/**
 * FR #418 / FR-036: interface run uses proc walker (FR-21 / FR-22).
 * Offline fakes only — no live SaaS / no secrets. Map is FR-37.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { runProcStart } from '../lib/proc.mjs';
import { verbIsWrite } from '../lib/dry-run.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');
const BIN = path.join(ROOT, 'bin', 'priority-wcf.mjs');

test('Fake single inputFields applies the file', async () => {
  let saw;
  const proc = {
    inputFields: async (_ok, data) => {
      saw = data;
      return { type: 'end', proc };
    },
  };
  const session = {
    priority: {
      procStart: async (name, ptype) => {
        assert.equal(name, 'MYIFACE');
        assert.equal(ptype, 'I');
        return {
          type: 'inputFields',
          proc,
          input: {
            EditField: [
              { field: 'PAR', title: 'Form name', value: '' },
              { field: 'FNM', title: 'Exec name', value: '' },
            ],
          },
        };
      },
    },
  };
  const result = await runProcStart(session, { company: 'CO' }, 'MYIFACE', {
    ptype: 'I',
    inputValues: { PAR: 'FROMFILE' },
    nameHint: 'HINTNAME',
  });
  assert.equal(result.ended, true);
  assert.notEqual(result.reason, 'needs_input');
  assert.equal(saw.EditFields[0].value, 'FROMFILE');
  assert.equal(saw.EditFields[1].value, 'HINTNAME');
});

test('Fake two-option step returns needs_input', async () => {
  let calls = 0;
  const proc = {
    inputOptions: async () => {
      calls += 1;
      return { type: 'end', proc };
    },
  };
  const session = {
    priority: {
      procStart: async () => ({
        type: 'inputOptions',
        proc,
        input: {
          Options: [
            { field: 'A', title: 'One' },
            { field: 'B', title: 'Two' },
          ],
        },
      }),
    },
  };
  const result = await runProcStart(session, { company: 'CO' }, 'MYIFACE', { ptype: 'I' });
  assert.equal(calls, 0);
  assert.equal(result.ok, false);
  assert.equal(result.reason, 'needs_input');
  assert.equal(result.options.length, 2);
  assert.equal(result.ended, false);
});

test('help interface stdout contains run', () => {
  const r = spawnSync(process.execPath, [BIN, 'help', 'interface'], {
    encoding: 'utf8',
    cwd: ROOT,
    env: { ...process.env },
  });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  assert.match(String(r.stdout || ''), /\brun\b/i);
});

test('verbIsWrite: interface.run is a write', () => {
  assert.equal(verbIsWrite('interface.run'), true);
  assert.equal(verbIsWrite('interface.list'), false);
});
