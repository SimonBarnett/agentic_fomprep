# Feature request — CE Priority agent skills into agentic_fomprep v2 (2026-09-19)

**From:** Eshbel (Simon 2026-09-19)  
**Repo:** SimonBarnett/agentic_fomprep  
**Status:** parked for build agent  
**Standing order:** Eshbel UATs and hostile-MRBs back to Bob after implement.

## Goal

Catalog folders under `v2/` (same pattern as `priority-formprep` / shell-compile) so any agent can grab Clarkson Evans Priority skills. Port existing Grok Bot workflows + add OData / form-engineering skills. Jester testing harvest merges into a stub later.

## LOCKED

- Do **not** invent Prepare Upgrade / Install Upgrade ENAMEs; keep `PinComplete` rules from shell-compile WP0.
- Do **not** change v1 `src\Prepare-NamedForm.ps1`.
- No secrets in git (CredMan / env only).
- Document FORMLIMITED / RESTFLAG footgun.
- Catalog MCP stays grab-only on Amplify; local plugins execute against allowlisted Windows instances.

## A. Port existing workflow skills

Copy into `v2/.../catalog/<name>/` (`SKILL.md` + `meta.json`) from existing workflows:

1. `ce-priority-project-create-smoke` — TC-01–05 site→contract→copy HT→paste plots
2. `ce-priority-day-works-uat` — Gates A/B/C Day Works UAT + video/CASE rules
3. `prepare-all-unprepared-priority-forms` — web Form Preparation batch
4. Medatech hours trio (optional separate catalog if out of CE scope): enter / search / export project hours

Source leaflets live under the Grok Bot workflows library; build agent should read those SKILL.md bodies and port faithfully.

## B. New skill: `priority-odata-dev` (MUST)

Use when reading/writing Priority dictionary or business data via OData instead of UI-only.

### Base URLs (CE DEV proven)

- Tabula OData: `https://prioritydev.clarksonevans.co.uk/odata/Priority/tabula.ini/base`
- Procedures: `.../base/EPROG` expand `PROG_SUBFORM` → `PROGTEXT_SUBFORM` for Step Query text (prefer over empty PROCTABLETEXT)
- Auth: HTTP Basic, username **case-sensitive** `Si` (CredMan `CE/Priority/Si`)
- Forms: EFORM family when licensed; structural asserts may use SQL on DEV when OData 401

### FORMLIMITED / RESTFLAG (critical)

- `RESTFLAG=Y` on FORMLIMITED can expose forms to OData **but** with LIMITFLAG blank + Si can **hide** the same forms from web sibling-tab strips (seen on PART long-desc tabs 2026-09-15).
- Do **not** leave RESTFLAG-only FORMLIMITED on UI-tested forms until LIMITFLAG/RESTFLAG pattern for “OData without hiding UI” is confirmed.
- Deleting bad FORMLIMITED rows restored UI tabs.

### Hard rules

- Never log passwords; use CredMan / env like formprep
- Prefer OData EPROG dumps for procedure archaeology; write dumps under instance work dir
- SQL on `system`/`base` is allowed for EXECPREPLOCK / FORMTRIGTEXT / structural asserts — OData does not replace Form Prep success gates
- Company/DNAME: UI title ≠ SQL DB name (e.g. TEST `base` = “T - Clarkson Evans Live - 20251031”; `test` = “Test”). Check USERENV.DNAME

### Suggested tools (plugin)

- `odata_get` / `odata_query` (path + $expand/$filter)
- `odata_dump_procedure` (ENAME → PROGTEXT)
- `formlimited_audit` (list RESTFLAG/LIMITFLAG risks for a form set)

## C. New skill: `priority-form-engineering` (MUST)

Use when changing CE custom forms/triggers/shells on DEV.

### Named Form Prep (DEV)

- Entry: `src\Prepare-NamedForm.ps1` (repo path; operators may use mapped `M:\py\agentic_fomprep\...`) — Web SDK EFORM→FORMPREPDRCT2; success only `ok=true` AND EXECPREPLOCK UPD=N AND LASTPREPDATE advanced
- Never fake UPD=N; Environment DEV only in current pin; Si may lack API licence on TEST → client Form Prep
- Re-prepare after FORMTRIGTEXT edits is normal at CE

### Generator / nav gotchas

- F6 on menu opens Menu Generator — highlight form then F6 for Form Generator
- F11 on Form Name (top list) to find forms; Sub-level Forms F6×2 down; never F6 empty Form Name
- #INCLUDE: F6 on include line → INCLUDE Line; F12 then F6 for body
- FORMKEYS/EXPRESSION can strip after Prep — restore parent keys after Prep when needed (PARTLONG pattern)
- New triggers: banner + Inputs/Outputs :VARs + Heading sections (CE code docs)

### House type PRE-DELETE (2026-09-18)

- `ZCLA_CHKPNT-DEL` expects **positive** `:ELEMENT`; PRE-DELETE must `:ELEMENT = - :ELEMENT` after selecting PROJACT<0 backups or loop hangs
- Optional harden: clear ZCLA_RECALC for that HT only; pre-purge ZCLA_SMALLWORKSPLOT for those checkpoints
- Open ZCLA_HTEDIT rows block HT delete (“Value exists in House Type Edits form”)

### Shells

- Dedicated Version Revision shells; never mix Day Works into upgrade 8338
- Install with zero TAKETRIG rows = silent miss — verify INSTALLEDUPGTRIG / hashes

## D. New skill: `priority-uat-orchestrator` (stub until Jester harvest)

- UNPARK/CASE protocol: CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN
- Company confirmation required on TEST
- PASS needs video; FAIL parks with CASE
- Merge Jester’s full testing skill list when available (stub OK this ticket)

## Acceptance

1. Catalog entries + SKILL.md for A–C (D stub OK)
2. OData plugin tools callable from allowlisted Windows instance with CredMan — no secrets in git
3. Hostile MRB (Eshbel): no guessed shell ENAMEs; formprep v1 untouched; document FORMLIMITED/RESTFLAG footgun
4. Eshbel UAT: OData dump of one known EPROG + Form Prep named smoke after ship (when DEV1 available)

## Non-goals

- Completing WP0 PinComplete / live shell compile-install (separate handoff; blocked on DEV1)
- Amplify hosting secrets
- Guessing procedure ENAMEs
