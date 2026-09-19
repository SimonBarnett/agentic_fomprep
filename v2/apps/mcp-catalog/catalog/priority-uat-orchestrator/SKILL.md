---
name: priority-uat-orchestrator
description: >
  Cross-cutting CE Priority UAT standing rules: login Si, banned sites, video/CASE,
  company confirmation, UNPARK protocol. Use when running CE Priority user tests
  on DEV or TEST web, or /priority-uat-orchestrator.
---

# CE Priority UAT orchestrator

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-uat-orchestrator`). Browser/desktop only. This catalog does not drive the UI.

Authoritative harvest: Jester UAT harvest in `docs/jester-priority-uat-skill-harvest-2026-09-19.md`. Child skills hold procedure; this skill holds standing rules. Do not duplicate those rules in the children beyond a pointer.

## When

Any CE Priority user-test on DEV or TEST web.

## Child skills

| Work | Skill |
|------|-------|
| Project create TC-01-05 | ce-priority-project-create-smoke |
| Day Works gates A-B | ce-priority-day-works-uat |
| House-type DELETE smoke | ce-priority-ht-delete-smoke |
| Named Form Prep / generator / PRE-DELETE code | priority-form-engineering |

Gates C-G (parallel DW lines, Quote, COW, Word, full UAT-01..14) stay parked until UNPARK.

## Hard rules

- Tester read-only on product code; CASE to engineering; no Recalc/HTSWAP/Clear Plots unless the case says so.
- Max one retry of the same failing step without an engineering reply; then CASE and park.
- Login `Si` (case-sensitive). If the password is prefilled, Log In immediately.
- Prefer pickers over free text (Branch, Contract Type, VAT Code).
- Banned sites: PR25000001 / 004 / 010. Avoid Recalc Plots/Types, HT Swap, Clear Plots, Site Bom, Margin unless unparked.

## Evidence

- PASS: screen-record. A silent pass without video is not allowed for formal UAT.
- FAIL: CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN (exact text).
- Human packs: human speed, mouse visible (`ffmpeg x11grab -draw_mouse 1`), click ripples, cut idle, burn-in subtitles. Capture the correct Priority display (wrong DISPLAY = empty video).

## Env

| Host | Use | Company pitfall |
|------|-----|-----------------|
| prioritydev.clarksonevans.co.uk | Day Works / create-smoke | Usually D / SQL `base` |
| prioritytest.clarksonevans.co.uk | HT-delete | DNAME `base` = UI title "T - Clarkson Evans Live - 20251031"; UI "Test" = DNAME `test` (empty PR26*). Confirm company title; USERENV can stick -- relogin after change. |

Thick client: CE-PRIORITY-DEV1, SQL `10.220.0.5\DEV`. Browser/desktop only (no MCP execute).

## UNPARK / CASE

Do not run a parked gate until an UNPARK note names it. Failures park with CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN. Company confirmation is required on TEST before any mutate.

## Not this catalog

Do not expect UAT tools on `mcp-priority.ntsa.uk`. Do not put secrets in git.
