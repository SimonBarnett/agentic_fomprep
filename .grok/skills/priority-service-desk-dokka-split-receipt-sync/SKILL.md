---
name: priority-service-desk-dokka-split-receipt-sync
description: >
  Goods-receipt lines split in Priority still appear as one aggregated
  line in Dokka. The supplier changes their sync. Customer acceptance
  was not recorded. Use when Dokka split receipt, split goods synced,
  or /priority-service-desk-dokka-split-receipt-sync.
---

# Dokka split-receipt sync is a supplier escalation

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

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
