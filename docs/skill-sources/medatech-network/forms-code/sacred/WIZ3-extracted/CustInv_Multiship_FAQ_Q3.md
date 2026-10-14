# CustInv_Multiship_FAQ_Q3

- **Source:** `CustInv_Multiship_FAQ_Q3.htm`

Customer Invoices - Multi-Shipment Invoices FAQ: One Invoice for All Customer Documents 
 
 
- 
 
 
 
# Opening an Invoice for All Customer Documents

 

Yes and No. You can set a customer parameter that causes the Prepare Invoices program to bill all open documents of the same type (customer shipments/returns, service calls, service contracts) together. 
 

 1 .  Enter the Financ. Parameters for Customers form. 
 

 2 .  Click the Invoices tab and flag the Periodic Invoice column. 
 

 3 .  Enter the Financial Constants form. 
 

 4 .  Make sure that the InvoiceDate constant is set at 0 . 
 
## Note:

 

 ·        A few conditions must be met in order for the documents to be billed together in the same invoice: 
 

 ·        They must have the same tax code (for dual-currency users: VAT code). 
 

 ·        They must generate the same branch in the invoice (as determined by the InvoiceBranch constant). 
 

 ·        They must be linked to the same project and order if the OneInvPerPrj constant is set to 2 .
