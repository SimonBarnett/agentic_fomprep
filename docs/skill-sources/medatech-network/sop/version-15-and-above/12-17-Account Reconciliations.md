# 12-17-Account Reconciliations

- **Source:** `12-17-Account Reconciliations.pdf`

www.priority -software.com   
1/3 ‏Feb. 02, '15 Ver.02 Cat.No. A800037 
 
 SOP: Account Reconciliations 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To reconcile journal entries recorded for the same account. 
Working Assumption 
 The reconciliation method defined in the system is By Invoice (see Setups). 
Setups 
Defining the reconciliation method 
1. Enter the Financial Constants form and move to the AutoRecon constant. 
2. Make sure the constant is set to 2 (By Invoice). 
Setting up reconciliation adjustments 
1. Move to the MaxReconVar constant In the Financial Constants form. Specify the maximum 
variance allowed between the amount paid for an invoice and the invoice balance that still 
constitutes full reconciliation of  the invoice and payment. Such variance will be automatically 
transferred to a default Reconciliation Adjustments account. 
2. Enter the Default Accounts form and move to the Reconciliation Adjustments line. In the 
Account No. column, specify the GL account to which reconciliation variances will be 
transferred. The Account Description is filled in automatically. 
Defining automatic account reconciliation  
1. Enter the Reconciliation Codes form and define an appropriate code for your company: 
 Record a Reconcil'n Code.  
 Provide an easily recognizable Code Description. 
 Select the value A (for account reconciliation) in the Type of Reconcil'n column. 
2. Enter the Itemized Code sub-level form, and construct the reconciliation method in the following 
manner: 
 In the Reconc'n Method column, select the method to be used for reconciliations. 
 Specify the Range in Days for which to perform the reconciliations. 
 In the Num Chars to Compare column, specify the number of characters in the entry 
reference numbers to compare (e.g., the value "4" indicates that the first four characters from 
the left will be compared). 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Feb. 02, '15 Ver.02 Cat.No. A800037 
 
 Specify the Maximum Number of Items to compare. It is not recommended to specify more 
than two items in the case of automatic reconciliations performed solely by sum. 
Procedure 
Stage I: Clearing the Reconciliation Worksheet 
1. Enter the Reconciliation Worksheet form and retrieve all records with a number greater than 0 in 
the Reconciliation Num. column. 
2. Check all of the pending reconciliations to determine which to approve and which to cancel. 
3. To cancel a pending reconciliation: 
 Run the Cancel Pending Reconcil'ns program, designating the desired range reconciliation 
numbers in the input screen, or 
 Change the reconciliation number in the Reconciliation Worksheet to 0. 
Stage II: Automatic Reconciliation 
1. Run the Prepare for Reconciliation program. 
2. Run the Automatic Reconciliation program, selecting the appropriate reconciliation code. 
Stage III: Dealing with Reconciliations Created by the Program 
1. Enter the Reconciliation Worksheet form and retrieve all records with a number greater than 0 in 
the Reconciliation Num. column. 
2. Check all of the pending reconciliations created by the program to determine which of them are 
correct, or run the Pending Reconciliations report. 
3. To cancel erroneous pending reconciliations: 
 Change the reconciliation number in the Reconciliation Worksheet to 0. 
Note: This method is appropriate for a small number of cancellations. 
 Run the Cancel Pending Reconcil'ns program. 
4. Approve all correct reconciliations by running the Finalize Reconciliations program. 
5. If the Reconciliation Worksheet includes records that were not reconciled automatically, they 
should be reconciled manually. 
Stage IV: Manual Reconciliation 
1. Enter the Reconciliation Worksheet form. 
2. Enter the Entries for Reconciliation sub-level form. The form displays lines that are potentially 
reconcilable with the line in the upper-level form.  
3. Identify the appropriate line and record a number in the Reconciliation Num. column. Use a 
number that has not yet been used in the worksheet. 
Stage V: Reconciling Lines While Creating an Adjustment Entry 
1. Enter the Reconciliation Worksheet form. 
2. If you have not yet assigned numbers to the matching entries, do so now. 
3. Make sure your cursor is on one of the entries for which a variance exists between it and its 
matching entry.

www.priority -software.com   
3/3 ‏Feb. 02, '15 Ver.02 Cat.No. A800037 
 
4. Enter the Adjustment Entry Definitions sub-level form. 
5. Select the Account Number of the adjustment account. 
6. Specify the Transaction Date.  
7. The Reference Date and/or Due Date appear automatically. Revise as needed. 
8. You can also record: 
 A journal entry code (in the Transaction column of the References tab) 
 The relevant Cash Flow Code 
 A brief remark (in the Details column) 
 The relevant budget item (in the Budget tab) 
 A profit or cost center (in the Profit/Cost Center tab). 
9. Return to the upper-level form.  
Stage VI: Finalizing the Reconciliations 
 Run the Finalize Reconciliations program. 
Stage VII: Running Reports 
Run the following reports: 
 Unreconciled Entries: The report displays any entries that have not been properly reconciled. 
That is, it provides a bird's-eye view of the Unreconciled Transactions sub-level form (for a 
specific account). The report cannot be limited to a specific date range. 
 Open Transactions as of Date: The report displays unreconciled entries as of a designated date. 
 Final Reconciliations by Date: The report displays final reconciliations for selected accounts 
within a designated date range. 
 Final Reconciliations by Number: The report displays final reconciliations for selected accounts 
within a designated range of reconciliation numbers. 
Results 
 You can run up-to-date aging reports. Only unreconciled transactions will be displayed there. 
 You can easily view the state of a given account in its sub-level forms. The Reconciled 
Transactions form displays all reconciled entries, including their reconciliation number. In the 
Unreconciled Transactions form, you can change the Due Date of the entry, if necessary.
