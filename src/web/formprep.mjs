/**
 * Priority web Form Prep. DEV only.
 * Path: dashboard -> My Shortcuts -> Form Preparation -> Unprepared Forms (default) -> OK
 *        -> wait progress -> Show Reports OK (safe) -> Errors Report if present.
 * Never click Ignore / Yes on index or duplicate dialogs.
 * Pin selectors.json with the last date they worked on DEV1.
 */
import { chromium } from 'playwright';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

function arg(name, fallback = '') {
  const i = process.argv.indexOf(name);
  if (i >= 0 && i + 1 < process.argv.length) return process.argv[i + 1];
  return fallback;
}

const baseUrl = arg('--baseUrl');
const storageState = arg('--storageState');
const runDir = arg('--runDir');
const selectorsPath = arg('--selectors');
const timeoutMs = Number(arg('--timeoutMs', '900000')) || 900000;

const captureDir = path.join(runDir, 'capture');
fs.mkdirSync(captureDir, { recursive: true });

const selectors = JSON.parse(fs.readFileSync(selectorsPath, 'utf8'));
const result = {
  auth: 'unknown',
  exitReason: 'started',
  dialogs: [],
  progressSeen: false,
  errorsReportPath: null,
};

function writeResult() {
  fs.writeFileSync(path.join(runDir, 'web-result.json'), JSON.stringify(result, null, 2));
}

function isLogin(url, title) {
  const u = String(url || '');
  const t = String(title || '');
  const urlRe = new RegExp(selectors.loginUrlPattern, 'i');
  const titleRe = new RegExp(selectors.loginTitlePattern, 'i');
  return urlRe.test(u) || titleRe.test(t);
}

function dangerous(text) {
  return new RegExp(selectors.dangerousDialog, 'i').test(String(text || ''));
}

let shot = 0;
async function screenshot(page, name) {
  shot += 1;
  const file = path.join(captureDir, `${String(shot).padStart(2, '0')}-${name}.png`);
  try {
    await page.screenshot({ path: file, fullPage: true });
  } catch {
    /* page may already be gone */
  }
  return file;
}

async function main() {
  if (!baseUrl || !runDir) {
    result.exitReason = 'missing_args';
    writeResult();
    process.exit(1);
  }

  const host = new URL(baseUrl).host;
  if (host !== 'prioritydev.clarksonevans.co.uk') {
    result.exitReason = 'webhost_refused';
    writeResult();
    process.exit(2);
  }

  const launchOpts = { headless: false };
  const contextOpts = { viewport: { width: 1400, height: 900 } };
  if (storageState && fs.existsSync(storageState)) {
    contextOpts.storageState = storageState;
  }

  let browser;
  try {
    browser = await chromium.launch(launchOpts);
  } catch (err) {
    result.exitReason = String(err && err.message ? err.message : err);
    writeResult();
    process.exit(1);
  }
  const context = await browser.newContext(contextOpts);
  const page = await context.newPage();
  page.setDefaultTimeout(Math.min(timeoutMs, 60000));

  page.on('dialog', async (dialog) => {
    const text = dialog.message();
    const type = dialog.type();
    await screenshot(page, 'js-dialog');
    if (dangerous(text)) {
      result.dialogs.push({ text, type, action: 'blocked-run' });
      result.exitReason = 'blocked-run';
      try { await dialog.dismiss(); } catch { /* ignore */ }
      return;
    }
    // Show Reports OK is a safe dismiss in Priority; window.alert/confirm is not auto-accepted
    // unless the text clearly matches Show Reports.
    if (/show reports/i.test(text) && type !== 'prompt') {
      result.dialogs.push({ text, type, action: 'dismissed-safe' });
      try { await dialog.accept(); } catch { /* ignore */ }
      return;
    }
    result.dialogs.push({ text, type, action: 'captured-left' });
    try { await dialog.dismiss(); } catch { /* ignore */ }
  });

  try {
    await page.goto(baseUrl, { waitUntil: 'domcontentloaded', timeout: 30000 });
    await screenshot(page, 'after-goto');
    if (isLogin(page.url(), await page.title())) {
      result.auth = 'expired';
      result.exitReason = 'login_page';
      writeResult();
      await browser.close();
      process.exit(2);
    }

    // Dashboard shortcuts tile should appear within 20s
    const shortcut = page.getByText(selectors.dashboardShortcut, { exact: false }).first();
    try {
      await shortcut.waitFor({ timeout: 20000 });
    } catch {
      result.auth = 'expired';
      result.exitReason = 'no_shortcuts_tile';
      writeResult();
      await browser.close();
      process.exit(2);
    }
    result.auth = 'ok';

    const other = new RegExp(selectors.otherSession, 'i');
    const bodyText = await page.locator('body').innerText().catch(() => '');
    if (other.test(bodyText)) {
      result.exitReason = 'other_session';
      result.dialogs.push({ text: bodyText.slice(0, 500), action: 'blocked-run' });
      await screenshot(page, 'other-session');
      writeResult();
      await browser.close();
      process.exit(3);
    }

    await shortcut.click();
    await screenshot(page, 'shortcuts');
    await page.getByText(selectors.formPreparation, { exact: false }).first().click();
    await screenshot(page, 'form-prep');

    // Leave Prep Type at Unprepared Forms (default). Click OK.
    const unprepared = page.getByText(selectors.unpreparedForms, { exact: false }).first();
    try { await unprepared.waitFor({ timeout: 15000 }); } catch { /* default may already be selected */ }
    await page.getByRole('button', { name: selectors.ok }).first().click();
    result.progressSeen = true;
    await screenshot(page, 'progress');

    const deadline = Date.now() + timeoutMs;
    let blocked = false;
    while (Date.now() < deadline) {
      if (result.exitReason === 'blocked-run') {
        blocked = true;
        break;
      }
      // HTML modals (not window.dialog)
      const modal = page.locator('[role="dialog"], .modal, .ui-dialog, .p-dialog').first();
      if (await modal.isVisible().catch(() => false)) {
        const text = await modal.innerText().catch(() => '');
        await screenshot(page, 'html-modal');
        if (dangerous(text) || !text) {
          result.dialogs.push({ text: text || '(empty modal)', action: 'blocked-run' });
          result.exitReason = 'blocked-run';
          blocked = true;
          break;
        }
        if (/show reports/i.test(text)) {
          result.dialogs.push({ text, action: 'dismissed-safe' });
          const okBtn = modal.getByRole('button', { name: selectors.ok });
          if (await okBtn.count()) await okBtn.first().click();
        } else {
          result.dialogs.push({ text, action: 'captured-left' });
          result.exitReason = 'blocked-run';
          blocked = true;
          break;
        }
      }

      const show = page.getByText(selectors.showReports, { exact: false });
      if (await show.first().isVisible().catch(() => false)) {
        const okBtn = page.getByRole('button', { name: selectors.ok });
        if (await okBtn.count()) {
          result.dialogs.push({ text: 'Show Reports', action: 'dismissed-safe' });
          await okBtn.first().click();
        }
      }

      const errTab = page.getByText(selectors.errorsReport, { exact: false });
      if (await errTab.first().isVisible().catch(() => false)) {
        await errTab.first().click();
        const html = await page.content();
        const reportPath = path.join(captureDir, 'errors-report.html');
        fs.writeFileSync(reportPath, html);
        result.errorsReportPath = reportPath;
        result.exitReason = 'completed';
        break;
      }

      // Progress gone and no modal: treat as completed; SQL is the real signal.
      const progress = page.getByText(selectors.progressText, { exact: false });
      const progressVisible = await progress.first().isVisible().catch(() => false);
      if (!progressVisible && result.progressSeen && Date.now() > deadline - timeoutMs + 8000) {
        result.exitReason = 'completed';
        break;
      }
      await page.waitForTimeout(1000);
    }

    if (!blocked && result.exitReason === 'started') {
      result.exitReason = 'timeout';
    }
    await screenshot(page, 'final');
    try {
      await context.storageState({ path: storageState });
    } catch {
      /* do not fail the run if we cannot refresh storage */
    }
    writeResult();
    await browser.close();
    if (result.exitReason === 'blocked-run') process.exit(3);
    if (result.exitReason === 'timeout') process.exit(5);
    process.exit(0);
  } catch (err) {
    result.exitReason = String(err && err.message ? err.message : err);
    writeResult();
    try { await browser.close(); } catch { /* ignore */ }
    process.exit(1);
  }
}

const __filename = fileURLToPath(import.meta.url);
if (process.argv[1] && path.resolve(process.argv[1]) === __filename) {
  main();
}
