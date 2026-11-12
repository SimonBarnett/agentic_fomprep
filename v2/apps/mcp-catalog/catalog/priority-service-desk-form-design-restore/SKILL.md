---
name: priority-service-desk-form-design-restore
description: >
  Customer Sites showed data in the wrong fields for one user in every company. Restoring the form design fixed it. A separate case of a missing sublevel was fixed by hiding and unhiding it in form design. Use when form data in wrong fields one user restore form design, or
  /priority-service-desk-form-design-restore.
---

# A form showed data in the wrong fields for one user until its form design was restored

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/form-design-restore.md`.

Issue type: a form looks wrong for one user only (fields in the wrong places, or a sublevel missing), in every company, and logging out or clearing the cache does not help.

Known: SC262983: on 2026-09-24 a user reported that Customer Sites showed data in the wrong fields, only with their login but in all companies; logging out and clearing the cache had not helped. On 2026-09-28 15:06 BST support asked them to restore the form design. On 2026-09-29 15:06 BST the user said that had worked. SC263041: on 2026-09-30 16:43 BST support recorded, after a call, that the Order for Part sublevel was not showing on price quotes, and hiding then unhiding the sublevel in form design solved it.

This is not a data problem and not a server fault. The pattern is per user, so it points at that user form design.

## Steps

1. Confirm the problem is limited to one user (another user sees the form correctly) and follows them across companies.
2. Ask the user to export or screenshot the form design first if they want to keep custom layouts.
3. Restore the form design for that user and form, then reopen the form.
4. For a missing sublevel, check form design to see if it is hidden. Hide then unhide it if it should show.
5. Confirm the fields or sublevel now show correctly.

## Verification

Proven: restoring the form design fixed the misplaced fields (SC262983, user confirmed). Hiding and unhiding the sublevel brought it back (SC263041, support note after call).

Not proven: what corrupted the design, and the exact menu path in each version.

## Stop

Stop if other users see the same problem. Then treat it as a form or customisation issue and escalate.
