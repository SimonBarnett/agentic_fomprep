/**
 * Headed capture of Si Playwright storageState. No secrets in git.
 * Saves to C:\Priority\tmp\agent-formprep\si-web-state.json after My Shortcuts is visible.
 */
import { chromium } from 'playwright';
import fs from 'node:fs';
import path from 'node:path';

const baseUrl = 'https://prioritydev.clarksonevans.co.uk';
const out = process.argv[2] || 'C:\\Priority\\tmp\\agent-formprep\\si-web-state.json';

const dir = path.dirname(out);
fs.mkdirSync(dir, { recursive: true });

const browser = await chromium.launch({ headless: false });
const context = await browser.newContext({ viewport: { width: 1400, height: 900 } });
const page = await context.newPage();
await page.goto(baseUrl, { waitUntil: 'domcontentloaded', timeout: 30000 });
console.log('Log in as Si. Waiting up to 5 minutes for My Shortcuts...');
await page.getByText('My Shortcuts', { exact: false }).first().waitFor({ timeout: 300000 });
await context.storageState({ path: out });
console.log('Wrote ' + out);
await browser.close();
