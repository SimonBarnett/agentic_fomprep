# Privilege Explorer would not give access to a whole sub-menu until Override was turned on

Issue type: in Privilege Explorer, giving a user or group access to a sub-menu does nothing: a "Please Wait" message flashes and the access stays the same, while single items under it give a message.

Known: on 2026-09-04 an experienced consultant reported that giving a user access to a warehouse setup sub-menu in Privilege Explorer showed "Privilege Explorer Please Wait" for a split second and made no change. Support replied: try clicking "Override?" from the top-right menu > Edit menu. The consultant replied "That's done the trick". User and menu names are not stored.

This is not a missing licence or a broken menu. Do not change privileges in tables directly.

## Steps

1. Confirm you are an authorised privileges administrator and the change is approved.
2. In Privilege Explorer, open the top-right menu > Edit menu.
3. Turn on "Override?".
4. Give access to the sub-menu again.
5. Check the user can now open the sub-menu, then follow your normal practice for the override setting.

## Verification

Proven: customer replied "That's done the trick" (SC262737, customer-verified).

Not proven: exactly what Override changes, and whether it should be left on.

## Stop

Stop if Override is on and the change still does not save. Then check whether the user inherits privileges from a group.
