---
name: priority-service-desk-last-purchase-price-report
description: >
  Build a Part Catalogue Report Generator report for stored last purchase
  price and date on R-type parts, then add the approved menu entry. Do not
  recalculate prices. Use when last purchase price date report, Part
  Catalogue Report Generator, or /priority-service-desk-last-purchase-price-report.
---

# Last purchase price report from Part Catalogue Report Generator

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/last-purchase-price-report.md`.

Issue type: users need a report of the stored last purchase price and date for raw-material (R-type) parts, and the existing output does not show them.

There is no existing catalog report-generator procedure for this. `priority-report-form-zooms` is column zooms, not this generator. `priority-ops-reports` is only the lesson hub.

Known: on 2026-10-28 11:04 GMT support recorded that a new report in the Part Catalogue Report Generator gave the required information, and that it was added to the menu. Scope was last purchase price, last purchase date, and R-type parts. Opened 2026-10-28 11:03 GMT.

Unknown: the dictionary field identifiers and the saved report definition. Do not invent column names. Do not print customer prices in the skill.

## Prerequisites

The request is to display stored last price and date, not to change them. An approved menu placement. No price update program. This harvest does not authorize publishing prices or running a price-update procedure.

## Steps

1. Confirm the columns are the stored last purchase price and date, and that the part scope is R-type raw materials.
2. Create the report in Part Catalogue Report Generator. Check the chosen price and date fields against a known part whose values you are allowed to see. Do not paste those values into notes.
3. Filter to R-type parts and confirm a non-R part is excluded.
4. Add the report to the approved menu entry.
5. Have the requester run it and confirm the columns and the selection. A successful create is not a price change.

## Verification

Proven: support said the new report gave what was needed and the menu entry was present (SC263402).

Not proven: the field names and the report-definition export.

## Stop or escalate

Stop if the user wants prices recalculated or updated. That is a different procedure and was not done here. Do not disclose prices in training notes.
