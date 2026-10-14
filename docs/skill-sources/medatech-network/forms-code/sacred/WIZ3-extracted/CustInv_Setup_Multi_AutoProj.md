# CustInv_Setup_Multi_AutoProj

- **Source:** `CustInv_Setup_Multi_AutoProj.htm`

Customer Invoices - Multi-Shipment Setup: Preparing Invoices Automatically By Project 
 
 
- 
 
 
 

Setting the Project Transactions that are Invoiced Together 
 

When working with projects, you can bill customers for all types of transactions related to the project: customer shipments and returns, service calls, service contracts, reported project hours and expenses, and payments for finished products. 
 

Depending on the value of the OneInvPerPrj constant and whether the customer receives periodic invoices, the Prepare Invoices program automatically opens one of the following: 
 

 ·        one invoice for the whole project (constant = 1 ) 
 

 ·        one invoice per transaction type (constant = 0 , customer receives periodic invoices) 
 

 ·        one invoice for every shipping document (and return) plus one invoice per transaction type for every other type of transaction (constant = 0 , customer does not receive periodic invoices) 
 

 ·        one invoice per sales order and transaction type (constant = 2 ). 
 
## Notes:

 

 ·        When you choose the last option (per order), all transactions of the same type that are not linked to any order are included together in a separate invoice. 
 

 ·        If there are returns without shipments, a credit memo is created for the returns. 
 
## To set the constant:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the OneInvPerPrj constant and select the appropriate value.
