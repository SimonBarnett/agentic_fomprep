# FR-E — CAT / hostile pins for hours webhook cutover

## Goal

Catalog or launcher tests lock Success needles S1–S6 after product FRs merge.

## Deliverables

- Allocate next-free CAT-Tn (Select-String Add-Gate on origin/main after sibling merges) or dedicated launcher test.
- Pin: HoursCheck does not fetch origin/hours; rules-version >= 5; bob.ntsa.uk/bob/v1/hours needles; no irc.ntsa.uk/bob/v1 in skills.

## Testable

- `v2/tools/Test-PriorityCatalog.ps1` (or launcher test) green on origin/main after merge.
- Add-Gate ids unique (CAT-T58).
