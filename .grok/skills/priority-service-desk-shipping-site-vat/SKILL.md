---
name: priority-service-desk-shipping-site-vat
description: >
  A new sales order takes VAT from the default shipping site, which
  overrides the customer Financial Parameters. Correct the site. Use
  when shipping address VAT overrides customer, or
  /priority-service-desk-shipping-site-vat.
---

# Shipping-site VAT overrides the customer VAT

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/shipping-site-vat.md`.

Issue type: a new sales order shows a VAT code that is not the customer's financial-parameter VAT, and no business rule is changing it. The default shipping site carries a different VAT code, and the order inherits that.

Known: on 2026-10-13 12:05 BST support recorded that Priority takes the VAT code from the default shipping address and that this overrides the customer. Changing the shipping-address VAT on a test order updated the order header. At 12:43 BST the customer said that resolved it. The final code values are not generalized. Do not copy a tax-exempt or OSS code from another customer.

Posted documents are not recalculated by a site-default change. Those need the finance correction process. Do not update VAT with SQL.

## Steps

1. Compare customer Financial Parameters VAT, the default or main customer site, and the order shipping-address VAT.
2. On a test order, change the shipping-address VAT and confirm the header follows. That proves precedence. It does not choose the legal code.
3. The finance owner names the correct site VAT.
4. An authorized user sets that code on the Customer Site. Check a new order. Do not claim old orders changed.

## Verification

Proven: the site-to-header override, and the customer saying the correction resolved it (SC263171).

Not proven: the final code the customer stored, and any historic-order recalc.

## Stop

Stop if a business rule is actually changing the code, if finance has not named the treatment, or if the request is to rewrite posted tax.
