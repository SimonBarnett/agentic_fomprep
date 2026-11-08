import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const appRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

const traces = [
  '.next/server/app/page.js.nft.json',
  '.next/server/app/mcp/route.js.nft.json',
];

function fail(message) {
  process.stderr.write(`catalog-trace: ${message}\n`);
  process.exit(1);
}

if (fs.existsSync(path.join(appRoot, '.next/standalone'))) {
  fail('output standalone is present; Amplify uploads .next and would ship a second server');
}

const requiredPath = path.join(appRoot, '.next/required-server-files.json');
if (!fs.existsSync(requiredPath)) fail('missing .next/required-server-files.json');
const required = JSON.parse(fs.readFileSync(requiredPath, 'utf8'));
if (required.config && required.config.output === 'export') {
  fail('static export cannot serve POST /mcp');
}

for (const rel of traces) {
  const full = path.join(appRoot, rel);
  if (!fs.existsSync(full)) fail(`missing ${rel}`);
  const nft = JSON.parse(fs.readFileSync(full, 'utf8'));
  const files = Array.isArray(nft.files) ? nft.files : [];
  const catalog = files.filter((item) => {
    const norm = String(item).replace(/\\/g, '/');
    return norm.includes('/catalog/') || norm.startsWith('catalog/');
  });
  const skills = catalog.filter((item) => item.replace(/\\/g, '/').endsWith('/SKILL.md'));
  if (catalog.length < 10 || skills.length < 1) {
    fail(`${rel} traced ${catalog.length} catalog files and ${skills.length} SKILL.md files`);
  }
  process.stdout.write(`catalog-trace: ${rel} files=${catalog.length} skills=${skills.length}\n`);
}

process.stdout.write('catalog-trace: ok\n');
