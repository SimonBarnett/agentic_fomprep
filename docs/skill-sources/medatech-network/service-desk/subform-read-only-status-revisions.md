# A text subform would open but not accept typing because the document status did not allow revisions

Issue type: a user can open a subform (for example a description text) on a document but cannot type or change anything there.

Known: on 2026-09-08 a customer reported a complaint description subform could be opened but not typed in. Support asked them to make sure the document was in a status that allows revisions. The customer replied that allowing revisions did enable editing the subform. Related explanation, SC262461 (2026-08-28): on an engineering change order, support explained that subforms cannot be edited when the ECO is in a status not ticked for "Allow Revisions" on the BPM, such as Cancelled and Authorised (explanation only; no follow-up recorded). Form and document names are not stored.

This is not a privilege fault or a broken form. Do not re-prepare the form first.

## Steps

1. Check the status of the document.
2. Check whether that status allows revisions (in the statuses form for that document type).
3. Move the document to a status that allows revisions, or have an authorised user decide whether that status should allow them.
4. Try typing in the subform again.

## Verification

Proven: customer confirmed allowing revisions enabled editing (SC262759, customer-verified).

Not proven: whether any other condition on the form also blocks edits.

## Stop

Stop if the status allows revisions and the subform is still read-only. Then check privileges and form customisation.
