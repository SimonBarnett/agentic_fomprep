import { getSkill, listSkills, readRunnerFile, type SkillRecord } from './catalog';

const PROTOCOL = '2024-11-05';
const SERVER = { name: 'mcp-priority', version: '1.0.0' };

const TOOLS = [
  {
    name: 'list_catalog',
    description:
      'List skills published on mcp-priority. Adding a folder under catalog/ with meta.json registers a new skill. This host does not compile Priority forms.',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
  {
    name: 'get_skill',
    description:
      'Return SKILL.md for a catalog skill. Pass name when more than one skill exists. Default skill today: priority-formprep.',
    inputSchema: {
      type: 'object',
      properties: { name: { type: 'string', description: 'Skill folder / meta.name' } },
      additionalProperties: false,
    },
  },
  {
    name: 'get_instance_schema',
    description: 'JSON Schema for the user-owned instance allowlist (no secrets).',
    inputSchema: {
      type: 'object',
      properties: { name: { type: 'string' } },
      additionalProperties: false,
    },
  },
  {
    name: 'get_runner_files',
    description:
      'Manifest of portable runner files for a skill. Optional path returns one file body. Does not execute prepare.',
    inputSchema: {
      type: 'object',
      properties: {
        name: { type: 'string' },
        path: { type: 'string', description: 'Relative path under runner/' },
      },
      additionalProperties: false,
    },
  },
];

function textResult(text: string) {
  return { content: [{ type: 'text', text }] };
}

function jsonResult(obj: unknown) {
  return textResult(JSON.stringify(obj, null, 2));
}

function needSkill(name?: string): { ok: true; skill: SkillRecord } | { ok: false; error: string } {
  const skill = getSkill(name);
  if (skill) return { ok: true, skill };
  const all = listSkills();
  if (!name && all.length > 1) {
    return { ok: false, error: `name required; catalog has: ${all.map((s) => s.id).join(', ')}` };
  }
  return { ok: false, error: `unknown skill '${name || ''}'` };
}

function callTool(name: string, args: Record<string, unknown> | undefined) {
  const a = args || {};
  const skillName = typeof a.name === 'string' ? a.name : undefined;

  if (name === 'list_catalog') {
    return jsonResult({
      host: 'https://mcp-priority.ntsa.uk',
      execute: 'local — user instances.json + CredMan; this MCP does not prepare forms',
      addSkill: 'add apps/mcp-catalog/catalog/<name>/meta.json + SKILL.md',
      skills: listSkills().map((s) => ({
        name: s.id,
        title: s.meta.title,
        description: s.meta.description,
        version: s.meta.version,
        runnerFileCount: s.runnerFiles.length,
      })),
    });
  }

  if (name === 'get_skill') {
    const got = needSkill(skillName);
    if (!got.ok) return { isError: true, ...textResult(got.error) };
    return textResult(got.skill.skillMd);
  }

  if (name === 'get_instance_schema') {
    const got = needSkill(skillName);
    if (!got.ok) return { isError: true, ...textResult(got.error) };
    if (!got.skill.schema) return { isError: true, ...textResult('no instance-schema.json') };
    return jsonResult(got.skill.schema);
  }

  if (name === 'get_runner_files') {
    const got = needSkill(skillName);
    if (!got.ok) return { isError: true, ...textResult(got.error) };
    const rel = typeof a.path === 'string' ? a.path : '';
    if (rel) {
      const body = readRunnerFile(got.skill, rel);
      if (body === null) return { isError: true, ...textResult('file not found') };
      return textResult(body);
    }
    return jsonResult({
      skill: got.skill.id,
      files: got.skill.runnerFiles,
      hint: 'call again with path to fetch one file',
    });
  }

  return { isError: true, ...textResult(`unknown tool ${name}`) };
}

export function handleMcp(body: unknown): unknown {
  const msg = body as { jsonrpc?: string; id?: unknown; method?: string; params?: Record<string, unknown> };
  if (!msg || msg.jsonrpc !== '2.0' || !msg.method) {
    return { jsonrpc: '2.0', id: msg && msg.id, error: { code: -32600, message: 'invalid request' } };
  }

  const id = msg.id;
  const method = msg.method;
  const params = msg.params || {};

  if (method === 'initialize') {
    return {
      jsonrpc: '2.0',
      id,
      result: {
        protocolVersion: PROTOCOL,
        capabilities: { tools: {}, resources: {} },
        serverInfo: SERVER,
        instructions:
          'Catalog only. list_catalog then get_skill. Prepare forms locally from user instances.json. Do not expect prepare_form on this host.',
      },
    };
  }
  if (method === 'notifications/initialized' || method === 'initialized') {
    return null;
  }
  if (method === 'ping') {
    return { jsonrpc: '2.0', id, result: {} };
  }
  if (method === 'tools/list') {
    return { jsonrpc: '2.0', id, result: { tools: TOOLS } };
  }
  if (method === 'tools/call') {
    const tool = String(params.name || '');
    const args = (params.arguments || {}) as Record<string, unknown>;
    const result = callTool(tool, args);
    return { jsonrpc: '2.0', id, result };
  }
  if (method === 'resources/list') {
    const resources = listSkills().map((s) => ({
      uri: `skill://${s.id}`,
      name: s.meta.title,
      mimeType: 'text/markdown',
    }));
    return { jsonrpc: '2.0', id, result: { resources } };
  }
  if (method === 'resources/read') {
    const uri = String(params.uri || '');
    const m = uri.match(/^skill:\/\/([^/]+)$/);
    const skill = m ? getSkill(m[1]) : null;
    if (!skill) {
      return { jsonrpc: '2.0', id, error: { code: -32002, message: 'unknown resource' } };
    }
    return {
      jsonrpc: '2.0',
      id,
      result: {
        contents: [{ uri, mimeType: 'text/markdown', text: skill.skillMd }],
      },
    };
  }

  return { jsonrpc: '2.0', id, error: { code: -32601, message: `method not found: ${method}` } };
}

export const corsHeaders: Record<string, string> = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'content-type, mcp-session-id, mcp-protocol-version',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
};
