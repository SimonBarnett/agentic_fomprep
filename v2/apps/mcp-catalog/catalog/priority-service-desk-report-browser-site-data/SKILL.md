---
name: priority-service-desk-report-browser-site-data
description: >
  A Priority report runs in a private or incognito window and fails in the
  normal browser until that site's cache and cookies are cleared. Confirm
  the client plugin first. Use when report works incognito, vanishing report
  popup, clear site data cookies, or /priority-service-desk-report-browser-site-data.
---

# Report runs after a scoped browser site-data clear

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/report-browser-site-data.md`.

Issue type: a report procedure fails or its popup vanishes in the normal browser, and the same procedure runs in a private window.

Known: browser-local site data for the affected Priority tab was implicated. On 2026-11-03 13:41 GMT support recorded: "I was able to run the report on an 'incognito' window, so I cleared your tab cache (cookies) and you were then able to run the report as expected."

Unknown: the exact cookie or cache entry, and any browser-version defect. Do not treat this as the cause of every missing report.

Not this defect: the client plugin. Internal notes the same day at 13:38 GMT say the Priority Client Plugin was installed, enabled, and detected. An empty report would show "No values in report", so a vanishing popup was a different observation from an empty result.

## Prerequisites

The person at the workstation can sign in again after a site-data clear. Do not clear a shared kiosk session they cannot reauthenticate. No server write, no form change, and no credential reset.

## Steps

1. Record the report path, inputs, and what the popup did (never appeared, vanished, or showed no values).
2. Check the client plugin is installed, enabled, and detected. If it is, do not reinstall it as the first action.
3. Run the same report in a private window and in the affected normal profile.
4. If the private window fails too, stop. This fix does not apply.
5. If only the normal profile fails, and a genuine empty result would have shown the no-values message, local site data is the working explanation.
6. Warn that clearing site data signs the user out. Clear only the Priority site's cache and cookies. Do not clear all history, saved passwords, or other sites.
7. Sign in again and rerun the original report. Record whether it completes.

## Verification

Proven for SC263476 (opened 2026-11-03 13:40 GMT): the user could run the report after that scoped clear.

Not proven: which cached item was wrong, or that another browser would need the same clear.

## Stop or escalate

Stop if the private window fails, or if the report shows the explicit no-values message (that is an empty result, not a cache clear). If the Priority client plugin is disabled for the site, that is `priority-service-desk-browser-plugin-enable`, not a cache clear. This call already had the plugin installed, enabled, and detected. Do not clear site data on a report that has not been compared in a private window.
