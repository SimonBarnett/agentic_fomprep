# Filter blank part rows out of a consumables report

Issue type: a custom consumables report prints blank lines because its base link table contains rows with no part.

Known: internal note 2026-10-16 11:40 BST: 12 blank records on the base table created the blank report lines. The deployed change was `PART.PARTNAME <> ''` at the end of that report. The note called the new condition line 800. That line number is this report only. Do not apply line 800 to other reports. After the change, the blank lines disappeared from the consumables section of the two affected visits, and the customer confirmed (12:01 BST). On 2026-10-20 08:43 BST the customer said it was updated and worked. Test was updated after the live sign-off (09:30 BST).

Why the blank links existed, including deleted consumables, was not proved. A duplicated logo was not fixed here. Other joins were tried and were not the deployed change. This filters report output. It does not delete base rows.

## Steps

1. Compare printed consumable rows with the form's base link rows. Count blank part rows. Read only.
2. Name the exact custom report and who else uses it.
3. In a copy, test `PART.PARTNAME <> ''` only when blank-part rows are unwanted. Check totals and other sections.
4. The owner deploys that predicate, retests the affected visits, then brings Test in line with the signed-off live report.

## Verification

Proven: blank consumable lines gone on the retested visits, customer confirmation, Test synchronized after sign-off (SC263245).

Not proven: how the blank links were created, and the logo symptom.

## Stop

Do not delete link rows. Do not add this predicate to every report. Do not treat a different line number as portable.
