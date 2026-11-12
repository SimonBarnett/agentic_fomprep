---
name: priority-service-desk-debit-memo-part-account
description: >
  A vendor debit memo journal stayed unposted with the account shown as Lineitems because the part had no nominal account. Defining the account on the part resolved it. Use when debit memo journal unposted Lineitems account, or
  /priority-service-desk-debit-memo-part-account.
---

# A debit memo part with no account left the journal unposted

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/debit-memo-part-account.md`.

Issue type: a purchase ledger debit memo creates a journal entry that stays unposted, and the account on the entry shows as Lineitems instead of a nominal account.

Known: on 2026-10-13 14:43 BST support recorded, after a call with the customer, that the part used on the debit memo had no nominal account defined. Priority could not work out which account to post to, so the journal stayed unposted with Lineitems as the account. Once the correct account was defined against the part, the issue was resolved. The account number, part, document numbers, and values are not stored. The exact form used to define the account was not recorded.

This is not a VAT setup problem and not a reason to edit or delete the journal directly. The finance owner chooses the account.

## Steps

1. Open the unposted journal and confirm the account column shows Lineitems (or is blank) rather than a nominal account.
2. Find the part on the debit memo line and check whether it has a nominal account defined, through its financial parameters or account family.
3. The finance owner decides the correct account. An authorised user defines it against the part. Do not pick an account for them.
4. Retry posting through the normal process and confirm the journal posts with the nominal account.
5. Check whether other parts used on purchase documents have the same gap.

## Verification

Proven: the missing part account explained the Lineitems journal, and defining it resolved the issue (SC263134).

Not proven: the exact form path used, whether the existing journal was reposted or recreated, and a customer-written confirmation.

## Stop

Stop if the part already has an account, if the journal is already posted, or if someone asks to change posted entries directly. Escalate to the finance owner.
