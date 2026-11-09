/**
 * FR #362 / #354 acceptance #8: agent-side customer overlay merge.
 *
 * Public mcp.ntsa.uk resolve_skills stays generic-only. Customer lessons/skills
 * live in the customer repo (root + SO/SC folder) and are merged locally.
 * Overlay bodies must never appear in MCP request payloads.
 */
import fs from 'node:fs';
import path from 'node:path';

const SO_SC_RE = /^(SC|SO)\d{5,}$/i;
const SKIP_DIRS = new Set([
  '.git',
  'node_modules',
  '.next',
  '.grok',
  'docs',
  'v2',
  'tools',
  'launcher',
  'tests',
  'catalog',
]);

/**
 * Build the only allowed arguments for public resolve_skills.
 * Never include overlay paths, lesson bodies, or customer text.
 */
export function buildPublicResolvePayload(task, opts = {}) {
  const taskStr = String(task || '').trim();
  if (!taskStr) throw new Error('task required');
  const out = { task: taskStr };
  if (opts.maxLessons != null) out.maxLessons = Number(opts.maxLessons);
  if (opts.maxSkills != null) out.maxSkills = Number(opts.maxSkills);
  if (opts.maxBytes != null) out.maxBytes = Number(opts.maxBytes);
  if (opts.allowLarge != null) out.allowLarge = Boolean(opts.allowLarge);
  if (opts.singleFileCeiling != null) {
    out.singleFileCeiling = Number(opts.singleFileCeiling);
  }
  return out;
}

/** Assert a tools/call arguments object is public-safe (no overlay leak). */
export function assertPublicSafeArgs(args, forbiddenSubstrings = []) {
  const json = JSON.stringify(args ?? {});
  const keys = Object.keys(args || {});
  for (const k of keys) {
    if (!['task', 'maxLessons', 'maxSkills', 'maxBytes', 'allowLarge', 'singleFileCeiling'].includes(k)) {
      throw new Error(`public resolve_skills args must not include key '${k}'`);
    }
  }
  for (const needle of forbiddenSubstrings) {
    if (needle && json.includes(needle)) {
      throw new Error(`overlay content leaked into public MCP args: ${needle.slice(0, 40)}`);
    }
  }
  return true;
}

function tokenize(query) {
  return String(query || '')
    .toLowerCase()
    .split(/[^a-z0-9]+/)
    .filter((t) => t.length >= 3);
}

function scoreText(text, tokens) {
  const blob = String(text || '').toLowerCase();
  let s = 0;
  for (const t of tokens) {
    if (blob.includes(t)) s += 2;
  }
  return s;
}

function readUtf8(filePath) {
  try {
    return fs.readFileSync(filePath, 'utf8');
  } catch {
    return '';
  }
}

function skillFromDir(dir, sourcePath) {
  const skillMd = path.join(dir, 'SKILL.md');
  if (!fs.existsSync(skillMd)) return null;
  const id = path.basename(dir);
  const body = readUtf8(skillMd);
  const titleMatch = body.match(/^#\s+(.+)$/m);
  const title = titleMatch ? titleMatch[1].trim() : id;
  const bytes = Buffer.byteLength(body, 'utf8');
  return {
    id: `overlay-skill:${id}`,
    type: 'catalog-skill',
    title,
    path: sourcePath || path.relative(dir, skillMd).replace(/\\/g, '/') || 'SKILL.md',
    absPath: skillMd,
    bytes,
    weight: 1,
    summary: body.slice(0, 240).replace(/\s+/g, ' ').trim(),
    source: 'overlay',
    contentPreview: body.slice(0, 400),
  };
}

function lessonFromFile(filePath, relPath) {
  const body = readUtf8(filePath);
  if (!body.trim()) return null;
  const base = path.basename(filePath, path.extname(filePath));
  const titleMatch = body.match(/^#\s+(.+)$/m);
  const title = titleMatch ? titleMatch[1].trim() : base;
  const bytes = Buffer.byteLength(body, 'utf8');
  return {
    id: `overlay-lesson:${relPath.replace(/\\/g, '/')}`,
    type: 'lesson',
    title,
    path: relPath.replace(/\\/g, '/'),
    absPath: filePath,
    bytes,
    weight: 1,
    summary: body.slice(0, 240).replace(/\s+/g, ' ').trim(),
    source: 'overlay',
    contentPreview: body.slice(0, 400),
  };
}

/**
 * Scan a customer repo for overlay skills/lessons.
 * - Root `.grok/skills/<name>/SKILL.md` and root `<name>/SKILL.md`
 * - When projectFolder is set (SCxxxxxx / SOxxxxxx), markdown under that folder
 */
export function scanOverlay(customerRoot, opts = {}) {
  const root = path.resolve(String(customerRoot || ''));
  const lessons = [];
  const skills = [];
  if (!root || !fs.existsSync(root) || !fs.statSync(root).isDirectory()) {
    return { root, skills, lessons, scanned: false };
  }

  const grokSkills = path.join(root, '.grok', 'skills');
  if (fs.existsSync(grokSkills)) {
    for (const ent of fs.readdirSync(grokSkills, { withFileTypes: true })) {
      if (!ent.isDirectory()) continue;
      const sk = skillFromDir(
        path.join(grokSkills, ent.name),
        `.grok/skills/${ent.name}/SKILL.md`,
      );
      if (sk) skills.push(sk);
    }
  }

  for (const ent of fs.readdirSync(root, { withFileTypes: true })) {
    if (!ent.isDirectory()) continue;
    if (SKIP_DIRS.has(ent.name) || SO_SC_RE.test(ent.name)) continue;
    const sk = skillFromDir(path.join(root, ent.name), `${ent.name}/SKILL.md`);
    if (sk) skills.push(sk);
  }

  let project = (opts.projectFolder || opts.project || '').trim();
  if (project) {
    project = project.replace(/\\/g, '/').split('/').filter(Boolean).pop();
    const projDir = path.join(root, project);
    if (SO_SC_RE.test(project) && fs.existsSync(projDir) && fs.statSync(projDir).isDirectory()) {
      for (const ent of fs.readdirSync(projDir, { withFileTypes: true })) {
        if (!ent.isFile()) continue;
        if (!/\.(md|txt)$/i.test(ent.name)) continue;
        if (/^project\.md$/i.test(ent.name) || /^log\.md$/i.test(ent.name)) continue;
        const rel = `${project}/${ent.name}`;
        const lesson = lessonFromFile(path.join(projDir, ent.name), rel);
        if (lesson) lessons.push(lesson);
      }
      // Project-local skill folder
      const projSkill = path.join(projDir, '.grok', 'skills');
      if (fs.existsSync(projSkill)) {
        for (const ent of fs.readdirSync(projSkill, { withFileTypes: true })) {
          if (!ent.isDirectory()) continue;
          const sk = skillFromDir(
            path.join(projSkill, ent.name),
            `${project}/.grok/skills/${ent.name}/SKILL.md`,
          );
          if (sk) skills.push(sk);
        }
      }
    }
  }

  return { root, skills, lessons, scanned: true };
}

function packOverlay(items, tokens, maxCount, budget) {
  const scored = items
    .map((n) => {
      const sc =
        scoreText(`${n.title} ${n.path} ${n.summary} ${n.contentPreview || ''}`, tokens) ||
        1; // keep overlay candidates visible when query is thin
      return [sc, n];
    })
    .sort((a, b) => b[0] - a[0] || String(a[1].id).localeCompare(String(b[1].id)));

  const out = [];
  for (const [, n] of scored) {
    if (out.length >= maxCount) break;
    const nbytes = Number(n.bytes) || 0;
    if (budget[0] < nbytes && out.length > 0) continue;
    budget[0] = Math.max(0, budget[0] - nbytes);
    const { contentPreview, absPath, ...rest } = n;
    out.push({ ...rest, score: scored.find((x) => x[1].id === n.id)?.[0] || 0 });
  }
  return out;
}

/**
 * Merge a public resolve_skills result with a local overlay scan.
 */
export function mergeResolve(publicResult, overlay, opts = {}) {
  const pub = publicResult || { skills: [], lessons: [], limits: {} };
  const maxLessons = opts.maxLessons ?? pub.limits?.maxLessons ?? 8;
  const maxSkills = opts.maxSkills ?? pub.limits?.maxSkills ?? 5;
  const maxBytes = opts.maxBytes ?? pub.limits?.maxBytes ?? 24000;
  const task = opts.task || pub.query || '';
  const tokens = tokenize(task);

  const pubSkills = Array.isArray(pub.skills) ? pub.skills.map((s) => ({ ...s, source: s.source || 'public' })) : [];
  const pubLessons = Array.isArray(pub.lessons) ? pub.lessons.map((s) => ({ ...s, source: s.source || 'public' })) : [];

  let used = 0;
  for (const x of [...pubSkills, ...pubLessons]) used += Number(x.bytes) || 0;
  const budget = [Math.max(0, maxBytes - used)];

  const overlaySkills = packOverlay(overlay?.skills || [], tokens, Math.max(0, maxSkills - pubSkills.length), budget);
  const overlayLessons = packOverlay(overlay?.lessons || [], tokens, Math.max(0, maxLessons - pubLessons.length), budget);

  const skills = [...pubSkills, ...overlaySkills].slice(0, maxSkills);
  const lessons = [...pubLessons, ...overlayLessons].slice(0, maxLessons);

  return {
    query: task,
    source: overlay?.scanned ? 'public+overlay' : 'public',
    overlayRoot: overlay?.root || null,
    limits: { maxLessons, maxSkills, maxBytes },
    skills,
    lessons,
    overlayCounts: {
      skills: (overlay?.skills || []).length,
      lessons: (overlay?.lessons || []).length,
      includedSkills: overlaySkills.length,
      includedLessons: overlayLessons.length,
    },
    note:
      'Overlay merged locally. Customer overlay content is never sent to mcp.ntsa.uk; only task (+limits) go to resolve_skills.',
  };
}

/**
 * End-to-end: build public-safe payload, call fetchPublic(payload), merge overlay.
 * fetchPublic must POST only the payload it is given (tests spy on this).
 */
export async function resolveWithOverlay({
  task,
  fetchPublic,
  overlayRoot,
  projectFolder,
  maxLessons,
  maxSkills,
  maxBytes,
  allowLarge,
  singleFileCeiling,
} = {}) {
  const payload = buildPublicResolvePayload(task, {
    maxLessons,
    maxSkills,
    maxBytes,
    allowLarge,
    singleFileCeiling,
  });
  const overlay = overlayRoot
    ? scanOverlay(overlayRoot, { projectFolder })
    : { root: null, skills: [], lessons: [], scanned: false };

  const forbidden = [];
  for (const item of [...(overlay.skills || []), ...(overlay.lessons || [])]) {
    if (item.contentPreview) forbidden.push(item.contentPreview.slice(0, 48));
    if (item.absPath) forbidden.push(item.absPath);
    if (item.summary && item.summary.length > 20) forbidden.push(item.summary.slice(0, 48));
  }
  assertPublicSafeArgs(payload, forbidden);

  if (typeof fetchPublic !== 'function') {
    throw new Error('fetchPublic(payload) required — call public resolve_skills with this payload only');
  }
  const publicResult = await fetchPublic(payload);
  assertPublicSafeArgs(payload, forbidden);

  return mergeResolve(publicResult, overlay, {
    task,
    maxLessons: payload.maxLessons,
    maxSkills: payload.maxSkills,
    maxBytes: payload.maxBytes,
  });
}
