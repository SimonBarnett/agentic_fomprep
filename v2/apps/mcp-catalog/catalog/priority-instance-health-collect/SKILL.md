---
name: priority-instance-health-collect
description: >
  Collect Priority SQL instance health (disk, memory, jobs, backups) via sqlcmd.
  Use when the user says instance health, capacity report, mount point free space,
  or /priority-instance-health-collect.
---

# Priority SQL instance health collect

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-instance-health-collect`).

Runs `docs/skill-sources/dba/dba_instance_health_collect.sql` against each configured instance (`HOST\DEV`, `\TST`, `\PRI`). Requires VIEW SERVER STATE on the jump-box login.

## When

Proactive capacity review; before major cutover; weekly alongside backup checks.

## Config

Same `%USERPROFILE%\.priority-dba\instances.json` as backup audit (`sqlHost`, `instanceIds`, `reportRoot`).

## Run

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File runner\Invoke-InstanceHealthCollect.ps1 -InstancesPath %USERPROFILE%\.priority-dba\instances.json
```

Outputs land under `{reportRoot}\health-collect\health_{INST}_*.txt`.

## Success

All instances exit 0; reports show mount-point free space (not stub drive letters), PLE/runnable/IO latency sections without critical flags.

## Do not

Embed customer IP as the only allowed host — use config. No SQL passwords.

## Offline

Catalog test: script present, config missing → exit 2 (**skip**). Live UAT on jump box with integrated auth.
