---
name: priority-post-move-health
description: >
  Post-move backup verification on Priority SQL: Agent jobs, G: paths, smoke backup
  VERIFYONLY. Use when the user says post-move health, backup smoke after cutover,
  or /priority-post-move-health.
---

# Priority post-move backup health

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-post-move-health`).

Runs after **priority-backup-cutover** phases. Confirms services, job enablement, backup paths on G:, and optional smoke backups with VERIFYONLY.

## When

Immediately after repointing backup directory to G: or enabling new Agent jobs.

## Run

Use the same `instances.json` as **priority-backup-audit** (`sqlHost`, `reportRoot`).

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File runner\Invoke-PriorityPostMoveHealth.ps1 -InstancesPath %USERPROFILE%\.priority-dba\instances.json
```

Wrapper calls `docs/skill-sources/dba/Invoke-PostMoveHealth.ps1` with integrated security.

## Success

JSON/TXT report under `reportRoot` with no critical findings; smoke backups land on G: only.

## Do not

Delete archived F: or I: trees from this skill. No SQL passwords in git.

## Offline

Exit 2 if config or harvest script missing; skip live SQL in catalog CI.
