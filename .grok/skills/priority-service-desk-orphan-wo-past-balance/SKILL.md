---
name: priority-service-desk-orphan-wo-past-balance
description: >
  Residual inventory from a production report that has no work-order
  reference. Warehouse transfer was not the cause in the source call.
  Escalate. Use when missing work order number balance, Update Invent. by
  Past Balance, orphan production report, or
  /priority-service-desk-orphan-wo-past-balance.
---

# Orphan work-order balance is an inventory escalation

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/orphan-wo-past-balance.md`.

Issue type: a part balance remains after production activity that was recorded with no work-order number. This is an escalation to the inventory and costing owner. It is not a procedure an agent may run by deleting documents or posting stock.

Known: support traced the originating production report to a part created with no work order number (2026-11-05 15:26 GMT). A prior similar case had been a warehouse transfer. The customer explicitly reported there were no warehouse transfers here. Do not reuse that earlier cause.

What was prescribed, and what the customer then did under that advice: correct or recreate the implicated production reporting so it carries the work-order reference, remove zero-quantity orphan count lines before past balances, and where a historical residue remains run Inventory > Warehouse Control > Past Balances > Update Invent. by Past Balance (support, 2026-11-06 08:31 GMT). The customer reported they had deleted the implicated production reports and closed or backflushed the work orders, and a residue remained until the past-balance update. On 2026-11-06 10:19 GMT the customer wrote "It is sorted!" and referred to the past-balance calculation.

Unknown: final stock figures, recreated document ids, and a full period or costing reconciliation. Do not invent them. Do not copy quantities into the skill.

## Prerequisites

Before authorized Live correction, require a verified backup/recovery plan, owner-approved Test rehearsal where feasible, period controls, audit trail and inventory/costing sign-off. Test reproduction alone is insufficient. Read-only tracing is the default. This harvest does not authorize those writes.

## Steps for the evidence pack

1. Trace each residual balance to the original inventory transaction, production report, transfer, and work-order reference.
2. Ask which past-balance and costing periods have already been run.
3. Confirm whether warehouse transfers exist. In SC263492 they did not. Do not assume they do.
4. Hand the pack to the inventory and costing owner with the menu path that support gave: Inventory > Warehouse Control > Past Balances > Update Invent. by Past Balance. The owner decides whether a document correction is required first.
5. After a later correction that meets the owner controls above, compare before and after balances with that owner. Record the comparison outside this skill if it contains figures. Formal approval and backup evidence for SC263492 were not retrieved.

## Verification

Proven for SC263492 (opened 2026-11-04 10:02 GMT): the customer said the issue was sorted after the past-balance step, following the document corrections support had required.

Not proven: ledger figures, costing close, or that the same clicks are safe on another company.

## Stop or escalate

Do not delete finalized documents, run past-balance update, edit balances in SQL, or post blind stock counts from this skill. If backup, period lock, or owner approval is missing, stop. High-impact stock history stays with the inventory owner.
