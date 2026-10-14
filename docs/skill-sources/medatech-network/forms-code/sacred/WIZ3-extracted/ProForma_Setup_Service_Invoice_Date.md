# ProForma_Setup_Service_Invoice_Date

- **Source:** `ProForma_Setup_Service_Invoice_Date.htm`

Cash-Based Accounting - Auto Invoice Preparation by Service Call/Contract.1 
 
 
- 
 
 
 
# Setting Up Automatic Invoice Preparation by Service Call/Contract

 

Pro forma invoices based on service documents can be prepared in a batch by the Prepare Pro Forma Invoices program, or one at a time by direct activation from within a specific document. If you prepare invoices in this manner, the following setups need to be performed (some only affect the Prepare Pro Forma Invoices program; some also affect the automatic preparation of multi-shipment invoices): 
 
## Invoice Date

 

When pro forma invoices are prepared in a batch, each on the basis of a single service call, the invoice date can be taken either from the date of the original call, or from the date specified by the user when the Prepare Pro Forma Invoices program is run (the system default). 
 

When a single pro forma invoice is prepared by direct activation from within a service call, the invoice date can be taken either from the call date or from today's date (the system default). 
 
## Notes:

 

 ·        The invoice date determines the reference date in the pro forma journal entry. It is also taken into account in calculating the payment date. 
 

 ·        Invoices for service contract payments, as well as pro forma invoices which bill multiple service calls together, are always given the user-assigned invoice date or (if no date is input) the current date. 
 

 ·        This definition does not affect the automatic preparation of multi-shipment invoices based on selected customer receipts. 
 
## To copy the service call date to the pro forma invoice:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the InvoiceDate constant and change its value to 1 .
