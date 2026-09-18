import fs from 'node:fs';
import path from 'node:path';

export type SkillMeta = {
  name: string;
  title: string;
  description: string;
  version: string;
};

export type SkillRecord = {
  id: string;
  dir: string;
  meta: SkillMeta;
  skillMd: string;
  schema: unknown | null;
  runnerFiles: { path: string; bytes: number }[];
};

const SKIP = new Set(['node_modules', '.git', '.next']);

export function catalogRoot(): string {
  return path.join(process.cwd(), 'catalog');
}

function listRunnerFiles(dir: string, rel = ''): { path: string; bytes: number }[] {
  const out: { path: string; bytes: number }[] = [];
  if (!fs.existsSync(dir)) return out;
  for (const name of fs.readdirSync(dir)) {
    if (SKIP.has(name)) continue;
    const full = path.join(dir, name);
    const childRel = rel ? `${rel}/${name}` : name;
    const st = fs.statSync(full);
    if (st.isDirectory()) out.push(...listRunnerFiles(full, childRel));
    else out.push({ path: childRel.replace(/\\/g, '/'), bytes: st.size });
  }
  return out;
}

export function listSkills(): SkillRecord[] {
  const root = catalogRoot();
  if (!fs.existsSync(root)) return [];
  const skills: SkillRecord[] = [];
  for (const name of fs.readdirSync(root)) {
    const dir = path.join(root, name);
    if (!fs.statSync(dir).isDirectory()) continue;
    const metaPath = path.join(dir, 'meta.json');
    if (!fs.existsSync(metaPath)) continue;
    const meta = JSON.parse(fs.readFileSync(metaPath, 'utf8')) as SkillMeta;
    const id = meta.name || name;
    const skillPath = path.join(dir, 'SKILL.md');
    const skillMd = fs.existsSync(skillPath) ? fs.readFileSync(skillPath, 'utf8') : '';
    const schemaPath = path.join(dir, 'instance-schema.json');
    const schema = fs.existsSync(schemaPath)
      ? JSON.parse(fs.readFileSync(schemaPath, 'utf8'))
      : null;
    skills.push({
      id,
      dir,
      meta: { ...meta, name: id },
      skillMd,
      schema,
      runnerFiles: listRunnerFiles(path.join(dir, 'runner')),
    });
  }
  skills.sort((a, b) => a.id.localeCompare(b.id));
  return skills;
}

export function getSkill(name?: string): SkillRecord | null {
  const all = listSkills();
  if (!name) return all.length === 1 ? all[0] : null;
  const key = name.trim().toLowerCase();
  return all.find((s) => s.id.toLowerCase() === key) || null;
}

export function readRunnerFile(skill: SkillRecord, rel: string): string | null {
  const safe = rel.replace(/\\/g, '/').replace(/^\/+/, '');
  if (safe.includes('..')) return null;
  const full = path.join(skill.dir, 'runner', ...safe.split('/'));
  const root = path.join(skill.dir, 'runner');
  if (!full.startsWith(root)) return null;
  if (!fs.existsSync(full) || fs.statSync(full).isDirectory()) return null;
  return fs.readFileSync(full, 'utf8');
}
