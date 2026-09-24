# Priority UAT orchestrator (source)

## When

Any Priority web user-test on a configured DEV or TEST instance (browser/desktop). Child skills hold procedure; this skill holds standing rules.

## Child skills

| Work | Skill |
|------|-------|
| Project create TC-01–05 | `priority-project-create-smoke` |
| Day Works gates A–B | `priority-day-works-uat` |
| House-type DELETE smoke | `priority-ht-delete-smoke` |
| Named Form Prep / generator / PRE-DELETE code | `priority-form-engineering` |
| Unprepared forms batch | `prepare-all-unprepared-priority-forms` |

Gates C–G (parallel DW lines, Quote, COW, Word, full UAT-01..14) stay parked until UNPARK.

## Hard rules

- Tester is **read-only** on product code. Report fails to engineering (CASE). Do not Recalc / HT Swap / Clear Plots / Site Bom / Margin unless the case says so.
- **Max one retry** of the same failing step without an engineering reply; then CASE and park.
- Login username is instance-configured and **case-sensitive** (CE example: `Si`). If the password is already filled on the login dialog, click Log In / OK or press Enter **immediately** (do not idle).
- Prefer **pickers** over free text (Branch, Contract Type, VAT Code, company).
- Do not use banned fixture sites from the case pack (CE example: PR25000001 / 004 / 010).

## Evidence (standing UAT order)

- **PASS:** screen-record the successful path. A silent pass without video is **not** formal UAT.
- **FAIL:** park with CASE template (exact text, every field):

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

### Human video packs

- Play at **human speed** (not sped up).
- Keep the **mouse cursor moving** visibly through navigation (`ffmpeg` x11grab `-draw_mouse 1`).
- Add **click animations / ripples** so reviewers see where clicks landed.
- **Cut long idle** / no-activity stretches (do not ship raw linger-heavy captures).
- **Burn in subtitles** describing what is on screen.
- Capture the **correct Priority display**. Wrong DISPLAY = empty or wrong video (CE box example: Priority on `:3`).

## Company / DNAME pitfall (critical)

UI company title is **not** the SQL database name.

CE TEST example (2026-09-18):

| UI title | SQL DNAME | Notes |
|----------|-----------|-------|
| T - Clarkson Evans Live - 20251031 | `base` | Fixtures (PR26*) lived here |
| Test | `test` | Empty of those fixtures |

Always **confirm the company title after login**. USERENV can stick on the wrong company — change company then **relogin**. Wrong company = stop and CASE (do not invent data).

## Env (examples only — prefer instance config)

| Example host | Typical use |
|--------------|-------------|
| `https://prioritydev.clarksonevans.co.uk/` | Day Works / create-smoke |
| `https://prioritytest.clarksonevans.co.uk/` | HT-delete smoke |

Thick client / SQL jump box are instance-config (CE example: CE-PRIORITY-DEV1, `10.220.0.5\DEV`). Browser/desktop only for UAT agents (no MCP execute against live Priority from Amplify catalog).

## UNPARK protocol

Do not run a parked gate until an UNPARK note names **CASE/DOCNO/steps** (and company/host if relevant). Company confirmation is required on TEST before any mutate.

## Not this skill

Do not put secrets in git. Do not invent procedure ENAMEs. Form Prep success gates stay with `priority-form-engineering` / `prepare-all-unprepared-priority-forms`.
