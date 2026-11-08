# MRP production days apply to the batch quantity

Issue type: Production Days is being applied per unit, or a Work Plan is overriding the manual production-days setup, so planned duration is many times too long.

Known from a practice company, 2026-10-28 16:42 GMT: Production Days stayed 21, Time per Batch stayed ticked, Production Quantity was changed to 5, and MRP was rerun without creating a Work Plan. Duration went from 105 days to 21 days. On 2026-10-29 10:51 GMT the customer said that morning's test worked and they set an agreed maximum quantity of 100. Earlier advice to tick Work Plan is superseded for this use case by that verified unticked run.

Those numbers are this company's test, not defaults. There is no unlimited fixed lead time above the configured batch. Exceeding the batch can take more time. Live rollout was not recorded. A missing purchase recommendation is not implied when stock covers demand.

## Prerequisites

A planner signs off live timing and real capacity. Practice-company or authorized Test first. This harvest does not authorize a live MRP run or unticking Work Plan where a routing capacity plan is required.

## Steps

1. Decide whether the duration is per batch or per unit. Read Production Quantity, Production Days, and Time per Batch together.
2. Read whether the MRP run created a Work Plan. For this fixed per-batch duration, the verified run did not.
3. Set the batch quantity to an engineering-approved maximum. Test below it, at it, and above it.
4. Rerun MRP without a Work Plan only when that is the approved mode. Confirm work-order start and end and the component dates.
5. Do not copy 21, 5, or 100 onto another part.

## Verification

Proven: the practice-company before and after, and the customer's test with maximum 100 (SC263299).

Not proven: live use.

## Stop or escalate

Stop if the plan needs routing-based capacity, if the batch maximum is not agreed, or if the request is to freeze one lead time for any quantity. The planner owns the live timing.
