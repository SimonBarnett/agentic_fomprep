# Skill harvest log

- 2026-09-24: Added foundation honesty-box skill at `.grok/skills/harvest-agent-skills/SKILL.md` (home `https://github.com/SimonBarnett/agentic_fomprep`). Table row: Formprep / MSSQL fleet playbooks -> `SimonBarnett/agentic_fomprep`. Product playbooks remain under `v2/plugins/*/skills/` and `v2/apps/mcp-catalog/catalog/`.

- 2026-09-28 (DEV1 / Day Works WP3): New skill `priority-dictionary-sql` (.grok + catalog) and `docs/skill-sources/programming/DICTIONARY_SQL.md`. IDENTITY-safe CATALOG/COLUMNS/T$EXEC/INDEXES inserts; COLUMNS.CNAME; INDEXES.T$KEY; EXECPREPLOCK required before Named Form Prep (`name_missing`); EXECMODULE; shell DBI CREATE TABLE pattern; PowerShell Tee-Object return pollution. Clarified `priority-formprep` catalog `name_missing` / `still_unprepared` (FCLMN).

- 2026-09-28: Rebased honesty-box / Foundation harvest onto main after CONFLICTING PR #68 (issue #58). CAT-T50 asserts Foundation on all priority-* leaflets.

- 2026-09-28 (DEV1): Tabula *Ignore Duplicate Values* + Unique Index/Origin. Harvested `IGNORE_DUP_KEY.md` + `FORMCLMNSA_JOINS.md`; updated `DICTIONARY_SQL.md`, `FORMPREP_SHADOW_TABLES.md`, catalog `priority-dictionary-sql` / `priority-formprep-shadow-tables`. Physical unique indexes need `IGNORE_DUP_KEY=ON` (company often reported as `system`); child joins need FORMCLMNSA `= :$$.COL`.

- 2026-09-28 (DEV1): Form Prep `Variable with two different types : SORT` � `:VAR` type clash (`ZCLA_ELEDITSPLIT` `:SORT = ''` vs numeric `:SORT`). Harvested into `PROCEDURE_STYLE.md`, `FORMTRIG_VAR_TYPES.md`, catalog `priority-procedure-style`, `priority-formprep` (WCF warnings + formStart vs SQL gate), `priority-uat-wcf` (`startSubForm` when direct `formStart` says unprepared). Fix applied on DEV as `:DWFIXSORT`.

## 2026-09-29 - ce-priority split + leave-line generics

- Relocated CE DBA pack to private `SimonBarnett/ce-priority` `docs/dba/`; `docs/skill-sources/dba/` is pointer-only.
- Harvest domain table: CE instance/DBA/customisations -> ce-priority; Day Works product -> ce-dayworks.
- Added Priority-generic `INDEXES_TYPE_A_IDENTITY.md` and `MSG154_OPTIMISTIC_LOCK.md` under programming/.
