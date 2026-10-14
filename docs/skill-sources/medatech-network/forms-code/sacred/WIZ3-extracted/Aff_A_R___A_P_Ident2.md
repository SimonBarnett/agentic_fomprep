# Aff_A_R___A_P_Ident2

- **Source:** `Aff_A_R___A_P_Ident2.htm`

Affiliates - Opening A/R and A/P Accounts.3 
 
 
- 
 
 
 
# Opening A/R and A/P Accounts in Multiple Subsidiaries

 

When the IdentCustAcc constant is set to 2 , a new A/R or A/P account is created automatically in the main company when you open a new customer or vendor record. You can then copy the new account to one or more subsidiaries. The subsidiary account credited/debited for a specific transaction is determined by the branch designated in the transaction document. 
 
## Before you begin:

 

 ·        Enter the Financial Constants form and set the IdentCustAcc constant to 2 . 
 

 ·        Enter the Subsidiaries form and click the Account Defs tab. Make sure that an Account Prefix or Account Suffix has been defined for each subsidiary. 
 

 ·        Run the Open Customers Wizard or the Open Vendors Wizard to open a new customer or vendor. 
 
## To copy A/R or A/P accounts to a subsidiary:

 

 ·        Run the Open Subsidiary Accounts program. In the form that opens, retrieve the main company accounts you want to copy, then exit the form. The new accounts will have the same numbers as the original accounts, with the addition of the prefix or suffix defined for the subsidiary to which they are being copied. 
 
## Note:

 

Click to set up journal entry codes for transactions that involve more than one subsidiary .
