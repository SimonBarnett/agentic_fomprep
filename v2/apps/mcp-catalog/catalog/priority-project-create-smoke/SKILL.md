---
name: priority-project-create-smoke
description: >-
  Priority project create smoke TC-01–05: new project, team, contract, copy HT, paste plots. Use for project create smoke, TC-01, copy house type, paste plots, or /priority-project-create-smoke.
---

# Priority project create smoke (TC-01–05)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-project-create-smoke`). Browser/desktop only. This catalog does not drive the UI.

Follow **priority-uat-orchestrator**. Web host from instance config. Source: `docs/skill-sources/uat/priority-project-create-smoke.md` (2026-09-24).

## When

Smoke a new site/project through team → contract → copy HT → paste plots.

## Sequence

1. New project (`DOCUMENTS_p` TYPE=p). **New DOCNO each run.**
2. Internal Project Team: add tester (CE: `Si`) — required or `ZGEM_ERR_NOTINTEAM`.
3. Contract (`ZCLA_CONTRACTS`): Branch + Contract Type via **picker**. Prefer Electrical/PV (`EL=5`). Skip Contract Elements on happy path.
4. Copy Core House type (`ZCLA_COPYCORE`): prefer `.2`/`.3` SNG-ROW.
5. Paste plots (`ZCLA_ADDPLOTFORM`): paste element **PV system**, not DAY WORK.
6. TC-05: one DOCNO with full chain.

## Gotchas

- Insertion-failed toast may still commit — refresh.
- Blank HT after logout — refresh.
- EL mismatch hangs paste — one retry then CASE.

## Pass / fail

PASS: screen-record. FAIL: CASE pack.

