---
name: priority-report-form-zooms
description: >
  Link Priority report name columns to forms via ZOOMCOLUMNS2 (FORMEXEC, COLNAME,
  ZOOMEXEC, JOINCOL). Hide id join columns; add description columns when needed.
  Use when the user says report form link, zoom PARTNAME to PART, ZOOMCOLUMNS2,
  clickable part on report, or /priority-report-form-zooms.
---

# Priority report form zooms

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authoritative procedure: `docs/skill-sources/programming/REPORT_FORM_ZOOMS.md`.

## Hard rules

1. Visible **name** + hidden **id** on the report row; `JOINCOL` is the id column name.
2. Prefer the estate’s common `ZOOMEXEC` for that `COLNAME` (often `LOGPART` for `PARTNAME`).
3. Never invent form `T$EXEC` — look up `T$EXEC` where `TYPE='F'`.
4. After `ZOOMCOLUMNS2` / `REPCLMNS` / table column changes: `EXECPREPLOCK.UPD='Y'` and Prepare.
5. No secrets in skills or SQL notes.

## Loop

1. Confirm report `T$EXEC` and target form ENAMEs.
2. Ensure physical + dictionary columns for name, description (optional), and id.
3. `REPCLMNS`: show names/descriptions; hide ids.
4. `INSERT` into `ZOOMCOLUMNS2` if the `(FORMEXEC,COLNAME,ZOOMEXEC,JOINCOL)` row is missing.
5. Prepare the report (and procedure if fill SQLI changed).

## Related

- **priority-procedure-prep** — prepare after dictionary change
- **priority-dictionary-sql** / **priority-create-table** — column bootstrap
