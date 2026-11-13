---
name: priority-service-desk-forecast-mrp-retrieve
description: >
  Prepare Forecast Order creates lines that stay out of MRP until Retrieve
  Sales Orders - MRP is run for those selected orders. Proved in local and
  customer Test, not live. Use when forecast MRP flag, Retrieve Sales
  Orders MRP, or /priority-service-desk-forecast-mrp-retrieve.
---

# Forecast order lines need Retrieve Sales Orders - MRP

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/forecast-mrp-retrieve.md`.

Issue type: Prepare Forecast Order creates forecast lines and does not set them for MRP. A later retrieval has to be run, and in the source case that retrieval had not been run in Live.

Known path: Purchasing > MRP for Manufacturers > Retrieve Sales Orders - MRP. Limit the scope to Selected Orders for the intended forecast order, and use the correct planning due date. After that run, the tested lines were flagged MRP? = Y. On 2026-10-29 13:12 GMT support had done this in a local environment and in the customer Test company. Both forecast lines were Y. Opened 2026-10-28 09:17 GMT.

Not proven: a Live run and a customer response. Order numbers and the future date are omitted on purpose.

## Prerequisites

Planning-owner approval before any Live retrieval. Test with Selected Orders only. This harvest does not authorize All Open Orders, an MRP rerun, or a date change.

## Steps

1. Separate "the forecast was generated" from "the lines were retrieved for MRP".
2. Check whether Retrieve Sales Orders - MRP has been run for that forecast order and planning due date.
3. In authorized Test, run it with Selected Orders for that forecast only.
4. Confirm the intended lines are Y and that unrelated orders were not flagged.
5. Live use waits for the planning owner to accept the schedule and the following planning run. Local plus customer Test is not Live acceptance.

## Verification

Proven: local and customer Test both set the forecast lines to Y (SC263390).

Not proven: Live, and the customer's own confirmation.

## Stop or escalate

Stop if the proposal is All Open Orders, if the due date is being moved to force a result, or if Live is requested without the planning owner. Do not flag every forecast line by a direct edit.
