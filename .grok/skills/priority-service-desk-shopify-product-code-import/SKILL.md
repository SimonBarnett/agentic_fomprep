---
name: priority-service-desk-shopify-product-code-import
description: >
  A Shopify order stays out when the incoming product code does not match
  the configured Priority identifier. Correct that mapping and confirm one
  imported order. Use when Shopify product code wrong, order not imported,
  or /priority-service-desk-shopify-product-code-import.
---

# Shopify product-code mapping blocked the order import

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/shopify-product-code-import.md`.

Issue type: a Shopify order does not import because the incoming product identifier does not match the configured Priority product identifier. The display name can look right while the code is wrong.

Known: on 2026-10-28 11:59 GMT support said the order was now in and the product code from Shopify was wrong. The customer thanked them. The recorded repair was to correct that product-code mapping. Align either the upstream identifier or the corresponding Priority field. Which field was edited was not named. Opened 2026-10-28 10:06 GMT.

Not fixed: the failure-notification email. A successful import does not repair alerts.

This is not the Dokka receipt-line sync skill. Do not copy product codes or order numbers into the skill.

## Prerequisites

Integration owner approval before a mapping change. Read the incoming identifier and the configured mapping first. No second import if the order is already in. This harvest does not authorize a force-import.

## Steps

1. Compare the actual incoming product identifier with the configured mapping. Ignore a matching display name.
2. Read the load failure, if one is still available, before retrying. Check whether the target order already exists.
3. The integration owner aligns the upstream code or the Priority field that the interface uses. Do not guess the field name if the call does not name it.
4. Confirm exactly one imported order and that its lines match the source quantities you are allowed to see.
5. Track the missing failure email as a separate defect. Do not close it because the order imported.

## Verification

Proven: the order imported after the product code was corrected (SC263397), and the customer acknowledged it.

Not proven: the exact field edited, and any repair of the notification mail.

## Stop or escalate

Stop if the order is already imported, if the identifier mismatch is not shown, or if the only proposal is to force a duplicate order. The integration owner makes the mapping change.
