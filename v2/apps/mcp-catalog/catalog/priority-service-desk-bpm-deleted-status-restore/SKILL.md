---
name: priority-service-desk-bpm-deleted-status-restore
description: >
  A user could not see a status in the purchase order BPM flow chart, and re-creating it said it already existed. The status had been deleted. Restoring it from the deleted statuses list in BPM fixed it. Use when BPM status missing flow chart already exists deleted statuses restore, or
  /priority-service-desk-bpm-deleted-status-restore.
---

# A BPM status could not be re-created because it had been deleted

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/bpm-deleted-status-restore.md`.

Issue type: a status is missing from a BPM flow chart, but creating it again says it already exists, and it is still listed in the statuses table.

Known: on 2026-09-03 a user tried to rename a purchase order BPM status, could not, then created a new status with the plus button; it did not show in the flow chart, though it was listed in the statuses for BPM table, and creating it again gave a message that it exists. Support found the status had been deleted, and that it can be restored by clicking the + icon, then using the deleted statuses list at the bottom left to select the status and restore it. The user confirmed it was sorted on 2026-09-09. Status names are not stored.

This is not data corruption. Do not delete or insert statuses in tables directly.

## Steps

1. In the BPM flow chart for that document type, click the + icon.
2. At the bottom left, open the list of deleted statuses.
3. Select the status and restore it.
4. Check it appears in the flow chart and its rules and flags are as expected.

## Verification

Proven: customer confirmed it was sorted (SC262695, customer-verified).

Not proven: how the status came to be deleted.

## Stop

Stop if the status is not in the deleted list. Then check the statuses table with an administrator.
