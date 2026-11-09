/**
 * FR #354 build gates: DAG↔catalog sync + public-safe content scan.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const appRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const dataDir = path.join(appRoot, 'data');
const catalogDir = path.join(appRoot, 'catalog');

function fail(msg) {
  process.stderr.write(`check-dag: ${msg}\n`);
  process.exit(1);
}

const dagPath = path.join(dataDir, 'dag.json');
if (!fs.existsSync(dagPath)) fail('missing data/dag.json — run sync-skill-dag.mjs first');
const dag = JSON.parse(fs.readFileSync(dagPath, 'utf8'));
const skillNodes = new Set(
  (dag.nodes || [])
    .filter((n) => n.type === 'catalog-skill' || n.type === 'loader')
    .map((n) => String(n.id || '').replace(/^skill:/, '')),
);

const catalogSkills = [];
for (const name of fs.readdirSync(catalogDir)) {
  const dir = path.join(catalogDir, name);
  if (!fs.statSync(dir).isDirectory()) continue;
  const metaPath = path.join(dir, 'meta.json');
  if (!fs.existsSync(metaPath)) continue;
  const meta = JSON.parse(fs.readFileSync(metaPath, 'utf8'));
  catalogSkills.push(String(meta.name || name));
}

const missingInDag = catalogSkills.filter((id) => !skillNodes.has(id));
const missingInCatalog = [...skillNodes].filter((id) => !catalogSkills.includes(id));
// Loaders may not be catalog folders — only require catalog-skill ids that look like catalog names
const catalogOnlyMissing = missingInCatalog.filter((id) =>
  fs.existsSync(path.join(catalogDir, id, 'meta.json')),
);

if (missingInDag.length) {
  fail(`catalog skills missing from DAG: ${missingInDag.slice(0, 20).join(', ')}`);
}
if (catalogOnlyMissing.length) {
  fail(`DAG catalog-skill nodes missing folders: ${catalogOnlyMissing.slice(0, 20).join(', ')}`);
}

// Secret / private-data scan (public MCP — no credentials or private hosts)
const SECRET_RX = [
  /\bpassword\s*[:=]\s*\S+/i,
  /\bBearer\s+[A-Za-z0-9\-._~+/]{20,}={0,2}\b/,
  /\b(api[_-]?key|secret|token)\s*[:=]\s*['\"]?[A-Za-z0-9\-._]{12,}/i,
  /\bAKIA[0-9A-Z]{16}\b/,
  /\b(ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{20,}\b/,
  /\binternal\.[a-z0-9.-]+\b/i,
  /\b\.local\b/i,
  /\b10\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/,
  /\b192\.168\.\d{1,3}\.\d{1,3}\b/,
];

const hits = [];
for (const n of dag.nodes || []) {
  const blob = [n.id, n.title, n.summary, n.path, ...(n.triggers || [])].join('\n');
  for (const rx of SECRET_RX) {
    if (rx.test(blob)) {
      hits.push({ id: n.id, pattern: String(rx) });
      break;
    }
  }
  if (hits.length >= 20) break;
}
if (hits.length) {
  fail(
    `secret/private-data scan hits (${hits.length}): ${hits
      .map((h) => h.id)
      .slice(0, 10)
      .join(', ')}`,
  );
}

process.stdout.write(
  `check-dag: ok catalog=${catalogSkills.length} dagSkillIds=${skillNodes.size} nodes=${(dag.nodes || []).length}\n`,
);
