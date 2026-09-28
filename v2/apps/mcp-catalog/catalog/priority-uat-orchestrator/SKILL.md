---
name: priority-uat-orchestrator
description: >-
  Cross-cutting Priority UAT standing rules: fast standard test vs optional video pack,
  login, banned sites, CASE, company/DNAME, UNPARK. Use for any Priority DEV/TEST UAT,
  or /priority-uat-orchestrator.
---

# Priority UAT orchestrator

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-uat-orchestrator`).
This catalog does not drive the UI or WCF.

Authoritative harvest: `docs/skill-sources/uat/priority-uat-orchestrator.md` (2026-09-28 fast-path split).
Child skills hold procedure; this skill holds standing rules. FR: `docs/feature-request-priority-uat-fast-path-and-video-skill.md`.

## When

Any Priority user-test on a configured DEV or TEST instance.

## Route (CAST IRON — Simon 2026-09-24)

| Ask | Skill |
|-----|-------|
| **Default / standard test** | Child smoke skills below — **fastest** path to pass/fail (prefer WCF / `priority-web-sdk` / SQL or OData gate). **No** mandatory video. |
| **Human evidence / video pack** | SimonBarnett/bob-design-uat skill **`uat-video-pack`** only (PR #75). Do **not** duplicate video rules here. |

Default = fast test. Invoke `uat-video-pack` only when a human pack is explicitly requested.

## Child skills (fast standard test)

| Work | Skill |
|------|-------|
| Project create TC-01–05 | `priority-project-create-smoke` |
| Day Works gates A–B | `priority-day-works-uat` |
| House-type DELETE smoke | `priority-ht-delete-smoke` |
| Shared WCF walker notes | `priority-uat-wcf` |
| Named Form Prep / generator / PRE-DELETE | `priority-form-engineering` |
| Unprepared forms batch | `prepare-all-unprepared-priority-forms` |

Gates C–G stay parked until UNPARK.

## Hard rules

- Tester read-only on product code; CASE to engineering; no Recalc/HTSWAP/Clear Plots/Site Bom/Margin unless the case says so.
- Max one retry of the same failing step without an engineering reply; then CASE and park.
- Login is case-sensitive (CE example `Si`). If password is prefilled, Log In / Enter immediately.
- Prefer pickers over free text (Branch, Contract Type, VAT Code, company).
- Banned fixtures are case-pack specific (CE example PR25000001 / 004 / 010).

## Evidence (fast standard test)

- Prefer WCF `formStart` / `getRows` / field set / action (see `priority-uat-wcf`) over headed browser when the same fields/actions can be asserted.
- Independent gate after the walk: SQL, OData, or re-read — never trust SDK "completed" alone.
- **PASS:** structured result; **screenshots only if everything passed** (optional). **No** mandatory screen-record / video on the standard path.
- **FAIL:** CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN (exact text). SCREEN optional when there was no headed capture.
- Silent structured PASS is valid formal UAT for the standard path.

## Video / human packs

All human-speed / mouse / ripples / idle cuts / burn-in subtitle rules live in **bob-design-uat `uat-video-pack`**. Orchestrator only points there. Do not require headed Chrome for standard smoke when WCF can assert the same checks.

## Company / DNAME

UI title ≠ SQL DNAME. CE TEST example: UI **T - Clarkson Evans Live - 20251031** = DNAME `base`; UI **Test** = DNAME `test` (empty of PR26* fixtures). Confirm company title after login; USERENV can stick — relogin after change. Pin company via instance config DNAME, not UI title.

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

No secrets in git. No invented ENAMEs. Amplify MCP is grab-only. Do not edit v1 `src\Prepare-NamedForm.ps1` for UAT.

