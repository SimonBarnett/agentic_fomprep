#!/usr/bin/env node
/**
 * priority-catalog MCP over stdio. It has no dependencies: plain Node 18+.
 * It serves the same tools as the Amplify app (lib/mcp.ts + lib/catalog.ts) from ./catalog in
 * this clone, so it needs no network and no npm install.
 *
 *   grok mcp add priority-catalog -- node <clone>/v2/apps/mcp-catalog/stdio.mjs
 *
 * Optional: argv[2] or PRIORITY_CATALOG_DIR overrides the catalog folder.
 * stdout carries newline-delimited JSON-RPC only; diagnostics go to stderr.
 */
import fs from 'node:fs';
import path from 'node:path';
import readline from 'node:readline';
import { fileURLToPath } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const ROOT = process.argv[2] || process.env.PRIORITY_CATALOG_DIR || path.join(here, 'catalog');
const PROTOCOLS = ['2025-06-18', '2025-03-26', '2024-11-05'];
const SERVER = { name: 'mcp-priority', version: '1.0.0-stdio' };
const SKIP = new Set(['node_modules', '.git', '.next']);

function listRunnerFiles(dir, rel = '') {
  const out = [];
  if (!fs.existsSync(dir)) return out;
  for (const name of fs.readdirSync(dir).sort()) {
    if (SKIP.has(name)) continue;
    const full = path.join(dir, name);
    const childRel = rel ? `${rel}/${name}` : name;
    const st = fs.statSync(full);
    if (st.isDirectory()) out.push(...listRunnerFiles(full, childRel));
    else out.push({ path: childRel.replace(/\\/g, '/'), bytes: st.size });
  }
  return out;
}

function listSkills() {
  if (!fs.existsSync(ROOT)) return [];
  const skills = [];
  for (const name of fs.readdirSync(ROOT)) {
    const dir = path.join(ROOT, name);
    try {
      if (!fs.statSync(dir).isDirectory()) continue;
      const metaPath = path.join(dir, 'meta.json');
      if (!fs.existsSync(metaPath)) continue;
      const meta = JSON.parse(fs.readFileSync(metaPath, 'utf8'));
      const id = meta.name || name;
      const skillPath = path.join(dir, 'SKILL.md');
      const schemaPath = path.join(dir, 'instance-schema.json');
      skills.push({
        id,
        dir,
        meta: { ...meta, name: id },
        skillMd: fs.existsSync(skillPath) ? fs.readFileSync(skillPath, 'utf8') : '',
        schema: fs.existsSync(schemaPath) ? JSON.parse(fs.readFileSync(schemaPath, 'utf8')) : null,
        runnerFiles: listRunnerFiles(path.join(dir, 'runner')),
      });
    } catch (e) {
      process.stderr.write(`priority-catalog: skipping ${name}: ${e.message}\n`);
    }
  }
  return skills.sort((a, b) => a.id.localeCompare(b.id));
}

function getSkill(name) {
  const all = listSkills();
  if (!name) return all.length === 1 ? all[0] : null;
  const key = name.trim().toLowerCase();
  return all.find((s) => s.id.toLowerCase() === key) || null;
}

function readRunnerFile(skill, rel) {
  const safe = rel.replace(/\\/g, '/').replace(/^\/+/, '');
  if (safe.includes('..')) return null;
  const root = path.join(skill.dir, 'runner');
  const full = path.join(root, ...safe.split('/'));
  if (!full.startsWith(root) || !fs.existsSync(full) || fs.statSync(full).isDirectory()) return null;
  return fs.readFileSync(full, 'utf8');
}

const TOOLS = [
  { name: 'list_catalog', description: 'List skills in the local Priority catalog (agentic_fomprep v2/apps/mcp-catalog/catalog). Adding a folder under catalog/ with meta.json registers a new skill. This server does not compile Priority forms.', inputSchema: { type: 'object', properties: {}, additionalProperties: false } },
  { name: 'get_skill', description: 'Return SKILL.md for a catalog skill. Pass name when more than one skill exists.', inputSchema: { type: 'object', properties: { name: { type: 'string', description: 'Skill folder / meta.name' } }, additionalProperties: false } },
  { name: 'get_instance_schema', description: 'JSON Schema for the user-owned instance allowlist (no secrets).', inputSchema: { type: 'object', properties: { name: { type: 'string' } }, additionalProperties: false } },
  { name: 'get_runner_files', description: 'Manifest of portable runner files for a skill. Optional path returns one file body. Does not execute prepare.', inputSchema: { type: 'object', properties: { name: { type: 'string' }, path: { type: 'string', description: 'Relative path under runner/' } }, additionalProperties: false } },
];

const text = (t, isError = false) => ({ content: [{ type: 'text', text: t }], ...(isError ? { isError: true } : {}) });
const json = (o) => text(JSON.stringify(o, null, 2));

function callTool(name, a = {}) {
  const skillName = typeof a.name === 'string' ? a.name : undefined;
  if (name === 'list_catalog') {
    return json({
      host: 'local stdio (v2/apps/mcp-catalog/stdio.mjs)',
      catalog: ROOT,
      execute: 'local - user instances.json + CredMan; this MCP does not prepare forms',
      addSkill: 'add v2/apps/mcp-catalog/catalog/<name>/meta.json + SKILL.md',
      skills: listSkills().map((s) => ({ name: s.id, title: s.meta.title, description: s.meta.description, version: s.meta.version, runnerFileCount: s.runnerFiles.length })),
    });
  }
  const skill = getSkill(skillName);
  if (!skill) {
    const all = listSkills();
    return text(!skillName && all.length > 1 ? `name required; catalog has: ${all.map((s) => s.id).join(', ')}` : `unknown skill '${skillName || ''}'`, true);
  }
  if (name === 'get_skill') return text(skill.skillMd);
  if (name === 'get_instance_schema') return skill.schema ? json(skill.schema) : text('no instance-schema.json', true);
  if (name === 'get_runner_files') {
    const rel = typeof a.path === 'string' ? a.path : '';
    if (rel) {
      const body = readRunnerFile(skill, rel);
      return body === null ? text('file not found', true) : text(body);
    }
    return json({ skill: skill.id, files: skill.runnerFiles, hint: 'call again with path to fetch one file' });
  }
  return text(`unknown tool ${name}`, true);
}

function handle(msg) {
  if (!msg || typeof msg !== 'object' || typeof msg.method !== 'string') {
    return msg && 'id' in msg ? { jsonrpc: '2.0', id: msg.id, error: { code: -32600, message: 'invalid request' } } : null;
  }
  const { id, method } = msg;
  const params = msg.params || {};
  if (!('id' in msg) || method.startsWith('notifications/')) return null;
  const ok = (result) => ({ jsonrpc: '2.0', id, result });
  switch (method) {
    case 'initialize':
      return ok({
        protocolVersion: PROTOCOLS.includes(params.protocolVersion) ? params.protocolVersion : '2024-11-05',
        capabilities: { tools: {}, resources: {} },
        serverInfo: SERVER,
        instructions: 'Catalog only. list_catalog then get_skill. Prepare forms locally from user instances.json.',
      });
    case 'ping': return ok({});
    case 'tools/list': return ok({ tools: TOOLS });
    case 'tools/call': return ok(callTool(String(params.name || ''), params.arguments || {}));
    case 'resources/list':
      return ok({ resources: listSkills().map((s) => ({ uri: `skill://${s.id}`, name: s.meta.title || s.id, mimeType: 'text/markdown' })) });
    case 'resources/read': {
      const m = String(params.uri || '').match(/^skill:\/\/([^/]+)$/);
      const s = m ? getSkill(m[1]) : null;
      if (!s) return { jsonrpc: '2.0', id, error: { code: -32002, message: 'unknown resource' } };
      return ok({ contents: [{ uri: params.uri, mimeType: 'text/markdown', text: s.skillMd }] });
    }
    default:
      return { jsonrpc: '2.0', id, error: { code: -32601, message: `method not found: ${method}` } };
  }
}

const rl = readline.createInterface({ input: process.stdin, crlfDelay: Infinity });
rl.on('line', (line) => {
  if (!line.trim()) return;
  let resp;
  try { resp = handle(JSON.parse(line)); }
  catch (e) { resp = { jsonrpc: '2.0', id: null, error: { code: -32700, message: `parse error: ${e.message}` } }; }
  if (resp) process.stdout.write(JSON.stringify(resp) + '\n');
});
rl.on('close', () => process.exit(0));
