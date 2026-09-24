---
name: priority-form-engineering
description: >
  Change CE custom forms, triggers, and shells on DEV: Named Form Prep success gate,
  Form Generator nav, house-type PRE-DELETE, shell install verify. Use when the user
  says form generator, FORMTRIGTEXT, PRE-DELETE, ZCLA_CHKPNT-DEL, or /priority-form-engineering.
---

# Priority form engineering (CE DEV)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-form-engineering`).

Do **not** edit repo-root `src\Prepare-NamedForm.ps1`. Do **not** guess Prepare Upgrade / Install Upgrade ENAMEs. Use `v2/config/pin.json` (PinComplete names are Simon-confirmed Medatech wrappers). FORMLIMITED/RESTFLAG footgun is owned by **priority-odata-dev**. HT-DL UAT procedure is **priority-ht-delete-smoke**.

## When

Changing CE custom forms, triggers, or shells on DEV.

## Named Form Prep (DEV)

Entry: `src\Prepare-NamedForm.ps1` (repo path; operators may use mapped `M:\py\agentic_fomprep\...`). Web SDK EFORM -> FORMPREPDRCT2. Portable plugin: `priority-formprep` (`prepare_form`).

Success only when `ok=true` **and** EXECPREPLOCK `UPD=N` **and** LASTPREPDATE advanced. Never fake UPD=N. Environment DEV only in the current pin. Si may lack API licence on TEST -- use client Form Prep there.

Re-prepare after FORMTRIGTEXT edits is normal at CE.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-NamedForm.ps1 -Name <ENAME>
```

ENAME must match `^[A-Za-z][A-Za-z0-9_]*$`. One name per call. SDK "successfully completed" is not success.

## Generator / nav gotchas

- F6 on a menu opens Menu Generator -- highlight the form then F6 for Form Generator.
- F11 on Form Name (top list) to find forms; Sub-level Forms F6 x2 down; never F6 empty Form Name.
- #INCLUDE: F6 on the include line -> INCLUDE Line; F12 then F6 for body.
- FORMKEYS/EXPRESSION can strip after Prep -- restore parent keys after Prep when needed (PARTLONG pattern).
- New triggers: banner + Inputs/Outputs :VARs + Heading sections (CE code docs). Full banner/debug rules: **priority-procedure-style**.
- Prefer a dedicated TRIG over overwriting a shared POST-FORM (a shared TRIG overwrite changes sibling forms). See **priority-procedure-style**.
- History/audit `UDATE` is minutes since 1988-01-01. Never `MAX(UDATE)+1`. See **priority-sql-udate-user**.
- New tables need `pritempdb` `T$$` shadows before Prep (SQL 208). See **priority-formprep-shadow-tables**.

## House type PRE-DELETE (2026-09-18)

- `ZCLA_CHKPNT-DEL` expects **positive** `:ELEMENT`. PRE-DELETE must `:ELEMENT = - :ELEMENT` after selecting PROJACT<0 backups or the loop hangs.
- Hang-without-1205 details live in **priority-recalc-concurrency** (ELEMENT sign, entity-only RECALC clear, dependent pre-purge).
- Optional harden: clear ZCLA_RECALC for that HT only; pre-purge ZCLA_SMALLWORKSPLOT for those checkpoints.
- Open ZCLA_HTEDIT rows block HT delete ("Value exists in House Type Edits form").

UAT smoke of the delete is **priority-ht-delete-smoke** (TEST, company title first).

## Shells

- Dedicated Version Revision shells. Never mix Day Works into upgrade 8338.
- Install with zero TAKETRIG rows = silent miss -- verify INSTALLEDUPGTRIG / hashes.
- Compile/install ENAMEs come from `v2/config/pin.json` only. Do not invent others. See **priority-shell-compile** and **priority-shell-install**.
- Shell discipline (one workstream, TAKETRIG step shape, verify INSTALLEDUPGTRIG): **priority-version-revision-discipline**.

## Related programming skills

Pointers only. Authority: `docs/skill-sources/programming/`.

- **priority-procedure-style**
- **priority-sql-udate-user**
- **priority-formprep-shadow-tables**
- **priority-recalc-concurrency**
- **priority-version-revision-discipline**
