# Returned_Checks_Setup_EntryCode

- **Source:** `Returned_Checks_Setup_EntryCode.htm`

Returned Payments - Setup: Entry Code 
 
 
- 
 
 
 
# Revising the Entry Code

 

Normally, the entry code for returned payments debits the customer for the return fee. If, however, your company prepares invoices that charge each customer for the return fee, you need to revise the entry code so that the customer is not debited twice (once by the journal entry for the returned payment and once by the journal entry for the invoice). Instead, a special Return Fees account is used. 
 
## Before you begin:

 

 ·        Add the Return Fees expense account to the Chart of Accounts. 
 
## Tip: 

 

For details on opening accounts, run the Open GL Accounts Wizard . 
 
## To revise the entry code:

 

 1 .  Enter the Journal Entry Codes form and move to the line for Returned Payments ( RET ). 
 

 2 .  Enter the Entry Patterns sub-level form and change the last line, specifying the Return Fees account rather than A/R. 
 

 3 .  If you charge the customer directly, rather than debiting the Returned Payments Cashier , return to the upper-level form and do the same for the line for Payment Returns to Customers ( PRC ).
