/**
 * Skills DAG for mcp-priority (FR #354).
 * Mirrors tools/priority-skill-dag/resolve_dag.py — bounded resolve for agents.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const QUERY_STOP = new Set([
  'the',
  'and',
  'for',
  'with',
  'from',
  'this',
  'that',
  'when',
  'how',
  'user',
  'priority',
  'medatech',
]);

const __dirname = path.dirname(fileURLToPath(import.meta.url));

let cached = null;

export function dagDataDir() {
  const env = (process.env.MCP_DAG_DIR || '').trim();
  if (env) return path.resolve(env);
  return path.join(process.cwd(), 'data');
}

export function loadDag(force = false) {
  if (cached && !force) return cached;
  const dir = dagDataDir();
  const dagPath = path.join(dir, 'dag.json');
  if (!fs.existsSync(dagPath)) {
    throw new Error(`DAG missing: ${dagPath} — run scripts/sync-skill-dag.mjs`);
  }
  const dag = JSON.parse(fs.readFileSync(dagPath, 'utf8'));
  const indexPath = path.join(dir, 'dag-index.json');
  const index = fs.existsSync(indexPath)
    ? JSON.parse(fs.readFileSync(indexPath, 'utf8'))
    : {
        version: dag.version,
        built: dag.built,
        note: 'Slim index unavailable; derived from dag.json',
        nodeCount: (dag.nodes || []).length,
        defaults: dag.defaults || {},
        nodes: (dag.nodes || []).map((n) => ({
          id: n.id,
          type: n.type,
          title: n.title,
          path: n.path,
          topic: n.topic,
          bytes: n.bytes,
          weight: n.weight,
        })),
      };
  const nodesById = new Map((dag.nodes || []).map((n) => [n.id, n]));
  const deps = new Map();
  const contains = new Map();
  const skillTopics = new Map();
  for (const e of dag.edges || []) {
    const rel = e.rel;
    const frm = e.from;
    const to = e.to;
    if (!frm || !to) continue;
    if (rel === 'depends_on') {
      if (!deps.has(frm)) deps.set(frm, new Set());
      deps.get(frm).add(to);
    } else if (rel === 'contains') {
      if (!contains.has(frm)) contains.set(frm, new Set());
      contains.get(frm).add(to);
    } else if (rel === 'loads_topic') {
      skillTopics.set(frm, to);
    }
  }
  cached = { dag, index, nodesById, deps, contains, skillTopics, dagPath };
  return cached;
}

function wordHit(token, text) {
  const t = String(text || '').toLowerCase();
  const tok = String(token || '').toLowerCase();
  if (tok.length < 5) {
    return new RegExp(`(?<![a-z0-9])${escapeRe(tok)}(?![a-z0-9])`).test(t);
  }
  return t.includes(tok);
}

function escapeRe(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function tokenize(query) {
  return String(query || '')
    .toLowerCase()
    .split(/[^a-z0-9]+/)
    .filter((t) => t.length >= 3 && !QUERY_STOP.has(t));
}

function scoreNode(node, tokens, helpIntent) {
  let s = 0;
  const title = String(node.title || '').toLowerCase();
  const pathStr = String(node.path || '').toLowerCase();
  const topic = String(node.topic || '').toLowerCase();
  const triggers = (node.triggers || []).map((tr) => String(tr).toLowerCase());
  const summary = String(node.summary || '').toLowerCase();
  const titleCompact = title.replace(/[^a-z0-9]+/g, '');
  const blob = [title, pathStr, topic, summary, ...triggers].join(' ');
  for (const t of tokens) {
    if (wordHit(t, title)) s += 5;
    else if (t.length >= 4 && titleCompact.includes(t)) s += 3;
    else if (triggers.some((tr) => wordHit(t, tr) || t === tr)) s += 4;
    else if (wordHit(t, summary)) s += 2;
    else if (wordHit(t, pathStr) || wordHit(t, topic)) s += 1;
    else if (t.length >= 5 && blob.includes(t)) s += 1;
  }
  if (tokens.length >= 2) {
    for (let i = 0; i < tokens.length - 1; i++) {
      const pair = tokens[i] + tokens[i + 1];
      if (pair.length >= 6 && titleCompact.includes(pair)) s += 10;
      const pairSpace = `${tokens[i]} ${tokens[i + 1]}`;
      if (triggers.some((tr) => tr.includes(pairSpace))) s += 6;
    }
    const joined = tokens.join('');
    if (joined.length >= 6 && titleCompact.includes(joined)) s += 4;
    const phrase = tokens.join(' ');
    if (triggers.some((tr) => tr.includes(phrase))) s += 6;
  }
  const weight = String(node.weight || 'normal');
  if (weight.startsWith('low') && !helpIntent) {
    s = Math.max(0, s - 4);
    if (pathStr.includes('forms-code/sacred') && s < 6) return 0;
  }
  return s;
}

function expandTopics(seedIds, deps, depth = 1) {
  const out = new Set(seedIds);
  let frontier = [...seedIds];
  for (let d = 0; d < depth; d++) {
    const nxt = [];
    for (const tid of frontier) {
      for (const dep of deps.get(tid) || []) {
        if (!out.has(dep)) {
          out.add(dep);
          nxt.push(dep);
        }
      }
    }
    frontier = nxt;
  }
  return out;
}

function pack(items, kind, limit, budget, singleFileCeiling, allowLarge) {
  const out = [];
  const skippedLarge = [];
  for (const [sc, n] of items) {
    if (out.length >= limit) break;
    const nbytes = Number(n.bytes || 0);
    const weight = String(n.weight || 'normal');
    const isLarge = nbytes > singleFileCeiling || weight.includes('large');
    if (isLarge && !allowLarge) {
      skippedLarge.push({
        id: n.id,
        path: n.path,
        bytes: nbytes,
        reason: `exceeds singleFileCeiling=${singleFileCeiling}; pass -AllowLarge`,
      });
      continue;
    }
    if (nbytes && nbytes > budget[0] && out.length) {
      skippedLarge.push({
        id: n.id,
        path: n.path,
        bytes: nbytes,
        reason: `would exceed maxBytes remaining=${budget[0]}`,
      });
      continue;
    }
    if (nbytes > budget[0] && !out.length && kind === 'lesson') {
      if (!allowLarge) {
        skippedLarge.push({
          id: n.id,
          path: n.path,
          bytes: nbytes,
          reason: 'single lesson exceeds maxBytes; pass -AllowLarge',
        });
        continue;
      }
    }
    const entry = {
      score: sc,
      id: n.id,
      path: n.path,
      topic: n.topic,
      bytes: nbytes,
      weight,
      summary: n.summary || '',
      title: n.title,
    };
    if (kind === 'lesson') {
      entry.path = `docs/skill-sources/medatech-network/${n.path}`;
    }
    out.push(entry);
    budget[0] = Math.max(0, budget[0] - nbytes);
  }
  return { out, skippedLarge };
}

/**
 * Bounded resolve — same contract as Resolve-SkillDag.ps1 / resolve_dag.py.
 */
export function resolveSkills(task, opts = {}) {
  const { dag, deps, contains, skillTopics } = loadDag();
  const defaults = dag.defaults || {};
  const maxLessons = opts.maxLessons ?? defaults.maxLessons ?? 8;
  const maxSkills = opts.maxSkills ?? defaults.maxSkills ?? 5;
  const maxBytes = opts.maxBytes ?? defaults.maxBytes ?? 24000;
  const allowLarge = Boolean(opts.allowLarge);
  const singleFileCeiling =
    opts.singleFileCeiling ?? defaults.singleFileCeiling ?? 20000;

  const query = String(task || '');
  const tokens = tokenize(query);
  const helpIntent =
    /\b(wiz3?|help\s*wizard|sacred|robohelp|form\s*help)\b/i.test(query) ||
    query.toLowerCase().includes('forms-code');

  const scoredTopics = [];
  const scoredSkills = [];
  const scoredLessons = [];
  for (const n of dag.nodes || []) {
    const sc = scoreNode(n, tokens, helpIntent);
    if (sc <= 0) continue;
    const t = n.type;
    if (t === 'topic') scoredTopics.push([sc, n]);
    else if (t === 'catalog-skill' || t === 'loader') scoredSkills.push([sc, n]);
    else if (t === 'lesson') scoredLessons.push([sc, n]);
  }
  const byScore = (a, b) => b[0] - a[0] || String(a[1].id).localeCompare(String(b[1].id));
  scoredTopics.sort(byScore);
  scoredSkills.sort(byScore);
  scoredLessons.sort(byScore);

  let activeTopics = new Set();
  if (scoredTopics.length) {
    const seeds = scoredTopics.slice(0, 3).map(([, n]) => n.id);
    activeTopics = expandTopics(seeds, deps, 1);
  }
  for (const [sc, n] of scoredSkills.slice(0, maxSkills)) {
    if (sc < 6) continue;
    let tid = skillTopics.get(n.id);
    if (
      !tid &&
      n.topic &&
      !['loader', 'programming', 'hours', 'uat'].includes(n.topic)
    ) {
      tid = `topic:${n.topic}`;
    }
    if (tid) {
      for (const x of expandTopics([tid], deps, 1)) activeTopics.add(x);
    }
  }

  let gatedLessons;
  if (activeTopics.size) {
    const allowed = new Set();
    for (const tid of activeTopics) {
      for (const id of contains.get(tid) || []) allowed.add(id);
    }
    gatedLessons = scoredLessons.filter(
      ([, n]) =>
        allowed.has(n.id) ||
        (n.topic && activeTopics.has(`topic:${n.topic}`)),
    );
    if (!gatedLessons.length) gatedLessons = scoredLessons;
  } else {
    gatedLessons = scoredLessons;
  }

  const budget = [maxBytes];
  const skillsPack = pack(
    scoredSkills,
    'skill',
    maxSkills,
    budget,
    singleFileCeiling,
    allowLarge,
  );
  const lessonsPack = pack(
    gatedLessons,
    'lesson',
    maxLessons,
    budget,
    singleFileCeiling,
    allowLarge,
  );
  const skillsOut = skillsPack.out;
  const lessonsOut = lessonsPack.out;
  const loadOrder = [];
  for (const s of skillsOut) {
    loadOrder.push({
      kind: 'skill',
      path: s.path,
      bytes: s.bytes,
      summary: String(s.summary || '').slice(0, 160),
    });
  }
  for (const lesson of lessonsOut) {
    loadOrder.push({
      kind: 'lesson',
      path: lesson.path,
      bytes: lesson.bytes,
      summary: String(lesson.summary || '').slice(0, 160),
    });
  }
  const used = maxBytes - budget[0];
  return {
    query: query.toLowerCase(),
    tokens,
    helpIntent,
    activeTopics: [...activeTopics].sort(),
    budget: {
      maxBytes,
      usedBytes: used,
      remainingBytes: budget[0],
      singleFileCeiling,
      allowLarge,
      maxLessons,
      maxSkills,
    },
    topics: scoredTopics.slice(0, 5).map(([s, n]) => ({
      score: s,
      id: n.id,
      title: n.title,
    })),
    skills: skillsOut,
    lessons: lessonsOut,
    skipped: [...skillsPack.skippedLarge, ...lessonsPack.skippedLarge].slice(0, 20),
    loadOrder,
    agentRules: [
      'Do NOT read docs/skill-sources/medatech-network/_dag/dag.json (too large).',
      'Prefer loadOrder skills first; open lesson bodies only when summary is insufficient.',
      'Skip any path whose bytes exceed your remaining context; re-resolve with a tighter query.',
      'Use resolve_skills for normal work; get_skill_dag only for audits.',
    ],
  };
}

export function getDagIndex() {
  const { index } = loadDag();
  return {
    version: index.version,
    built: index.built,
    note: index.note,
    nodeCount: index.nodeCount,
    defaults: index.defaults,
    // Slim: ids + type + title only for transport
    nodes: (index.nodes || []).map((n) => ({
      id: n.id,
      type: n.type,
      title: n.title,
      path: n.path,
      topic: n.topic,
      bytes: n.bytes,
      weight: n.weight,
    })),
  };
}

export function getDagNode(id) {
  const { dag, nodesById } = loadDag();
  const key = String(id || '').trim();
  const node = nodesById.get(key);
  if (!node) {
    return { ok: false, error: `unknown dag node '${key}'` };
  }
  const edges = (dag.edges || []).filter((e) => e.from === key || e.to === key);
  return { ok: true, node, edges };
}

/**
 * Page through full graph for audits. cursor is opaque offset integer as string.
 */
export function getSkillDagPage(cursor, pageSize = 50) {
  const { dag } = loadDag();
  const nodes = dag.nodes || [];
  const size = Math.min(Math.max(Number(pageSize) || 50, 1), 200);
  let offset = 0;
  if (cursor != null && String(cursor).trim() !== '') {
    offset = Number(cursor);
    if (!Number.isFinite(offset) || offset < 0) {
      return { ok: false, error: 'cursor must be a non-negative integer offset' };
    }
  }
  const slice = nodes.slice(offset, offset + size).map((n) => ({
    id: n.id,
    type: n.type,
    title: n.title,
    path: n.path,
    topic: n.topic,
    bytes: n.bytes,
    weight: n.weight,
    summary: n.summary,
  }));
  const next = offset + size;
  return {
    ok: true,
    nodeCount: nodes.length,
    edgeCount: (dag.edges || []).length,
    offset,
    pageSize: size,
    nodes: slice,
    nextCursor: next < nodes.length ? String(next) : null,
    done: next >= nodes.length,
  };
}


/**
 * Catalog skill ids required by a skill, from DAG edges.
 * - Transitive depends_on targets that are skill:* nodes (direct skill deps).
 * - Skills that load topics in the depends_on closure of this skill's topic
 *   (excludes peers on the same topic).
 * Returns bare catalog names (no skill: prefix), sorted unique.
 */
export function getRequiredSkillIds(skillName) {
  const { deps, skillTopics } = loadDag();
  const raw = String(skillName || '').trim();
  if (!raw) return [];
  const key = raw.startsWith('skill:') ? raw : ('skill:' + raw);
  const out = new Set();

  const stack = [...(deps.get(key) || [])];
  const seen = new Set();
  while (stack.length) {
    const n = stack.pop();
    if (!n || seen.has(n)) continue;
    seen.add(n);
    if (n.startsWith('skill:')) out.add(n.slice('skill:'.length));
    for (const d of deps.get(n) || []) stack.push(d);
  }

  const topic = skillTopics.get(key);
  if (topic) {
    const topics = expandTopics([topic], deps, 2);
    topics.delete(topic);
    for (const [sk, t] of skillTopics.entries()) {
      if (!topics.has(t) || sk === key || !sk.startsWith('skill:')) continue;
      out.add(sk.slice('skill:'.length));
    }
  }

  return [...out].sort((a, b) => a.localeCompare(b));
}

export function resetDagCache() {
  cached = null;
}
