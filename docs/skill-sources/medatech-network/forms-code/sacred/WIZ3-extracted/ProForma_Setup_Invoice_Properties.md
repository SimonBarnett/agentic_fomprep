# ProForma_Setup_Invoice_Properties

- **Source:** `ProForma_Setup_Invoice_Properties.htm`

Cash-Based Accounting - Defining Invoice Properties 
 
 
- 
 
 
 
# To define properties for pro forma invoices:

 

 1 .  Enter the Financial Documents form. 
 

 2 .  Move to the line for pro forma invoices, check the default properties and revise them if necessary. In particular: 
 

 ·      Post Journ. Entries : Determines whether a pro forma journal entry will be posted to the ledger automatically when the invoice is finalized. 
 

 ·      Round Price : Determines whether invoice prices are rounded to the nearest dollar or ten cents.
 Note: Click to set different values for different customers . 
 

 ·      Finalize Immediately : Determines whether the invoice, once opened, must be finalized before the user can leave the form.
 Note: If you flag this column, users will not be able to record temporary pro forma invoices. 
 

 ·      Cancel Reconcil ' n : Determines whether cancellation of a pro forma invoice also cancels any reconciliation already made with a customer receipt. 
 

 3 .  Use the Set Text for Document sub-level form to record set text that will appear in all printouts of pro forma invoices. Alternatively, to record set text that will appear in all pro forma invoices for specific branches and entry codes, move to the appropriate branch in the Journal Entry Codes per Branch form, and record the set text in the Set Text for Branch sub-level form. Any text recorded for a specific branch and entry code will override the default text for that document type. You can later change or delete this text for each individual invoice. 
 
## Notes: 

 

 ·      D ual-currency users: If you work in a language other than English you can record set text in English in the Set Text for Document - Lang2 sub-level form. You may also record set text for specific branches and entry codes by moving to the appropriate line in the Journal Entry Codes per Branch sub-level form, and recording the set text in the Set Text for Branch - Lang2 sub-level form. This text will appear in invoices to customers that have been defined to receive Printouts in Lang 2 (in the Customers form). 
 

 ·      For more information on document properties, run the Set Up Financial Docs Wizard .
