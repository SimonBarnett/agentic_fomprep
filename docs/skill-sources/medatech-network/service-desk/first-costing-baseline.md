# First costing needs an opening past-balance baseline

Issue type: a requested inventory valuation date has no past balances or costing, and the company has never run costing, so an earlier opening baseline has to exist first.

This is not `priority-service-desk-orphan-wo-past-balance`. That skill is a missing work-order reference on a production report. This one is the first costing chain for a company.

Known: on 2026-10-28 15:29 GMT support said that because no costings had been run in that company, they needed to do the opening date first. The customer then followed the sequence and could run inventory valuation reports for the target date. Running a past balance blocks inventory from changing before that date. The opening date in the call was 01/01/22 and the target was 31/03/26. Those dates belong to that company. Do not reuse them. Opened 2026-10-28 13:59 GMT.

The historical sequence support described was: under supervision, delete existing past balances if that was the approved plan, calculate the opening baseline and the target past balances, then run Costing for Past Balance Date for the baseline and then the target. This skill does not authorize an agent to delete those balances or recost.

Unknown: valuation totals and a rollback test.

## Prerequisites

Finance and inventory owner sign-off, a backup, and a written order of dates for this company. Read-only check of whether costing has ever run is the default. No autonomous delete, no reopen of history, and no production recost.

## Steps

1. Read whether any costing has been run, and which past-balance dates already exist.
2. Agree the opening baseline date and the target valuation date with finance. Do not copy 01/01/22 or 31/03/26 from this call.
3. Review period locks and any historical stock corrections before a recalculation.
4. The specialist, not this skill, runs past balances and Costing for Past Balance Date in baseline-then-target order, on an approved Test or with backup.
5. After that authorized work, run the intended valuation report and note which earlier periods are now blocked from inventory changes.

## Verification

Proven: the customer could run the target-date valuation reports after that sequence (SC263410).

Not proven: report totals and a restore test.

## Stop or escalate

Stop if costing has already been run for the requested date, if the owner has not named the baseline, or if the plan is to delete past balances without supervision. Do not recost from this skill.
