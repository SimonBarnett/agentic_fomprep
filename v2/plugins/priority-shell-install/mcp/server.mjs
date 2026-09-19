/**
 * Local execute MCP: list_instances / install_shell / get_last_result / get_skill.
 * Catalog MCP at https://mcp-priority.ntsa.uk does not install.
 */
import fs from 'node:fs';
import path from 'node:path';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const pluginRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const skillMd = path.join(pluginRoot, 'skills', 'priority-shell-install', 'SKILL.md');
const runner = path.join(pluginRoot, 'scripts', 'Install-Shell.ps1');

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
    buildSetRoot: i.buildSetRoot || '',
  };
}

function workRoot(inst) {
  if (inst && inst.agentWork) return inst.agentWork;
  const tmp = process.env.TEMP || process.env.TMP || '/tmp';
  return path.join(tmp, 'priority-shell-' + (inst && inst.id ? inst.id : 'default'));
}

const TOOLS = [
  {
    name: 'list_instances',
    description: 'User-allowlisted Priority instances (no passwords). Empty means stop and ask the user to fill instances.json.',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
  {
    name: 'install_shell',
    description: 'Install one caller-supplied .sh on an allowlisted instance. Parses and path-allowlists before WCF. DBI refused unless allow_dbi. SQL-gated. Does not auto-prep forms. Separate from compile_shell.',
    inputSchema: {
      type: 'object',
      required: ['instance_id', 'shell'],
      properties: {
        instance_id: { type: 'string' },
        shell: { type: 'string', description: 'Path on the runner / build set, not latest in system\\upgrades' },
        allow_dbi: { type: 'boolean', description: 'Default false. DBI in the shell is refused unless true.' },
      },
      additionalProperties: false,
    },
  },
  {
    name: 'get_last_result',
    description: 'Last install_shell result for an instance.',
    inputSchema: {
      type: 'object',
      properties: { instance_id: { type: 'string' } },
      additionalProperties: false,
    },
  },
  {
    name: 'get_skill',
    description: 'Local SKILL.md for priority-shell-install.',
    inputSchema: { type: 'object', properties: {}, additionalProperties: false },
  },
];

function text(s, isError = false) {
  return { content: [{ type: 'text', text: s }], isError };
}

function json(obj, isError = false) {
  return text(JSON.stringify(obj, null, 2), isError);
}

function runInstall({ instance_id, shell, allow_dbi }) {
  return new Promise((resolve) => {
    if (process.platform !== 'win32') {
      resolve(json({ ok: false, reason: 'windows_only' }, true));
      return;
    }
    if (!fs.existsSync(runner)) {
      resolve(json({ ok: false, reason: 'runner_missing', path: runner }, true));
      return;
    }
    const args = [
      '-NoProfile',
      '-ExecutionPolicy',
      'Bypass',
      '-File',
      runner,
      '-InstanceId',
      String(instance_id),
      '-Shell',
      String(shell),
    ];
    if (allow_dbi) args.push('-AllowDbi');
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
  if (name === 'install_shell') {
    if (!a.instance_id || !a.shell) return text('instance_id and shell required', true);
    return runInstall({
      instance_id: a.instance_id,
      shell: a.shell,
      allow_dbi: !!a.allow_dbi,
    });
  }
  if (name === 'get_last_result') {
    const al = readAllowlist();
    let inst = al.instances[0];
    if (a.instance_id) inst = al.instances.find((i) => i.id === a.instance_id);
    if (!inst) return json({ ok: false, reason: 'instance_unknown' }, true);
    const last = path.join(workRoot(inst), 'last-install.json');
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
        serverInfo: { name: 'priority-shell-install-local', version: '0.1.0' },
        instructions: 'Use list_instances then install_shell. Separate from compile_shell. Catalog at https://mcp-priority.ntsa.uk/mcp is grab-only.',
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
