---
name: priority-service-desk-form-designer-multi-record
description: >
  Single-record and multi-record user designs diverge because multi-record
  Form Designer rows are missing. Regenerate them in the multi-record view,
  then copy only with approval. Use when Form Designer multi-record,
  copied user design, or /priority-service-desk-form-designer-multi-record.
---

# Regenerate a multi-record Form Designer layout

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/form-designer-multi-record.md`.

Issue type: a user's multi-record form layout does not match the single-record design because multi-record Form Designer entries are missing or different. The reason those entries were absent is unknown.

This is not `priority-form-engineering`. That skill is trigger and form-prep work. Do not change global dictionary titles to fix one user's view.

Known fix, recorded 2026-11-02 12:21 GMT from the customer mail at 12:16 GMT: on live they used Form Designer to change the multi-record view, which generated multi-record entries for them, then copied that design to everyone. They said live was then as it should be and no further action was required. They also repeated the approach in Test. Opened 2026-11-02 11:27 GMT.

Unknown: why the entries were missing, and which fields differed. A Test-only revised title, if one remains, stays a separate note. Do not recommend a blanket copy to every user without the layout owner checking a representative user first.

## Prerequisites

Layout-owner approval before a design is copied. Export or otherwise preserve the target users' current designs. Copying overwrites per-user customization. This harvest does not authorize the copy.

## Steps

1. Compare labels in single-record view and multi-record view, and the user's Form Columns design rows. Check Live and Test separately.
2. Edit the affected mode in Form Designer. Changing the single-record design does not by itself create the multi-record rows. The recorded fix changed the multi-record view so those entries were generated.
3. Confirm the multi-record layout with one representative user.
4. Copy to other users only for the approved scope. Do not edit form dictionary titles globally.
5. Verify both view modes after the copy. Record any leftover Test-only title difference separately. Do not "fix" it with a global rename.

## Verification

Proven: the customer confirmed live looked right after the generate-and-copy (SC263454).

Not proven: the root cause of the missing rows, the field list, and that every user wanted that design.

## Stop or escalate

Stop if the owner has not approved the copy, if there is no backup of existing user designs, or if the discrepancy is a dictionary title rather than a per-user design. Escalate title changes to the form owner. No Form Prep and no trigger edit for this symptom.


## Copy one user's design onto a new user (SC263148)

Different from regenerating missing multi-record rows. A new user had the wrong personalized layout. It was not a privilege failure. On 2026-10-08 17:00 BST support ran Copy form design for all forms from the original user to the new user, refreshed, and saw the layout was right.

All-forms was what this incident used. It is not the safe default. Copying overwrites the destination user's own designs. The owner approves the source user, the destination user, and the form scope. Refresh that user's session and check the layout. The menu options were not recorded. Personal filters and tiles were not proved. Do not copy privileges and do not edit designs in SQL.
