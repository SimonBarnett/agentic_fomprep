# Feature request: v2 SQL identifiers must be pinned, and gates must assert composed SQL

**Date:** 2026-09-20
**Repo:** https://github.com/SimonBarnett/agentic_fomprep
**Raised by:** MRB worker (hostile MRB of `7db4bccdb8355a321c3f60e8961f6376ccdf265`)
**Parked by:** bob-spec-intake
**MRB home:** the `feature-request` issue that links this document

## Ask

Two consecutive pushes tried to fix one query (`formlimited_audit`) and a green offline gate
covered both attempts, including the attempt that composed syntactically invalid SQL. The hole is
not that query: v2 hardcodes SQL identifiers that v1 pins, and v2's SQL gates assert *source text*
instead of the *composed* statement. Close both holes so a broken query cannot be green again.

## Observed state at `7db4bcc`

| Hole | Evidence |
|---|---|
| v2 hardcodes SQL identifiers that v1 resolves from a pin file | v1 `src/Prepare-NamedForm.ps1:34-40` reads `$cfg.ExecTable` / `ExecIdCol` / `ExecNameCol` / `LockCols.*` behind a `PinComplete` throw; `config/dev.psd1:19-21` pins `dbo.T$EXEC` / `ENAME` / `T$EXEC` with the comment "not dbo.EXEC". v2 `plugins/priority-odata-dev/scripts/Invoke-PriorityOData.ps1:142-145` and `plugins/priority-formprep/scripts/Prepare-NamedForm.ps1:96-102` hardcode the same identifiers inline. |
| The identifiers demonstrably vary by instance | `tests/fixtures/fake-dev.psd1:10-12` uses `dbo.EXEC` / `EXEC`. Hardcoded v2 runners cannot be pointed at such a dictionary and cannot be exercised against the fake config. |
| `FORMLIMITED`'s foreign-key column is pinned nowhere and corroborated nowhere | `FORMLIMITED` appears in the tree only inside the audit query and in prose. `v2/config/pin.json` pins `InstallLogTable` / `InstallLogRevisionCol` for the install gate but nothing for the audit. The `T$EXEC` side is corroborated by v1 + v2 formprep; the `FORMLIMITED.[T$EXEC]` side rests on draft text this repo has since withdrawn as unverifiable (`docs/mrb-2026-09-19-wcf-walker-eshbel.md`, "Historical note"). |
| The SQL gate asserts source text, not the statement | `v2/tools/Test-PriorityCatalog.ps1:242-251` (CAT-T25) regex-matches the runner file. Lifting that predicate verbatim and feeding it mutated sources, it returns `True` when parameter binding is deleted, when the join moves to the wrong column, and when form names are inlined as literals instead of placeholders. Its predecessor at `c0355d8` returned `True` on source composing `IN (" + (@f0 @f1 -join ', ') + ")`. |
| Only fixture mode executes the audit | `Invoke-PriorityOData.ps1:116-166` — the fixture branch returns before the SQL branch, so CAT-T16/T17/T18 never compose a statement. There is no offline path that builds the SQL. |
| Runner copies are kept identical by hand | `v2/plugins/priority-odata-dev/scripts/Invoke-PriorityOData.ps1` and `v2/apps/mcp-catalog/catalog/priority-odata-dev/runner/Invoke-PriorityOData.ps1` are byte-identical at this SHA (SHA-256 `71F7FA7D...`), but no gate asserts that. `v2/tools/Sync-ShellRunnerLibs.ps1` covers `lib/` only; no test pack calls `Get-FileHash`. |

## Ask (scope)

1. Every SQL table and column name used by v2 product scripts comes from a pin source
   (`v2/config/pin.json` or the instance record), with the v1 `PinComplete` refusal behaviour.
   No `ConvertTo-SqlIdent 'dbo.<literal>'` in v2 product scripts.
2. Pin the `FORMLIMITED` table and its executable foreign-key column, plus the `T$EXEC` id and
   name columns, and cite the dictionary recon that establishes them.
3. Each query becomes composable offline: a dot-sourceable builder function or a dry-run switch
   that returns the statement and the parameter names without a connection.
4. Gates assert the composed statement and bound parameters. Mutation bar: deleting parameter
   binding, changing the join column, or inlining literals must turn the gate red.
5. A gate asserts each plugin `scripts/` runner is byte-identical to its catalog `runner/` copy.

## Do not

- Change v1 `src/Prepare-NamedForm.ps1` or `config/dev.psd1` pin values.
- Invent a `FORMLIMITED` column name to satisfy item 2; pin it from recon or leave it unpinned
  and refuse, the way v1 refuses on `PinComplete=false`.
- Put credentials or instance secrets in git.

## Acceptance

1. No hardcoded `dbo.` table literal or bare column literal in `v2/**` product scripts; a gate
   enforces it.
2. `formlimited_audit`, the install `INSTALLEDUPGRADES` gate, and v2 formprep all resolve
   identifiers from pins, and refuse with a pin reason when a required pin is empty.
3. An offline gate composes the `formlimited_audit` statement and asserts one `@fN` placeholder
   per requested form, all bound, joined on the pinned key, with no literal form names.
4. The three mutations listed above each turn that gate red (documented in the plan as a
   mutation check).
5. A copy-equality gate covers every plugin/catalog runner pair.

## Out of scope

- The live `formlimited_audit` execution on a proof instance — that is issue #7 acceptance 2 and
  a required fix on the MRB issue for `7db4bcc`, not this FR.
- The live WCF compile/install walk (issue #6).
- The `ce-priority-*` catalog rename (issue #4).
