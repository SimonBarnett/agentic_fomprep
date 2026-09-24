---
name: priority-project-create-smoke
description: >
  Priority project create smoke TC-01-05: new project, team, contract, copy HT,
  paste plots. Use when the user says project create smoke, TC-01, copy house type,
  paste plots, or /priority-project-create-smoke.
---

# Priority project create smoke (TC-01-05)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-project-create-smoke`). Browser/desktop only.

Follow **priority-uat-orchestrator** standing rules (login Si, banned sites, video/CASE, pickers, one retry then CASE). Web host comes from the deployment instance config (e.g. Clarkson Evans DEV in `instances.example.json`).

Source leaflet was not on this box; procedure is the Jester harvest 2026-09-19.

## When

Smoke a new **site / project** through team -> contract -> copy HT -> paste plots (TC-01-05).

## Sequence

Harvest procedure (do not invent extra TC numbers):

1. New site / project. **New DOCNO each run.**
2. Internal Project Team: add `Si` (TC-01b). Required or `ZGEM_ERR_NOTINTEAM`.
3. Contract: Branch and Contract Type via **picker** (not free text). Prefer Electrical/PV (`EL=5`). Skip Contract Elements on the happy path.
4. Copy house type. Prefer `.2` / `.3` SNG-ROW.
5. Paste plots. Paste element **PV system**, not DAY WORK.

## Gotchas

- Insertion-failed toast may still commit -- refresh before assuming rollback.
- Blank HT after logout -- refresh.
- EL mismatch hangs paste. Stop, CASE; do not retry past the one-retry rule.

## Pass / fail

PASS: screen-record of the new DOCNO with team, contract, copied HT, pasted plots. FAIL: CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN.
