---
name: priority-service-desk-grv-not-linked-po-warehouse
description: >
  A goods receipt did not show the warehouse from the purchase order. The GRV was not linked to the purchase order. After linking them, the warehouse was right. Use when GRV wrong warehouse not linked to purchase order, or
  /priority-service-desk-grv-not-linked-po-warehouse.
---

# A GRV had the wrong warehouse because it was not linked to the purchase order

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/grv-not-linked-po-warehouse.md`.

Issue type: a goods receipt (GRV) shows a different warehouse from the one on the purchase order.

Known: on 2026-09-16 12:17 BST support recorded that a GRV did not have the warehouse from the purchase order. On checking, the purchase order was not linked to the GRV, which caused the issue. After the PO was linked to the GRV the issue was sorted. Document numbers are not stored.

This is not a warehouse default defect. Check the link before changing defaults.

## Steps

1. Open the GRV lines and check whether they are linked to the purchase order lines.
2. If not linked, the user links the purchase order to the GRV through the standard receiving process before finalising.
3. Check the warehouse on the GRV now matches the purchase order.
4. If the GRV is already final, follow the owner process to correct it; do not edit stock directly.

## Verification

Proven: after linking the PO, the warehouse issue was sorted (SC262875, support note after call).

Not proven: a customer-written confirmation, and how the GRV was created unlinked.

## Stop

Stop if the GRV is linked and the warehouse still differs. Then check the PO line warehouse and defaults.
