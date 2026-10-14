# Cust_Setup_IdentCustAcc

- **Source:** `Cust_Setup_IdentCustAcc.htm`

Open Customers - Setup: The IdentCustAcc Constant 
 
 
- 
 
 
 
# The IdentCustAcc Constant

 

When a new customer is recorded in the system, or when a potential customer is converted to a regular one, a corresponding A/R account must be opened in the ledger. Priority provides several methods for opening A/R accounts, corresponding to the settings of the IdentCustAcc constant. If you work with subsidiaries, this constant should already be set to either 1 or 2 . For more information, run the Subsidiaries Wizard . 
 

If you do not work with subsidiaries, leave the default value of 1 . Consequently, an A/R account will open automatically when a new customer is recorded, or when a potential customer is converted to a regular one. Conversely, a customer record will open automatically when you record a new A/R account. In both cases, the customer number and A/R account number are identical. 
 

If you work with an exceptionally large amount of customers, you may want to set the constant to 3 . As a result, A/R accounts will not be opened automatically when a new customer is recorded, and instead, you'll be able to manage large numbers of customers using a general A/R account per branch. 
 

If your customer records and their corresponding A/R accounts are not identically numbered, you need to enter the Financial Constants form and change the value of the constant to 0 . Consequently, you will need to open all records and accounts manually. 
 
## Note:

 

The IdentCustAcc constant affects vendor numbers and A/P accounts as well. For more information, run the Open Vendors Wizard .
