---
name: priority-service-desk-inventory-count-prepare-zero
description: >
  A user could not zero a part stock with an inventory count because they had not prepared the count. Preparing the count for the part, leaving the counted quantity at 0 and approving the lines zeroed the stock. Use when cannot zero stock inventory count prepare, or
  /priority-service-desk-inventory-count-prepare-zero.
---

# Stock could not be zeroed because the inventory count was not prepared first

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/inventory-count-prepare-zero.md`.

Issue type: a user tries to zero a part stock with an inventory count, and the count does nothing.

Known: on 2026-09-29 the customer could not zero the stock of a part that had been inventory-controlled, unticked, then ticked again with past balances refreshed. At 12:38 BST support said to prepare the count first (Inventory > Warehouse Control > Inventory Count > Prepare Count for Past Date > Prepare for Inventory Count, with Select Parts for that part), which calculates the current stock, then leave the counted quantity as 0 and approve the lines. The internal note says the user had not prepared the count and had just entered a zero count. At 12:59 BST the customer said that was it, they had forgotten to run the prep first. The part name is not stored.

This is not a stock-balance defect and not a reason to adjust balances directly.

## Steps

1. Ask whether the count was prepared before quantities were entered.
2. Prepare the count: Inventory > Warehouse Control > Inventory Count > Prepare Count for Past Date > Prepare for Inventory Count. Use Select Parts to limit it to the part.
3. Check the prepared lines show the current stock.
4. Leave the counted quantity at 0 for the stock to remove, with the owner agreeing the write-off.
5. Approve the lines and confirm the stock is now zero.

## Verification

Proven: the customer confirmed the missing prepare step was the cause (SC263014).

Not proven: the final stock balance check and the financial effect of the count.

## Stop

Stop if the count was prepared and still does not post, or if the zeroing has not been agreed by the stock owner.
