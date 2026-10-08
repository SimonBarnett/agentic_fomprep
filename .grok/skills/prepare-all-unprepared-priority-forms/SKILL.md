---
name: prepare-all-unprepared-priority-forms
description: >
  Web Form Preparation batch on CE Priority DEV: Unprepared Forms tile, named list,
  SQL-gated success. Use when the user says prepare all unprepared, Form Preparation
  tile, unprepared estate, or /prepare-all-unprepared-priority-forms.
---

# Prepare unprepared Priority forms (web batch)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=prepare-all-unprepared-priority-forms`).

Grok Bot workflow leaflet was not on this box. This skill is the CE DEV method already in this repo. Do **not** implement or call CLI `-Scope AllUnprepared` (not in MVP). Do **not** edit `src\Prepare-NamedForm.ps1`.

## When

A human asks to prepare the unprepared estate (or a named list) on CE DEV web.

## Hard rules

1. DEV only. Never live/PRI.
2. Never report prepared unless EXECPREPLOCK `UPD=N` **and** LASTPREPDATE moved.
3. Never SQL-flip UPD=N. Never click Ignore Duplicate / Yes on index dialogs.
4. One prepare at a time -- mutex `Global\CE-DEV-FORMPREP`. OPEN parks must be 0 before a headed run.
5. Never log the Si password. CredMan `CE/Priority/Si`.
6. Preferred executor: one name via `src\Prepare-NamedForm.ps1` (or local `priority-formprep` `prepare_form`). Repeat per name.
7. Headed Playwright `src\Prepare-Forms.ps1` is the fallback when a human asks. Needs an unlocked DEV1 desktop and live cookies.

## Preferred loop (named, headless SDK)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-NamedForm.ps1 -Name <ENAME>
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Get-LastFormPrepResult.ps1
```

## Headed web tile (human-supervised fallback)

Dashboard shortcut **Form Preparation**. Select Company **D - Clarkson Evans Live** (SQL `base` / dictionary `system`). List **Unprepared Forms**. Do not click Ignore Duplicate. Success is still the SQL gate, not the progress toast.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Invoke-OpenCount.ps1
# OPEN=0 required
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -Names <ENAME>[,<ENAME2>] -Environment DEV -SkipCli -TimeoutMinutes 15
```

If the session probe says recapture cookies: **stop** and ask a human for `tools\Save-WebStorageState.ps1`. Exit 3: RepairOpenParks only; do not start a second headed run until OPEN=0.

## Not this skill

- `Prepare-Forms.ps1 -Scope AllUnprepared` (refuses in MVP).
- Overnight unattended / session-0.
- Amplify catalog execute (no ERP SQL on mcp-priority.ntsa.uk).
