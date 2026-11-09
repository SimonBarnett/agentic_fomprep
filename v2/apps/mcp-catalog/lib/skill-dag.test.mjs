import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import test from 'node:test';
import {
  getDagIndex,
  getDagNode,
  getSkillDagPage,
  resetDagCache,
  resolveSkills,
} from './skill-dag.mjs';

const appRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const repoRoot = path.resolve(appRoot, '..', '..', '..');

function ensureData() {
  const sync = path.join(appRoot, 'scripts', 'sync-skill-dag.mjs');
  const r = spawnSync(process.execPath, [sync], { cwd: appRoot, encoding: 'utf8' });
  assert.equal(r.status, 0, r.stderr || r.stdout);
  resetDagCache();
}

test('sync + resolve_skills matches resolve_dag.py skill ids for sample tasks', () => {
  ensureData();
  const samples = ['form prep UAT', 'hours webhook', 'WCF API license'];
  for (const task of samples) {
    const py = spawnSync(
      'python',
      [
        path.join(repoRoot, 'tools', 'priority-skill-dag', 'resolve_dag.py'),
        repoRoot,
        task,
        '8',
        '5',
        '24000',
        'false',
        '20000',
      ],
      { encoding: 'utf8' },
    );
    assert.equal(py.status, 0, py.stderr);
    const expected = JSON.parse(py.stdout);
    const got = resolveSkills(task);
    assert.deepEqual(
      got.skills.map((s) => s.id),
      expected.skills.map((s) => s.id),
      `skills mismatch for ${task}`,
    );
    assert.deepEqual(
      got.lessons.map((s) => s.id),
      expected.lessons.map((s) => s.id),
      `lessons mismatch for ${task}`,
    );
  }
});

test('get_dag_node known and unknown', () => {
  ensureData();
  const ok = getDagNode('skill:priority-formprep');
  assert.equal(ok.ok, true);
  assert.equal(ok.node.id, 'skill:priority-formprep');
  assert.ok(Array.isArray(ok.edges));
  const bad = getDagNode('skill:does-not-exist-fr354');
  assert.equal(bad.ok, false);
});

test('get_skill_dag pages cover all nodes', () => {
  ensureData();
  const index = getDagIndex();
  const total = Number(index.nodeCount);
  assert.ok(total > 1000);
  let cursor = null;
  let seen = 0;
  let guard = 0;
  while (guard++ < 500) {
    const page = getSkillDagPage(cursor, 200);
    assert.equal(page.ok, true);
    seen += page.nodes.length;
    if (page.done) break;
    cursor = page.nextCursor;
  }
  assert.equal(seen, total);
});

test('get_dag_index is slim relative to dag.json', () => {
  ensureData();
  const index = getDagIndex();
  const dagBytes = fs.statSync(path.join(appRoot, 'data', 'dag.json')).size;
  const indexJson = JSON.stringify(index);
  assert.ok(index.nodes.length === index.nodeCount);
  // Index may still be large; must not embed full lesson bodies
  assert.ok(!indexJson.includes('"content"'));
  assert.ok(dagBytes > 1_000_000);
});
