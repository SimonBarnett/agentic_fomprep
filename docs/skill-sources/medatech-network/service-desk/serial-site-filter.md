# Service-call device list filtered by a different site

Issue type: a service call's device or serial dropdown is empty even though the serial belongs to the same customer. The site on the serial is not the site on the call, and the dropdown is filtered by site.

Known: on 2026-10-22 13:46 BST support said the site on the serial and the site on the service call were different. At 13:44 BST an internal note said it works when the site is removed. At 16:20 BST the customer accepted the explanation. The customer did not separately describe finishing the configuration. The explicit proof is the technician's dropdown test.

Do not remove a real site segregation just to make assets appear. Do not reassign the serial to another customer, and do not widen privileges.

## Prerequisites

A service owner agrees whether the call site or the serial site is wrong. Read both sites first. This harvest does not authorize clearing the site.

## Steps

1. Compare customer and site on the service call and on the serial.
2. If the customers differ, stop. This skill is the site filter, not a missing asset and not a privilege fault.
3. If the customers match and the sites differ, show that the dropdown is empty because of the site. The technician check was to remove the site and see the device.
4. Either set the legitimate site on both records, or clear an unintended filter, with the service owner's approval.
5. Confirm the intended device appears and that other sites stay hidden.

## Verification

Proven: with the site removed, the dropdown showed the device (SC263316), and the customer accepted the explanation.

Not proven: the customer completing the site setup themselves.

## Stop or escalate

Stop if the sites are supposed to differ, if the customer does not match, or if the proposal is a broad privilege change. The service owner chooses the site.
