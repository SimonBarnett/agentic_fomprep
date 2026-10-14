# SalesOrd_blanket_full_itemize_1b

- **Source:** `SalesOrd_blanket_full_itemize_1b.htm`

Sales Orders - Recording an Order by Copying a Blanket Order.5 
 
 
- 
 
 
 

 5 .  Make sure that the Due Date is correct for each item.
 Tip: To check part availability, use the Inventory for Part and the Part Availability sub-level forms. 
 

 6 .  If you are working with order item statuses, choose the desired Status . 
 

 7 .  If you want this particular order item to be disregarded when calculating customer credit, remove the check mark from the Consider Credit column.
 Note: If the entire order is disregarded (as defined in the upper-level form), a check mark will not appear. 
 

 8 .  If you will be billing the order in a multi-shipment invoice, and you want the order item to be billed to a third party rather than the customer's usual billing customer (or the one specified for this entire order), choose the desired Billing Customer . The invoice for the ordered part will consequently debit the account of that third party.
 Note: If a third-party customer was recorded for this line in the blanket order, it is automatically copied to the order item. 
 

 9 .  Click if this order calls for special components (custom BOM). Example. 
 Notes: 
 

 ·              If you make any changes in the BOM, these will affect the order item's price and cost, with two exceptions:
1) If they were recorded manually, the only way to change them is by selecting Calculate Price/Cost by BOM from the list of Direct Activations .
2) If the SBOMPrice constant is set to 0 , the item's price will not be affected, even by running Calculate Price/Cost by BOM . 
 

 ·              Before printing the order, select the With Custom BOM print format.
