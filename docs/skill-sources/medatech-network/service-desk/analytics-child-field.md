# Optional Analytics child field hides parent rows

Issue type: an Analytics report on shipping vouchers returns no parent rows, or only parents that have a child line, after an optional child cost field is added.

Known: on 2026-10-16 17:19 BST support saw the data return when the expense field was removed from the sub-subform. On 2026-10-21 the supplier said the report shows only vouchers that have a line in Additional Expenses while the Cost field is included, and all of them once that field is removed. There is no setting that changes this. The customer reported output without the extra child data, and none after the child data was added.

This restores parent rows. It does not produce a report that has every parent and the child cost. A two-report spreadsheet combination was only suggested. It was not tested. Do not invent an outer-join option. Do not insert zero-value child rows to force the join.

## Steps

1. Run the parent-only report and the same report after the optional child field is added.
2. Check whether the missing parents really have no child rows.
3. In a copy, remove the optional child field and confirm the parent population returns. The child cost is then absent on purpose.
4. If both are required, write that as an untested proposal. Do not mark it done.

## Verification

Proven: parents returned when the child cost field was removed (SC263252). Supplier confirmed the behavior.

Not proven: a combined report.

## Stop

Do not change generated SQL or draw financial conclusions from the child-only population.
