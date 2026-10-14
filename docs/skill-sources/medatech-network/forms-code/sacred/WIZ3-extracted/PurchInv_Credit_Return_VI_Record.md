# PurchInv_Credit_Return_VI_Record

- **Source:** `PurchInv_Credit_Return_VI_Record.htm`

Purchase Invoices/Memos - Recording Credit for Returned Goods in a Vendor Invoice.1 
 
 
- 
 
 
 
# Recording Credit for Returned Goods in a Vendor Invoice

 

You can record returns in a vendor invoice that also records the receipt of goods. The cost of the returned goods is deducted from the total price of the invoice, and the goods are removed from inventory. 
 

 1 .  Enter the Vendor Invoices form and retrieve a pending vendor invoice recorded for the vendor that is crediting you. 
 

 2 .  Enter the Invoice Items sub-level form. 
 

 3 .  For each returned item, open a new line and record the number of units you are returning in the Invoice Quantity column, using negative values. 
 

 4 .  Check the Unit Price and revise if necessary. 
 

 5 .  If you want the corresponding line in the entry journal (created when the invoice is finalized) to belong to an Entry Item Group , specify the group code. 
 Note: Linking an entry item to a group facilitates data retrieval from the entry journal, as well as data sorting in the general ledger and in transaction reports. 
 

 6 .  Click to link the line item to a project or project activity . 
 

 7 .  Enter the Invoice Item - Remarks sub-level form and check the remarks recorded for the memo item. Revise them if necessary.
 Note: The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable).
