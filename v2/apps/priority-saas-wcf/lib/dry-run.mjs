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

export function verbIsWrite(verb) {
  const v = String(verb || '');
  if (v === 'form.set' || v === 'form.save' || v === 'form.action') return true;
  if (v.startsWith('prepare.')) return true;
  if (v === 'proc.start') return true;
  return false;
}

export function planDryRun(argv, { instancesPath } = {}) {
  const verb = verbFromArgv(argv);
  const pathArg = instancesPath || flagValue(argv, '--instances') || defaultInstancesPath();
  const instanceId = flagValue(argv, '--instance');
  const allow = readAllowlist(pathArg);
  const picked = selectInstance(allow, instanceId);
  if (!picked.ok) {
    return {
      ok: false,
      reason: picked.reason || 'instance_unknown',
      instanceId: instanceId || picked.instanceId || '',
      verb,
      write: verbIsWrite(verb),
    };
  }
  return {
    ok: true,
    instanceId: picked.instance.id,
    verb,
    write: verbIsWrite(verb),
  };
}

function flagValue(argv, name) {
  const i = argv.indexOf(name);
  if (i >= 0 && i + 1 < argv.length) return argv[i + 1];
  return '';
}
