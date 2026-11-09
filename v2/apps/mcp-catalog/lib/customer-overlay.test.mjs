import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import test from 'node:test';
import {
  assertPublicSafeArgs,
  buildPublicResolvePayload,
  mergeResolve,
  normalizeMcpToolsUrl,
  resolveWithOverlay,
  scanOverlay,
} from './customer-overlay.mjs';

const SECRET = 'CUSTOMER_PRIVATE_OVERLAY_SECRET_NEVER_ON_MCP';
const SO_LESSON = 'HR Smith DEV estate dial-tone for SC263139 overlay only';

function makeCustomerTree() {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'fomprep-overlay-'));
  const skillDir = path.join(root, '.grok', 'skills', 'hrsmith-dialtone');
  fs.mkdirSync(skillDir, { recursive: true });
  fs.writeFileSync(
    path.join(skillDir, 'SKILL.md'),
    `# HR Smith dialtone\n\n${SECRET}\nUse local DEV only.\n`,
    'utf8',
  );
  const sc = path.join(root, 'SC263139');
  fs.mkdirSync(sc, { recursive: true });
  fs.writeFileSync(path.join(sc, 'project.md'), 'priority_project: PR1\nwbs: unknown\n', 'utf8');
  fs.writeFileSync(path.join(sc, 'estate-notes.md'), `# Estate notes\n\n${SO_LESSON}\n`, 'utf8');
  return root;
}

test('buildPublicResolvePayload only carries task and limits', () => {
  const p = buildPublicResolvePayload('form prep UAT', { maxLessons: 4, maxSkills: 2 });
  assert.deepEqual(Object.keys(p).sort(), ['maxLessons', 'maxSkills', 'task']);
  assert.equal(p.task, 'form prep UAT');
  assert.throws(() => buildPublicResolvePayload('  '));
});

test('assertPublicSafeArgs rejects overlay keys and secret needles', () => {
  assertPublicSafeArgs({ task: 'x' });
  assert.throws(() => assertPublicSafeArgs({ task: 'x', overlay: 'nope' }));
  assert.throws(() => assertPublicSafeArgs({ task: SECRET }, [SECRET]));
});

test('scanOverlay finds root skills and SO/SC lessons', () => {
  const root = makeCustomerTree();
  try {
    const empty = scanOverlay(root);
    assert.equal(empty.skills.length, 1);
    assert.equal(empty.lessons.length, 0);
    assert.ok(empty.skills[0].summary.includes(SECRET) || empty.skills[0].id.includes('hrsmith'));

    const withProj = scanOverlay(root, { projectFolder: 'SC263139' });
    assert.equal(withProj.lessons.length, 1);
    assert.ok(withProj.lessons[0].summary.includes('SC263139') || withProj.lessons[0].path.includes('SC263139'));
    assert.ok(withProj.lessons[0].summary.includes('overlay') || withProj.lessons[0].contentPreview.includes(SO_LESSON));
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('mergeResolve without overlay is public-only; with overlay includes local lessons', () => {
  const publicResult = {
    query: 'dialtone estate',
    limits: { maxLessons: 8, maxSkills: 5, maxBytes: 24000 },
    skills: [{ id: 'skill:priority-formprep', title: 'formprep', bytes: 100, summary: 'public' }],
    lessons: [{ id: 'lesson:public-a', title: 'public lesson', bytes: 50, summary: 'public only' }],
  };
  const none = mergeResolve(publicResult, { scanned: false, skills: [], lessons: [] }, { task: 'dialtone estate' });
  assert.equal(none.source, 'public');
  assert.equal(none.skills.length, 1);
  assert.equal(none.lessons.length, 1);
  assert.ok(none.skills.every((s) => s.source === 'public'));

  const root = makeCustomerTree();
  try {
    const overlay = scanOverlay(root, { projectFolder: 'SC263139' });
    const merged = mergeResolve(publicResult, overlay, { task: 'dialtone estate HR Smith' });
    assert.equal(merged.source, 'public+overlay');
    assert.ok(merged.skills.some((s) => s.source === 'overlay'));
    assert.ok(merged.lessons.some((s) => s.source === 'overlay'));
    assert.ok(merged.overlayCounts.includedLessons >= 1);
    // Bodies stay local — merged entries must not be shaped as MCP args
    const asArgs = buildPublicResolvePayload(merged.query);
    assertPublicSafeArgs(asArgs, [SECRET, SO_LESSON]);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('resolveWithOverlay never POSTs overlay content to fetchPublic', async () => {
  const root = makeCustomerTree();
  const calls = [];
  try {
    const publicResult = {
      query: 'HR Smith dialtone',
      limits: { maxLessons: 8, maxSkills: 5, maxBytes: 24000 },
      skills: [],
      lessons: [],
    };
    const merged = await resolveWithOverlay({
      task: 'HR Smith dialtone estate',
      overlayRoot: root,
      projectFolder: 'SC263139',
      maxLessons: 8,
      maxSkills: 5,
      fetchPublic: async (payload) => {
        calls.push(payload);
        const raw = JSON.stringify(payload);
        assert.equal(raw.includes(SECRET), false, 'SECRET must not leave the seat');
        assert.equal(raw.includes(SO_LESSON), false, 'SO lesson must not leave the seat');
        assert.equal(raw.includes(root), false, 'overlay path must not leave the seat');
        assert.equal(raw.includes('SC263139'), false, 'project folder must not be sent to MCP');
        assert.deepEqual(Object.keys(payload).sort(), ['maxLessons', 'maxSkills', 'task']);
        return publicResult;
      },
    });
    assert.equal(calls.length, 1);
    assert.equal(merged.source, 'public+overlay');
    assert.ok(merged.skills.some((s) => String(s.id).includes('overlay') || s.source === 'overlay'));
    assert.ok(merged.lessons.some((s) => s.source === 'overlay'));
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

test('normalizeMcpToolsUrl accepts base or /mcp form', () => {
  assert.equal(normalizeMcpToolsUrl('https://mcp.ntsa.uk'), 'https://mcp.ntsa.uk/mcp');
  assert.equal(normalizeMcpToolsUrl('https://mcp.ntsa.uk/'), 'https://mcp.ntsa.uk/mcp');
  assert.equal(normalizeMcpToolsUrl('https://mcp.ntsa.uk/mcp'), 'https://mcp.ntsa.uk/mcp');
  assert.equal(normalizeMcpToolsUrl('https://mcp.ntsa.uk/mcp/'), 'https://mcp.ntsa.uk/mcp');
  assert.throws(() => normalizeMcpToolsUrl(''));
});
