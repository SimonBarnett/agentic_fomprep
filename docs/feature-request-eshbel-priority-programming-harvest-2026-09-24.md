# Feature request — Eshbel Priority programming skill harvest (2026-09-24)

**Intake / track with:** [GitHub issue #7](https://github.com/SimonBarnett/agentic_fomprep/issues/7) (skills catalog) — this FR is an additive harvest, not a replacement.
**From:** Eshbel (Simon 2026-09-24: "harvest all the Priority programming skills you have learned into that repo")
**Repo:** SimonBarnett/agentic_fomprep
**Status:** ready for build agent
**Standing order:** Eshbel UATs / hostile-MRBs after implement. Bob owns intake wiring if needed.

## Goal

Land the Priority **programming** knowledge Eshbel learned on CE DEV/TEST (Sep 2026 Day Works + HT-delete + Form Prep + OData) as:

1. Source dump under `docs/skill-sources/programming/` (this FR's authority for new facts).
2. New catalog skills under `v2/apps/mcp-catalog/catalog/` (Priority-generic ids; CE examples only).
3. Targeted expansions of existing catalog skills where facts belong with current owners.

Naming: **priority-*** only (config-driven instance). Do not invent Prepare/Install ENAMEs. Do not edit v1 `src\Prepare-NamedForm.ps1`. No secrets in git.

## Already shipped (do not re-port)

Catalog already has (issue #7 / earlier FRs): formprep, odata-dev, form-engineering, shell-compile/install, UAT suite, HT smoke/triage, DBA suite. This harvest **fills gaps** and **corrects** stale notes.

## A. New catalog skills (MUST)

### 1) `priority-procedure-style`

When writing or editing Priority form triggers / SQLI procedures / #INCLUDE bodies.

Source: `docs/skill-sources/programming/PROCEDURE_STYLE.md`

Hard rules:
- Banner: name + one-line purpose; `/* Inputs */` / `/* Outputs */` listing `:VAR`s; `/* Heading */` / `/* Sub-heading */` body sections.
- When touching existing stack triggers, update headers to match.
- Debug: `#INCLUDE` site debug helper (CE: `func/ZCLA_DEBUGUSR`); set `:RUN_BY` before includes as `Form/proc / column / trigger-or-step`; gate logs on `:DEBUG=1` to `:DEBUGFILE`.
- Customization: 4-letter customer prefix; copy vendor objects — do not edit in place.
- Prefer dedicated TRIG ids over overwriting shared POST-FORM (shared TRIG overwrite bites sibling forms).

### 2) `priority-sql-udate-user`

When minting History/audit rows or writing SQL Server triggers that set Priority `UDATE` / user fields.

Source: `docs/skill-sources/programming/SQL_UDATE_USER.md`

Hard rules:
- Priority `UDATE` is **minutes since 1988-01-01**, not a SQL datetime. Use `SQL.DATE` (form/SQLI) or `DATEDIFF(minute, '19880101', GETDATE())` pattern in SQL Server triggers.
- Never `MAX(UDATE)+1` — that collapses to Priority zero date `01/01/88 00:01` and fails UAT asserts.
- `SQL.USERLOGIN` is invalid. Use `USERLOGIN` from `USERS` where `USER = SQL.USER`.
- Gate mint on meaningful text only (empty leave-field must not spam History).

### 3) `priority-formprep-shadow-tables`

When Form Prep fails with SQL 208 / missing temp objects, or preparing forms for new tables.

Source: `docs/skill-sources/programming/FORMPREP_SHADOW_TABLES.md`

Hard rules:
- New tables need `pritempdb.dbo.T$$<TNAME>` (+ `T$LINKID`) mirroring live base, plus CATALOG registration (`TNAME` max 20).
- Prefer Named Form Prep / Web SDK path; Priority `bin\formprep.exe` often fails SQL auth (no Integrated Security).
- Agent/non-interactive `WINRUN … WINACTIV -P FORMPREP` often exits 0 with **no** EXECPREPLOCK change when other winactiv run — treat EXECPREPLOCK (`UPD=N` + LASTPREPDATE advanced) as the only success signal.
- Working interactive pattern (document, do not hardcode secrets): `winrun "" <user> <pass> <system\prep> <company> WINACTIV -P FORMPREP [FormName]` — no `-nbg`, no `-T`.

### 4) `priority-recalc-concurrency`

When editing delete/recalc paths under live Stack load, or diagnosing hangs that are not 1205.

Source: `docs/skill-sources/programming/RECALC_CONCURRENCY.md`

Hard rules:
- Checkpoint helpers that `#INCLUDE …/ZCLA_CHKPNT-DEL` often expect **positive** `:ELEMENT` and delete `-:ELEMENT`. If PRE-DELETE selected `PROJACT<0` backups, flip sign (`:ELEMENT = - :ELEMENT`) before the include or the loop hangs with no 1205.
- Harden deletes: clear `ZCLA_RECALC` for that entity only; pre-purge dependent plot rows (e.g. `ZCLA_SMALLWORKSPLOT`) for those checkpoints; align NCI to live shape (e.g. `(PROJACT, FIX)`).
- Open edit rows (e.g. `ZCLA_HTEDIT`) can block deletes by design — pick 0-edit fixtures for smoke.
- Consumers that only gate on `RECALC=Y` / `ISBUILD=Y` (Margin Calculator pattern) can open on **stale prices** after HT swap or stuck P/INPROG — treat as product risk, not just flag hygiene.

### 5) `priority-version-revision-discipline`

When maintaining Version Revision shells / TAKETRIG packs for a feature stream.

Source: `docs/skill-sources/programming/VERSION_REVISION.md`

Hard rules:
- One dedicated shell per workstream; keep shell text updated as work proceeds; Prepare after meaningful batches.
- Never mix unrelated streams into a shared upgrade (CE example: never mix Day Works into 8338).
- Re-preparing the same Version Revision after content change is normal.
- Silent install miss: UI can show Installed while `INSTALLEDUPGTRIG` / TAKETRIG rows are zero — verify hashes and installed trigger rows.
- TAKETRIG Revision Steps that work: `HOWCREATED=M`, `AFTERPREP=Y`, `OPTFLAG` blank (match known-good shells). Wrong step shape → booked shell, zero triggers applied.
- Headless takeupgr Prepare can fail without a linked Version Revisions UI row — human Prepare click may still be required.
- Compile/install ENAMEs only from `v2/config/pin.json` (see priority-shell-*).

## B. Expand existing catalog skills

### `priority-form-engineering`

Merge pointers + short sections from A.1–A.5 (do not duplicate full bodies; link skill-sources + sibling skills). Add:
- Dedicated TRIG vs shared POST-FORM overwrite.
- FORMKEYS/EXPRESSION restore after Prep.
- SQL UDATE mint footgun → link `priority-sql-udate-user`.
- Shadow T$$ → link `priority-formprep-shadow-tables`.
- ELEMENT sign + RECALC clear → link `priority-recalc-concurrency` (keep short PRE-DELETE blurb).
- Shell discipline → link `priority-version-revision-discipline`.

### `priority-odata-dev`

Add:
- `formlimited_audit` must join on real key **`[T$EXEC]`** (plus ENAME), **not** `FORMLIMITED.FORM` (that column does not exist — known sql_failed on issue #7 / MRB of `80d8ce4`).
- Table Dictionary CATALOG family often returns "API cannot be run" — register CATALOG/COLUMNS/INDEXES/INDCLMNS/CATALOGA via SQL first.

### `priority-ht-delete-deadlock-triage`

Rename leftover `ce-priority-ht-delete-smoke` references to `priority-ht-delete-smoke`. Note hang-without-1205 = ELEMENT sign (recalc-concurrency), not only classic 1205.

### `docs/skill-sources/README.md`

Add programming harvest section pointing at `docs/skill-sources/programming/` and this FR.

## C. Optional note (not a skill)

SDK feature map (forms/triggers, SQLI+ACTIVATF, reports, tables/DBI, INTERFACE loads, menus, BPM, REST OData, Web SDK, MCP ≥26, TTS, privileges, Customization-Rules, Version Revisions) can live as `docs/skill-sources/programming/SDK_FEATURE_MAP.md` for archaeology — no catalog id required this ticket unless Bob wants `priority-sdk-map`.

## Acceptance

1. Source files under `docs/skill-sources/programming/` match this FR.
2. New catalog folders A.1–A.5 each have `SKILL.md` + `meta.json` (same shape as `priority-form-engineering`).
3. Expansions in B applied; no CE-hardcoded secrets; Priority-generic wording with CE examples labeled as examples.
4. Offline catalog tests still pass (or updated for new ids).
5. Issue #7 comment summarizing this additive harvest + link to PR.
6. Hostile MRB owner: Eshbel after merge.

## Non-goals

- Fixing live `formlimited_audit` runner SQL beyond documenting the `T$EXEC` key (separate Bob tip already tracked).
- Landing HT-delete / Day Works onto LIVE.
- Changing v1 Prepare-NamedForm.ps1.
- Inventing shell procedure ENAMEs.
