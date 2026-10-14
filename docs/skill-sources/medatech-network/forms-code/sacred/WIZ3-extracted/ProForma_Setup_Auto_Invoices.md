# ProForma_Setup_Auto_Invoices

- **Source:** `ProForma_Setup_Auto_Invoices.htm`

Cash-Based Accounting - Setting Up for Auto Preparation of Invoices 
 
 
- 
 
 
 
# Setting Up Automatic Invoice Preparation

 

The OneInvPer SalesRep and OneInvPerSite constants are used to control the resolution of invoice generation. If either constant is enabled, one invoice per customer per sales rep or one invoice per customer per site will be generated when the Prepare Pro Forma Invoices program is run. If both constants are enabled, the system will generate one invoice per customer site per sales rep: 
 

 OneInvPerSalesRep : 
 

 ·        one invoice for all sales reps (constant = 0 ) 
 

 ·        one invoice per customer per sales rep (constant = 1 ) 
 

 OneInvPerSite : 
 

 ·        one invoice for all customer sites (constant = 0 ) 
 

 ·        one invoice per customer site (constant = 1 ) 
 
## Notes:

 

 ·        The value of the constant also affects the automatic preparation of multi-shipment invoices. 
 

 ·        Click for a detailed explanation of how billable documents are grouped together into periodic invoices. 
 
## To set the constant(s):

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the OneInvPer SaleRep or OneInvPerSite constant and select the appropriate value.
