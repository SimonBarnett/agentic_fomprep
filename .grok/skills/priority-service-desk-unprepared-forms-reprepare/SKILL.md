---
name: priority-service-desk-unprepared-forms-reprepare
description: >
  A user could not be made active and running Add New User froze the system for everyone. Many forms were unprepared, possibly after a new custom procedure was added. Running the procedure to re-prepare unprepared forms fixed it. Use when Add New User hangs active user tickbox unprepared forms, or
  /priority-service-desk-unprepared-forms-reprepare.
---

# User setup misbehaved and Add New User hung while many forms were unprepared

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/unprepared-forms-reprepare.md`.

Issue type: user maintenance (for example the active user tick, or Add New User) misbehaves or hangs, soon after a customisation was installed.

Known: on 2026-09-11 the customer reported that a user could not be set active, and that running Add New User again froze the system for all users. At 10:39 BST support recorded that many forms were unprepared; once the customer ran the procedure to re-prepare the unprepared forms, the issue was fixed and the user was active. Support and customer thought a new custom procedure added the week before might be the cause. The exact procedure name used was not recorded. User names are not stored.

This is not a licence problem. Do not keep re-running Add New User while users are stuck.

## Steps

1. Stop re-running the failing user procedure while others are affected.
2. Check whether many forms are unprepared (the Form Preparation list of unprepared forms).
3. Check what customisation changed recently, and with whom.
4. An authorised administrator runs the standard procedure to prepare the unprepared forms, outside busy hours if possible.
5. Retry the user change and confirm it saves.

## Verification

Proven: after the unprepared forms were re-prepared, the user change worked (SC262804, support note after call).

Not proven: the exact procedure name, and that the new custom procedure was the cause.

## Stop

Stop if no forms are unprepared. Then escalate the hang with the time it happened. For the CE DEV preparation method see prepare-all-unprepared-priority-forms; its environment rules do not apply to customers.
