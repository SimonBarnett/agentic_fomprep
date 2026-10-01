# Prepare Report/Procedure (TYPE=P / TYPE=R)

**Catalog:** `priority-procedure-prep`  
**Runner:** `src/Prepare-NamedProcedure.ps1` + `src/sdk/run-repprep-via-exec.mjs`  
**Pinned proc:** `REPPREPDIRECT2` (Reprepare Report/Procedure). Prefer over `REPPREPDIRECT` unless a human pins Prepare.

## Why not Named Form Prep

`Prepare-NamedForm.ps1` / `EFORM` + `FORMPREPDRCT2` only see **forms** (`TYPE=F`).  
Calling it for a procedure (e.g. `ZCLA_BUILD`) fails with **form not found in EFORM**.

| Entity | Prep path |
|--------|-----------|
| Form `TYPE=F` | `EFORM` → `FORMPREPDRCT2` (`Prepare-NamedForm.ps1`) |
| Procedure `TYPE=P` / Report `TYPE=R` | `EXEC` → `REPPREPDIRECT2` (`Prepare-NamedProcedure.ps1`) |

## WCF walk

1. Login (CredMan password → `PRIORITY_SDK_PASSWORD`; never log it).
2. `formStart('EXEC')` (Entity Titles).
3. Search `ENAME = <procedure>`.
4. `setActiveRow` on the match.
5. `activateStart('REPPREPDIRECT2', 'P')`.
6. Walk messages / optional inputFields to `end`.

Do **not** `procStart('REPPREPDIRECT2')` alone and hope to type the name: the `PAR` progparam is **FILE** (linked `EXEC` buffer). Over WCF that often arrives as `inputFields` with an **empty** `EditField[]`, then an info message *Specify the name of the report or procedure to prepare.* and an early `end` — lock may flip `UPD=Y` and stay there. Selecting the row on `EXEC` first supplies the link.

## Success gate

Never trust SDK “successfully completed” alone. Never `UPDATE EXECPREPLOCK SET UPD='N'` to fake success.

Require **all** of:

1. Walk `ended` without Blocker errors.
2. `EXECPREPLOCK.UPD = 'N'`.
3. Prepared binary advanced: `\<PriorityRoot>\system\prep\d{T$EXEC}.prp` **LastWriteTime** increased (or file created).

### LASTPREPDATE caveat

On some estates, procedure rows keep `EXECPREPLOCK.LASTPREPDATE = 0` even after a real prepare. Treat **`.prp` mtime** as the durable compile signal for TYPE=P/R. If both `LASTPREPDATE` and `.prp` stay unchanged, report `prp_unchanged` / fail.

## Force reprepare

Same pattern as forms: set `EXECPREPLOCK.UPD='Y'` (or `-ForceUnprepared`) before the walk so prep is not skipped.

## After prepare (stack workers / WINRUN)

Prepared text is what WINRUN loads from `.prp`. After changing `PROGRAMSTEXT` and procedure-prepping orchestrators, recycle long-lived workers (`ENDSTACK` / `RUNSTACK` or site equivalent) so processes reload the new binary.

## Version Revision / AFTERPREP

Shell `TAKE` rows with `UPGTYPE=24`, `HOWCREATED=M`, `AFTERPREP=Y` ask Prepare Upgrade to procedure-prep taken TYPE=P entities. That is complementary to this direct `REPPREPDIRECT2` path; use whichever the operator pinned for the change.

## Hard rules

1. User allowlists instance / WCF URL / SQL — never invent.
2. CredMan only for passwords.
3. One ENAME per call.
4. Report `ok`, `reason`, `upd` before→after, `.prp` before→after, every SDK error line.
