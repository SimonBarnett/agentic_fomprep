---
name: priority-form-prep-after-sql-change
description: >
  Gate Form Preparation after FORMTRIGTEXT or trigger SQL changes before UAT retry. Links
  prepare-all-unprepared-priority-forms. Use when triggers changed, form prep after SQL,
  or /priority-form-prep-after-sql-change.
---

# Form Prep gate after SQL dictionary change

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-form-prep-after-sql-change`).

Dictionary edits (`FORMTRIGTEXT`, PRE-DELETE/PRE-INSERT bodies, related procs) **invalidate** prepared forms until Form Prep succeeds with SQL gates.

## When

After any trigger/procedure SQL change on DEV (or target UAT instance) and **before** retrying HT delete smoke, Day Works, or project-create UAT.

## Required next step

Run **prepare-all-unprepared-priority-forms** for the affected ENAME(s) — do **not** duplicate that loop here.

Minimum:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-NamedForm.ps1 -Name <ENAME>
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Get-LastFormPrepResult.ps1
```

Success = EXECPREPLOCK `UPD=N` **and** `LASTPREPDATE` advanced. Never SQL-flip `UPD`.

## Hard rules (inherited)

- DEV only for unattended agents unless user allowlists otherwise.
- Never edit repo-root `src\Prepare-NamedForm.ps1` from this skill.
- CredMan for web/Si secrets — never log passwords.

## Success

All touched forms pass SQL gate; then re-run the relevant UAT catalog skill.

## Related

**priority-ht-delete-deadlock-triage** when 1205 involved trigger work.
