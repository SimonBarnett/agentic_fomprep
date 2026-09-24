---
name: priority-ht-delete-smoke
description: >-
  Priority house-type DELETE smoke (HT-DL) on TEST under concurrent recalc. Use for HT delete, house type delete, HT-DL, Ctrl+Delete HOUSETYPEID, or /priority-ht-delete-smoke.
---

# Priority house-type DELETE smoke (HT-DL)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-ht-delete-smoke`). Browser/desktop only. This catalog does not drive the UI.

Follow **priority-uat-orchestrator**. PRE-DELETE sign lives in **priority-form-engineering**. Deadlock checklist: **priority-ht-delete-deadlock-triage**. Source: `docs/skill-sources/uat/priority-ht-delete-smoke.md` (2026-09-24).

Use TEST web from instance config. Confirm company title first (CE: UI **T - Clarkson Evans Live - 20251031** = DNAME `base`; UI **Test** = DNAME `test`).

## Sequence

1. Confirm company title. Wrong company = stop.
2. Leave Stack/recalc running. Do not drain Stack.
3. Projects F11 DOCNO → House Types → HOUSETYPEID → Ctrl+Delete.
4. Open `ZCLA_HTEDIT` blocks delete — pick a 0-edit fixture.

## Pass / fail

- Hang without 1205 = FAIL (PRE-DELETE ELEMENT sign). CASE; do not keep retrying.
- PASS: HT gone, no hang, no 1205, with video.
- FAIL: CASE pack.

Learned sign (form-engineering): `:ELEMENT = - :ELEMENT` before `#INCLUDE ZCLA_ELACT/ZCLA_CHKPNT-DEL`.

