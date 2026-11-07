# Work-order close record-modified (custom close balance)

Issue type: persistent record-modified or version-mismatch while closing a
released work order, when custom close-time development writes the backend
balance before the transition completes.

This is a diagnostic and escalation playbook. It is not a repair script.
The historical correction changed the custom work-order closing development.
The exact trigger name, statement, code diff, and deployment artifact are
unknown. Do not invent them.

Catalog: `priority-service-desk-record-modified-custom-close`.

## Route

Load this procedure when all of the following are in play:

- Closing a released work order raises a record-modified or version-mismatch
  error (wording such as record has been modified or deleted).
- The failure repeats on one record.
- Custom development on the close transition is in scope.

Do not use this procedure as the repair for:

- Msg 154 from a mid-edit side effect or from nullable form columns. That
  playbook is `docs/skill-sources/programming/MSG154_OPTIMISTIC_LOCK.md`
  via `priority-procedure-style` and `priority-form-engineering`. Do not
  copy that resync onto this incident.
- House-type delete SQL 1205: `priority-ht-delete-deadlock-triage`.
- Delete hang without 1205: `priority-recalc-concurrency`.
- BPM / SP003 call handling: `priority-ops-support-desk`.

## Known versus unknown

Known, from SC263394 internal dialogue on 2026-11-05 14:25 GMT:

> A back-end development fires on close and sets balance to 0 while the screen still shows 10, causing the version mismatch.

The balance was changed even though close had not completed.

Corrected component, known: the custom work-order closing development.
On 2026-11-05 15:04 GMT support wrote that the developer should have fixed
this and asked the customer to test. On 2026-11-06 09:30 GMT the customer
confirmed it was fixed and authorized closing the request. SC263536 (opened
2026-11-06 09:28 GMT) carries that confirmation and links SC263394 (opened
2026-10-28 09:43 GMT).

Unknown: exact trigger name, statement, code diff, and deployment artifact.
No standalone script repairs this. A refresh is not the repair. The same
internal note says Ctrl+F11 did not reliably clear the error during testing.

## Prerequisites

- The instance is one the user allowlisted for this session. Do not invent a
  company, URL, or form name.
- Reproduce the close only on an authorized Test company. This playbook
  authorizes no production write, no stock or balance edit, and no trigger
  disable.
- Preserve pending edits before any undo or refresh. Do not discard
  unrecorded work.
- A code change needs the customization owner plus the estate's normal Test
  review and deployment approval. This harvest is not that approval.

## Discriminate

1. Concurrent user or stale screen, versus a repeatable single-record failure.
   Ask whether another session (same login, second browser, WCF, or Form Prep)
   saved the same work order during the close. If a second session changed the
   row, stop. That is ordinary optimistic locking. Use one session and retry
   the original close once. Do not loop retries and do not force the close.
   If it still fails on one record with no other writer, continue.
2. Preserve pending edits, then record the on-screen quantity and balance.
   Ctrl+F11 or reopen is a diagnostic only. In the source case it did not
   reliably clear the error. A successful refresh does not prove the custom
   close logic is fixed.
3. Authorized Test repro of the observed path. Do not invent other quantities.
   Quantity 10, balance 10. Release the work order. Enter the sublevel the
   close uses. Attempt close. When the defect is present, expect the
   record-modified or version-mismatch error, with the stored balance moved
   (source: set to 0) while the screen still shows 10.
4. Compare the stored balance with the UI snapshot at the failing transition.
   Read only. Do not write the balance. The observed cause is custom
   close-time logic writing the backend balance before the status transition
   completes, while the UI still holds the prior value. When an uncustomized
   Test company is allowlisted, run the same steps there. The same failure on
   that company means this is not the customization; stop and escalate it as
   product behavior. Failure only where the custom close development exists
   supports the observed cause.
5. Reject lookalikes before escalating as this defect. Nullable painted
   columns, or a documented mid-edit write of some other column, stay on the
   MSG154 playbook. SQL 1205 or a delete/recalc hang stays on the deadlock and
   recalc skills. This case was a version mismatch, not a deadlock graph.

## Read-only diagnostics

Default is read-only.

Capture and keep:

- Exact error text.
- Status transition attempted (close of a released work order).
- Environment (Test or live) and whether a second session was open.
- On-screen quantity and balance immediately before close.
- Stored balance for that work order immediately after the error, read from
  the same form field the user was looking at. Do not hardcode a table or
  column. The source call does not name them.
- Whether the close status actually changed.
- Whether custom close development is installed (yes, no, or unknown). If a
  name is not already in the service-call evidence, report it as found during
  this investigation, not as the historical fix.

## Steps

1. Capture the error, transition, environment, and steps.
2. Run the discrimination list above.
3. On authorized Test only, replay quantity 10 / balance 10, release, enter
   the sublevel, and close.
4. Record UI balance, stored balance, and whether status moved.
5. When the pattern matches (backend balance written, UI still at the prior
   value, close not completed, repeats without a second user), stop changing
   data.
6. Hand the package to the customization owner: reproduction, before and
   after values, transition, environment, and the statement that the
   historical correction was to the custom work-order closing development
   with the exact edit unknown.
7. The owner corrects that component under normal Test review. This playbook
   does not supply the edit.
8. Retest the same close path on Test. Then ask the customer to confirm.
   Record separately: observed cause, component corrected, and the
   confirmation. Do not record an invented diff.

## Verification

Proven for SC263394:

- 2026-11-05 15:04 GMT, DOCTEXT_Q_2_SUBFORM: "[Developer] should have fixed this, can you test?"
- 2026-11-06 09:30 GMT, DOCTEXT_Q_2_SUBFORM: "Looks like it is fixed. Happy for you to close the support request."
- SC263536 opened 2026-11-06 09:28 GMT carries the confirmation link.

Not proven: exact code change, trigger name, automated regression, full
edge-case coverage, and post-deployment balance values.

A new incident is verified only when the original close path succeeds on
authorized Test and the customer confirms. "Should have fixed" without
customer confirmation is not verification.

## Stop or escalate

Stop and do not improvise a repair when:

- A second user or second session explains the mismatch.
- Refresh or reopen clears it once and it does not repeat. Treat that as a
  stale screen. Still preserve edits.
- An uncustomized Test company reproduces it. Escalate as product behavior.
- The stored balance did not change while the UI showed the old value. The
  observed cause does not fit. Re-triage with the MSG154 causes before
  calling it custom close logic.
- You cannot name the customization owner. Do not edit triggers yourself.
- The environment is live. No live repro that writes, releases, or closes.
  Read-only capture only, then authorized Test.

Escalate to the customization owner with the evidence pack when the Test
repro matches. Do not disable triggers in production. Do not run a retry
loop. Do not force the close. Do not edit stock or balance to unstick the row.

## Permissions

- Read-only diagnostics: allowed on the user-allowlisted instance.
- Reproduce the close path: authorized Test only, with approval to use a
  disposable work order at quantity 10 / balance 10.
- Code change and deployment: customization owner plus normal Test-then-live
  approval. This playbook grants neither.
- Live: no close retries, no balance edits, no trigger changes.

## Provenance

- SC263394, opened 2026-10-28 09:43 GMT. Internal dialogue 2026-11-05 14:25 GMT.
  Customer confirmation 2026-11-06 09:30 GMT.
- SC263536, opened 2026-11-06 09:28 GMT, links that confirmation.
- Extracts are sanitized. No customer name, contact, price, or host.
