---
name: priority-service-desk-inventory-conversion-raw-lot
description: >
  New reel or raw-material lot cannot be selected on an inventory conversion
  until it exists in Raw Material Lots. Leave the conversion in Draft.
  Use when raw material lot missing, inventory conversion draft, lot zero
  original part, or /priority-service-desk-inventory-conversion-raw-lot.
---

# Draft inventory conversion needs the raw-material lot first

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/inventory-conversion-raw-lot.md`.

Issue type: Inventory Conversion will not accept a new lot because that lot is not yet in Raw Material Lots. A typo in the original part reference can sit beside this and must be ruled out first.

Known fix, from support on SC263474 at 2026-11-05 14:36 GMT: "the new lot number must first exist in the Raw Material Lots form before it can be selected in the Inventory Conversion." The same instruction: "please initially leave the Inventory Conversion in Draft status and do not finalise it yet." On 2026-11-05 14:55 GMT the customer wrote that they had done that, it was all perfect, and the call could close.

That confirmation accepts the draft instructions. It does not prove the conversion was finalized, and it does not prove stock-ledger balances changed.

Unknown / not universal: PLotByVendor=1 was observed on that environment. Do not change that constant from this skill. Do not copy customer part numbers or stock totals into notes. Creating the lot master does not by itself transfer stock.

## Prerequisites

Inventory owner approval before any conversion that will be finalized. This harvest authorizes Draft entry only, on an allowlisted company. No live finalization.

## Steps

1. Confirm the real part identity and that the goal is a same-part lot reallocation. Correct a typo before calling it a missing dictionary row.
2. Read part lot settings and the lot-number constant. Do not change the constant.
3. If the new lot is absent from Raw Material Lots for that part, create that lot record. Stop there if the only task was to register the lot. Lot creation is not a stock transfer.
4. On a Draft inventory conversion only: put the new lot on the after side, reference the same part and lot zero on the original side, keep quantities equal, and keep the same part and warehouse. The net quantity change must be zero.
5. Leave the document in Draft until the inventory owner approves finalization. Do not finalize it under this skill.
6. Do not mass-create estimated reel lots, and do not assume the whole balance is one full reel.

## Verification

Proven: the customer completed the instructed draft path and accepted closure (SC263474, opened 2026-11-03 12:48 GMT).

Not proven: final status, posted stock movement, or ledger balances.

## Stop or escalate

Stop if the part identity is still uncertain, if quantities would not net to zero, or if someone asks to finalize. Escalation for finalization is the inventory owner, with a Test or approved live window. No direct stock edits.
