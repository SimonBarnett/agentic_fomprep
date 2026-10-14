# SOP Credit Card Reconciliation

- **Source:** `SOP Credit Card Reconciliation.pdf`

Cat.No. LB10000111 1 Ver.1 – June 1,’10 
 
SOP: Credit Card Reconciliation* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To reconcile the entries in your credit card statement against journal entries recorded 
in Priority. 
Working Assumptions 
 Credit card companies and the necessary transaction currencies have been defined 
in the system. 
 A credit card account has been defined using the account number of the matching 
A/P account. 
Procedure 
Stage I: Manually Recording a Credit Card Statement 
1. Enter the Record Credit Card Statements form. 
2. To itemize an existing statement, retrieve the statement by year and/or statement 
number and proceed to step  4. 
3. 
To record a new statement, select the desired account code. The Year and 
Statement Number are filled in automatically with the current fiscal year and the 
next consecutive statement number for this credit card account, respectively. Revise 
as necessary. 
Note: The Fee (%) column is filled in automatically with the percentage of payment 
that the credit card company charges as its fee (as defined in the Credit Card 
Accounts form). 
4. Move to the Itemized Statement sub-level form. 
5. Record all transactions from the credit card statement, one per line. For each item, 
indicate the following: 
 Due Date 
 Reference (if any) 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

 Gross Sum – the amount billed to the credit card. The Commission and Net Sum 
are filled in automatically based on this amount. 
 Details – a brief comment relevant to the transaction. This can later be used to 
facilitate reconciliation of this item. 
Stage II: Recording a Vendor Invoice for Credit Card Fees 
1. Enter the Vendor Invoices form. 
2. Record a new invoice, indicating the A/P account defined for the credit card 
company. Itemize the invoice with the commission fees recorded in the itemized 
credit card statement. 
Note: For detailed instructions on recording a vendor invoice, see the relevant SOP. 
Stage III: Preparing to Reconcile the Credit Card Account 
 Run the Prepare for Reconciliation for the credit card account to be reconciled. 
Result 
 
Unreconciled journal entries and statement items recorded against this account are 
loaded into the Reconciliation Worksheet. 
Stage IV: Automatically Reconciling the Credit Card Account 
1. Run the Automatic Reconciliation program. In the input screen, select the desired 
reconciliation code. The system automatically matches items in the Reconciliation 
Worksheet, using the designated reconciliation code. Such reconciliations are 
considered pending until they have been finalized. 
2. Enter the Reconciliation Worksheet. 
3. Review the results and make sure the suggested reconciliations are correct. 
Successfully matched journal entries and statement items are assigned the same 
reconciliation number. If no prior reconciliations were recorded in the worksheet 
before the Automatic Reconciliation program was run, numeration starts at 1. 
4. To finalize an individual reconciliation, move to one of the reconciled items and 
select the Finalize Reconciliation program from the list of Direct Activations. 
5. To finalize all reconciliations in the worksheet, run the Finalize Reconciliations 
program. 
Note: To avoid finalization of individual transactions, replace the reconciliation 
number with 0 in all the involved lines before running the program. 
6. If one or more entries have not been reconciled, continue to Stage V. 
Stage V: Manually Reconciling the Credit Card Account 
1. Enter the Reconciliation Worksheet. 
2. Move to the item you want to reconcile. 
3. Enter the Entries for Reconciliation sub-level form. The items appearing here are 
potential matches for the item selected in the upper-level form. The order of the 
items is arranged to assist you in matching transactions quickly and easily (e.g., a 
Cat.No. LB10000111 2 Ver.1 – June 1,’10

statement item for the same amount as the entry in the upper-level form will appear 
in the first line). 
4. Find the matching item. In the Reconciliation Num. column, assign it the first 
consecutive number that has not yet been used. 
Note: If you have recorded one or more invoices for credit card fees, these should 
be included in the reconciliation. 
5. Return to the upper-level form. The reconciliation number indicated in the sub-level 
form is assigned automatically to the item in the upper-level form. 
6. Enter the Reconciliation Status sub-level form to check whether there is any 
Difference between the entry amount and the statement amount to be reconciled 
(i.e., the matched items are not balanced). To reconcile this difference, do the 
following: 
a. Move to the parallel Adjustment Entry Definitions sub-level form. 
b. Specify the account in which the adjustment is to be recorded (i.e., your 
bank account). 
c. Indicate the Transaction Date and Due Date to be assigned to the 
adjustment entry. 
Note: Once the reconciliation is finalized, an adjustment entry will be 
created that debits or credits the bank account. 
7. Return to the upper-level form. 
8. To finalize an individual reconciliation, move to one of the reconciled items and 
select the Finalize Reconciliation program from the list of Direct Activations. 
9. To finalize all reconciliations in the worksheet, run the Finalize Reconciliations 
program. 
Results 
 
The entries in your credit card statement have been reconciled against journal 
entries recorded in Priority. 
 Your bank account has been debited/credited by a journal entry for any variance. 
Stage VI: Canceling Reconciliations 
To cancel a pending reconciliation: 
1. Enter the Reconciliation Worksheet and move to any one of the reconciled items to 
be canceled. 
2. Select Cancel Pending Reconcil'ns from the list of Direct Activations. 
Tip: To cancel a batch of pending reconciliations within a specified range, run the 
Cancel Pending Reconcil'ns program from the menu. 
To cancel a final reconciliation: 
1. Run 
the Cancel Final Reconciliations program. 
2. Indicate the relevant account code and the range of reconciliation numbers to be 
canceled. 
Cat.No. LB10000111 3 Ver.1 – June 1,’10

Cat.No. LB10000111 4 Ver.1 – June 1,’10 
Stage VII: Viewing Final Reconciliations 
Aim: To view reconciled journal entries and statement items. 
1. Run the Prepare Final Reconciliations program. 
2. Indicate the account code and range of dates for which to prepare reconciliations. 
3. Enter the Final Reconciliations form. 
4. Retrieve reconciled journal entries and statement items using any of the form 
columns (e.g., Bank/Credit Cd Acc't or Recon Num).
