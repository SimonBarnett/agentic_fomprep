---
name: priority-service-desk-outlook-plugin-mail-not-sending
description: >
  A user could no longer send Priority emails to colleagues. The Outlook option was missing from Mail Options, which shows the Priority plugin is broken. Reinstalling the plugin with a Windows admin account fixed it. Use when Priority emails not sending Outlook plugin Mail Options classic Outlook, or
  /priority-service-desk-outlook-plugin-mail-not-sending.
---

# Priority emails stopped sending from Outlook because the plugin was broken

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/outlook-plugin-mail-not-sending.md`.

Issue type: emails that Priority sends through the user's Outlook (alerts, documents) stop going out for one user.

Known: on 2026-09-09 a user reported that Priority emails to colleagues had stopped since Monday; their IT had tried to fix it without success. Support asked them to check they were not using New Outlook, as Priority only supports Classic Outlook, and to check the menu (top-right) > Mail > Mail Options for an "Outlook" option. If it is missing, the Priority plugin is broken and must be reinstalled, using a Windows admin account and logging into Priority while still on that account. After IT reinstalled the plugin the user confirmed on 2026-10-07 that it was working. Names are not stored.

This is not a mail server problem when only one user is affected. New Outlook is not supported.

## Steps

1. Confirm the user is on Classic Outlook, not New Outlook.
2. In Priority, open the menu > Mail > Mail Options and check whether an "Outlook" option is there.
3. If it is missing, the user's IT reinstalls the Priority plugin using the standard install instructions, signed in with a Windows admin account.
4. While still on that admin account, log into Priority once.
5. Log back in as the user and send a test email from Priority.

## Verification

Proven: after the plugin reinstall the user confirmed emails were working (SC262772, customer-verified).

Not proven: what broke the plugin.

## Stop

Stop if the Outlook option is present and mail still fails. Then check the mail settings and send log.
