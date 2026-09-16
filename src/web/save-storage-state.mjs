/**
 * Headed capture of Si Playwright storageState. Search frames (Priority is iframed).
 * Saves to C:\Priority\tmp\agent-formprep\si-web-state.json
 */
import { chromium } from 'playwright';
import fs from 'node:fs';
import path from 'node:path';

const baseUrl = 'https://prioritydev.clarksonevans.co.uk';
const out = process.argv[2] || 'C:\\Priority\\tmp\\agent-formprep\\si-web-state.json';
const dir = path.dirname(out);
fs.mkdirSync(dir, { recursive: true });
const shot = path.join(dir, 'storage-capture.png');

async function visibleInFrames(page, text) {
  for (const f of page.frames()) {
    const loc = f.getByText(text, { exact: false }).first();
    if (await loc.isVisible().catch(() => false)) return true;
  }
  return false;
}

function isLogin(url, title) {
  return /login|signin|sign-in|logon/i.test(String(url || '')) || /login|sign in|logon/i.test(String(title || ''));
}

const browser = await chromium.launch({ headless: false });
const context = await browser.newContext({ viewport: { width: 1400, height: 900 } });
const page = await context.newPage();
await page.goto(baseUrl, { waitUntil: 'domcontentloaded', timeout: 30000 });
console.log('Log in as Si in THIS Chromium window (not Google Chrome).');
console.log('Waiting up to 5 minutes for My Shortcuts (all frames)...');

const deadline = Date.now() + 300000;
let found = false;
while (Date.now() < deadline) {
  if (await visibleInFrames(page, 'My Shortcuts')) {
    found = true;
    break;
  }
  if (await visibleInFrames(page, 'Form Preparation')) {
    found = true;
    break;
  }
  await page.waitForTimeout(1000);
}

await page.screenshot({ path: shot, fullPage: true }).catch(() => {});
const url = page.url();
const title = await page.title().catch(() => '');
console.log('url=' + url);
console.log('title=' + title);
console.log('dashboardTile=' + found);

if (!found) {
  console.error('Dashboard tile never appeared. Not overwriting storageState with a splash cookie.');
  await browser.close();
  process.exit(2);
}

await context.storageState({ path: out });
console.log('Wrote ' + out);
await browser.close();
