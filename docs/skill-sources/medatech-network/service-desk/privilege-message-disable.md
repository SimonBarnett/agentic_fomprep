# A shipment warning popped up too often and was turned off for one privilege group

Issue type: a standard warning message on a form appears so often that it slows users, and the business owner wants it off for a group of users.

Known: on 2026-09-25 the customer said a below-minimum sell-price warning appeared on many shipments after they started using the minimum price field. On 2026-09-28 14:38 BST support said: open System Management > System Maintenance > Privileges > Privilege Explorer, search for the group leader, go to the Shipped Items form (Inventory > Inventory Transactions > Sales Inventory Transactions > Customer Shipments > Shipped Items), open the messages (hazard) icon on the right, find the message, click its small ! mark and select no message, then ask users in the group to restart Priority. At 15:22 BST the customer thanked support and said they had not known that existed. The message text and group are not stored.

This turns off a control for a whole group. It is not a fix for wrong minimum prices.

## Steps

1. Get the exact message text and the form it appears on.
2. Confirm the business owner wants the message off, and for which privilege group. A warning about price or credit is a control; record the decision.
3. In Privilege Explorer, open the group leader, go to the form, open its messages, find the message and set it to no message.
4. Ask users in that group to restart Priority.
5. Confirm the message no longer appears for that group, and still appears for others if intended.

## Verification

Proven: support gave the path and the customer accepted it (SC262991).

Not proven: an explicit retest after the change, and whether it worked for every user in the group.

## Stop

Stop if the message is an error (it blocks the action) rather than a warning, or if the owner has not agreed. Then escalate.
