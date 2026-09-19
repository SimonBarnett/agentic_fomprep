/**
 * Local execute MCP: list_instances / odata_get / odata_query /
 * odata_dump_procedure / formlimited_audit / get_last_result / get_skill.
 * Catalog MCP at https://mcp-priority.ntsa.uk does not call OData.
 */
import fs from 'node:fs';
import path from 'node:path';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const pluginRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const skillMd = path.join(pluginRoot, 'skills', 'priority-odata-dev', 'SKILL.md');
const runner = path.join(pluginRoot, 'scripts', 'Invoke-PriorityOData.ps1');

function instancesPath() {
  if (process.env.PRIORITY_FORMPREP_INSTANCES) return process.env.PRIORITY_FORMPREP_INSTANCES;
  const home = process.env.USERPROFILE || process.env.HOME || '';
  return path.join(home, '.priority-formprep', 'instances.json');
}

function readAllowlist() {
  const p = instancesPath();
  if (!fs.existsSync(p)) return { path: p, instances: [] };
  const raw = JSON.parse(fs.readFileSync(p, 'utf8'));
  return { path: p, instances: Array.isArray(raw.instances) ? raw.instances : [] };
}

function publicInstance(i) {
  return {
    id: i.id,
    title: i.title || '',
    company: i.company,
    priorityUser: i.priorityUser,
    allowLive: !!i.allowLive,
    odataBaseUrl: i.odataBaseUrl || '',
  };
}

function workRoot(inst) {
  if (inst && inst.agentWork) return inst.agentWork;
  const tmp = process.env.TEMP || process.env.TMP || '/tmp';
  return path.join(tmp, 'priority-odata-' + (inst && inst.id ? inst.id : 'default'));
}

const TOOLS = [
  {
    name: 'list_instances',
    description: 'User-allowlisted Priority instances (no passwords). Empty means stop and ask the user to fill instances.json.',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
  {
    name: 'odata_get',
    description: 'GET an OData path under the allowlisted instance base. No passwords in the result.',
    inputSchema: {
      type: 'object',
      required: ['instance_id', 'path'],
      properties: {
        instance_id: { type: 'string' },
        path: { type: 'string', description: 'Path under the OData base, e.g. EPROG' },
      },
      additionalProperties: false,
    },
  },
  {
    name: 'odata_query',
    description: 'GET an OData path with $filter/$expand/$select/$top. No passwords in the result.',
    inputSchema: {
      type: 'object',
      required: ['instance_id', 'path'],
      properties: {
        instance_id: { type: 'string' },
        path: { type: 'string' },
        filter: { type: 'string' },
        expand: { type: 'string' },
        select: { type: 'string' },
        top: { type: 'integer' },
      },
      additionalProperties: false,
    },
  },
  {
    name: 'odata_dump_procedure',
    description: 'Dump EPROG PROGTEXT_SUBFORM for one caller-supplied ENAME into the instance work dir.',
    inputSchema: {
      type: 'object',
      required: ['instance_id', 'ename'],
      properties: {
        instance_id: { type: 'string' },
        ename: { type: 'string', description: 'Procedure ENAME supplied by the caller. Do not invent one.' },
      },
      additionalProperties: false,
    },
  },
  {
    name: 'formlimited_audit',
    description: 'Read-only FORMLIMITED RESTFLAG/LIMITFLAG risk list for a form set. Flags RESTFLAG without LIMITFLAG (UI-hide footgun).',
    inputSchema: {
      type: 'object',
      required: ['instance_id', 'forms'],
      properties: {
        instance_id: { type: 'string' },
        forms: { type: 'array', items: { type: 'string' } },
      },
      additionalProperties: false,
    },
  },
  {
    name: 'get_last_result',
    description: 'Last OData/audit result for an instance.',
    inputSchema: {
      type: 'object',
      properties: { instance_id: { type: 'string' } },
      additionalProperties: false,
    },
  },
  {
    name: 'get_skill',
    description: 'Local SKILL.md for priority-odata-dev.',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
];

function text(s, isError = false) {
  return { content: [{ type: 'text', text: s }], isError };
}

function json(obj, isError = false) {
  return text(JSON.stringify(obj, null, 2), isError);
}

function runOData(argList) {
  return new Promise((resolve) => {
    if (process.platform !== 'win32') {
      resolve(json({ ok: false, reason: 'windows_only' }, true));
      return;
    }
    if (!fs.existsSync(runner)) {
      resolve(json({ ok: false, reason: 'runner_missing', path: runner }, true));
      return;
    }
    const args = ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', runner].concat(argList);
    const child = spawn('powershell.exe', args, { windowsHide: true });
    let out = '';
    let err = '';
    child.stdout.on('data', (d) => { out += d.toString(); });
    child.stderr.on('data', (d) => { err += d.toString(); });
    child.on('close', (code) => {
      const jsonLine = out.trim().split(/\r?\n/).reverse().find((l) => l.trim().startsWith('{'));
      if (jsonLine) {
        try {
          resolve(json(JSON.parse(jsonLine)));
          return;
        } catch { /* fall through */ }
      }
      resolve(json({ ok: false, reason: 'runner_failed', exit: code, stderr: err.slice(0, 2000), stdout: out.slice(0, 2000) }, true));
    });
  });
}

async function callTool(name, args) {
  const a = args || {};
  if (name === 'get_skill') {
    if (!fs.existsSync(skillMd)) return text('SKILL.md missing', true);
    return text(fs.readFileSync(skillMd, 'utf8'));
  }
  if (name === 'list_instances') {
    const al = readAllowlist();
    return json({
      path: al.path,
      count: al.instances.length,
      instances: al.instances.map(publicInstance),
      hint: al.instances.length ? null : 'Copy instances.example.json to this path. Do not invent URLs.',
    });
  }
  if (name === 'odata_get') {
    if (!a.instance_id || !a.path) return text('instance_id and path required', true);
    return runOData(['-Action', 'get', '-InstanceId', String(a.instance_id), '-Path', String(a.path)]);
  }
  if (name === 'odata_query') {
    if (!a.instance_id || !a.path) return text('instance_id and path required', true);
    const list = ['-Action', 'query', '-InstanceId', String(a.instance_id), '-Path', String(a.path)];
    if (a.filter) list.push('-Filter', String(a.filter));
    if (a.expand) list.push('-Expand', String(a.expand));
    if (a.select) list.push('-Select', String(a.select));
    if (a.top !== undefined && a.top !== null && a.top !== '') list.push('-Top', String(a.top));
    return runOData(list);
  }
  if (name === 'odata_dump_procedure') {
    if (!a.instance_id || !a.ename) return text('instance_id and ename required', true);
    return runOData(['-Action', 'dump_procedure', '-InstanceId', String(a.instance_id), '-EName', String(a.ename)]);
  }
  if (name === 'formlimited_audit') {
    if (!a.instance_id) return text('instance_id required', true);
    const forms = Array.isArray(a.forms) ? a.forms.map(String) : [];
    if (!forms.length) return text('forms required', true);
    return runOData(['-Action', 'formlimited_audit', '-InstanceId', String(a.instance_id), '-Forms', forms.join(',')]);
  }
  if (name === 'get_last_result') {
    const al = readAllowlist();
    let inst = al.instances[0];
    if (a.instance_id) inst = al.instances.find((i) => i.id === a.instance_id);
    if (!inst) return json({ ok: false, reason: 'instance_unknown' }, true);
    const last = path.join(workRoot(inst), 'last-odata.json');
    if (!fs.existsSync(last)) return json({ ok: false, reason: 'no_result', path: last }, true);
    return json(JSON.parse(fs.readFileSync(last, 'utf8')));
  }
  return text('unknown tool ' + name, true);
}

function handle(msg) {
  if (!msg || msg.jsonrpc !== '2.0' || !msg.method) {
    return { jsonrpc: '2.0', id: msg && msg.id, error: { code: -32600, message: 'invalid request' } };
  }
  const { id, method, params } = msg;
  if (method === 'initialize') {
    return {
      jsonrpc: '2.0',
      id,
      result: {
        protocolVersion: '2024-11-05',
        capabilities: { tools: {} },
        serverInfo: { name: 'priority-odata-dev-local', version: '1.0.0' },
        instructions: 'Use list_instances then odata_get/odata_query/odata_dump_procedure/formlimited_audit. Catalog at https://mcp-priority.ntsa.uk/mcp is grab-only.',
      },
    };
  }
  if (method === 'notifications/initialized' || method === 'initialized') return null;
  if (method === 'ping') return { jsonrpc: '2.0', id, result: {} };
  if (method === 'tools/list') return { jsonrpc: '2.0', id, result: { tools: TOOLS } };
  if (method === 'tools/call') {
    return callTool(String(params && params.name), (params && params.arguments) || {}).then((result) => ({
      jsonrpc: '2.0',
      id,
      result,
    }));
  }
  return { jsonrpc: '2.0', id, error: { code: -32601, message: 'method not found: ' + method } };
}

function writeMsg(obj) {
  if (obj === null || obj === undefined) return;
  const buf = Buffer.from(JSON.stringify(obj), 'utf8');
  process.stdout.write('Content-Length: ' + buf.length + '\r\n\r\n');
  process.stdout.write(buf);
}

let buf = Buffer.alloc(0);
process.stdin.on('data', async (chunk) => {
  buf = Buffer.concat([buf, chunk]);
  while (true) {
    const headerEnd = buf.indexOf('\r\n\r\n');
    if (headerEnd < 0) break;
    const header = buf.slice(0, headerEnd).toString('utf8');
    const m = header.match(/Content-Length:\s*(\d+)/i);
    if (!m) {
      buf = buf.slice(headerEnd + 4);
      continue;
    }
    const len = Number(m[1]);
    const start = headerEnd + 4;
    if (buf.length < start + len) break;
    const body = buf.slice(start, start + len).toString('utf8');
    buf = buf.slice(start + len);
    let msg;
    try { msg = JSON.parse(body); } catch { continue; }
    const out = await handle(msg);
    writeMsg(out);
  }
});
process.stdin.resume();
