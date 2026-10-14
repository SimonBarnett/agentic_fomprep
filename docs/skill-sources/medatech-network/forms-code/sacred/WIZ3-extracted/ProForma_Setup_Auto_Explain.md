# ProForma_Setup_Auto_Explain

- **Source:** `ProForma_Setup_Auto_Explain.htm`

Cash-Based Accounting - Periodic Invoice Explanation 
 
 
- 
 
 
 
# How Billable Documents are Grouped Together in Periodic Invoices

 

When a customer is flagged to receive a Periodic Invoice (in the Financ. Parameters for Customers form) and the customer's billable documents are invoiced automatically in a batch, documents are invoiced together based on the project they are assigned to, their sales rep, their customer site, their original order and/or their transaction type (depending on how the Prepare Pro Forma Invoices program is run and how the OneInvPerPrj , OneInvPerSalesRep and OneInvPerSite constants are set in the Financial Constants form). 
 

Beyond that breakdown of documents, a few additional conditions must be met in order for the documents to be billed together in the same pro forma invoice: 
 

 ·        They must have the same billing customer (or regular customer, if no billing customer has been defined). 
 

 ·        They must have the same tax code. 
 

 ·        They must generate the same branch in the invoice (as determined by the InvoiceBranch constant). 
 

 ·        Dual-currency users: For contract payments, they must have the same credit card or bank account defined for standing orders.
