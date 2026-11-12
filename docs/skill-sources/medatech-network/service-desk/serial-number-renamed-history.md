# A serial number missing from the catalogue had been renamed on another record

Issue type: an asset or serial number shows in inventory but is missing from Catalogue of Parts with Serial Numbers.

Known: on 2026-09-29 support compared live with an older copy company where the serial still existed. At 13:10 BST support reported that the same serial was now under a different serial number on that part, and History of Changes on the part showed a user had changed it a few days earlier. Support suggested changing it back the same way. On 2026-09-30 11:16 BST the customer said they had amended the asset. Why the change was made is not known. Part, serial and user names are not stored.

This is not data loss or a report fault. Do not create a duplicate serial to work around it.

## Steps

1. Confirm the item is in stock (warehouse balance) and check whether the balance is by lot or serial.
2. If a recent copy company exists, check whether the serial exists there. That narrows when it changed.
3. Search Catalogue of Parts with Serial Numbers for the part and look for an unexpected serial on it.
4. Open History of Changes for the part or serial record to find the rename and when it happened.
5. With the owner agreeing, change the serial back on the same form, then confirm it shows in the catalogue.

## Verification

Proven: the customer amended the asset after support found the rename in history (SC263002).

Not proven: why the rename happened, and how a count in live came to differ from the copy company.

## Stop

Stop if history shows no rename. Then escalate; do not edit serial data directly.
