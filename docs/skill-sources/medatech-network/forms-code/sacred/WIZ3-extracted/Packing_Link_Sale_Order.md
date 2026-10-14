# Packing_Link_Sale_Order

- **Source:** `Packing_Link_Sale_Order.htm`

Packing Slip - Linking a Packing Slip to a Sales Order 
 
 
- 
 
 
 
# Linking a Packing Slip to a Sales Order

 

There are several ways to record a packing slip and link it to a sales order: 
 

 ·        If each crate contains the goods needed to fill one or more complete sales orders, you can set up the system to itemize the packing slip automatically, with all of the ordered parts. 
 

 ·        If each crate only contains part of a specific order, and you want to determine which of the ordered parts are packed, you can specify the order in the packing slip, but record the items manually. The system will fill in the appropriate line number of each specified item in the original order. If the order balance is less than the quantity available for shipping, and there is another order for the same part, you can set up the system to open a second line for the surplus and link it to the second order. 
 

 ·        If you do not know which orders are to be filled by the parts in any crate, you can record the packing slip lines manually, and set up the system to fill in the appropriate order number and order lines. Again, if the order balance is less than the available quantity, and there is another order for the same part, you can set up the system to open another line for the second order. 
 
## To selected the desired option:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Check the value of the SAutoFindOrd constant and change it, if necessary. 
 
## Note:

 

This constant also affects shipping documents, sales invoices and warehouse transfers that are linked to sales orders.
