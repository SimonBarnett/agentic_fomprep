# 13-17-Open a Cashier

- **Source:** `13-17-Open a Cashier.pdf`

www.priority -software.com   
1/3 Feb. 04, '15 Ver03 Cat.No. A8000092 
 
 SOP: Opening and Initializing a Cashier 
Customer: Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up cashiers and define their contents before beginning to work with cashiers in the 
system. 
Procedure 
Stage I: Opening a Cashier Account 
1. Enter the Chart of Accounts form and press F4. 
Tip: For more details regarding the opening of accounts, see the relevant standard operating 
procedure. 
2. Fill in the Account No., Account Description and Currency. 
3. For dual-currency users: If the cashier is for multiple currencies, flag the Multiple Currencies 
column (in the General tab). It is advisable to use one cashier for the local currency and a 
separate one either for each foreign currency or for all foreign currencies together. 
4. Click the Report tab and fill in the Trial Bal Item and Bal Sheet/P&L Item columns. 
Stage II: Defining the Cashier 
1. Enter the Cashiers form. 
2. Fill in the Cashier Code and Cashier Description. 
3. In the GL Account column, select the account defined for the cashier.  
4. The Currency column is filled in automatically; make sure it is correct.  
Note for dual-currency users: It is advisable to use one cashier for the local currency and a 
separate one either for each foreign currency or for all foreign currencies together. 
5. By default, each check or credit card voucher that is deposited at the cashier is recorded as a 
separate entry item in the ledger. To record total deposits to the cashier as a single journal 
entry, flag the Receive/Dep Lump Sum column. 
Note: It is recommended not to flag this column, so as to facilitate reconciliations in case of a 
returned check, for instance. 
6. If the cashier is for a specific branch, specify its code in the Branch column. 
7. If the cashier is not in use and you do not want it to appear in Choose lists of cashiers, flag the 
Inactive column. 
8. Customer receipts are recorded by default for the pre-defined Main Cashier. If you want receipts 
of a particular payment means to be recorded automatically for the current cashier rather than 
the Main Cashier, enter the Payment Means form, move to the desired line and specify the 
                                                
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb. 04, '15 Ver03 Cat.No. A8000092 
 
cashier in the Cash/Bank/Credit Cd column. 
Note: Cash payments are an exception – you cannot define a different default cashier for them, 
as they are always recorded in the cashier defined in the receipt. 
Stage III: Initializing a Cashier 
Before beginning to work with cashiers in Priority, it is recommended to empty the cashiers that are 
in use. If you cannot empty them completely, record the opening balance of each cashier in order to 
initialize them for work in the system. This is done by recording the cashier’s contents as a customer 
receipt, using the “Opening Balances” account as the A/R account. Consequently, the cashier’s 
contents will be recorded in the ledger. 
1. Enter the Chart of Accounts form and retrieve the “Opening Balances” account. 
2. Copy the number of the account. 
3. Enter the Receipts form, and paste the number in the Customer’s Account column. 
4. In the Date column, specify the date you begin working in Priority (e.g., 12/31/08). 
5. Revise the Cashier column, as needed. Usually, it is the Main Cashier that is initialized. 
6. In the Cash Receipts column (in the Receipt Data tab), record the existing sum of cash in the 
cashier. 
7. To list checks, enter the Check Payment (Details) sub-level form. 
Note: There is no need to initialize bank transfers or credit card payments – the former are 
recorded directly in the bank, the latter are deposited on a daily basis. 
8. Select Finalize Receipt from the list of Direct Activations. The transfer transaction and cashier 
contents are recorded in the ledger. 
Note: If a journal entry has already been recorded for the cashier’s opening balance, recording a 
receipt in the above manner will duplicate the results. In such a case, be careful to record the 
initializing receipt for the cashier account and not the “Opening Balances” account. 
9. Dual-currency users: If, in addition to initialing the cashier, you want to update your customers’ 
liability (post-dated checks), perform the above process with the following changes: 
 In steps 1 and 2, retrieve and copy the customer account rather than the “Opening Balances” 
or cashier account. 
 Perform steps 3-5 as detailed above. 
 List the customer's checks as outlined in step 7. 
 The following step is highly sensitive - it is advisable to perform it with the assistance 
of a Priority implementor: In order not to change the customer’s account balance, make 
sure the receipt creates a journal entry that credits and debits the same account number:  
o Enter the Journal Entry Codes form and move to the REC (Receipts) entry code.  
o Save the definition of the entry pattern (e.g., in MS-Excel). 
o Make sure no users record a regular customer receipt in the system until the 
original pattern is restored. 
o Change the pattern so that the A/R account appears in both the credit and debit 
lines, and “Total amount” appears in the Description column in both lines. 
o When you are finished recording these special receipts, restore the original entry 
pattern.

www.priority -software.com   
3/3 Feb. 04, '15 Ver03 Cat.No. A8000092 
 
Result: The checks recorded in these special receipts will appear as customer liabilities in 
the Postdated Checks column of the Customer Credit form (sub-level of the Financial 
Parameters for Customers form), and will be listed in the Post-dated Checks sub-level of 
that form.
