---
name: priority-service-desk-split-grv-before-invoice
description: >
  Invoicing part of a GRV line consumes the whole received line unless
  the line is split first. Proved on local Priority 26.0 only. Use when
  split GRV line before invoice, Multi-GRV partial quantity, or
  /priority-service-desk-split-grv-before-invoice.
---

# Split a GRV line before the first invoice

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/split-grv-before-invoice.md`.

Issue type: a goods-received line that is invoiced for a smaller quantity does not leave a reusable remainder. The received line has to be split before the first invoice links it.

This is standard Priority handling in the tested case. It is not `priority-service-desk-dokka-split-receipt-sync` (supplier sync of an already split receipt).

Known, from support on 2026-11-04 14:09 GMT, tested on local Priority 26.0: split before the GRV line is linked to the first invoice, using GRV > Received Items > Actions > Split Line Item. Then invoice the distinct split receipt lines on separate Multi-GRV invoices. Support finalized two invoices of 500 units each against one 1000-unit receipt without changing the overall received quantity. Those quantities are the test example, not a customer identity. Opened 2026-10-29 15:41 GMT.

A full order quantity invoiced at a lower unit price still closes that quantity. Do not "fix" a price difference by splitting, and do not change the price to force a partial invoice.

Not proven: the customer's live company, any version other than the local 26.0 test, and a customer confirmation. Ask them to validate the version and the workflow before production use.

## Prerequisites

Authorized Test, or the same local version the procedure was proved on. The receipt line must not already be linked to an invoice. No deletion of finalized invoice links, no price edit, and no stock edit. This harvest does not authorize a live invoice.

## Steps

1. Check whether the target received line is already linked to an invoice. If it is, do not promise a split. Stop and escalate.
2. If it is not linked, split it with GRV > Received Items > Actions > Split Line Item before any invoice is linked.
3. Invoice each split line on its own Multi-GRV invoice for the intended quantity.
4. Confirm the total received quantity is unchanged.
5. Treat a successful local 26.0 test as version-scoped evidence. It is not a customer production sign-off.

## Verification

Proven: support's local Priority 26.0 test finalized the two partial invoices and left the received total unchanged (SC263436).

Not proven: customer live use, and other Priority versions.

## Stop or escalate

Stop if the line is already invoiced, if the request is to delete an invoice link, or if the symptom is Dokka showing one aggregated line. Escalate version doubt to the customer before anyone repeats this on live.
