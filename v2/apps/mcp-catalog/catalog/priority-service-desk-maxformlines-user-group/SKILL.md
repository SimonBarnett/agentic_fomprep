---
name: priority-service-desk-maxformlines-user-group
description: >
  A query shows a fixed row ceiling for some users because MAXFORMLINES
  is overridden per user or group. Use when MAXFORMLINES, form stops at
  2000 rows, Constant per User/User Group, or
  /priority-service-desk-maxformlines-user-group.
---

# MAXFORMLINES user or group override caps rows

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/maxformlines-user-group.md`.

Issue type: the same form query returns a hard row ceiling for some people in a role and a fuller list for others. In the source call the restricted ceiling was 2000 records. That was a MAXFORMLINES override, not missing account data.

Known path, support on 2026-10-30 13:06 GMT: System Management > System Maintenance > Constant Forms > System Constants, search for MAXFORMLINES, then the sublevel Constant per User/User Group. The customer changed the applicable scope and on 2026-10-30 14:01 GMT wrote "Thank you all sorted." Opened 2026-10-30 12:12 GMT.

Unknown: the final constant value, and which scope wins when both a user and a group override exist. Do not invent a number to set. Do not publish financial rows from the call.

## Prerequisites

A system manager, and a performance review before any limit is raised. Read the effective override first. This harvest does not authorize raising or clearing the cap. No privilege change and no bulk financial export.

## Steps

1. Run the same query as an affected user and as an unaffected user. Separate a fixed cap from a filter, a privilege, or genuinely missing rows.
2. Open MAXFORMLINES and read the Constant per User/User Group sublevel for the affected user and their groups, not only the global constant.
3. The system manager sets the approved scope only. Leave unrelated users and groups alone.
4. Retest the same query and confirm the expected count still performs. Record the scope that changed, not a guessed value if the screen value was not part of the approved change.
5. Do not remove the cap entirely.

## Verification

Proven: the customer confirmed the cap change sorted the issue (SC263442).

Not proven: the number that was saved, and override precedence.

## Stop or escalate

Stop if affected and unaffected users see the same count (not this override), if the request is to remove every limit, or if there is no performance review. Escalate the constant change to the system manager.
