import { readAllowlist, selectInstance, defaultInstancesPath } from './allowlist.mjs';

/** FR #391 / FR-009: resolve instance + verb without login. */

export function verbFromArgv(argv) {
  const verb = String(argv[2] || '').toLowerCase();
  const maybeSub = String(argv[3] || '');
  const sub = maybeSub.startsWith('-') ? '' : maybeSub.toLowerCase();
  if (!verb) return '';
  if (sub) return verb + '.' + sub;
  return verb;
}

export function verbIsWrite(verb, argv = []) {
  const v = String(verb || '');
  if (v === 'form.set' || v === 'form.save' || v === 'form.action') return true;
  // FR #400: form subform --set is a write; bare subform start stays read-only.
  if (v === 'form.subform' && Array.isArray(argv) && argv.includes('--set')) return true;
  if (v.startsWith('prepare.')) return true;
  if (v === 'proc.start' || v === 'proc.continue' || v === 'report.run') return true;
  if (v === 'proc.text' && Array.isArray(argv) && argv.includes('set')) return true;
  if (v === 'table.column' && Array.isArray(argv) && argv.includes('add')) return true;
  if (v === 'table.create') return true;
  if (v === 'interface.map' && Array.isArray(argv) && argv.includes('set')) return true;
  return false;
}

export function planDryRun(argv, { instancesPath } = {}) {
  const verb = verbFromArgv(argv);
  const pathArg = instancesPath || flagValue(argv, '--instances') || defaultInstancesPath();
  const instanceId = flagValue(argv, '--instance');
  const allow = readAllowlist(pathArg);
  const picked = selectInstance(allow, instanceId);
  const write = verbIsWrite(verb, argv);
  if (!picked.ok) {
    return {
      ok: false,
      reason: picked.reason || 'instance_unknown',
      instanceId: instanceId || picked.instanceId || '',
      verb,
      write,
    };
  }
  return {
    ok: true,
    instanceId: picked.instance.id,
    verb,
    write,
  };
}

function flagValue(argv, name) {
  const i = argv.indexOf(name);
  if (i >= 0 && i + 1 < argv.length) return argv[i + 1];
  return '';
}
