# Priority UAT orchestrator (source)

Updated 2026-09-28 for FR #53 (fast standard test vs video pack).

## When

Any Priority user-test on a configured DEV or TEST instance. Child skills hold procedure; this skill holds standing rules.

## Route

- **Default:** fast standard test (WCF / SQL / OData preferred). No mandatory video.
- **Human video pack:** SimonBarnett/bob-design-uat `uat-video-pack` only — do not duplicate video rules here.

## Child skills

| Work | Skill |
|------|-------|
| Project create TC-01–05 | `priority-project-create-smoke` |
| Day Works gates A–B | `priority-day-works-uat` |
| House-type DELETE smoke | `priority-ht-delete-smoke` |
| Shared WCF notes | `priority-uat-wcf` |
| Named Form Prep / generator / PRE-DELETE code | `priority-form-engineering` |
| Unprepared forms batch | `prepare-all-unprepared-priority-forms` |

Gates C–G stay parked until UNPARK.

## Hard rules

- Tester is **read-only** on product code. Report fails to engineering (CASE). Do not Recalc / HT Swap / Clear Plots / Site Bom / Margin unless the case says so.
- **Max one retry** of the same failing step without an engineering reply; then CASE and park.
- Login username is instance-configured and **case-sensitive** (CE example: `Si`). If the password is already filled on the login dialog, click Log In / OK or press Enter **immediately** (do not idle).
- Prefer **pickers** over free text (Branch, Contract Type, VAT Code, company).
- Do not use banned fixture sites from the case pack (CE example: PR25000001 / 004 / 010).

## Evidence (fast standard test)

- Prefer WCF `formStart` / `getRows` / field set / action over headed browser when equivalent.
- Independent gate after the walk (SQL/OData/re-read). Never trust SDK "completed" alone.
- **PASS:** structured result; screenshots only if everything passed (optional). No mandatory screen-record.
- **FAIL:** CASE template (SCREEN optional when no headed capture):

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

Video / human-speed / mouse / ripples / idle cuts / burn-in subtitles → **bob-design-uat `uat-video-pack`** only.

## Company / DNAME pitfall (critical)

UI company title is **not** the SQL database name.

CE TEST example (2026-09-18):

| UI title | SQL DNAME | Notes |
|----------|-----------|-------|
| T - Clarkson Evans Live - 20251031 | `base` | Fixtures (PR26*) lived here |
| Test | `test` | Empty of those fixtures |

Always **confirm the company title after login**. USERENV can stick — change company then **relogin**.

## Env (examples only — prefer instance config)

| Example host | Typical use |
|--------------|-------------|
| `https://prioritydev.clarksonevans.co.uk/` | Day Works / create-smoke |
| `https://prioritytest.clarksonevans.co.uk/` | HT-delete smoke |

## UNPARK protocol

Do not run a parked gate until an UNPARK note names **CASE/DOCNO/steps**. Company confirmation required on TEST before any mutate.

## Not this skill

No secrets in git. No invented ENAMEs. Do not edit v1 `src\Prepare-NamedForm.ps1` for UAT.
