---
name: priority-uat-orchestrator
description: >-
  Cross-cutting Priority UAT standing rules: login, banned sites, human video/CASE, company/DNAME confirmation, UNPARK protocol. Use for any Priority web user test on DEV or TEST, or /priority-uat-orchestrator.
---

# Priority UAT orchestrator

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-uat-orchestrator`). Browser/desktop only. This catalog does not drive the UI.

Authoritative harvest: `docs/skill-sources/uat/priority-uat-orchestrator.md` (2026-09-24). Child skills hold procedure; this skill holds standing rules.

## When

Any Priority web user-test on a configured DEV or TEST instance.

## Child skills

| Work | Skill |
|------|-------|
| Project create TC-01–05 | `priority-project-create-smoke` |
| Day Works gates A–B | `priority-day-works-uat` |
| House-type DELETE smoke | `priority-ht-delete-smoke` |
| Named Form Prep / generator / PRE-DELETE | `priority-form-engineering` |
| Unprepared forms batch | `prepare-all-unprepared-priority-forms` |

Gates C–G stay parked until UNPARK.

## Hard rules

- Tester read-only on product code; CASE to engineering; no Recalc/HTSWAP/Clear Plots/Site Bom/Margin unless the case says so.
- Max one retry of the same failing step without an engineering reply; then CASE and park.
- Login is case-sensitive (CE example `Si`). If password is prefilled, Log In / Enter immediately.
- Prefer pickers over free text (Branch, Contract Type, VAT Code, company).
- Banned fixtures are case-pack specific (CE example PR25000001 / 004 / 010).

## Evidence

- PASS → screen-record. Silent pass without video is not formal UAT.
- FAIL → CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN (exact text).
- Human packs: human speed; mouse visible (`ffmpeg x11grab -draw_mouse 1`); click ripples; cut idle; burn-in subtitles; capture the correct Priority display (wrong DISPLAY = empty video).

## Company / DNAME

UI title ≠ SQL DNAME. CE TEST example: UI **T - Clarkson Evans Live - 20251031** = DNAME `base`; UI **Test** = DNAME `test` (empty of PR26* fixtures). Confirm company title after login; USERENV can stick — relogin after change.

## Env

Hosts and jump boxes come from instance config. CE examples only: `prioritydev.clarksonevans.co.uk` (Day Works / create-smoke), `prioritytest.clarksonevans.co.uk` (HT-delete), thick client CE-PRIORITY-DEV1, SQL `10.220.0.5\DEV`.

## UNPARK / CASE

Do not run a parked gate until UNPARK names CASE/DOCNO/steps. Company confirmation required on TEST before mutate.

```
CASE:
DOCNO:
STEP:
ACTION:
FIELD:
TRIED:
ERROR:
SCREEN:
```

## Not this catalog

No secrets in git. No invented ENAMEs. Amplify MCP is grab-only.

