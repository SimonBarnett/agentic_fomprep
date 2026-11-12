---
name: priority-service-desk-company-timezone-scheduled-reports
description: >
  After a version 26 upgrade, scheduled report emails seemed missing; they were arriving an hour late because the companies had no time zone. Support added a time zone to each company and the customer closed the call. Use when scheduled reports late after upgrade company timezone, or
  /priority-service-desk-company-timezone-scheduled-reports.
---

# Scheduled reports ran an hour off after upgrade until the company time zone was set

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/company-timezone-scheduled-reports.md`.

Issue type: after an upgrade, scheduled report emails stop arriving at the expected time, or seem to stop altogether.

Known: on 2026-10-08 09:55 BST support asked the customer to run Define Input for Task on each task. At 11:20 BST the customer said this had no effect. At 12:06 BST the customer received reports set for 11:00 and noticed the server appeared to be on GMT, not BST, with US date formats. At 12:37 BST support added a time zone to each company in System Management > System Maintenance > Companies > Companies. At 12:49 BST the customer asked for the call to be closed. The date-format language request is not recorded as changed in this call.

Define Input for Task alone did not fix it here. The reports were running, late, so do not reinstall the scheduler.

## Steps

1. Confirm whether the scheduled reports are missing or arriving late. Compare the arrival time with the scheduled time.
2. If they are late by a whole hour or more, check the time zone on each company in System Management > System Maintenance > Companies > Companies.
3. An authorised administrator sets the correct time zone on each affected company.
4. Confirm the next scheduled run arrives at the expected local time.
5. Handle date format or language as a separate request.

## Verification

Proven: reports were arriving, an hour off, and the customer closed the call after the time zone was set (SC263125). Second example: SC262659 (2026-09-01): a customer reported Priority time stamps were out; support found some companies had no time zone in the Companies form and set them; the customer confirmed they all had a time zone and asked to close the call.

Not proven: an explicit post-change arrival check, and whether the date format was changed.

## Stop

Stop if the reports are not arriving at all after checking the time. Then check the task input and the mail setup instead.
