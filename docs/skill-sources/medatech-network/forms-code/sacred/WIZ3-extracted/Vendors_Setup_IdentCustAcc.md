# Vendors_Setup_IdentCustAcc

- **Source:** `Vendors_Setup_IdentCustAcc.htm`

Open Vendors - Setup: The IdentCustAcc Constant 
 
 
- 
 
 
 
# The IdentCustAcc Constant

 

When a new vendor is recorded in the system, a corresponding A/P account must be opened in the ledger. Priority provides several methods for opening A/P accounts, corresponding to the settings of the IdentCustAcc constant. If you work with subsidiaries, this constant should already be set to either 1 or 2 . For more information, run the Subsidiaries Wizard . 
 

If you do not work with subsidiaries, leave the default value of 1 . Consequently, an A/P account will open automatically when a new vendor is recorded. Conversely, a vendor record will open automatically when you record a new A/P account. In both cases, the vendor number and A/P account number are identical. 
 

If your vendor records and their corresponding A/P accounts are not identically numbered, you need to enter the Financial Constants form and change the value of the constant to 0 . Consequently, you will need to open all records and accounts manually. 
 
## Notes:

 

 ·    If you work with customers that use a general A/R account per branch as opposed to their A/R accounts, the constant will be set to 3 . In this case, A/P accounts will be opened automatically, as occurs when the constant is set to 1 . 
 

 ·    The IdentCustAcc constant affects customer numbers and A/R accounts as well. For more information, run the Open Customers Wizard .
