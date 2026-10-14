# Part MRP Flag Users Guide

- **Source:** `Part MRP Flag Users Guide.docx`

Part MRP Flag for Sales Orders Module Users Guide

Description

The part flag for MRP module enables the setting of a flag for any part such that when that part is added to a Sales order which is already at a matching flagged MRP status or when a sales order is moved to such a flagged status all order item parts MRP value is used for the sales order line MRP flag. See Sales Order Items form MRP? Field: -

The value in this column determines whether or not the order item is taken into account during Material Requirements Planning (MRP):

- A Y indicates that the item is to be taken into account.

- A blank column indicates that the item is not currently included in MRP calculations, but may possibly be included in the future.

- An N indicates that the order item should not be included in MRP. It will therefore be ignored by the Retrieve Sales Orders – MRP program.

Part MRP Flag

Inventory > Parts > Part Catalogue or

Production > Factory Modelling > Parts > Parts

Sales Order Statuses

Sales > Orders > Statuses for Orders > Statuses for Orders

You may tick as many sales order status as you require.

NB. “Allocate/Reserve?” is not used by this module.

Sales Order Items

The value from the entered Part defaults on to the Order line.
