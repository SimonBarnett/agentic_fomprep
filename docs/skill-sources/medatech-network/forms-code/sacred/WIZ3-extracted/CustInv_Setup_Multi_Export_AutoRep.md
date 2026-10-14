# CustInv_Setup_Multi_Export_AutoRep

- **Source:** `CustInv_Setup_Multi_Export_AutoRep.htm`

Customer Invoices - Multi-Shipment Setup: Preparing Invoices Automatically By Sales Rep 
 
 
- 
 
 
 
# Preparing Invoices by Sales Representative

 

When working with sales representatives, you can decide whether to issue a separate periodic invoice for each sales representative involved in sales to a given customer, or include sales for all sales reps in the same invoice. 
 

Depending on the value of the OneInvPer SalesRep constant and whether the customer receives periodic invoices, the Prepare Invoices program automatically opens one of the following: 
 

 ·        one invoice for all sales reps (constant = 0 ). 
 

 ·        one invoice per sales representative (constant = 1 ). 
 
## Note: The number of invoices opened for the customer is also impacted (among other things) by the OneInvPerSite constant, which can be set to create one invoice per customer site . 

 
## To set the constant:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the OneInvPer SalesRep constant and select the appropriate value.
