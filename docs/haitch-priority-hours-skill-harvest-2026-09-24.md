# Haitch reporting-hours skill harvest — Priority (2026-09-24)

**From:** Haitch  
**Authoritative procedure sources:** `docs/skill-sources/hours/`  
**Catalog targets:** `v2/apps/mcp-catalog/catalog/priority-hours-{orchestrator,search-by-date-employee,enter-line,less-than-8-report,export-excel,odata-post}/`

## Why this harvest

Simon asked to harvest all Priority reporting-hours skills Haitch learned into `agentic_fomprep`, and to add the harvest skill foundation for this repo. Earlier catalog work skipped the Medatech hours trio. Local Grok leaflets are gone; this pack is the learned procedure, Priority-generic.

## Skills harvested

| Skill | Coverage |
|-------|----------|
| `priority-hours-orchestrator` | 8h weekday cap; 0.25 Recording Hours; WBS map; draft then confirm; overflow; agent wall-clock scrutiny; no agent/WP jargon in PDES |
| `priority-hours-search-by-date-employee` | F11 day + `??/MM/YY` month search; never Down into Tasks |
| `priority-hours-enter-line` | Stay on row until complete; Tab+F6 WBS; Ctrl+Enter new blank; never overwrite |
| `priority-hours-less-than-8-report` | Shortcut → Excel; empty = all weekdays full |
| `priority-hours-export-excel` | Export search results No Template |
| `priority-hours-odata-post` | TRANSORDER_q; PDES ≤60; FLAG N for non-billable customers; live vs DEV auth |

Also: `.grok/skills/harvest-priority-skills` — CAST IRON harvest foundation for this product (route IRC playbooks to `agentic_irc`; formprep/hours playbooks stay here).

## Related (do not conflate)

`priority-hours-handoff-haitch` — DBA hours/WBS notice **to** Haitch after material DBA work. Not timesheet entry.
