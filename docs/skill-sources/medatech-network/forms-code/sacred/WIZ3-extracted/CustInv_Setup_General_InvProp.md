# CustInv_Setup_General_InvProp

- **Source:** `CustInv_Setup_General_InvProp.htm`

Customer Invoices - General Setup: Invoice Document Properties 
 
 
- 
 
 
 
# To define invoice/memo properties:

 

 1 .  Enter the Financial Documents form. 
 

 2 .  For each invoice type and credit memo, check the default properties and revise them if necessary. In particular: 
 

 ·              Post Journ. Entries : Determines whether a journal entry will be posted to the ledger automatically when the invoice/memo is finalized. 
 

 ·              Round Price : Determines whether invoice/memo prices are rounded to the nearest dollar or ten cents.
 Note: Click {bmctCHICLET.BMP} to set different values for different customers . 
 

 ·              Text from Order/Shp : Determines whether remarks are copied from the shipping/return document (if there is one) or the order (if there is not) into the invoice/memo. 
 Note: Remarks are taken from both the entire document and individual items. In the latter case, these only appear in printouts when a suitable print format is selected. 
 

 ·              Finalize Immediately : Determines whether the invoice or memo, once opened, must be finalized before the user can leave the form. 
 

 ·              Negative Sum Counter : Determines whether a document whose total sum is negative receives a separate numeration sequence than the same document with a positive total. When this property is flagged, a sales invoice with negative values becomes a credit memo (with the credit displayed as a positive number in the printout). 
 

 ·              Cancel Reconcil ' n : Determines whether cancellation of an invoice/memo also cancels any reconciliation involving the invoice/memo (generally, should not be flagged). 
 

 ·              Auth. Can't Finalize : Determines whether the last user to update the assigned user or status of an invoice/memo can also finalize the invoice/memo. 
 

 3 .  Use the Set Text for Document sub-level form to record set text that will appear in all printouts of this type of invoice or credit memo. You may also record set text for specific branches and entry codes by moving to the appropriate line in the Journal Entry Codes per Branch sub-level form, and recording the set text in the Set Text for Branch sub-level form. This will override any set text recorded for invoices or credit memos in general. In either case, remarks may be changed manually in individual documents. 
 
## Notes:

 

 ·        Dual-currency users: If you are working in a language other than English, you can record set text in English in the Set Text for Document - Lang2 sub-level form. You may also record set text for specific branches and entry codes by moving to the appropriate line in the Journal Entry Codes per Branch sub-level form, and recording the set text in the Set Text for Branch - Lang2 sub-level form. This text will appear in invoices or credit memos for customers that have been defined to receive Printouts in Lang 2 (in the Customers form). 
 

 ·        If text is copied from the order or shipping/return document (see above), it will appear together with the set text in the printout. 
 

 ·        For more information on document properties, run the Set Up Financial Docs Wizard .
