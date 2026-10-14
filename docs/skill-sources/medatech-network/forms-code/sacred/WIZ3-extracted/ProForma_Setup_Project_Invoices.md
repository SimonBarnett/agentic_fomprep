# ProForma_Setup_Project_Invoices

- **Source:** `ProForma_Setup_Project_Invoices.htm`

Cash-Based Accounting - Setting Up for Auto Preparation by Project.1 
 
 
- 
 
 
 
# Setting Up Automatic Invoice Preparation by Project

 

You can bill customers for all types of transactions related to a project: reported project hours and project payments, as well as service calls and contract payments linked to the project. 
 

Depending on the value of the OneInvPerPrj constant, the Prepare Pro Forma Invoices program automatically opens one of the following: 
 

 ·        one invoice for the whole project (constant = 1 ) 
 

 ·        one invoice per transaction type (constant = 0 ) 
 

 ·        one invoice per sales order and transaction type (constant = 2 ). 
 
## Notes:

 

 ·        When you choose the last option (per order), all transactions of the same type that are not linked to any order are included together in a separate invoice. 
 

 ·        The values of the OneInvPerSalesRep and OneInvPerSite constants also affect how the invoices are prepared. Click ProForma_Setup_Auto_Invoices for a detailed explanation ProForma_Setup_Auto_Invoices 
 

 ·        The values of all three constants also affect the automatic preparation of multi-shipment invoices. 
 

 ·        Click for a detailed explanation of how billable documents are grouped together into periodic invoices. 
 
## To set the constant:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the OneInvPerPrj constant and select the appropriate value.
