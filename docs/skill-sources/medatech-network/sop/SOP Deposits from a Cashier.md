# SOP Deposits from a Cashier

- **Source:** `SOP Deposits from a Cashier.pdf`

Cat.No.LB130003 1 Ver.1 – Jan. 13, ’13 
 
SOP: Deposits from a Cashier* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record deposits, manually or automatic ally in batch, whenever cash, checks or 
credit card slips are transferred from a given cashier to a bank account, a credit card 
company, another cashier or other accounts. 
Setups 
 Define a BPM workflow for deposits (by recording statuses in the appropriate BPM 
flowchart). 
 
Define cashiers (see the relevant Standard Operating Procedure) 
 Define banks and bank accounts (see the relevant Standard Operating Procedure). 
 Define credit card companies (see the relevant Standard Operating Procedure). 
 Define banknotes and coins in the Banknotes and Coins form. 
Procedure 
Stage I: Opening a Deposit Slip Manually 
Aim: To open a single pending deposit slip for cash, checks or credit card slips from a 
given cashier to a bank account, a credit card company, another cashier or another 
account. 
1. Enter the Deposit Slips form. 
2. Record the Date of the deposit. 
3. The Main Cashier code appears by default in the From Cashier column. Revise as 
needed. 
4. In the To Cash/Bk/CredCd column, specify the cashier, bank account or credit card 
company to which the deposit is being made. The Currency column is filled in 
automatically. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

5. If the deposit is to a customer or employee, or if it entails endorsement of a check to 
a third party, record the relevant account in the To A/R Account column (in the 
Sums tab). 
6. Click the References tab and specify the Branch from which the deposit is being 
made. If the From Cashier is linked to a branch, its code appears automatically. 
7. Record a brief remark regarding the deposit in the Details column. 
8. To deposit cash, record the amount in the Cash Deposit column (in the Sums tab). 
Alternatively, you can specify the quantities of banknotes and coins included in this 
deposit in the Banknotes and Coins in Deposit sub-level form. 
Note: To make sure there is enough cash to cover the deposit, you can select 
Check Cashier Balance from the list of Direct Activations. 
9. To deposit checks or credit card slips: 
a. For dual-currency users: If the check is postdated, flag the Postdated 
Checks column (in the Sums tab). 
b. Enter the Items at Cashier sub-level form. This form lists the cash, checks and 
credit card slips that are currently at the cashier. For each check or credit card 
slip that you want to deposit, flag the Deposit column. You can also flag a given 
item in the Checking column, to prevent it from being deposited inadvertently. 
c. Enter the parallel Deposited Items sub-level form. This form displays all of the 
checks/credit card slips that were flagged for deposit. 
Note: If a Max Itms per Deposit is defined for this account (in the Bank 
Accounts form), this value determines the maximum number of items which 
may be included in the deposit slip. 
d. Make sure the data in the deposit form is correct. 
e. If you detect errors in the check information (e.g., check number, payment 
date), enter the Revision of Checks form and make the necessary changes 
before completing the deposit. 
10. If you want to check the deposit before it is finalized, return to the upper-level form 
and change the Status to "Checking" (in the References tab). Documents with this 
status cannot be finalized. Specify the person responsible for checking the deposit in 
the Assigned to column. 
Note: Until the deposit is finalized, the payments will continue to appear in the cashier 
contents, but cannot be recorded in another deposit slip. 
Stage II: Recording a Deposit Slip Automatically for a Batch of 
Deposits 
Aim: To open a batch of pending deposit slips for checks or credit card slips (and cash) 
from a given cashier to a bank account, a credit card company, another cashier or 
another account. 
1. Run the Prepare Deposit Slip program. 
2. Fill in the relevant details in the input screen: From Cashier, To Cash/Bank/Cred 
Cd, and the range of payment dates to include in the deposit. You can also fill in the 
To Payment Date and Max Number of Lines columns without defining a start date. 
Cat.No.LB130003 2 Ver.1 – Jan. 13, ’13

When the program finishes running, a notification appears, displaying the number of 
the temporary deposit slip that was opened. 
3. Enter the Deposit Slips form and retrieve the document opened by the program, 
using the document number displayed when the program finished running. 
4. To include a cash deposit, specify the sum in the Cash Deposit column. 
5. Enter the Items at Cashier sub-level form and check the deposit details. If the 
cashier contains checks or credit card slips that you do not want to include, move to 
the item in question and remove the check mark from the Deposit column. 
6. Return to the upper-level form. Dual-currency users: If you chose a deposit date in 
the future (later than today), flag the Postdated Checks column in the Sums tab. 
7. You can run the Bank Deposits report in order to view the deposits made to a given 
bank within a designated range of dates. 
Stage III: Approving a Deposit Slip via Another User 
Aim: To have another user approve a deposit slip so that it may be finalized. 
Note: If your company does not require that an additional user approve a deposit slip 
before it may be finalized, you may skip this stage. 
To assign the deposit slip to another user for approval: 
1. Enter the Deposit Slips form and retrieve the document in question. 
2. Assign the document to the user who needs to approve it by selecting their user 
name in the Assigned to column. 
To approve deposit slips assigned to you: 
1. Enter the Deposit Slips form and retrieve all pending documents assigned to you. 
2. Change the status of each document to “Approved”. 
3. If it is company policy to have a third user finalize the document, transfer each 
deposit slip to a third user by selecting their user name in the Assigned to column. 
Otherwise, move directly to Stage IV. 
Notes: 
 To restrict deposit slips from being finalized by the user who created them, enter the 
Financial Documents form and make sure that Disallow Single User is flagged for 
the Deposit line. 
 To additionally require that a third user finalize the deposit slip after the second user 
approves it, flag Auth. Can't Finalize as well. 
Stage IV: Finalizing and Printing the Deposit Slip 
Aim: To finalize and print deposit slips. 
After checking the deposit slip, you should finalize it and print it by Direct Activation, in 
order to avoid having to check it again as you continue working. 
1. Enter the Deposit Slips form and retrieve the desired document. 
Cat.No.LB130003 3 Ver.1 – Jan. 13, ’13

Cat.No.LB130003 4 Ver.1 – Jan. 13, ’13 
2. To finalize the deposit slip, select Finalize Deposit Slip  from the list of Direct 
Activations. 
3. To print the deposit slip, select Print Deposit Slip from the list of Direct Activations. 
Stage V: Canceling a Final Deposit Slip 
1. Enter the Deposit Slips form and retrieve the desired document. 
2. Select Cancel Document (Original Date) or Cancel Document (Today's Date) 
from the list of Direct Activations. These programs create a cancellation entry in the 
entry journal for the original date of the deposit slip or today's date, respectively. 
3. To cancel a final deposit slip whose journal entry has not yet been posted, post the 
entry before running the cancellation program. 
Notes: 
 Both the cancellation document and the original canceled document are 
automatically flagged in the Canceled column (in the Sums tab), and display the 
same sum, positive in the original and negative in the cancellation document. 
 To cancel a single item in a final deposit slip, enter the slip, move to the line in 
question and select Cancel Deposit Item from the list of Direct Activations. 
Stage VI: Deleting a Pending Deposit Slip 
1. Enter the Deposit Slips form and retrieve the desired document. 
2. Select Delete Pending Deposit Slip from the list of Direct Activations. 
Results 
 Deposits from a cashier to a bank account or other cashier update the balances in 
the cashiers and account involved in the deposits. 
 The contents of the cashier are emptied. 
 A journal entry is recorded for each deposit.
