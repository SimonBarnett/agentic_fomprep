import { chromium } from 'playwright';
import fs from 'node:fs';

const storageState = 'C:\\Priority\\tmp\\agent-formprep\\si-web-state.json';
const shot = 'C:\\Priority\\tmp\\agent-formprep\\dump-frames.png';
const out = 'C:\\Priority\\tmp\\agent-formprep\\dump-frames.txt';

const browser = await chromium.launch({ headless: false });
const context = await browser.newContext({ storageState, viewport: { width: 1400, height: 900 } });
const page = await context.newPage();
await page.goto('https://prioritydev.clarksonevans.co.uk/', { waitUntil: 'domcontentloaded', timeout: 30000 });
await page.waitForTimeout(15000);
await page.screenshot({ path: shot, fullPage: true }).catch(() => {});
const lines = [];
lines.push('url=' + page.url());
lines.push('title=' + (await page.title()));
lines.push('frames=' + page.frames().length);
for (const [i, f] of page.frames().entries()) {
  const t = await f.innerText('body').catch(() => '');
  const snippet = String(t || '').replace(/\s+/g, ' ').slice(0, 800);
  lines.push('--- frame ' + i + ' url=' + f.url());
  lines.push(snippet);
}
fs.writeFileSync(out, lines.join('\n'), 'utf8');
console.log(out);
await browser.close();
