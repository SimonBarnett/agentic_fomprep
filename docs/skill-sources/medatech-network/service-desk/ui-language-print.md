# UI language selected the wrong print format

Issue type: after a cloud move, printouts are in the wrong format because the user is working in American English rather than the language the formats were built for.

Known: on 2026-10-19 08:22 BST support recorded that the printouts were wrong because she was working in American English, showed her how to change the UI language, and everything was ok after that. The target language was not named. Do not hardcode British English. The menu clicks were not recorded.

This does not fix missing tiles or a missing column translation. Those are separate. It does not fix every cloud print problem.

## Steps

1. Record the user's UI language, the print action, and whether this followed a move.
2. Compare with a user whose language and format are already correct before editing a template.
3. The user switches to the intended supported language in the standard UI and runs the same print.
4. Check the format and the content. Stop if the language change is not the difference.

## Verification

Proven: the format was correct after the language change (SC263256).

Not proven: the target language name and the menu path.

## Stop

Do not delete translations or replace the report. Do not treat this as the email-editor column translation or the OData language-code case.
