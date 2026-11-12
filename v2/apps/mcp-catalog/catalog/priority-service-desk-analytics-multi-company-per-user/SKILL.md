---
name: priority-service-desk-analytics-multi-company-per-user
description: >
  A Priority Analytics report would not run for several companies. Multi-company selection is set per user from the top-right menu. After the user selected the companies there, the report ran for all of them. Use when Priority Analytics report multi company selection per user burger menu, or
  /priority-service-desk-analytics-multi-company-per-user.
---

# An analytics report did not run across several companies until the user picked them

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/analytics-multi-company-per-user.md`.

Issue type: a Priority Analytics report should show data from several companies but only runs for one, or works for one user and not another.

Known: on 2026-09-08 a customer's report would not run against multiple companies. In a short call with support they cleared it by changing the Multi Company setting from the top-right (burger) menu. Support then checked the documentation and confirmed the multi-company selection is per user, so each user must select the companies from that menu for the report to run for all of them. The customer agreed to ask each user. Report and user names are not stored.

This is not a report design fault. Do not rebuild the report first.

## Steps

1. Ask the user to open the top-right menu and find the multi-company selection.
2. Select the companies the report should cover.
3. Run the report again and check the data now covers those companies.
4. Repeat for each user who runs the report; the setting is per user.

## Verification

Proven: the customer confirmed the problem cleared after changing the Multi Company setting (SC262740, customer-verified).

Not proven: whether any user privilege also limits which companies can be selected.

## Stop

Stop if the companies are selected and the report still shows one company. Then check the report definition and company privileges.
