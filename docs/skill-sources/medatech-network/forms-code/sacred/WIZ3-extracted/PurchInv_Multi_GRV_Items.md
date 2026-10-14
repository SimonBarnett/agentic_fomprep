# PurchInv_Multi_GRV_Items

- **Source:** `PurchInv_Multi_GRV_Items.htm`

Purchase Invoices/Memos - Recording a Multi-GRV Invoice Based on GRVs.4 
 
 
- 
 
 
 
# To check itemization:

 

 1 .  Enter the Invoice Items sub-level form. 
 

 2 .  For each item, make sure that the Inv. Quantity , Unit Price and Item Discount are correct. If not, revise them, and the resulting discrepancy will be reflected in the Diff. In Price column in the upper-level form. The item's Extended Price is filled in automatically, as well as the total Amount Owing in the upper-level form.
 Note: The source of the unit price is determined by a system constant. Explanation . 
 

 3 .   The Budget Item , if any, is filled in automatically from the GRV, but may be revised. This value can be used to define the account to be charged for this shipment. 
 Note: To view information on usage of this budget item, enter the Budgeted vs. Actual sub-level form. 
 

 4 .  Check the Expense Account . Revise it if necessary. 
 

 5 .  Click to link the line item to a project or project activity . 
 

 6 .  Enter the Invoice Item - Remarks sub-level form and check the remarks recorded for the invoice item. Revise them if necessary.
 Note: The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable).
