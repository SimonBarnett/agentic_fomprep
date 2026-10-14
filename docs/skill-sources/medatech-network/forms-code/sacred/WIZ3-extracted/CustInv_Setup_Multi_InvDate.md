# CustInv_Setup_Multi_InvDate

- **Source:** `CustInv_Setup_Multi_InvDate.htm`

Customer Invoices - Multi-Shipment Setup: Setting Invoice Dates 
 
 
- 
 
 
 
# Setting Invoice/Memo Dates

 

When a multi-shipment invoice, credit memo or export invoice/memo is prepared automatically in a batch, the invoice/memo date can be taken either from the date of the original document on which the invoice is based, or from the date specified by the user when the Prepare Invoices program is run (the system default). 
 

When it is prepared by direct activation from within a document, the invoice/memo date can be taken either from the date of the document, or from today's date (the system default). 
 
## Note:

 

The invoice/memo date determines the reference date in the journal entry for the invoice/memo. It is also taken into account in calculating the payment date. 
 
## To copy the document date to invoices/memos:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the InvoiceDate constant and change its value to 1 . 
 
## Notes:

 

 ·        When invoices/memos are prepared for a project, their dates are always user-determined regardless of the value of the constant. 
 

 ·        Invoices for service contract payments and for periodic invoices (which bill multiple documents together) are always given the user-assigned invoice date or (if no date is input) the current date.
