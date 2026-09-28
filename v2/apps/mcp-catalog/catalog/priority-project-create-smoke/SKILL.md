---
name: priority-project-create-smoke
description: >-
  Priority project create smoke TC-01–05 (fast path): new project, team, contract, copy HT, paste plots.
  Prefer WCF over headed browser; no mandatory video. Use for project create smoke, TC-01, or /priority-project-create-smoke.
---

# Priority project create smoke (TC-01–05)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-project-create-smoke`).
This catalog does not drive the UI or WCF.

Follow **priority-uat-orchestrator** (fast standard test). Prefer **priority-uat-wcf** / formprep-style WCF over headed browser when the same fields/actions can be asserted. Source: `docs/skill-sources/uat/priority-project-create-smoke.md` (2026-09-28).

## When

Smoke a new site/project through team → contract → copy HT → paste plots.

## Sequence

1. New project (`DOCUMENTS_p` TYPE=p). **New DOCNO each run.**
2. Internal Project Team: add tester (CE: `Si`) — required or `ZGEM_ERR_NOTINTEAM`.
3. Contract (`ZCLA_CONTRACTS`): Branch + Contract Type via **picker**. Prefer Electrical/PV (`EL=5`). Skip Contract Elements on happy path.
4. Copy Core House type (`ZCLA_COPYCORE`): prefer `.2`/`.3` SNG-ROW.
5. Paste plots (`ZCLA_ADDPLOTFORM`): paste element **PV system**, not DAY WORK.
6. TC-05: one DOCNO with full chain.
7. Independent gate: re-read rows (WCF/SQL/OData) — do not trust SDK "completed" alone.

## Gotchas

- Insertion-failed toast may still commit — refresh / re-read.
- Blank HT after logout — refresh.
- EL mismatch hangs paste — one retry then CASE.

## Pass / fail

- **PASS:** structured result (DOCNO + chain asserted). Screenshots **only if everything passed** (optional). **No** mandatory video / screen-record.
- **FAIL:** CASE pack (SCREEN optional if no headed capture).
- Human video evidence → bob-design-uat **`uat-video-pack`** only (orchestrator route).
