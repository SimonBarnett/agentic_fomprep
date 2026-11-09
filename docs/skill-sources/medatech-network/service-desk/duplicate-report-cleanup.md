# Duplicate project-report cleanup is an approved escalation

Issue type: duplicate project hour or report rows exist after service activity. The generation cause is unknown. Do not assert that restarting services created them.

This is escalation and cleanup governance. It is not a delete script. The query body was not in the retrieved call. Do not invent one. Do not make the primary record field writable to force a UI delete.

Known process: a developer prepared a deletion limited to an explicit approved report list, tolerant of rows already missing. Internal note 2026-11-03 12:52 GMT: it deletes the reports from the spreadsheet list, still succeeds if a report is already gone, and a run in the copy company deleted the ones that existed. Support on 2026-11-03 15:05 GMT: the test-copy run succeeded. The list later changed, so the script was revised rather than reused blind. Support on 2026-11-05 15:18 GMT: the modified script had been run and the customer was asked to check. Recorded customer update 2026-11-06 08:43 GMT: it looked updated. Opened 2026-10-29 08:30 GMT.

Unknown: the SQL text, the deleted row count, the root cause, and a full hour or cost reconciliation.

## Prerequisites

Exact duplicate identifiers, business-owner approval, a backup or recovery plan, and a successful copy-company test of the script that will actually be run. If the id list changes, review and retest. This harvest does not authorize a live delete.

## Steps

1. List the duplicate document ids the owner agrees are duplicates. Keep legitimate reported hours. Sharing one field is not enough to call every row a duplicate.
2. Investigate how they were generated as a separate task. Do not block the approved cleanup on an unproven restart theory, and do not write that theory down as the cause.
3. The developer writes a narrow cleanup for that list only, safe when a listed id is already absent, and runs it on a copy company. Compare before and after totals there.
4. Only an authorized operator runs the reviewed script on live, after approval. If the list changed, they run the retested revision, not the old script.
5. The customer checks that the named duplicates are gone and that legitimate totals remain.

## Verification

Proven: copy-company test, a later live run of the revised list, and the customer's "looks to be updated" (SC263424).

Not proven: query text, row counts, root cause, and costing reconciliation.

## Stop or escalate

Stop if there is no approved id list, no copy-company test of the script about to be run, or no backup plan. Do not mass-zero hours. Do not run a query that is not the reviewed one. The data owner and the developer own the script.
