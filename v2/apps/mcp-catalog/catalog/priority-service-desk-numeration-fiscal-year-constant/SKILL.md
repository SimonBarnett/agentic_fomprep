---
name: priority-service-desk-numeration-fiscal-year-constant
description: >
  Open Numeration Templates did not produce the new-year document prefix in one company because the DocumentNumeration constant was 0 (calendar year). Setting it to 1 (fiscal year) and rerunning the procedure created documents with the new prefix. Use when new year numeration prefix not created DocumentNumeration, or
  /priority-service-desk-numeration-fiscal-year-constant.
---

# New-year document prefixes did not open because numeration followed the calendar year

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/numeration-fiscal-year-constant.md`.

Issue type: after running Open Numeration Templates for a new fiscal year, documents in one company are still created with the old year prefix.

Known: on 2026-10-01 10:37 BST support recorded that in the affected company the DocumentNumeration constant was 0, which opens numeration by calendar year, not fiscal year. After changing it to 1 and rerunning the open numeration process, documents were created with the new year prefix. Support had also told the customer that continuing to use the old prefix in the meantime would not cause a problem on the financial side. The company name and document numbers are not stored.

This is not a full numeration (see the scanner numeration skill) and not a reason to renumber existing documents.

## Steps

1. Confirm which company is affected and that Open Numeration Templates has already been run for the new year there.
2. Check the DocumentNumeration system constant in that company. 0 means calendar-year numeration; 1 means fiscal-year numeration.
3. If the company runs on a fiscal year and the constant is 0, the system owner agrees the change. An authorised administrator sets it to 1.
4. Rerun Open Numeration Templates for the company.
5. Create a test document of an affected type and confirm it gets the new-year prefix.

## Verification

Proven: after setting the constant to 1 and rerunning, documents were created with the new prefix (SC263045, support-verified).

Not proven: a customer-written confirmation, and the effect on other companies that share the constant.

## Stop

Stop if the constant is already 1, or if the company deliberately uses calendar-year numbering. Then escalate instead of changing it.
