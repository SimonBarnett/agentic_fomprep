/**
 * MRB #484 hostile pins for FR-023 / #405 proc continue.
 * Offline only — no live SaaS / no secrets.
 */
import test from 'node:test';
import assert from 'node:assert/strict';
import { walkProcSteps } from '../lib/proc-walk.mjs';

test('MRB-484: without chosenOption, multi-option still needs_input (FR-404)', async () => {
  const first = {
    type: 'inputOptions',
    proc: { inputOptions: async () => ({ type: 'end', proc: {} }) },
    input: {
      Options: [
        { field: 'A', title: 'One' },
        { field: 'B', title: 'Two' },
      ],
    },
  };
  const result = await walkProcSteps(first, { maxSteps: 5, deadlineMs: 3000 });
  assert.equal(result.reason, 'needs_input');
  assert.equal(result.ok, false);
});

test('MRB-484: chosenOption applies only once across two inputOptions steps', async () => {
  const fields = [];
  const proc = {
    inputOptions: async (_ok, field) => {
      fields.push(field);
      if (fields.length === 1) {
        return {
          type: 'inputOptions',
          proc,
          input: {
            Options: [
              { field: 'X', title: 'x', selected: true },
              { field: 'Y', title: 'y' },
            ],
          },
        };
      }
      return { type: 'end', proc };
    },
  };
  await walkProcSteps(
    {
      type: 'inputOptions',
      proc,
      input: {
        Options: [
          { field: 'A', title: 'One' },
          { field: 'B', title: 'Two' },
        ],
      },
    },
    { chosenOption: 'B', maxSteps: 10, deadlineMs: 5000 },
  );
  assert.equal(fields[0], 'B');
  // second step: chosenOption already spent; uses selected X
  assert.equal(fields[1], 'X');
});
