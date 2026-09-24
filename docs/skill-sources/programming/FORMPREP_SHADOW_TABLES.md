# Form Prep shadow tables and success gates

## Shadow tables

Before preparing forms that touch new tables, create in **pritempdb**:

- `dbo.T$$<TNAME>` mirroring live base columns
- `T$LINKID` as required by Form Prep temp linking

Also register dictionary objects (CATALOG family). `TNAME` max length **20**. Missing shadows → SQL 208 during prep.

## Success gate (never fake)

Success only when:

1. Runner/UI reports ok / completed, **and**
2. `EXECPREPLOCK.UPD = N`, **and**
3. `LASTPREPDATE` advanced for that form.

Never SQL-flip `UPD=N`.

## Paths

| Path | Notes |
|------|-------|
| Named Form Prep (`Prepare-NamedForm.ps1` / plugin `prepare_form`) | Preferred on allowlisted DEV; Web SDK EFORM → FORMPREPDRCT2 |
| Interactive WINRUN FORMPREP | `WINACTIV -P FORMPREP [FormName]`; no `-nbg`, no `-T` |
| Agent WINRUN | Often exits 0 with no EXECPREPLOCK change if other winactiv busy / non-interactive |
| `bin\formprep.exe` | Often "Can't connect to SQL Server - authorization failed" (no Integrated Security) — avoid |

## Environment

Si may lack API licence on some TEST hosts — use client Form Prep there; leave `UPD=Y` honest until prepared.
