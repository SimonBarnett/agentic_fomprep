---
name: priority-service-desk-email-column-translation
description: >
  Custom columns are missing in the Email Editor until a translation
  exists for the editor language. Use when Email Editor custom field
  missing translation, column language, or
  /priority-service-desk-email-column-translation.
---

# Missing column translation hides Email Editor fields

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/email-column-translation.md`.

Issue type: custom columns exist but do not appear in the Email Editor because the column has no translation for the language the editor is using.

Known: on 2026-10-14 16:41 BST support said the fields were missing a British English translation, and after that translation was added the fields appeared. At 16:25 BST the supplier said the installation was US English, and columns added in British English need a translation. Those two directions disagree. Read the actual installation and the language the column was created in. Do not hardcode British English for every site. The maintenance menu and field ids were not recorded. A sent email was not separately checked. Editor visibility is what was proved.

This is not the UI-language print-format case and not the OData language-code case. Do not edit dictionary tables directly and do not recreate the column. `priority-dictionary-sql` is for dictionary inserts, not this translation.

## Steps

1. Confirm the custom column exists and is allowed on an email template.
2. Compare the installation language, the editor language, and the column's translations.
3. An authorized administrator adds the missing translation for the language in use.
4. Reopen the editor and confirm the fields are listed. Test a sent message separately before calling delivery proved.

## Verification

Proven: the fields appeared in the editor after the translation was added (SC263220).

Not proven: the menu path and a sent email.

## Stop

Stop if the column is absent entirely, or if the proposal is a direct table edit or a new privilege.
