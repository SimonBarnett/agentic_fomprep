# FR: Split Priority UAT — fast standard test vs video pack skill

**Date:** 2026-09-24  
**From:** Jester (UAT agent) per Simon  
**Parked by:** Bob, 2026-09-25  
**Repo:** SimonBarnett/agentic_fomprep  
**Status:** ready for build  
**Related:** PR #44 (UAT skill harvest 1.1.0, merged; still carries mandatory video); formprep WCF walker (`src/sdk/run-formprep.mjs`, `v2/lib/wcf.ps1`); video pack skill `uat-video-pack` in SimonBarnett/bob-design-uat (PR #75)

## Problem

Harvested UAT skills still bake "screen-record every PASS or CASE on fail" into the standard test path. That is slow and fights the WCF method the skill book already uses for form prep. Simon moved video into a **separate** skill; the standard test skill must be the **fastest** path to a pass/fail finding.

## Decision (Simon, 2026-09-24)

1. **Standard test skill**: fastest method that returns findings (prefer `priority-web-sdk` / WCF over headed browser). Fail: CASE to engineering (`CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN`, SCREEN optional when no headed capture). Pass: structured result; **screenshots only if everything passed**.
2. **Separate video / human UAT skill** owns human packs (human-speed, visible mouse, click ripples, idle cuts, burn-in subtitles). Invoked only when a human pack is requested. It lives as `uat-video-pack` in SimonBarnett/bob-design-uat (#75); agentic_fomprep only points to it.

## Proposed catalog / sources

| Skill | Role |
|-------|------|
| `priority-uat-orchestrator` | Route: default to fast test; optional pointer to bob-design-uat `uat-video-pack` when human evidence asked |
| `priority-project-create-smoke`, `priority-day-works-uat`, `priority-ht-delete-smoke` | Rewrite for **fast path**: WCF `formStart`/`getRows`/field set/action plus SQL or OData gate where applicable; no video; screenshots only on full PASS |
| **New** `priority-uat-wcf` (optional shared kernel) | Walker pattern mirrored from formprep: CredMan password, pin company DNAME, dump JSON, never trust SDK "completed" alone |

## Non-goals

- Do not edit v1 `src/Prepare-NamedForm.ps1` for UAT.
- Do not invent procedure ENAMEs; pinned or Eshbel-supplied names only.
- Do not drop CASE reporting on fail.
- Do not require headed Chrome for standard smoke when WCF can assert the same fields/actions.
- Do not duplicate video rules in agentic_fomprep.

## Acceptance

- [x] FR parked under `docs/feature-request-*.md`
- [ ] Catalog / skill-sources say: fastest path; screenshots only on full PASS; no mandatory video
- [ ] Video rules live only in bob-design-uat `uat-video-pack` (+ orchestrator pointer)
- [ ] Offline `Test-PriorityCatalog.ps1` still PASS
- [ ] Bob MRB; Jester hostile UAT after merge

## Notes for implementer

Reuse formprep WCF patterns: login, `formStart` / `procStart`, filter, steps, scrape errors, then independent gate (SQL/OData/re-read). Company = pinned DNAME (instance config), not UI title. Instance, user and allowlist via config/env; CE (`base`, user `Si`) is example only.
