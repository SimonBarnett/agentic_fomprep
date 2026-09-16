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

async function firstVisible(page, builder) {
  for (const f of page.frames()) {
    try {
      const loc = builder(f);
      if (await loc.first().isVisible().catch(() => false)) return loc.first();
    } catch {
      /* frame navigated */
    }
  }
  return null;
}

async function waitVisible(page, builder, timeoutMs) {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    const loc = await firstVisible(page, builder);
    if (loc) return loc;
    await page.waitForTimeout(250);
  }
  return null;
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
    let ui = page;
    if (isLogin(page.url(), await page.title())) {
      result.auth = 'expired';
      result.exitReason = 'login_page';
      writeResult();
      await browser.close();
      process.exit(2);
    }

    const homeTile = await waitVisible(
      page,
      (f) => f.getByText(selectors.dashboardShortcut, { exact: true }),
      25000
    );
    if (!homeTile) {
      result.auth = 'expired';
      result.exitReason = 'no_form_preparation_tile';
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

    const companyDlg = await waitVisible(page, (f) => f.getByText(selectors.selectCompany || 'Select Company', { exact: false }), 3000);
    if (companyDlg) {
      const want = selectors.companyName || 'D - Clarkson Evans Live';
      const looksLive = /pri|production|\blive\b/i.test(want);
      if (looksLive && selectors.allowLiveCompanyLabel !== true) {
        result.exitReason = 'company_live_refused';
        writeResult();
        await browser.close();
        process.exit(2);
      }
      const opt = await waitVisible(page, (f) => f.getByText(want, { exact: true }), 5000);
      if (!opt) {
        result.exitReason = 'company_pin_missing';
        writeResult();
        await browser.close();
        process.exit(2);
      }
      await opt.click();
      const companyOk = await firstVisible(page, (f) => f.getByRole('button', { name: selectors.ok }));
      if (companyOk) await companyOk.click();
      await screenshot(page, 'company');
    }

    const formTile = await waitVisible(page, (f) => f.getByText(selectors.formPreparation, { exact: true }), 15000);
    if (!formTile) {
      result.exitReason = 'no_form_preparation';
      writeResult();
      await browser.close();
      process.exit(1);
    }
    const popupP = page.waitForEvent('popup', { timeout: 20000 }).catch(() => null);
    await formTile.click();
    const popup = await popupP;
    ui = popup || page;
    await ui.waitForTimeout(2000);
    await screenshot(ui, 'form-prep');

    await waitVisible(ui, (f) => f.getByText(selectors.unpreparedForms, { exact: false }), 20000);
    const okBtn = await waitVisible(ui, (f) => f.getByRole('button', { name: selectors.ok }), 10000);
    if (okBtn) {
      await okBtn.click();
    } else {
      const anyOk = await firstVisible(ui, (f) => f.getByText(selectors.ok, { exact: true }));
      if (anyOk) await anyOk.click();
    }
    await screenshot(ui, 'after-ok');

    const deadline = Date.now() + timeoutMs;
    let blocked = false;
    while (Date.now() < deadline) {
      if (result.exitReason === 'blocked-run') {
        blocked = true;
        break;
      }
      const modal = await firstVisible(ui, (f) => f.locator('[role="dialog"], .modal, .ui-dialog, .p-dialog'));
      if (modal) {
        const text = await modal.innerText().catch(() => '');
        await screenshot(ui, 'html-modal');
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

      const show = await firstVisible(ui, (f) => f.getByText(selectors.showReports, { exact: false }));
      if (show) {
        const okOnShow = await firstVisible(ui, (f) => f.getByRole('button', { name: selectors.ok }));
        if (okOnShow) {
          result.dialogs.push({ text: 'Show Reports', action: 'dismissed-safe' });
          await okOnShow.click();
        }
      }

      const errTab = await firstVisible(ui, (f) => f.getByText(selectors.errorsReport, { exact: false }));
      if (errTab) {
        await errTab.click();
        const jsonlPath = path.join(captureDir, 'errors-report.jsonl');
        const rows = [];
        for (const f of ui.frames()) {
          const trs = f.locator('table tr');
          const n = await trs.count().catch(() => 0);
          for (let i = 0; i < Math.min(n, 200); i++) {
            const t = String(await trs.nth(i).innerText().catch(() => '')).replace(/\s+/g, ' ').trim();
            if (t) rows.push(JSON.stringify({ source: 'errors-report', text: t, seq: rows.length }));
          }
        }
        fs.writeFileSync(jsonlPath, rows.join('\n'));
        result.errorsReportJsonl = jsonlPath;
        result.exitReason = 'completed';
        break;
      }

      // Progress is NOT the Form Preparation menu title (P0-W1). Prefer a progressbar/status.
      const bar = await firstVisible(ui, (f) => f.getByRole('progressbar'));
      const status = await firstVisible(ui, (f) => f.getByRole('status'));
      const progressLabel = selectors.progressText && selectors.progressText !== selectors.formPreparation
        ? await firstVisible(ui, (f) => f.getByText(selectors.progressText, { exact: false }))
        : null;
      const barVis = !!bar;
      const statusVis = !!status;
      const labelVis = !!progressLabel;
      if (barVis || statusVis || labelVis) {
        result.progressSeen = true;
      }
      if (!barVis && !statusVis && !labelVis && result.progressSeen) {
        result.exitReason = 'completed';
        break;
      }
      await page.waitForTimeout(1000);
    }

    if (!blocked && result.exitReason === 'started') {
      result.exitReason = 'timeout';
    }
    await screenshot(ui, 'final');
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
