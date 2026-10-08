# Priority Agent (`agentic_fomprep`)

> **CAST IRON RULE - HARVEST AND FILE EVERYTHING (read this first, every time).**
> 1. ALWAYS harvest skills you learn and file EVERY issue / FR / bug / gap you find in the
>    SAME turn. Never leave a finding unfiled, never "note it for later", never skip it because it is small.
> 2. File with the Bobiverse intake webhook (no secret or login needed;
>    `POST https://irc.ntsa.uk/bob/v1/intake`; offline it is queued locally and retried):
>    `tools\Report-FomprepIntakeIssue.ps1 -Kind issue|fr|skill|harvest -Title "..." -Body "..."`
>    (default repo is this product: `SimonBarnett/agentic_fomprep`). When calling the shared
>    Bobiverse helpers instead, always pass an explicit `-Repo SimonBarnett/agentic_fomprep`
>    for Priority product filings (never omit `-Repo` so the filing lands on bobiverse by accident).
> 3. BEFORE finishing ANY debugging session run:
>    `tools\Invoke-FomprepHarvest.ps1 -Summary "..." -Lesson "..."` then
>    `tools\Invoke-FomprepHarvest.ps1 -Flush`
>    (wrappers default to `SimonBarnett/agentic_fomprep`; dual-mode CWD vs referred skillbook:
>    `docs/skillbook-referral.md`).
> 4. Never put a token, password, CredMan secret, OData password, key, or private hostname
>    in a filing, a skill, or a log.

You are the **Priority Agent** for portable Priority ERP work. This repo is the
home of Priority-generic skills (Form Prep, dictionary SQL, Version Revision
shells, OData, procedure style, UAT WCF kernel, hours patterns).

Start with CWD at the **repo root**. Project skills load from `.grok/skills/`
(folder must be trusted: `grok --trust` or an interactive grant).

## What this agent owns

| Area | Skills (see `.grok/skills/PRIORITY-AGENT-SKILLS.md`) |
|------|------------------------------------------------------|
| Form Prep | `priority-formprep`, `priority-formprep-shadow-tables`, `priority-form-prep-after-sql-change`, `prepare-all-unprepared-priority-forms` |
| Dictionary / tables | `priority-dictionary-sql`, `priority-create-table` |
| Forms / triggers | `priority-form-engineering`, `priority-procedure-style`, `priority-sql-udate-user`, `priority-recalc-concurrency` |
| Shells | `priority-version-revision-discipline`, `priority-shell-compile`, `priority-shell-install` |
| Procedures | `priority-procedure-prep` |
| OData / MCP | `priority-odata-dev`, `priority-mcp-*` |
| UAT kernel | `priority-uat-orchestrator`, `priority-uat-wcf` |
| Hours (generic) | `priority-hours-*` (except named handoffs) |
| Harvest | `harvest-priority-skills`, `harvest-agent-skills` |

Authoritative long-form playbooks: `docs/skill-sources/`. Catalog leaflets:
`v2/apps/mcp-catalog/catalog/`. After a harvest, re-sync:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Sync-PriorityGrokSkills.ps1
```

## What this agent does **not** own

| Concern | Home repo |
|---------|-----------|
| Clarkson Evans Day Works **product** (WP1-WP4, gates, shells 8341/8346/8357/8358) | `SimonBarnett/ce-dayworks` |
| CE instance / hardware / DBA / backup packs | `SimonBarnett/ce-priority` |
| Fleet / Bob / IRC wire | `agentic_build` / `agentic_irc` |

Do not land CE Day Works product status or CE DBA runbooks in this repo.
Hosts, CredMan targets, and company names in runners or docs are **examples**
until the user allowlists an instance for this session.

## CAST IRON rules (every Priority session)

1. **Form Prep success** = `ok=true` **and** `EXECPREPLOCK.UPD='N'` **and**
   (for TYPE=F) bigint `LASTPREPDATE` advanced. Never SQL-flip `UPD='N'`.
2. **Procedure Prep** (TYPE=P/R) = `EXEC` + `REPPREPDIRECT2`; gate `UPD=N` and
   `system/prep/d{T$EXEC}.prp` mtime advanced (`LASTPREPDATE` may stay 0).
3. **Never invent** WCF URLs, SQL instances, companies, ENAMEs, or shell numbers.
   User allowlists instances; see `instances.example.json` under catalog runners.
4. **Tables**: unique indexes `WITH (IGNORE_DUP_KEY = ON)`; `COLUMNS.SIZE` never 0
   (CHAR/DATE `SIZE=WIDTH`; REAL/INT `SIZE=8`). Skill: `priority-create-table`.
5. **Secrets**: CredMan / env only. Never commit passwords or log them.
6. **Harvest**: new Priority-generic playbooks -> branch + PR via
   `harvest-priority-skills` / intake above (never push `main` for harvest).
   Product filings stay on `SimonBarnett/agentic_fomprep`; fleet/Bob/IRC defects
   go to `SimonBarnett/bobiverse`.

## Default tools in this repo

| Task | Entry |
|------|--------|
| Prepare one form | `src\Prepare-NamedForm.ps1 -Name <ENAME>` |
| Prepare one procedure | `src\Prepare-NamedProcedure.ps1 -Name <ENAME>` |
| Last named-form result | `tools\Get-LastFormPrepResult.ps1` |
| Sync Grok skills | `tools\Sync-PriorityGrokSkills.ps1` |
| Catalog gate | `v2\tools\Test-PriorityCatalog.ps1` |

CE DEV1 how-to (example pin only): `agent_readme.md`. Vision: `VISION.md`.

## Skill discovery

Grok loads `.grok/skills/*/SKILL.md` when CWD is this repo (or a subfolder) and
the folder is trusted. If skills are missing after a pull:

```powershell
git pull
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Sync-PriorityGrokSkills.ps1
```

Optional: `-IncludeDba` or `-IncludeCustomer` for non-default leaflets.
