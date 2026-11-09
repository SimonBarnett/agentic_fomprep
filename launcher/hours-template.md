# LEGACY. Not the hours store.
# Do not copy this file into a customer repo. Do not push it to a git hours ref.
# Hours are the bob.ntsa.uk webhook. See launcher/customer-setup and hours-log-work-session.
# The table below is historical shape only. The project column here was a Medatech
# booking id. That id is not the webhook project field and not the SC/SO folder name.

---
date: YYYY-MM-DD       # the working day the effort belongs to (weekday)
agent: legacy-template
status: legacy          # not a webhook status
---

| booking id | wbs | role | hours | description                                    | evidence       |
|------------|-----|------|-------|------------------------------------------------|----------------|
| (blank)    |     |      |       | Do not file a fictitious line                  |                |

<!--
This template is not authoritative. Webhook field rules:
- idempotency_key priority-agent-<full-session-uuid>, reused on retry
- persist the returned id; heartbeat every 15-30 minutes
- project folder is SCxxxxxx or SOxxxxxx; booking id and WBS stay in project.md
- do not send duration_minutes; do not treat auto_closed as a successful close
- log.md is narrative only
-->
