---
name: priority-service-desk-dokka-split-receipt-sync
description: >
  Goods-receipt lines split in Priority still appear as one aggregated
  line in Dokka. The supplier changes their sync. Customer acceptance
  was not recorded. Use when Dokka split receipt, split goods synced,
  or /priority-service-desk-dokka-split-receipt-sync.
---

# Dokka split-receipt sync is a supplier escalation

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/dokka-split-receipt-sync.md`.

Issue type: receipt lines that were split in Priority still show as one aggregated line in Dokka, so the downstream quantities do not match and processing stops. There is no evidence the Priority split itself was wrong.

Known: on 2026-11-04 13:30 GMT the report was "Lines split in Priority aren't reflected in Dokka, so invoices show the wrong quantities and can't be processed." A non-financial shape from the investigation: two one-unit lines in Priority still appeared as one two-unit line downstream. On 2026-11-05 11:03 GMT an internal note recorded the supplier mail from 10:34 GMT: "Following a change on our end, the split goods are synced properly." Support told the customer at 13:48 GMT that Dokka said this should now be fixed and asked them to advise if the issue persists.

Unknown: the supplier patch id, any config toggle, and a customer retest. Do not describe this as customer-confirmed. Do not invent a Priority SQL change or a connector setting.

The scanned stub `docs/skill-sources/medatech-network/customer-guides/Conenect Dokka to Priority.md` has no procedure text. It is not this fix. `priority-ops-integrations` is only the lazy-load hub. There was no open integration PR to enrich.

Do not fold in SC263507, SC263508, or SC263509. Those tax and partial-export investigations were still open and are not this pattern.

## Prerequisites

An active split-receipt example the supplier can see, with quantities and line counts and without prices, tax, or bank details. Do not delete, rewrite, or re-export the receipt as a shortcut. No financial posting.

## Steps

1. Compare Priority line count and quantities with the downstream matched receipt. A sync mismatch is not an invoice price or VAT defect.
2. Keep the example in place until connector support has seen it.
3. Escalate to Dokka, or the connector owner, with that sanitized comparison. The repair in this call was a change on their side.
4. Record the supplier's statement as supplier verification, separate from customer acceptance.
5. Ask the customer to retest the same split-line path. Until they do, customer acceptance is absent. Support's "please advise if the issue persists" is that request, not a confirmation.

## Verification

Proven for SC263506 (opened 2026-11-04 13:28 GMT): the supplier said that after their change the split goods synced.

Not proven: customer retest, patch contents, and a wider sync regression.

## Stop or escalate

Stop if the Priority split itself looks wrong, if the case is a tax mapping (the neighbouring calls), or if the only proposed action is to delete or repost financial documents. No local sync edit from this skill.


## Different Dokka defect: accounting-family refresh (SC263283)

Issue type: new-part expense accounts are correct on a native Multi-GRV invoice and wrong or missing on the Dokka invoice. Ordinary integration sync already failed.

Known: the supplier said the expense account is not stored on the part. It comes from the part's Accounting Family. Dokka takes the Purchases/Inventory account for that family and sets it on the invoice line (internal note 2026-10-29 12:05 GMT). A full sync on their side can disrupt people working in Dokka. Support confirmed Dokka ran that full update (13:31 GMT). At 13:42 GMT the customer said those parts were now working. Opened 2026-10-20 13:57 BST.

This is not the split-receipt sync above. The accounting-family mapping was already correct. Do not change GL accounts to force a match. There is no user button in this call. The supplier runs the full refresh, after the owner agrees a window. Do not invent the payload.

A related tax or greyed-field case was still open. This refresh does not close it.

Proven: supplier full refresh, then the customer confirmed the parts. Not proven: how the supplier refresh works, or the cache mechanism.


## Manual company sync restored line selection (SC263202)

Different symptom from the accounting-family refresh and from the split-receipt sync. Dokka would not select GRV or PO item lines. The warning was that the certificate or document was not available for item line selection.

On 2026-10-19 09:08 BST support recorded that Dokka did a manual company sync, then support tested the two affected invoices and the lines were pulled. That is a technician test. It is not the customer accepting a posted invoice. The supplier mechanism is unknown. Do not finalize, reopen, or remap accounts from this note. Opened 2026-10-14.
