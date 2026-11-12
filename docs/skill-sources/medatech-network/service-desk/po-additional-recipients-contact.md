# Purchase orders went to only one vendor contact until additional recipients were defined

Issue type: purchase orders sent by email reach only one vendor contact, even though more than one contact seems to be ticked to receive them.

Known: on 2026-08-24 a customer said they still could not have more than one contact receive purchase orders. On 2026-08-26 support recorded that this was because no additional recipients were added to the contact; after they were defined and tested, it worked correctly. Related: in another call support said defining additional recipients against a contact for Quick Email arrived in Priority version 25.0 (SC262797), so check the version first. Contact names are not stored.

This is not a mail server fault. Ticking more contacts alone did not do it here.

## Steps

1. Check the Priority version supports additional recipients on a contact (25.0 or later per SC262797).
2. Open the vendor contact that receives purchase orders.
3. Define the additional recipients for that contact.
4. Send a test purchase order and check every recipient gets it.

## Verification

Proven: after the additional recipients were defined, a test worked (SC262549, support-verified).

Not proven: the exact form or field name for additional recipients in each version.

## Stop

Stop if the version does not support it. Then discuss an upgrade or a development with the account manager.
