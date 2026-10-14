# PurchInv_Credit_Over_Items

- **Source:** `PurchInv_Credit_Over_Items.htm`

Purchase Invoices/Memos - Recording a Credit Memo for Overcharging.3 
 
 
- 
 
 
 
# To itemize the memo:

 

 1 .  Enter the Invoice Items sub-level form. 
 

 2 .  Do one of the following: 
 

 ·              Record the details of the credited items as they appear in the vendor's credit memo.
 OR 
 

 ·              Specify a non-inventory part defined specifically for miscellaneous purposes (e.g., the predefined “000” part), and change its Part Description to “Overcharge.” Record an Invoice Quantity of 1 and record the full amount of received credit in the Unit Price column. 
 

 Note: Click to define a general-purpose non-inventory part . 
 

 3 .  For each line item, flag the Credit Only column. 
 

 4 .  If necessary, specify a Budget item . 
 

 5 .  Check the Expense Account . Revise it if necessary. 
 

 6 .  If you want the corresponding line in the entry journal (created when the memo is finalized) to belong to an Entry Item Group , specify the group code. 
 Note: Linking an entry item to a group facilitates data retrieval from the entry journal, as well as data sorting in the general ledger and in transaction reports. 
 

 7 .  Click to link the line item to a project or project activity . 
 

 8 .  Enter the Invoice Item - Remarks sub-level form and check the remarks recorded for the memo item. Revise them if necessary.
 Note s : 
 

 ·      Any part remarks recorded in the part catalogue appear in this form automatically if Copy Part Remarks has been flagged for multi-GRV invoices (in the Copy Part Remarks to Document form). 
 

 ·      The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable).
