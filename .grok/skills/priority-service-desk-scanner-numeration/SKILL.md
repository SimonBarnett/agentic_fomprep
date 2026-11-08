---
name: priority-service-desk-scanner-numeration
description: >
  Scanner Trans cannot record more documents because the annual
  numeration is full. Extending that numeration restored opening.
  It is not an API quota. Use when scanner 10000 documents per year,
  Scanner Trans numeration, or /priority-service-desk-scanner-numeration.
---

# Scanner document numeration reached its annual maximum

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/scanner-numeration.md`.

Issue type: the scanner says it cannot record more than 10000 documents per year because document numeration has reached its maximum. That message was first mistaken for a mobile or API entitlement limit.

Known: on 2026-10-12 13:02 BST support said the procedure was amended so Scanner Trans numeration could be extended, and asked the customer to test opening documents. At 13:51 BST the customer said it was working. The procedure diff and the new width were not recorded. Do not invent them. Do not reset the sequence, renumber old documents, or delete them.

## Steps

1. Copy the exact message. Read the configured annual numeration and the current sequence before calling it a licence or API cap.
2. Confirm this is the custom Scanner Trans numeration and list what else consumes those numbers.
3. A developer, with the owner, extends the supported numeration in Test, checks existing numbers stay unique, then deploys through the normal path.
4. The customer opens a new scanner document and confirms the reference is unique.

## Verification

Proven: the customer could open scanner documents after the extension (SC263177).

Not proven: the code diff, the new width, and a later year.

## Stop

Stop if the message is not this numeration limit, if uniqueness cannot be checked, or if the proposal is a sequence reset or a licence bypass.
