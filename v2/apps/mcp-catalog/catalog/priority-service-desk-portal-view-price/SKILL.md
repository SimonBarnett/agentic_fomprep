---
name: priority-service-desk-portal-view-price
description: >
  The customer portal shows no product prices until View Price in Portal
  is ticked on that customer. Use when portal prices hidden, View Price
  in Portal, or /priority-service-desk-portal-view-price.
---

# View Price in Portal shows prices for that customer

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/portal-view-price.md`.

Issue type: the portal shows products but no prices, until the customer record allows price display.

Known: on 2026-10-14 16:31 BST support said to flag View Price in Portal on the customers form. On 2026-10-15 14:11 BST the customer said that worked. Discounted portal prices and branding were separate requests and were not done by this flag. No product prices are recorded here.

Showing prices is a commercial decision. The owner approves which customer, and which portal users, should see them. The flag does not fix units, price lists, or family discounts.

## Steps

1. Separate hidden prices from wrong discounts or units.
2. Confirm the portal user is the intended customer.
3. An authorized administrator ticks View Price in Portal on that customer only.
4. The customer retests the portal. Do not paste prices into notes.

## Verification

Proven: the customer said pricing was then available (SC263208).

Not proven: discounts, branding, and every unit or case price.

## Stop

Stop if the owner has not agreed to show prices, or if the complaint is a wrong discount rather than a hidden price.
