# Calculate/Update Standard Cost writes the catalogue

Issue type: nightly costing finishes, but parent standard costs in the Part Catalogue stay wrong until someone runs Calculate/Update Standard Cost.

Known: UpdStdCost is 0. The nightly Costing for Current Date process calculates costs and does not automatically update standard costs in the Part Catalogue (technician, 2026-10-21 11:20 BST). The customer said the parent was wrong until they costed it manually (2026-10-20 10:28 BST) and named Financials > Cost Analysis for Manufacturers > Standard Costs > Calculate/Update Standard Cost (2026-10-21 09:19 BST). The technician confirmed that procedure corrected the affected parents. Opened 2026-10-19 15:00 BST. No amounts are recorded here.

Unknown: exactly when the component cost source changed relative to the nightly run. A manual-source placeholder is not a required step. Do not set component costs to zero. Do not flip UpdStdCost as the first response. A constant change is a separate finance policy decision.

## Prerequisites

Finance or costing owner, a controlled Test, and a named list of parents. This harvest does not authorize a company-wide costing or a journal rewrite.

## Steps

1. Read completed costing history. Compare calculated product costs with Parts - Std Costs before calling the nightly task a failure.
2. Read UpdStdCost. At 0, calculation without a catalogue update is the configured behavior in this call.
3. Read component cost source and BOM quantities. Do not change them to force a number.
4. The owner runs Calculate/Update Standard Cost for the affected parents only. Compare catalogue values before and after. Manually entered standard costs are not overwritten. Check that on the installed version rather than assuming it.
5. If the business wants the nightly run to write the catalogue, that is a separate approved constant review. It is not this repair.

## Verification

Proven: the manual procedure corrected the affected parent costs (SC263270).

Not proven: component-source timing, and that every nightly run is broken.

## Stop or escalate

Stop if the request is to change UpdStdCost globally, rewrite old journals, or cost every part. The finance owner owns the scope.
