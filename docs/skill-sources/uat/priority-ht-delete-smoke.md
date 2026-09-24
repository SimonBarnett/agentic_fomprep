# Priority house-type DELETE smoke HT-DL (source)

## When

Smoke-delete a house type on Priority **TEST** web under concurrent recalc load. Follow `priority-uat-orchestrator`. Trigger sign lives in `priority-form-engineering` (PRE-DELETE `:ELEMENT = - :ELEMENT` before `#INCLUDE` checkpoint delete). Deadlock triage checklist: `priority-ht-delete-deadlock-triage`.

## Preflight

1. Confirm **company title** after login (DNAME ≠ UI label). Wrong company = stop.
2. Leave Stack / recalc running. **Do not drain Stack** for this smoke.
3. Use the DOCNO / HOUSETYPEID from the UNPARK note (do not invent fixtures).

## Sequence

1. Projects → F11 DOCNO → House Types → select HOUSETYPEID → Ctrl+Delete.
2. If blocked with “Value exists in House Type Edits form” → open HTEDIT exists; pick a **0-edit** fixture (or ask engineering for one). Do not force-delete through open edits.

## Pass / fail

- **Hang** (~minutes, progress stuck) **without** SQL 1205 text = **FAIL** (often PRE-DELETE ELEMENT sign). CASE; do not keep retrying the same HT.
- **PASS:** HOUSETYPEID gone; no hang; no 1205; sibling HTs untouched as required; **video**.
- **FAIL:** CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN.

## Learned product note (for engineering, not tester edit)

`:ELEMENT = - :ELEMENT` before `#INCLUDE ZCLA_ELACT/ZCLA_CHKPNT-DEL` — owned by form-engineering / DBA triage skills.
