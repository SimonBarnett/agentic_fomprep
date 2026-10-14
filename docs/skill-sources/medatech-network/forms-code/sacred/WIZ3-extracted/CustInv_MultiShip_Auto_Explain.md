# CustInv_MultiShip_Auto_Explain

- **Source:** `CustInv_MultiShip_Auto_Explain.htm`

Customer Invoices - Periodic Invoice Explanation 
 
 
- 
 
 
 
# How Billable Documents are Grouped Together in Periodic Invoices

 

When a customer is flagged to receive a Periodic Invoice (in the Financ. Parameters for Customers form) and the customer's billable documents are invoiced automatically in a batch, documents are invoiced together based on their transaction type, the sales rep, the project they are assigned to and/or the original order (depending on how the Prepare Invoices program is run and how certain constants are set in the Financial Constants form). 
 

Beyond that breakdown of documents, a few additional conditions must be met in order for the documents to be billed together in the same invoice: 
 

 ·        They must have the same billing customer (or regular customer, if no billing customer has been defined). 
 

 ·        They must have the same tax code (for dual-currency users: VAT code). 
 

 ·        They must generate the same branch in the invoice (as determined by the InvoiceBranch constant).
