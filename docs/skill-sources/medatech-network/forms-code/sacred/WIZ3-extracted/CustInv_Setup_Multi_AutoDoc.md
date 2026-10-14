# CustInv_Setup_Multi_AutoDoc

- **Source:** `CustInv_Setup_Multi_AutoDoc.htm`

Customer Invoices - Multi-Shipment Setup: Preparing Invoices Automatically By Documents 
 
 
- 
 
 
 
# Setting How Documents are Invoiced

 

When you use the Prepare Invoices program to open invoices and credit memos for a batch of documents, you have the option, per customer, of: 
 

 ·        Preparing a single invoice/memo for each individual document (the default). 
 

 ·        Preparing three periodic invoices , one per type of document (for all customer shipments and returns; for all service calls; and for all service contracts), and one credit memo (for all returns if there are no shipments). 
 

You can also determine whether payment terms are taken from the original document (e.g., customer shipment) or from the customer for which the invoice is opened (which may be a separate billing customer). 
 
## To determine which payment terms are used:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the line for the InvoicePayTerms constant and set the appropriate value. 
 
## Note:

 

Payment terms for the customer are set in the Financial Constants form. 
 
## To set up periodic invoices:

 

 1 .  Enter the Financ. Parameters for Customers form and retrieve the desired customer.
 Note: Retrieve the customer for which invoices/memos will be recorded, whether it be the regular customer or the billing customer. 
 

 2 .  Click the Invoices tab and flag the Periodic Invoice column. 
 
## Notes:

 

 ·        If periodic invoices are recorded for the billing customer, all documents (of each type), and/or any line items in a document, recorded for any customer using this billing customer are charged together in the same invoice. 
 

 ·        Do not flag customers for periodic invoices if invoice dates are taken from the original document. 
 

 ·        Click for a detailed explanation of how billable documents are grouped together into periodic invoices.
