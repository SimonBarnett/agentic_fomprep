# WP0 walker slice — WCF + SQL gate (2026-09-19)

**Repo:** SimonBarnett/agentic_fomprep  
**Machine:** ionos  
**v1:** `src\Prepare-NamedForm.ps1` untouched  
**Pins:** Medatech `ZEMG_TAKEUPGRADE` / `ZEMG_EXECUPGRADES`, `UPGRADES`, `INSTALLEDUPGRADES`, `ProofInstanceId=ce-priority-dev` (`docs/wp0-recon.md`). `DbiMarker` still empty. `WcfFileStepWorks` still null.

## What landed

1. WCF walker (`v2/lib/run-upgrade-proc.mjs` + `v2/lib/wcf.ps1`) walks **pinned** TYPE=P procedures only. Prepare fills `PAR` / `FN`; install fills recon `NAM` (File Name) plus `FN` when that field appears. No guessed ENAMEs (`PREPAREUPGRADE` / `INSTALLUPGRADE` / …).
2. Install SQL gate (`v2/lib/gate.ps1`): `INSTALLEDUPGRADES.UPG` row must advance after `startedAt`; every parsed `TAKESINGLEENT` name must exist in `T$EXEC`. Fail reasons: `gate_unchanged`, `partial_entities`.
3. `postInstall.formsUnprepared[]` is a handoff to `prepare_form`. Install does **not** call FormPrep / `prepare_form`.
4. WINRUN is **not** implemented. If `WcfFileStepWorks=false`, runners refuse `winrun_required` rather than invent a CLI. Null pin = try WCF file/path fields.
5. WP0-T5 uses a scratch incomplete pin so `PinComplete=true` does not break the refuse contract. WP0-T5b checks complete pins stop at `no_cred` (not `pin_incomplete`) without WCF.

## WP0-R* / FR §15 proof instance

`PRIORITY_WP0_INSTANCE` was **unset** on this ionos runner. There is no `%USERPROFILE%\.priority-formprep\instances.json` here and `C:\Priority\system\upgrades` is not present. CE dictionary SQL `10.220.0.5\DEV` / `prioritydev.clarksonevans.co.uk` were not used.

**Skip:** live WP0-R1..R7 and FR §15 proof-instance ATs (human dummy revision compile → install → truncated file → `prepare_form` still works). Re-run with `PRIORITY_WP0_INSTANCE=ce-priority-dev` on a host that can reach that allowlist row, CredMan, dictionary SQL, upgrades dir, and WCF.

Off-instance FR §15 (schema, refuse paths, fixture parse, WhatIf, truncated shell, formsUnprepared handoff, no auto-prep) is covered by `v2/tools/Test-WP0.ps1`.

## Non-claims

- Not a live compile or install on `ce-priority-dev`.
- Not ready for human UAT (Eshbel MRB / Bob stamp).
- Not a v1 change.
- Not a WINRUN executor.
