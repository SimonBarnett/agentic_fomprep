---
name: priority-ht-delete-smoke
description: >
  Priority house-type DELETE smoke (HT-DL) on TEST under concurrent recalc.
  Use when the user says HT delete, house type delete, HT-DL, Ctrl+Delete HOUSETYPEID,
  or /priority-ht-delete-smoke.
---

# Priority house-type DELETE smoke (HT-DL)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-ht-delete-smoke`). Browser/desktop only.

Follow **priority-uat-orchestrator** standing rules. Trigger sign lives in **priority-form-engineering** (PRE-DELETE `:ELEMENT = - :ELEMENT`). Do not restate the trigger body here.

Use the deployment TEST web instance from config (e.g. Clarkson Evans `prioritytest.clarksonevans.co.uk`). Confirm company title first (DNAME vs UI label pitfalls are instance-specific — see orchestrator).

## When

Smoke-delete a house type on TEST while recalc may be running.

## Sequence

1. Confirm company title. Wrong company = stop.
2. Leave Stack/recalc running. Do not drain Stack.
3. Projects F11 DOCNO -> House Types -> HOUSETYPEID -> Ctrl+Delete.
4. Open `ZCLA_HTEDIT` rows block delete ("Value exists in House Type Edits form"). Pick a 0-edit fixture.

## Pass / fail

- Hang without error 1205 = FAIL (PRE-DELETE ELEMENT sign). CASE; do not keep retrying.
- PASS: HT gone, no hang, no 1205, with video.
- FAIL: CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN.

Learned sign (owned by form-engineering): `:ELEMENT = - :ELEMENT` before `#INCLUDE ZCLA_ELACT/ZCLA_CHKPNT-DEL`.
