# SalesOrd_pq_full_itemize_1b

- **Source:** `SalesOrd_pq_full_itemize_1b.htm`

Sales Orders - Recording an Order by Copying a Price Quote.4 
 
 
- 
 
 
 

 6 .  If you are working with order item statuses, choose the desired Status . 
 

 7 .  If you want this particular order item to be disregarded when calculating customer credit, remove the check mark from the Consider Credit column.
 Note: If the entire order is disregarded (as defined in the upper-level form), a check mark will not appear. 
 

 8 .  If you will be billing the order in a multi-shipment invoice, and you want the order item to be billed to a third party rather than the customer's usual billing customer (or the one specified for this entire order), choose the desired Billing Customer . The invoice for the ordered part will consequently debit the account of that third party. 
 

 9 .  If the part requires special components (a customized bill of materials), enter the BOM for Order Item sub-level form. The custom BOM recorded in the quote appears automatically. Make any necessary adjustments to it.
 Notes: 
 

 ·              If you make any changes in the BOM, these will affect the order item's price and cost, with two exceptions:
1) If they were recorded manually, the only way to change them is by selecting Calculate Price/Cost by BOM from the list of Direct Activations .
2) If the SBOMPrice constant is set to 0 , the item's price will not be affected, even by running Calculate Price/Cost by BOM . 
 

 ·              Before printing the order, select the With Custom BOM print format.
