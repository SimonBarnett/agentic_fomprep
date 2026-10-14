# ConAcc_5_exist_gl_to_ven

- **Source:** `ConAcc_5_exist_gl_to_ven.htm`

Converting Accounts - Converting a GL Account to an A/P Account 
 
 
- 
 
 
 
# Defining a GL Account to Serve Also as an A/P Account

 

 Priority offers the option of defining a GL account so that it also serves as an A/P account. You do so by opening a new vendor with the same number as the GL account and linking this vendor to this GL account. 
 
## Tip:

 

For details on how to create the GL account, run the Open GL Accounts Wizard . 
 
## Opening the Vendor

 

 1 .  Enter the Chart of Accounts form and retrieve the desired GL account. Copy the account number ( Ctrl-C ). 
 

 2 .  Enter the Vendors form and record a new vendor whose number is identical to that of the GL account ( Ctrl-V to paste). Assign the vendor any name you wish and record any other relevant vendor data (e.g., address). 
 
## Linking the Vendor to the GL Account

 

If the value of the IdentCustAcc constant (in the Financial Constants form) is 1, the new vendor is automatically linked to the GL account. If the constant's value is 0, this link must be made manually. 
 
## To create the link:

 

 1 .  Enter the Financial Parameters for Vendors form and retrieve the vendor you have opened. 
 

 2 .  Click the General tab. In the Account No. column, specify the GL account number in question.
