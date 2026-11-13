---
name: priority-service-desk-vendor-price-list-unit-readd
description: >
  Vendor price list lines showed a different unit from the one now set on the vendor part. The line had to be deleted from the price list and re-added to pick up the new unit. Use when vendor price list unit different vendor parts unit changed re-add line, or
  /priority-service-desk-vendor-price-list-unit-readd.
---

# A vendor price list kept the old unit after the unit on vendor parts changed

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/vendor-price-list-unit-readd.md`.

Issue type: a vendor price list line shows a different purchase unit from the unit set on the part in the vendor parts form.

Known: on 2026-08-21 support recorded after a call that the customer showed vendor price list entries with a different unit from the vendor parts form. To update it, they had to delete the line from the price list for that part and add it again, so it pulled the new unit. Support suggested a rule in vendor parts warning users to do this when they change the unit. Part and vendor names are not stored.

Changing the unit on vendor parts does not update existing price list lines.

## Steps

1. Confirm the unit on the vendor part is now correct.
2. Note the current price and dates on the price list line.
3. An authorised user deletes the line for that part from the vendor price list.
4. Re-add the part to the price list, re-enter the price, and check the unit now matches.
5. Consider a warning rule on vendor parts so unit changes prompt this step.

## Verification

Proven: after deleting and re-adding the line, the new unit was pulled (SC262535, support note after call).

Not proven: whether any other documents keep the old unit.

## Stop

Stop if the line is used by open purchase orders the owner has not reviewed. Do not change prices without the owner.
