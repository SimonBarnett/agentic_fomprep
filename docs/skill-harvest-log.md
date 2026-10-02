# Skill harvest log

- 2026-09-24: Added foundation honesty-box skill at `.grok/skills/harvest-agent-skills/SKILL.md` (home `https://github.com/SimonBarnett/agentic_fomprep`). Table row: Formprep / MSSQL fleet playbooks -> `SimonBarnett/agentic_fomprep`. Product playbooks remain under `v2/plugins/*/skills/` and `v2/apps/mcp-catalog/catalog/`.

- 2026-09-28 (DEV1 / Day Works WP3): New skill `priority-dictionary-sql` (.grok + catalog) and `docs/skill-sources/programming/DICTIONARY_SQL.md`. IDENTITY-safe CATALOG/COLUMNS/T$EXEC/INDEXES inserts; COLUMNS.CNAME; INDEXES.T$KEY; EXECPREPLOCK required before Named Form Prep (`name_missing`); EXECMODULE; shell DBI CREATE TABLE pattern; PowerShell Tee-Object return pollution. Clarified `priority-formprep` catalog `name_missing` / `still_unprepared` (FCLMN).

- 2026-09-28: Rebased honesty-box / Foundation harvest onto main after CONFLICTING PR #68 (issue #58). CAT-T50 asserts Foundation on all priority-* leaflets.

- 2026-09-28 (DEV1): Tabula *Ignore Duplicate Values* + Unique Index/Origin. Harvested `IGNORE_DUP_KEY.md` + `FORMCLMNSA_JOINS.md`; updated `DICTIONARY_SQL.md`, `FORMPREP_SHADOW_TABLES.md`, catalog `priority-dictionary-sql` / `priority-formprep-shadow-tables`. Physical unique indexes need `IGNORE_DUP_KEY=ON` (company often reported as `system`); child joins need FORMCLMNSA `= :$$.COL`.

- 2026-09-28 (DEV1): Form Prep `Variable with two different types : SORT` ï¿½ `:VAR` type clash (`ZCLA_ELEDITSPLIT` `:SORT = ''` vs numeric `:SORT`). Harvested into `PROCEDURE_STYLE.md`, `FORMTRIG_VAR_TYPES.md`, catalog `priority-procedure-style`, `priority-formprep` (WCF warnings + formStart vs SQL gate), `priority-uat-wcf` (`startSubForm` when direct `formStart` says unprepared). Fix applied on DEV as `:DWFIXSORT`.

## 2026-09-29 - ce-priority split + leave-line generics

- Relocated CE DBA pack to private `SimonBarnett/ce-priority` `docs/dba/`; `docs/skill-sources/dba/` is pointer-only.
- Harvest domain table: CE instance/DBA/customisations -> ce-priority; Day Works product -> ce-dayworks.
- Added Priority-generic `INDEXES_TYPE_A_IDENTITY.md` and `MSG154_OPTIMISTIC_LOCK.md` under programming/.

## 2026-09-30 - empty named trigger stub

Added docs/skill-sources/programming/EMPTY_NAMED_TRIGGER_STUB.md.

## 2026-09-30 - WCF Projects hierarchy / retrieve window

Expanded `priority-uat-wcf` skill-source + catalog (v1.1.0): parent `startSubForm` when `formStart` stays O11 after Form Prep; `DOCUMENTS_p` retrieve windows and sticky empty `DOCNO`/`DOC` filters; clearSearchFilter + reload before `setActiveRow`; plot vs element `PROJACT` keys; `Owner missing`; multi-project scan fallback; unique appname/devicename. Product runner stays in ce-dayworks.

## 2026-09-30 - Version Revision TAKE steps (Eshbel shell files)

Expanded `VERSION_REVISION.md` + catalog `priority-version-revision-discipline` v1.1.0 from Eshbel Installing Customizations: Revision Steps (`UPGNOTES`) must be flagged/added before Prepare; SQL `FORMTRIGTEXT` patches do not auto-create TAKE rows; empty steps = non-shippable shell; TAKETRIG shape; headless Prepare may still need a human click. CE proof: shell 8366 Price Log Fix.

## 2026-09-30 - msg 154 nullable form columns + FORMTRIGTEXT 68

Expanded `MSG154_OPTIMISTIC_LOCK.md`: Cause B = nullable origin columns painted on the form with NULL in existing rows (`NULL = NULL` → 0-row UPDATE); DEFAULT + backfill; resync hygiene (do not resync the column the user is editing); `FORMTRIGTEXT.TEXT` max ~68. Updated `PROCEDURE_STYLE.md`, catalog `priority-procedure-style` / `priority-form-engineering` (meta 1.1.0). Version Revision TAKE-steps harvest: merged PR #88.

## 2026-10-01 - Prepare procedure (REPPREPDIRECT2)

- New skill-source `docs/skill-sources/programming/PREPARE_PROCEDURE.md`.
- Catalog `priority-procedure-prep` (meta 1.0.0) + runners `src/Prepare-NamedProcedure.ps1`, `src/sdk/run-repprep-via-exec.mjs`.
- Path: `EXEC` → `activateStart(REPPREPDIRECT2)`. Bare `procStart` cannot fill FILE `PAR`.
- Success: `EXECPREPLOCK.UPD=N` + `system/prep/d{T$EXEC}.prp` mtime advanced (`LASTPREPDATE` may stay 0).
- Cross-link from `priority-formprep` (TYPE=P is not EFORM).

## 2026-10-02 - UAT WCF startSubForm parent confirm + name filters

Expanded `priority-uat-wcf` (skill-source + catalog meta **1.2.0**) from CE Day Works WP1 WCF demo:

- Confirm warning/info/error on the **parent** during `startSubForm` when the child handle is still null.
- Prefer `PARTNAME` (string) filters; numeric `PART` filters often return Invalid filter.
- Sibling sub-forms under one parent: open hard path before revise-text; soft-skip text locks.
- WCF `getRows` may be empty after a successful open - SQL remains data authority.
- ASCII-only punctuation in PowerShell 5.1 runner strings without UTF-8 BOM.
