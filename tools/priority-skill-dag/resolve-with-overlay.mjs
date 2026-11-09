#!/usr/bin/env node
/**
 * FR #362: seat-side resolve_skills + local customer overlay merge.
 *
 * Usage:
 *   node tools/priority-skill-dag/resolve-with-overlay.mjs --task "..." [--overlay <customerRepo>] [--project SCxxxxxx]
 *     [--mcp-url https://mcp.ntsa.uk] [--public-json path|-]
 *   --mcp-url accepts base host or .../mcp (normalized).
 *
 * Only {task, max*} are sent to the public MCP. Overlay never leaves the seat.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const here = path.dirname(fileURLToPath(import.meta.url));
const overlayMod = path.resolve(here, '../../v2/apps/mcp-catalog/lib/customer-overlay.mjs');
const { resolveWithOverlay, buildPublicResolvePayload, normalizeMcpToolsUrl } = await import(pathToFileURL(overlayMod).href);

function arg(name, fallback = null) {
  const i = process.argv.indexOf(name);
  if (i >= 0 && process.argv[i + 1]) return process.argv[i + 1];
  return fallback;
}

function has(name) {
  return process.argv.includes(name);
}

const task = arg('--task') || arg('-t');
if (!task) {
  console.error('Usage: resolve-with-overlay.mjs --task "..." [--overlay DIR] [--project SCxxx] [--mcp-url URL] [--public-json path|-]');
  process.exit(2);
}

const overlayRoot = arg('--overlay') || arg('--customer') || process.env.PRIORITY_CUSTOMER_ROOT || '';
const projectFolder = arg('--project') || process.env.PRIORITY_PROJECT_FOLDER || '';
const mcpUrl = arg('--mcp-url') || process.env.PRIORITY_MCP_URL || '';
const publicJson = arg('--public-json');
const maxLessons = Number(arg('--max-lessons') || 8);
const maxSkills = Number(arg('--max-skills') || 5);
const maxBytes = Number(arg('--max-bytes') || 24000);

async function fetchFromMcp(payload) {
  const url = normalizeMcpToolsUrl(mcpUrl);
  const body = {
    jsonrpc: '2.0',
    id: 1,
    method: 'tools/call',
    params: { name: 'resolve_skills', arguments: payload },
  };
  const res = await fetch(url, {
    method: 'POST',
    headers: { 'content-type': 'application/json', accept: 'application/json' },
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`MCP HTTP ${res.status}`);
  const msg = await res.json();
  if (msg.error) throw new Error(JSON.stringify(msg.error));
  const text = msg.result?.content?.[0]?.text;
  if (!text) throw new Error('MCP resolve_skills returned no text content');
  return JSON.parse(text);
}

async function fetchFromFile(payload) {
  // payload unused for body — already public-safe; file is a stub public result
  void payload;
  const raw =
    publicJson === '-'
      ? fs.readFileSync(0, 'utf8')
      : fs.readFileSync(path.resolve(publicJson), 'utf8');
  return JSON.parse(raw);
}

async function fetchEmpty(payload) {
  return {
    query: payload.task,
    limits: buildPublicResolvePayload(payload.task, payload),
    skills: [],
    lessons: [],
  };
}

let fetchPublic;
if (publicJson) fetchPublic = fetchFromFile;
else if (mcpUrl) fetchPublic = fetchFromMcp;
else if (has('--public-empty')) fetchPublic = fetchEmpty;
else {
  console.error('Provide --mcp-url, --public-json path|-, or --public-empty (overlay-only demo)');
  process.exit(2);
}

const result = await resolveWithOverlay({
  task,
  overlayRoot: overlayRoot || null,
  projectFolder: projectFolder || null,
  maxLessons,
  maxSkills,
  maxBytes,
  fetchPublic,
});
process.stdout.write(`${JSON.stringify(result, null, 2)}\n`);
