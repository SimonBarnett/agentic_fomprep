---
name: priority-service-desk-record-modified-custom-close
description: >
  Diagnose a record-modified or version-mismatch error while closing a
  released work order when custom close logic writes the backend balance
  before the transition completes. The historical correction changed that
  custom work-order closing development; the exact edit is unknown. Use when
  work order close record modified, version mismatch on close, custom close
  balance, or /priority-service-desk-record-modified-custom-close.
---

# Work-order close record-modified (custom close balance)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/record-modified-custom-close.md`.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-service-desk-record-modified-custom-close`).

Issue type: persistent record-modified or version-mismatch on work-order close caused by custom close-time development.

This skill does not repair the row. No script, balance write, or trigger edit in this leaflet fixes it. The exact trigger name, statement, code diff, and deployment artifact are unknown.

## Route

Use this skill when closing a released work order raises a record-modified or version-mismatch error, the failure repeats on one record, and custom close development is in scope.

Send these elsewhere:

- Msg 154 from a mid-edit side effect or nullable form columns: `docs/skill-sources/programming/MSG154_OPTIMISTIC_LOCK.md` via `priority-procedure-style` and `priority-form-engineering`. Do not copy that resync onto this incident.
- House-type delete SQL 1205: `priority-ht-delete-deadlock-triage`.
- Delete hang without 1205: `priority-recalc-concurrency`.
- BPM / SP003 handling: `priority-ops-support-desk`.

## Known versus unknown

Known (SC263394, INTERNALDIALOGTEXT_SUBFORM, 2026-11-05 14:25 GMT):

> A back-end development fires on close and sets balance to 0 while the screen still shows 10, causing the version mismatch.

The balance was changed even though close had not completed. The same note: Ctrl+F11 refresh did not reliably clear the error during testing.

Corrected component: the custom work-order closing development. Support on 2026-11-05 15:04 GMT: "[Developer] should have fixed this, can you test?" Customer on 2026-11-06 09:30 GMT: "Looks like it is fixed. Happy for you to close the support request." SC263536 (opened 2026-11-06 09:28 GMT) links SC263394 (opened 2026-10-28 09:43 GMT).

Unknown: exact trigger name, statement, code diff, deployment artifact. Do not claim a particular line was changed.

## Prerequisites

- User-allowlisted instance only. Do not invent a company, URL, or form name.
- Reproduce the close only on authorized Test. No production write, stock edit, balance edit, or trigger disable.
- Preserve pending edits before undo or refresh.
- Code change needs the customization owner and the estate's normal Test-then-live approval. This harvest is not that approval.

## Discriminate

1. Separate a second session (same login, another browser, WCF, Form Prep) from a repeatable single-record failure. If another session saved the row, stop. Retry the original close once in one session. Do not loop and do not force the close.
2. Record on-screen quantity and balance before any refresh. Refresh is a diagnostic. In the source case it was not a reliable clear, and it is not proof of repair.
3. Authorized Test repro, original quantities only: quantity 10, balance 10, release, enter the close sublevel, attempt close. Defect present: record-modified or version-mismatch, stored balance moved (source: set to 0), screen still shows 10.
4. Read the stored balance from the same on-screen field. Do not hardcode a table or column; the call names none. The observed cause is custom close-time logic writing that backend balance before the transition completes. If an allowlisted uncustomized Test company fails the same way, stop and escalate as product behavior.
5. Nullable columns or a mid-edit write of a different column stay on MSG154. Deadlock or recalc hangs stay on those skills.

## Steps

1. Capture exact error, transition, environment, and steps.
2. Run the discrimination list.
3. On authorized Test only, replay quantity 10 / balance 10, release, sublevel, close.
4. Record UI balance, stored balance, and whether status moved.
5. When the pattern matches, stop changing data.
6. Escalate to the customization owner with the reproduction, before and after values, transition, and the statement that the historical correction was to the custom work-order closing development with the exact edit unknown.
7. The owner supplies the correction. This skill does not.
8. Retest the same close on Test, then get customer confirmation. Record cause, corrected component, and confirmation separately.

## Verification

Proven for this call: developer-should-have-fixed on 2026-11-05 15:04 GMT, and customer confirmation on 2026-11-06 09:30 GMT.

Not proven: exact code change, trigger name, regression suite, edge cases, post-deployment balances.

A new incident is verified only when the original close succeeds on authorized Test and the customer confirms.

## Stop or escalate

- Second session explains it: stop.
- One refresh clears a non-repeating case: stale screen, not this defect.
- Uncustomized Test reproduces it: product escalation, not this customization.
- Stored balance did not change: not this cause. Re-triage MSG154 first.
- No customization owner, or the environment is live: read-only capture only. No live close, release, or write.

Do not disable production triggers, retry in a loop, force the close, or edit stock or balance to unstick the row.

## Permissions

- Read-only diagnostics on the allowlisted instance.
- Close-path repro on authorized Test only, disposable work order at quantity 10 / balance 10.
- Live: no close retries, no balance edits, no trigger changes.

## Provenance

SC263394 (opened 2026-10-28 09:43 GMT) and confirming link SC263536 (opened 2026-11-06 09:28 GMT). Sanitized extracts only.
