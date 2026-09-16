# agentic_fomprep — operator how-to (for Eshbel)

DEV-only Form Prep runner on **CE-PRIORITY-DEV1**. Do not point this pack at live/PRI.

Repo: `M:\py\agentic_fomprep` (`\\10.220.0.5\dev\py\agentic_fomprep`)
Host: CE-PRIORITY-DEV1 (NetBIOS `CE-PRIORITY-DEV`)
SQL: `10.220.0.5\DEV` database `system`
Web: `https://prioritydev.clarksonevans.co.uk` (company label **D - Clarkson Evans Live** = DEV `base`)

## Hard rules

1. Never report a form prepared unless `EXECPREPLOCK.UPD='N'` **and** `LASTPREPDATE` moved.
2. Never SQL-flip `UPD='N'` to fake success.
3. Never leave OPEN park rows (`AGENT_FORMPREP_PARK.restored_at IS NULL`).
4. Never click Ignore Duplicate / Yes on index dialogs.
5. One prepare at a time — mutex `Global\CE-DEV-FORMPREP`.
6. Secrets stay out of git: CredMan target `CE/Priority/Si`, cookies at `C:\Priority\tmp\agent-formprep\si-web-state.json`.

## Preconditions (once per box / when expired)

```powershell
cd M:\py\agentic_fomprep
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Install-OnDev.ps1
# CredMan (interactive password prompt — human only):
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Set-WinrunCredential.ps1
# Fresh Si web cookies when the session probe says recapture:
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Save-WebStorageState.ps1
```

## Check before every run

```powershell
cd M:\py\agentic_fomprep
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Invoke-OpenCount.ps1
# Must print OPEN=0. If not:
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -RepairOpenParks -Environment DEV
# Re-check OPEN=0. Do not start Prepare-Forms while another run holds the mutex.
```

## Dry run (no park)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -WhatIf
```

## Real prepare (one name — preferred)

Unlocked desktop session on DEV1. Web is the success path; CLI is a probe (`-SkipWeb`) that only counts if LASTPREPDATE moves.

```powershell
# Supervised web path (default CLI wrapper skips CLI):
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -SkipCli -TimeoutMinutes 15

# Or CLI-only probe (needs CredMan; fail if lastprep unchanged):
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -SkipWeb -CliTimeoutSeconds 60
```

## Read the result

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Get-LastFormPrepResult.ps1
```

Trust `prepared[]` / `stillUnprepared[]` / `restoreOk`. `ok=true` only if every requested name compiled **and** park restored. Playwright finished or winrun exit 0 is **not** success.

| Exit | Meaning |
|------|---------|
| 0 | `ok=true` (or WhatIf) |
| 2 | refuse before park (env/auth/mutex) |
| 3 | park taken but prep failed, or restore short |
| 4 | post-hook assertion failed |

If exit 3 with OPEN parks: **RepairOpenParks only** — do not start a second Prepare-Forms until OPEN=0.

## Multi-name set

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC,ZCLA_PARTLONGDHIST,ZCLA_PARTLONGDREV -Environment DEV -SkipCli -TimeoutMinutes 15
```

## After a crash / reboot mid-run

1. Map `M:` to `\\10.220.0.5\dev` if needed.
2. `RepairOpenParks` until OPEN=0.
3. Recapture cookies if the probe says so.
4. Resume Grok conversation (if needed) via desktop shortcut **Resume Grok agentic_fomprep** or `grok --resume 01a0a96c-2677-7c61-bf65-3ce9e16e4d3b` from `M:\`.

## SQL sanity

```sql
SELECT * FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL;
SELECT E.ENAME, L.UPD, L.LASTPREPDATE, L.COMPUTERNAME, L.PID
FROM dbo.EXECPREPLOCK L
JOIN dbo.[T$EXEC] E ON E.[T$EXEC] = L.[T$EXEC]
WHERE E.ENAME LIKE 'ZCLA_PARTLONG%';
```

## Off-DEV pack check (no SQL/web)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Test-Pack.ps1
```

## Handoff notes for engineering (Eshbel)

- Config pin: `config/dev.psd1` with `PinComplete=$true`; frozen hosts in `src/Private/Get-FrozenEnvironment.ps1`.
- Working method PDF: `reviews/agentic_fomprep_Agent_Working_Method.pdf`.
- Build plan PDF: `CE_Priority_Autonomous_Form_Prep_Build_Plan.pdf`.
- Result schema: `schemas/prepare-forms-result.schema.json`.
- Bob (this agent) runs supervised prepares on DEV1 and files feedback to the Grok Build session; do not dual-run Form Prep against the same mutex.
