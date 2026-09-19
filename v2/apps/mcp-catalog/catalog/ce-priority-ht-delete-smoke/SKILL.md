---
name: ce-priority-ht-delete-smoke
description: >
  CE Priority house-type DELETE smoke (HT-DL) on TEST under concurrent recalc.
  Use when the user says HT delete, house type delete, HT-DL, Ctrl+Delete HOUSETYPEID,
  or /ce-priority-ht-delete-smoke.
---

# CE Priority house-type DELETE smoke (HT-DL)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=ce-priority-ht-delete-smoke`). Browser/desktop only.

Follow **priority-uat-orchestrator** standing rules. Trigger sign lives in **priority-form-engineering** (PRE-DELETE `:ELEMENT = - :ELEMENT`). Do not restate the trigger body here.

Host: `prioritytest.clarksonevans.co.uk`. Confirm company title first (DNAME `base` = UI "T - Clarkson Evans Live - 20251031"; UI "Test" = DNAME `test`, empty PR26*). USERENV can stick -- relogin after change.

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
