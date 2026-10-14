# ConAcc_3_exist_gl_to_cust

- **Source:** `ConAcc_3_exist_gl_to_cust.htm`

Converting Accounts - Converting a GL Account to an A/R Account 
 
 
- 
 
 
 
# Defining a GL Account to Serve Also as an A/R Account

 

If you wish to record customer invoices against a GL account, you need to open a new customer with the same number as the GL account and link this customer to this GL account. 
 
## Tip:

 

For details on how to create the GL account, run the Open GL Accounts Wizard . 
 
## Opening the Customer

 

 1 .  Enter the Chart of Accounts form and retrieve the desired GL account. Copy the account number ( Ctrl-C ). 
 

 2 .  Enter the Customers form and record a new customer whose number is identical to that of the GL account ( Ctrl-V to paste). Assign the customer any name you wish and record any other relevant customer data (e.g., address). 
 
## Linking the Customer to the GL Account

 

If the value of the IdentCustAcc constant (in the Financial Constants form) is 1, the new customer is automatically linked to the GL account. If the constant's value is 0, this link must be made manually. 
 
## To create the link:

 

 1 .  Enter the Financ. Parameters for Customers form and retrieve the customer you have opened. 
 

 2 .  Click the Customer tab. In the Account No. column, specify the GL account number in question.
