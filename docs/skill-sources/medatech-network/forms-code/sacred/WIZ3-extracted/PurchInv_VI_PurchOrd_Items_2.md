# PurchInv_VI_PurchOrd_Items_2

- **Source:** `PurchInv_VI_PurchOrd_Items_2.htm`

Purchase Invoices/Memos - Recording a Vendor Invoice Based On Purchase Orders.5 
 
 
- 
 
 
 

 5 .  If a lot number was specified, make sure its Expiration Date is correct.
 Note: The expiration date is filled in automatically according to the part's shelf life. Click for details. 
 

 6 .  The part is automatically received into the warehouse and bin recorded in the upper-level form (or the part's default bin, if one has been defined). Revise the Warehouse and Bin if necessary. 
 

 7 .   The Budget Item , if any, is filled in automatically from the purchase order, but may be revised. This value can be used to define the account to be charged for this purchase. 
 Note: To view information on usage of this budget item, enter the Budgeted vs. Actual sub-level form. 
 

 8 .  Check the Expense Account . Revise it if necessary. 
 

 9 .  If you want the corresponding line in the entry journal (created when the invoice is finalized) to belong to an Entry Item Group , specify the group code. 
 Note: Linking an entry item to a group facilitates data retrieval from the entry journal, as well as data sorting in the general ledger and in transaction reports. 
 

 10 .  Enter the Invoice Item - Remarks sub-level form and check the remarks recorded for the invoice item. Revise them if necessary.
 Note: The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable).
