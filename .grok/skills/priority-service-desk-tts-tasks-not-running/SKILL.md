---
name: priority-service-desk-tts-tasks-not-running
description: >
  Scheduled reports stopped and clean-up tasks did not run. In one case the TTS service had stopped after a logon failure on its service account. In another the service was running but no new task processes started. Fixing the account, or restarting the service, fixed it. Use when Tabula Task Scheduler TTS not running tasks stopped scheduled reports not sent, or
  /priority-service-desk-tts-tasks-not-running.
---

# Tabula Task Scheduler tasks stopped running

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/tts-tasks-not-running.md`.

Issue type: scheduled reports are not being sent, or scheduled procedures (such as clean-up of zero-quantity work orders) have not run for a while.

Known: two support-fixed cases. SC262780 (2026-09-09): the TTS service had not run for about a week; Windows showed a logon failure for the account the service runs as. Support fixed the service account and started the service. SC262771 (2026-09-09): the TTS service showed as running, but the recent processes on each TTS task showed nothing new since the afternoon before. Support stopped the service (Windows gave an error about pipes, but it did stop) and started it again; new processes then launched and the customer later asked for the call to be closed. Priority has a service-level notice when TTS is inactive for X hours, but no per-task "mail at run failure" alert in version 25.00 (logged as an enhancement). Server and account names are not stored.

This is not a problem with each report definition. Do not recreate tasks before checking the service.

## Steps

1. On the TTS tasks, check the recent processes to see when each task last ran.
2. On the server, check the Tabula Task Scheduler service state and the Windows event or service error.
3. If the service stopped with a logon failure, an authorised server admin fixes the service account credentials (do not record them) and starts the service.
4. If the service is running but tasks have stalled, an authorised server admin restarts the service out of hours if possible.
5. Check that new processes appear on the tasks and that the next scheduled report arrives.

## Verification

Proven: after fixing the account and starting the service, tasks ran (SC262780, support-fixed); after a restart new processes launched (SC262771, support-verified).

Not proven: why the tasks stalled while the service was running, and why the account failed to log on.

## Stop

Stop if the service will not start after the account is fixed. Then escalate to the server owner. This needs server access; read-only users should only report.
