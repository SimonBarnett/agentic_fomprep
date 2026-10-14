# SOP Bank Reconciliations

- **Source:** `SOP Bank Reconciliations.pdf`

Cat.No.A7000243 1 Ver.2 – Jun.29,’08 
 
SOP: Bank Reconciliations* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The following explains how to reconcile bank statement items with journal entries that 
are recorded in Priority. 
Working Assumption 
 Bank accounts are defined in the system, together with any currencies of foreign 
accounts. 
Procedure 
Stage I: Recording Bank Statements 
1. Enter the Record Bank Statements form. 
2. Select the appropriate internal Bank Account Code. If this is the first statement for 
this account, record the Opening Balance. 
3. Enter the sub-level form, Itemized Statement, and record all items that appear on 
your bank statement. 
4. Select the desired Transaction Code. You can use the default Miscellaneous 
transaction.  
5. Record brief remarks in the Details column, describing each item, to facilitate 
reconciliations. 
Result: 
 Bank statements are ready for reconciliation. They are now stored in the system as 
unreconciled journal entries.  
Stage II: Performing Reconciliations 
1. Run the Prepare for Reconciliation program. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

2. Select the internal code of a single bank account. Also select a date and transaction 
code (the latter is optional). All unreconciled entries in the system that meet the 
criteria you have specified will be prepared in the work area. 
3. Choose between two types of reconciliations: automatic and manual. 
4. To perform automatic reconciliations:  
 Run the Automatic Reconciliation program. 
Result: The system "suggests" reconciliations between entries that ought to be 
reconciled with one another. At this stage, the reconciliations are only pending. 
 Enter the Reconciliation Worksheet form. Entries that were reconciled by the 
system have been assigned identical numbers in the Reconciliation Num. 
column. If the work area was "clean" before you started, the first number will be 
"1". 
 To approve a single reconciliation, move the cursor to one of the entries that share 
the same number and click Finalize Reconciliation from the list of Direct 
Activations. 
 To approve all reconciliations in the work area, run the Finalize Reconciliations 
program. 
Note: To omit a given set of entries, remove their reconciliation number from the 
work area before running the program. 
5. To perform manual reconciliations: 
 Enter the  Reconciliation Worksheet form. 
 
Move to the row of the entry you want to reconcile. 
 Enter the Entries for Reconciliation sub-level form. This form displays entries 
from the same ledger with sums equal to (or lower than) the amount appearing in 
the upper-level form. 
 Move to the appropriate line and assign the entry in question a Reconciliation 
Num. 
 Return to the upper-level form. The same number you have recorded in the sub-
level is allotted automatically to the entry in this form. 
 Enter the Reconciliation Status sub-level form. If there is variance between the 
two reconciled entries, it appears here. 
 If you want to transfer the variance to an adjustment account, enter the parallel 
sub-level form, Adjustment Entry Definitions, and specify the Account Number, 
Transaction Date and Due Date. 
Result: A journal entry is created that debits or credits the adjustment account with 
the sum of the variance. 
 Return to the upper-level form. 
 To approve a single reconciliation, move the cursor to one of the reconciled entries 
and click Finalize Reconciliation from the list of Direct Activations. 
 To approve all reconciliations in the work area, run the Finalize Reconciliations 
program. 
Cat.No.A7000243 2 Ver.2 – Jun.29,’08

Cat.No.A7000243 3 Ver.2 – Jun.29,’08 
Results: 
 Bank statement items are reconciled with journal entries in Priority . 
 The adjustment account is debited/credited for the variance in a journal entry. 
 In the Reconciled Transactions and Unreconciled Transactions sub-levels of the 
Chart of Accounts, you can see those entries for an account that have been 
reconciled and those that still need to be reconciled. 
Stage III: Canceling Pending and Final Reconciliations 
1. To cancel a pending reconciliation: 
 Enter the Reconciliation Worksheet form and move to the line you want to cancel. 
 Click Cancel Pending Reconcil'ns from the list of Direct Activations. 
2. To cancel a final reconciliation: 
 Run the Cancel Final Reconciliations program. 
 Select the internal bank account code and indicate the range of reconciliation 
numbers to cancel. 
Stage IV: Preparing Final Bank Reconciliations 
This stage allows you to view all journal entries reconciled with bank statement lines. 
1. Run the Prepare Final Reconciliations program. 
2. Select the internal bank account code and indicate the range of reconciled entries to 
prepare, based on their due dates. 
3. Enter the Final Reconciliations form. 
4. Use it to retrieve by reconciliation number, dates, references and/or bank account.
