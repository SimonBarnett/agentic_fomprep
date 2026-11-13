---
name: priority-service-desk-renew-license-login-errors
description: >
  Users saw licence error messages, or could not open Business Rules and Autofill Rules. An administrator ran the Renew License program on the server, and the errors stopped. Use when licence error message login does not include application Renew License business rules will not open, or
  /priority-service-desk-renew-license-login-errors.
---

# Licence error pop-ups, or business rules that would not open, cleared after Renew License on the server

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/renew-license-login-errors.md`.

Issue type: several users suddenly see a licence error message (for example that the licence does not include using the application), or Business Rules and Autofill Rules will not open, with no change to their user setup.

Known: three support-fixed cases. SC262447 (2026-08-12): a few users saw a licence error pop-up; after running the renew license program on the server it was sorted, as seen and agreed with the customer. SC262456 (2026-08-13): Business Rules and Autofill Rules would not open in the web interface; a bin update alone did not fix it; support ran Renew License on the server through the client (a message mentioned a problem with the automatic upgrade, but the licence updated) and business rules worked again, confirmed by a second person. SC262592 (2026-08-27): several users got "Your license does not include using the application"; support saw it when logging in to test, ran Renew License, and the error stopped. Server and user names are not stored.

This is not a missing user licence assignment by default. Do not remove or move user licences first.

## Steps

1. Reproduce the error with a test login if you can, and note the exact message.
2. An authorised administrator with server access runs Renew License (the renew licence program) on the Priority server.
3. Note any message it shows, but check whether the licence updated.
4. Log in again and retry the action (or open Business Rules) to confirm the error has gone.
5. If only one user is affected and the message names an application, also check that user's licence assignment.

## Verification

Proven: errors stopped after Renew License (SC262447 agreed with customer; SC262456 confirmed by a second user; SC262592 support-tested).

Not proven: why the licence needed renewing, and what the automatic-upgrade message meant.

## Stop

Stop if Renew License fails or the error persists. Then escalate to Priority with the message. Needs server access; do not upload or share licence files.
