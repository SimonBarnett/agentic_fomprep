/**
 * Live hosting smoke against the public Amplify MCP (FR #364 / FR #354 acceptance #5).
 * Default origin: https://mcp.ntsa.uk  Override: SMOKE_MCP_ORIGIN
 *
 * Usage: node scripts/smoke-mcp-live.mjs
 * Exit 0 on PASS; prints a short evidence block suitable for docs / PR bodies.
 */
import assert from 'node:assert/strict';

const origin = String(process.env.SMOKE_MCP_ORIGIN || 'https://mcp.ntsa.uk').replace(/\/$/, '');
const mcpUrl = `${origin}/mcp`;
const timeoutMs = Number(process.env.SMOKE_MCP_TIMEOUT_MS || 60000);

async function rpc(method, params, id = 1) {
  const ctrl = new AbortController();
  const t = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    const res = await fetch(mcpUrl, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ jsonrpc: '2.0', id, method, params: params || {} }),
      signal: ctrl.signal,
    });
    const text = await res.text();
    assert.equal(res.status, 200, `HTTP ${res.status} for ${method}: ${text.slice(0, 200)}`);
    return JSON.parse(text);
  } finally {
    clearTimeout(t);
  }
}

function toolText(envelope) {
  const c = envelope?.result?.content;
  assert.ok(Array.isArray(c) && c[0]?.type === 'text', 'tool result content');
  return c[0].text;
}

const evidence = {
  origin,
  when: new Date().toISOString(),
  serverInfo: null,
  tools: null,
  resolveSkillIds: null,
  getDagNodeOk: null,
  getDagNodeUnknownError: null,
};

const discRes = await fetch(mcpUrl, { method: 'GET', signal: AbortSignal.timeout(timeoutMs) });
assert.equal(discRes.status, 200, 'GET /mcp');
const disc = await discRes.json();
assert.ok(Array.isArray(disc.tools) && disc.tools.includes('resolve_skills'), 'GET tools include resolve_skills');
assert.ok(disc.tools.includes('get_dag_node'), 'GET tools include get_dag_node');
evidence.tools = disc.tools;

const init = await rpc('initialize', { protocolVersion: '2024-11-05', capabilities: {} }, 1);
evidence.serverInfo = init.result?.serverInfo || null;
assert.equal(init.result?.protocolVersion, '2024-11-05');
assert.equal(init.result?.serverInfo?.name, 'mcp-priority');

const resolveEnv = await rpc(
  'tools/call',
  { name: 'resolve_skills', arguments: { task: 'form prep UAT' } },
  2,
);
const resolvePayload = JSON.parse(toolText(resolveEnv));
const skillIds = (resolvePayload.skills || []).map((s) => s.id);
assert.ok(skillIds.length > 0, 'resolve_skills returns non-empty skills');
evidence.resolveSkillIds = skillIds;

const nodeOkEnv = await rpc(
  'tools/call',
  { name: 'get_dag_node', arguments: { id: 'skill:priority-formprep' } },
  3,
);
const nodeOk = JSON.parse(toolText(nodeOkEnv));
assert.equal(nodeOk.ok, true);
assert.equal(nodeOk.node?.id, 'skill:priority-formprep');
evidence.getDagNodeOk = nodeOk.node.id;

const nodeBadEnv = await rpc(
  'tools/call',
  { name: 'get_dag_node', arguments: { id: 'skill:does-not-exist-fr364' } },
  4,
);
assert.equal(nodeBadEnv.result?.isError, true);
evidence.getDagNodeUnknownError = toolText(nodeBadEnv);

console.log('smoke-mcp-live PASS');
console.log(JSON.stringify(evidence, null, 2));
