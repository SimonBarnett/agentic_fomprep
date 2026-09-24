# Priority project create smoke TC-01–05 (source)

## When

Smoke a new site/project through team → contract → copy house type → paste plots on Priority web (DEV). Follow `priority-uat-orchestrator` for login, video/CASE, pickers, banned sites.

## Sequence

1. **TC-01 New project** — Project Management → Projects (`DOCUMENTS_p`, TYPE=p). **New DOCNO each run.** Do not reuse banned fixtures.
2. **TC-01b Internal Project Team** — add tester user (CE: `Si`). Required or `ZGEM_ERR_NOTINTEAM`.
3. **TC-02 Assign contract** — `ZCLA_CONTRACTS`. Branch and **Contract Type Name via picker only**. Prefer Electrical/PV (`EL=5`). Skip Contract Elements on the happy path.
4. **TC-03 Copy Core House type** — `ZCLA_COPYCORE`. Prefer `.2` / `.3` SNG-ROW.
5. **TC-04 Paste Plots** — `ZCLA_ADDPLOTFORM`. Paste element **PV system**, not DAY WORK.
6. **TC-05 Full chain** — one DOCNO with team + contract Draft + copied HT + plot with PV system.

## Gotchas

- Insertion-failed toast may still commit — **refresh** before assuming rollback.
- Blank HT after logout — refresh.
- EL mismatch hangs paste — stop; one retry max then CASE.
- Avoid Recalc / HT Swap / Clear Plots unless the case says so.

## Pass / fail

- PASS: screen-record of the new DOCNO with team, contract, copied HT, pasted plots (human pack rules).
- FAIL: CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN.
