# Enable the Priority browser plugin for the site

Issue type: reports, PDFs, or a document link fail because the Priority client plugin is installed but disabled for the Priority site. This is not a report-definition defect and not a reinstall.

No existing catalog skill owned this enablement step. Browser site-data clear is a different incident: `priority-service-desk-report-browser-site-data` (plugin already detected; private window worked).

Known fixes:

- SC263453, 2026-11-02 11:20 GMT: executive reports were not running, or a white blank screen showed after run, and the plugin was disabled. After enabling the plugin the issue was resolved. Opened 2026-11-02 11:18 GMT.
- SC263452, 2026-11-02 12:11 GMT: the plugin was disabled for Priority in Chrome. After enabling it, the statements PDF issue was solved. Opened 2026-11-02 09:17 GMT.

Corroboration only: SC263456, 2026-11-04 11:57 GMT, says the shipping-document link issue was solved and was because of the plugin. The exact enable or reinstall action was not recorded. Do not claim the same click. Opened 2026-11-02 10:22 GMT.

Unknown: browser version and the exact menu clicks. Do not invent a click path. SC263531 proposed plugin checks with no completed repair. SC263428 suspected the plugin for a new user with no enablement confirmation. Neither joins this confirmed pair.

## Prerequisites

The extension is already installed from the approved source. The user, or an admin on their browser profile, can change the site's extension permission. No server write. No untrusted extension install. No global browser-policy weakening.

## Steps

1. Separate "extension not installed" from "installed but disabled for this site". Presence in the browser does not mean the Priority site is allowed.
2. Check Priority client plugin detection and the site permission before investigating report code.
3. If it is disabled for the site, enable it using the estate's approved plugin instructions. Do not reinstall first.
4. Rerun the original report, PDF, or link. Record whether the fix was enablement, a reinstall, or something else. Do not silently equate them.
5. If the plugin is already enabled and detected, stop. Compare a private window. That path is the site-data skill, not this one.

## Verification

Proven: enablement restored executive reports (SC263453) and statement PDFs (SC263452).

Not proven: one click sequence for every browser, and the precise action on SC263456.

## Stop or escalate

Stop if the plugin is missing, if enablement does not restore the same action, or if the request is to weaken browser policy or grant permissions globally. Do not install an extension from an unknown source.
