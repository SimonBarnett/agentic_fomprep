---
name: priority-hours-handoff-haitch
description: >
  Record human-equivalent hours and WBS after material Priority DBA work; notify Haitch.
  Use when DBA handoff, WBS hours, backup notice routing, or /priority-hours-handoff-haitch.
---

# Priority DBA hours handoff (Haitch)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-hours-handoff-haitch`).

Standing process after non-trivial DBA work (cutover, audit remediation, Sunday failures, health incidents).

## When

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Closing a DBA task that consumed material time or needs customer-visible billing/traceability.

## Do

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

1. Summarize **what** ran (instances, read-only vs change, evidence paths under `reportRoot`).
2. Record **human-equivalent hours** and WBS code (example format: `2.35` — use your org’s active WBS).
3. Send **Haitch** the summary; Haitch routes customer/infra comms including backup notices.
4. Attach pointers to audit/health outputs — not raw secrets.

## Do not

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

- Teams Gergo (or other infra) **directly** for backup notices unless standing order explicitly changes.
- Put SQL passwords or API keys in the handoff text.

## Success

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Haitch has hours, WBS, pass/fail facts, and links to evidence sufficient for Simon/customer follow-up.

## Related

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

**priority-sunday-backup-check** weekly signal; **priority-backup-cutover** for phased work.
