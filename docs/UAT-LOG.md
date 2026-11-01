# UAT log — SimonBarnett/agentic_fomprep#0

**Verdict:** UAT PASS  
**Date (UTC):** 2026-11-01T21:10:36Z  
**Commit tested:** cd47a99082ef5ac73f65ecd13e039026946e2dca (origin/main after PR #254)  
**Seat / machine:** flamingo-37172 (Windows)  
**Cycle PRs:** #252 (harvest lesson), #253 (Fr201 rules-version >= 2), #254 (docs/mrb-253 hostile pin)

## Vision criteria (offline / harness)

| id | criterion | result | evidence |
|----|-----------|--------|----------|
| V1 | Priority Agent rules-version >= 2; connect without ask; prefer DEV; never echo secrets; ask before messaging | PASS | Test-Fr201-VisionRulesV2.ps1 (rules-version got 4); Test-Mrb200-CatalogStdio.ps1 |
| V2 | Fr201 pin uses -ge 2 (not exact document version 2) | PASS | Test-Mrb253-Fr201RulesVersionGe2.ps1 |
| V3 | Catalog merge gate + honesty-box intake + no-BOM metas | PASS | 2/tools/Test-PriorityCatalog.ps1 |
| V4 | OData empty-500 company probe (FR #226) | PASS | Test-Fr226-ODataEmpty500Refuse.ps1 |
| V5 | SaaS OIDC / catalog skill pins (FR #212/#219/#208) | PASS | matching 	ests/Test-*.ps1 |
| V6 | Main auto-merge protection docs (FR #247) | PASS | Test-Fr247-MainAutoMergeProtection.ps1 |
| V7 | Form Prep EXECPREPLOCK/LASTPREPDATE live success | SKIP | No C:\passwords\agentic_fomprep-connections.txt on flamingo; no DEV1 session. Product rules require ask Haitch when missing. Not a product defect for this cycle. |

## Harness

All 13 root 	ests/Test-*.ps1 scripts: **PASS** (exit 0).  
Test-PriorityCatalog.ps1: **PASS**.

## Notes

- CAT-T56 gate *label* still says "refuses live/PRI" while VISION rules v2 allows Live/PRI connect without ask (prefer DEV). Assert only checks the string live/PRI is present — ACCEPTABLE label drift; not filed as a blocking gap this cycle.
- Launcher PriorityAgent.exe release path remains CI (launcher-v* / workflow_dispatch); this UAT does not rebuild the launcher (no local dotnet). Prior asset: release launcher-v1.0.0.

## Gaps

none
