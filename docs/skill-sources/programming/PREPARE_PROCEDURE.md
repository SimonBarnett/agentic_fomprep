# Prepare Report/Procedure (TYPE=P / TYPE=R)

**Catalog:** `priority-procedure-prep`  
**Runner (CE-pinned pack):** `src/Prepare-NamedProcedure.ps1` + `src/sdk/run-repprep-via-exec.mjs`  
**Runner (portable):** same `run-repprep-via-exec.mjs` with params `--name --url --company --user` and env `PRIORITY_SDK_PASSWORD`; SQL-gate `EXECPREPLOCK` + `PrepDir\d{T$EXEC}.prp` yourself when the CE `AllowedComputer` pack cannot run on the box.  
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

## API Licence

If walk fails at `formStart(EXEC)` with *flag the user as having an API Licence*,
set `USERSB.REST='Y'` for that web user on the target estate (Dev/test unless
approved). See `API_LICENCE_WCF.md`.

## Portable / remote box

When the agent host cannot reach the Priority web URL (no VPN/DNS) but an **airc
console on the Priority server** can:

1. Run Node + `run-repprep-via-exec.mjs` **on that console** (web is local).
2. Pass company `DNAME`, web URL, and user from the allowlist / connections file.
3. Never put the password in IRC PRIVMSG; drop a one-line cred file via sandbox
   Put / b64+certutil and delete after the run.
4. Gate success with local SQL `EXECPREPLOCK` and `\<PriorityRoot>\system\prep\d{id}.prp`
   (Priority root is not always `C:\Priority` — discover it on the box).

CE `Prepare-NamedProcedure.ps1` refuses non-`AllowedComputer` hosts and frozen
CE SQL/WebHost; do not edit frozen CE pins to point at a customer — use the
portable mjs path instead.

## Hard rules

1. User allowlists instance / WCF URL / SQL — never invent.
2. CredMan only for passwords (or a local cred file outside git; never log it).
3. One ENAME per call.
4. Report `ok`, `reason`, `upd` before→after, `.prp` before→after, every SDK error line.
5. API Licence (`USERSB.REST`) required for `formStart` — see `API_LICENCE_WCF.md`.
