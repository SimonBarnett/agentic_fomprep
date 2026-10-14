# 16-17-Starting to Work with Subsidiaries

- **Source:** `16-17-Starting to Work with Subsidiaries.pdf`

www.priority -software.com   
1/2 ‏Mar. 12,'15 Ver. 02 Cat.No. LB140043 
 
 SOP: Starting to Work with Subsidiaries 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To migrate Priority data from an existing company to subsidiary companies. 
Working Assumptions 
 Customers have been defined in the main company. 
 Vendors have been defined in the main company. 
 GL accounts have been defined in the main company. 
Procedure 
Stage I: Backing Up Company Data 
Note: This stage is relevant if transactions have already been recorded for the main company and 
you need to work continuously during migration of company data to subsidiaries. 
1. Enter Priority in the demo environment. 
2. Run the Copy Company program to back up all the data of the existing company, in case you 
need to restore the system to its current state. 
Important note: Make sure that no users are working in the current company before you run 
this program; ideally, run it after work hours.  
3. In the input screen, designate the full name of the existing company from which you are copying 
data in the Full Company Name column. Assign the new company a valid company code in the 
New Company column. In the New Co. - Full Name column, record the descriptive name that 
will appear in the menu of companies. 
Stage II: Opening Subsidiaries 
1. Enter the Chart of Accounts form and move to the Definitions for Transfer Account sub-level 
form to define a transfer account for each subsidiary. This account is used when creating journal 
entries, enabling you to balance the various accounts in transactions involving more than one 
subsidiary (e.g., a customer pays several invoices that were recorded by multiple subsidiaries). 
2. Enter the Subsidiaries form and define the desired subsidiaries. 
Note: Do not overwrite the predefined '000' company code (assigned to the main company). 
3. Click the Address and Phone tab and fill in the subsidiary's contact info. 
4. Dual-currency users: Click the Company Data tab, and designate the Company Number, 
File Number (Tax) and VAT Number. In the Company Status column, indicate the type of 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 ‏Mar. 12,'15 Ver. 02 Cat.No. LB140043 
 
company or VAT categorization (e.g., partnership, non-profit organization), which determines the 
type of VAT report to be filed. 
5. Click the Account Defs tab, and designate an Account Prefix and/or Account Suffix (e.g., 
001).  
Note: The prefix/suffix identifies the subsidiary to which each account belongs, when main 
company accounts are copied to subsidiaries. 
6. For each subsidiary, indicate the Transfer Account defined in step 1. 
7. Enter the Financial Constants form and change the value of the IdentCustAcc constant to 2. 
8. Enter the Branches form to link each branch to its subsidiary. Click the Financial Data tab and 
specify the Subsidiary to which to link the branch. 
Stage III: Initializing Subsidiary Data 
1. To link each employee to the appropriate subsidiary, enter the Company-Specific Information 
sub-level of the Personnel File form and indicate the Main Branch defined for the subsidiary in 
question. 
2. Run the Open Subsidiary Accounts for each subsidiary, indicating A/R Accounts as the 
Accounts to Copy. 
3. Run the Open Subsidiary Accounts for each subsidiary, indicating A/P Accounts as the 
Accounts to Copy. 
4. Run the Open Subsidiary Accounts for each subsidiary, indicating GL Accounts as the 
Accounts to Copy. 
5. Enter the Chart of Accounts form. Retrieve the bank and cashier accounts opened by the Open 
Subsidiary Accounts program and delete the value recorded in the Account in Main 
Company column. 
6. Enter the Cashiers form and open cashiers for each subsidiary. In the GL Account column, 
specify the subsidiary account to be linked to this cashier. In the Branch Code column, indicate 
the branch office that is linked to the subsidiary. 
7. Enter the Bank Accounts form and open bank accounts for each subsidiary. In the Branch Code 
column, indicate the branch office that is linked to the subsidiary. 
8. If transactions were recorded in the main company before you opened subsidiaries, run the 
Transfer Opening Balances program for each subsidiary. 
9. Enter the Journal Entry Codes form. For any entry codes that are likely to involve more than one 
subsidiary, flag the Auto Balance Affils column. 
Results 
 Once subsidiary accounts have been opened, A/R and A/P accounts are linked to the relevant 
customer and vendor records in each subsidiary, respectively. The new accounts have the same 
numbers as the original accounts, with the addition of the prefix or suffix defined for the 
subsidiary to which they are being copied. For example, if you have defined two subsidiaries 001 
and 002, two accounts will be created for customer number 555: 555-001 and 555-002. 
 In the chart of accounts, each new account is linked to the appropriate Subsidiary (e.g., 001) as 
well as the parallel Account in Main Company (e.g., 555). 
 When recording a financial document for a customer that is linked to a particular branch, the 
subsidiary account credited/debited in the journal entry is determined by the branch. For 
example, in an invoice recorded for customer 555 and linked to branch 001, the entry will debit 
the 555-001 account.
