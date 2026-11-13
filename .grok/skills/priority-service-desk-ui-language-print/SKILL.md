---
name: priority-service-desk-ui-language-print
description: >
  Printouts use the wrong format because the user is in a different UI
  language. Switch to the intended language and reprint. Use when print
  format American English, UI language printout, or
  /priority-service-desk-ui-language-print.
---

# UI language selected the wrong print format

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/ui-language-print.md`.

Issue type: after a cloud move, printouts are in the wrong format because the user is working in American English rather than the language the formats were built for.

Known: on 2026-10-19 08:22 BST support recorded that the printouts were wrong because she was working in American English, showed her how to change the UI language, and everything was ok after that. The target language was not named. Do not hardcode British English. The menu clicks were not recorded.

Related example: SC262893. On 2026-09-17 a user logged in and all their shortcuts were missing. Support asked whether the user language had changed to American English and, if so, to change it back to British; support called it a known issue. On 2026-09-18 09:39 BST the customer said that did the trick. So a changed UI language can also hide a user's shortcuts, not only change print formats. A second case, SC262605 (2026-08-27): homepage shortcut tiles were missing for some users; support asked which language those users were in, as this is seen when the language changes to American English from British English. On 2026-08-28 the customer said that fixed it.

This does not fix missing tiles or a missing column translation. Those are separate. It does not fix every cloud print problem.

## Steps

1. Record the user's UI language, the print action or missing item (for example shortcuts), and whether this followed a move or an update.
2. Compare with a user whose language and format are already correct before editing a template.
3. The user switches to the intended supported language in the standard UI and runs the same print.
4. Check the format and the content. Stop if the language change is not the difference.

## Verification

Proven: the format was correct after the language change (SC263256). Shortcuts came back after the language was changed back (SC262893, SC262605).

Not proven: the target language name and the menu path.

## Stop

Do not delete translations or replace the report. Do not treat this as the email-editor column translation or the OData language-code case.
