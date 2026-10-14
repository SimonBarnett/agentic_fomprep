# ProForma_Setup_Branches

- **Source:** `ProForma_Setup_Branches.htm`

Cash-Based Accounting - Setting Up How Branches are Assigned 
 
 
- 
 
 
 
# Setting Up Automatic Branch Assignment

 

Whenever a pro forma invoice is opened, a branch is assigned automatically from one of several sources – the branch of the user recording the invoice, the branch of the customer for which it was opened, or the branch in the previous linked document (e.g., the order or service call). The InvoiceBranch constant determines the hierarchy that is used to assign the branch. 
 
## To set the constant value:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Set the value of the InvoiceBranch constant as follows: 
 

 ·      Specify 0 to use the hierarchy: branch in previous document; if none, then customer's branch; if none, then user's branch. 
 

 ·      Specify 1 to use the following hierarchy when invoices are opened manually: user's branch; if none, then branch in previous document; if none, then customer's branch. In invoices opened automatically, the branch will always be that of the user who ran the program; if the user has not been assigned a branch, no branch will appear in the invoices. 
 
## Notes:

 

 ·        The constant also affects how branches are assigned to all types of customer invoices. 
 

 ·        The constant has the following effect on pro forma invoices prepared automatically in a batch: If you assign a constant value of 0 , orders/service calls for different branches will generate invoices for different branches, even when they are for the same customer. If you assign a constant value of 1 , orders/service calls from the customer will be invoiced together, even if they were originally recorded for different branches.
