---
name: priority-service-desk-mobile-migration-qr
description: >
  Mobile apps fail after a server move until a new environment registration
  QR is generated and used. Do not store the QR. Use when mobile app after
  server move, new registration QR, or /priority-service-desk-mobile-migration-qr.
---

# Regenerate the mobile registration QR after a server move

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/mobile-migration-qr.md`.

Issue type: the mobile app stops working after a server move because it still points at the old registration. The exact mechanism was not recorded.

Known: on 2026-10-27 13:43 GMT support said the apps were not working since the server move, showed how to generate a new QR code for the app, and that this worked. Opened 2026-10-27 13:42 GMT.

Unknown: the menu path for the QR. Do not invent the clicks. A separate mail setup was shown and its success was not recorded. Do not claim mail was fixed.

Different incident: an outdated app build plus registration (`priority-service-desk-mobile-app-update-registration`). A certificate error is the install-upgrade example, not a new QR.

## Prerequisites

An authorized administrator generates the QR for the correct environment. The user completes registration. Never copy the QR, the link, or a registration payload into a ticket, a skill, or a log. No password reset.

## Steps

1. Tie the failure to the server move. Record the error text without registration secrets.
2. Rule out an outdated build and a certificate error before treating this as a stale registration.
3. The administrator generates a new registration QR or link for the environment the user should reach, using the estate's approved procedure. The clicks were not in this call.
4. The user registers with that QR. Confirm they reach the intended company and that the original app function works.
5. Leave mail reconfiguration as its own check. This call did not prove it.

## Verification

Proven: support said the new QR generation worked (SC263384).

Not proven: the menu path, and mail delivery.

## Stop or escalate

Stop if the only available QR is for the wrong environment, or if someone asks to paste the QR into chat. Escalate a certificate or version mismatch to those skills instead of issuing another code.
