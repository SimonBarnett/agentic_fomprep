---
name: priority-service-desk-closed-so-mrp-flag-demand
description: >
  A sales order marked completed or cancelled still drove MRP purchase demand. Support removed the MRP: Y flag from its order items; after the next MRP run the customer said it was resolved. Use when cancelled sales order still in MRP demand, or
  /priority-service-desk-closed-so-mrp-flag-demand.
---

# A completed or cancelled sales order kept creating MRP demand until its MRP flag was removed

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/closed-so-mrp-flag-demand.md`.

Issue type: MRP keeps suggesting purchases for a sales order that the business has completed or cancelled.

Known: on 2026-09-22 the customer reported a sales order marked completed or cancelled that MRP still treated as demand, even after daily and weekly MRP runs. On 2026-10-21 they sent screenshots of the order and the part demand. The internal plan was to uncancel the order and remove MRP Y from the lines. On 2026-10-23 15:10 BST support said they had removed the MRP: Y flag from the order items and asked the customer to check after MRP re-ran. On 2026-10-26 15:22 GMT the customer said this had resolved the issue. Order numbers are not stored.

This is not an MRP calculation defect, and not a reason to delete the order or its lines.

## Steps

1. Get an example part and show which order MRP links the demand to. Confirm it is the completed or cancelled order, not another open order.
2. Open the order items and check the MRP flag on each line.
3. With the owner agreeing, an authorised user removes the MRP flag from those lines. If the order status blocks the change, follow the owner process (support here planned to uncancel first).
4. Rerun MRP with the usual parameters.
5. Confirm the demand from that order has gone.

## Verification

Proven: after the MRP flag was removed and MRP re-ran, the customer said it was resolved (SC262958).

Not proven: why the flag stayed on after the order was closed, and whether the order status was changed back afterwards.

## Stop

Stop if the demand comes from a different open order, or if the lines have no MRP flag. Then investigate the MRP input.
