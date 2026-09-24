# Build-and-test plan — SQL pins and composed SQL gates (2026-09-20)

**FR:** docs/feature-request-sql-pins-and-composed-sql-gates-2026-09-20.md  
**MRB:** https://github.com/SimonBarnett/agentic_fomprep/issues/22  
**Repo:** SimonBarnett/agentic_fomprep  

## Goal

Close the v2 holes where SQL identifiers are hardcoded or gates assert source text instead of composed SQL. Offline catalog gates must turn red on identifier laundering and on the three `formlimited_audit` composition mutations.

## Phases

### P0 — Pin model (qualified tables + revision column)

- Add `VersionRevisionsTable` / `VersionRevisionCol` to `v2/config/pin.json` and `pin.psd1` (recon: `docs/wp0-recon.md` — `dbo.UPGRADES` / `UPGNUM`).
- Store qualified install log table in the pin (`InstallLogTable=dbo.INSTALLEDUPGRADES`); keep revision/date columns pinned (`InstallLogRevisionCol`, `InstallLogDateCol`).
- Tabulate `FORMLIMITED` dictionary columns in `docs/wp0-recon.md` (same style as `INSTALLEDUPGRADES`); pin `FormLimitedTable` / `FormLimitedExecCol` from that recon only.
- Extend `Convert-ShellPinObject` / `Get-ShellPinGaps` for the new required keys.

### P1 — Product scripts use pins only

- `v2/lib/gate.ps1`: `Test-VersionRevisionExists` and `Get-InstallLogSnapshot` read table/column names from pins; throw when a required pin is empty (no `'UPG'` / `'STARTDATE'` / `'dbo.' +` fallbacks; no `ConvertTo-SqlIdent 'UPGNUM'`).
- Run `v2/tools/Sync-ShellRunnerLibs.ps1` so plugin and catalog runner copies match `v2/lib`.

### P2 — Composed SQL gates (CAT-T25 / CAT-T26)

- **CAT-T25:** `Invoke-PriorityOData.ps1 -ComposeSql` builds `formlimited_audit`; `Test-FormLimitedAuditComposed` asserts join on pinned columns and bound `@fN` placeholders.
- **CAT-T26 mutation bar** (must each fail `Test-FormLimitedAuditComposed`):
  1. **No-bind:** pass composed SQL with an empty parameter hashtable.
  2. **Bad-join:** replace the good join needle  
     `FL.{ConvertTo-SqlIdent FormLimitedExecCol} = E.{ConvertTo-SqlIdent ExecIdCol}`  
     with  
     `FL.{ConvertTo-SqlIdent FormLimitedExecCol} = E.{ConvertTo-SqlIdent ExecNameCol}`  
     (needles derived from the same pin loaded for CAT-T25 so a pin change cannot no-op the mutation).
  3. **Inline literal:** replace `@f0` with a quoted form name literal in the SQL text.

### P3 — Hardcoded identifier gate (CAT-T27)

- Scan all `v2/**` product PowerShell under `lib/`, `plugins/**/scripts/`, and catalog `runner/` trees (not `tools/`).
- Fail on `ConvertTo-SqlIdent 'dbo.*'`, `ConvertTo-SqlIdent 'UPGNUM'`, and `'dbo.' +` table prefix concatenation.

### P4 — Runner parity (CAT-T28)

- Existing SHA-256 gate for plugin `scripts/` vs catalog `runner/` copies (unchanged scope).

## Test commands (offline)

From repo root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File v2\tools\Test-PriorityCatalog.ps1
```

Expect **CAT-T25**, **CAT-T26**, **CAT-T27**, **CAT-T28** PASS when pins and `v2/lib/gate.ps1` are correct.

## Success

- Acceptance 1–5 of the FR satisfied offline via catalog gates; no credentials in git; v1 `src/Prepare-NamedForm.ps1` untouched.
- Live `formlimited_audit` on a proof instance remains issue #7 / separate MRB scope.

## Out of scope

- Human UAT stamp (Bob chairs MRB on issue #22).
- Live WCF compile/install walk.
