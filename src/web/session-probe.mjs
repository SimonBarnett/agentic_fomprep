/**
 * P0-A1: 10s live session probe before park. Cookie file is not sufficient.
 * Exit 0 = dashboard-like page. Exit 2 = login / missing state.
 */
import { chromium } from 'playwright';
import fs from 'node:fs';

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

const baseUrl = arg('--baseUrl');
const storageState = arg('--storageState');
const timeoutMs = Number(arg('--timeoutMs', '10000')) || 10000;

function isLogin(url, title) {
  const u = String(url || '');
  const t = String(title || '');
  return /login|signin|sign-in|logon/i.test(u) || /login|sign in|logon/i.test(t);
}

async function main() {
  if (!baseUrl) {
    console.log(JSON.stringify({ auth: 'expired', reason: 'missing_baseUrl' }));
    process.exit(2);
  }
  const host = new URL(baseUrl).host;
  if (host !== 'prioritydev.clarksonevans.co.uk') {
    console.log(JSON.stringify({ auth: 'expired', reason: 'webhost_refused' }));
    process.exit(2);
  }
  if (!storageState || !fs.existsSync(storageState)) {
    console.log(JSON.stringify({ auth: 'expired', reason: 'storage_state_missing' }));
    process.exit(2);
  }

  // Headless misses the framed dashboard on this build (P1-A1b). Headed probe matches capture.
  const browser = await chromium.launch({ headless: false });
  try {
    const context = await browser.newContext({ storageState, viewport: { width: 1200, height: 800 } });
    const page = await context.newPage();
    page.setDefaultTimeout(timeoutMs);
    await page.goto(baseUrl, { waitUntil: 'domcontentloaded', timeout: timeoutMs });
    const deadline = Date.now() + Math.max(timeoutMs, 20000);
    let found = false;
    let url = page.url();
    let title = await page.title();
    while (Date.now() < deadline) {
      url = page.url();
      title = await page.title();
      if (isLogin(url, title)) {
        console.log(JSON.stringify({ auth: 'expired', reason: 'login_page', url, title }));
        process.exit(2);
      }
      for (const f of page.frames()) {
        for (const text of ['Form Preparation', 'My Shortcuts', 'Select Company']) {
          const loc = f.getByText(text, { exact: false }).first();
          if (await loc.isVisible().catch(() => false)) {
            found = true;
            break;
          }
        }
        if (found) break;
      }
      if (found) break;
      await page.waitForTimeout(250);
    }
    if (!found) {
      console.log(JSON.stringify({ auth: 'expired', reason: 'no_shortcuts_tile', url, title }));
      process.exit(2);
    }
    console.log(JSON.stringify({ auth: 'ok', reason: 'live_probe_shortcuts', url, title }));
    process.exit(0);
  } finally {
    await browser.close();
  }
}

main().catch((err) => {
  console.log(JSON.stringify({ auth: 'expired', reason: String(err && err.message ? err.message : err) }));
  process.exit(2);
});
