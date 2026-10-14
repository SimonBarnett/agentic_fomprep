# 14-17-Reconciliation with Paper Statements

- **Source:** `14-17-Reconciliation with Paper Statements.pdf`

www.priority -software.com   
1/2 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110027 
 
 SOP: Reconciliation with Paper Statements 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The following explains how to reconcile bank statements with journal entries that are recorded in 
Priority, without first recording the statement in the system. 
Working Assumption 
 Unreconciled journal entries have been recorded for the bank account for which the paper 
statement was issued. 
Procedure 
Stage I: Performing Reconciliations 
1. Run the Prep for Recon. w/Paper Statemt program. 
2. In the program's input, indicate the following: 
 The internal code of the relevant bank account 
 The range of dates which the statement covers 
 The opening and closing balances appearing on the statement 
 The statement number and the year in which the statement was prepared. 
3. Enter the Reconcil Work Area-Paper Statemt form. 
4. Move to the Entries to Reconcile sub-level form.  
5. For each entry to be reconciled with the current bank statement, flag the Reconcile column. 
Result: The following columns are updated automatically in the upper-level form: 
 ClosingBal in Ledger - This balance is calculated by adding the amount of the entries that 
are flagged for reconciliation to the opening balance in the ledger. 
 Flagged for Reconcil - The total amount of those journal entries that have been flagged for 
reconciliation with the current statement. 
 Total Reconc Amount - The total amount of the journal entries to reconcile with the current 
statement (i.e., the amount flagged for reconciliation plus the amount already reconciled, as 
displayed in the parallel sub-level form, Reconciled Entries-Paper Statemt). 
6. Return to the upper-level form.  
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110027 
 
7. To view a report displaying the journal entries that appear in the Entries to Reconcile sub-level 
form, select Entries in Reconcil Work Area from the list of Direct Activations and choose 
whether to view all entries or only those that are flagged for reconciliation. 
8. Select Finalize Recon. w/Paper Statemt from the list of Direct Activations. 
Results 
 Bank statement items are reconciled with journal entries in Priority. 
 The reconciled entries are deleted from the Entries to Reconcile sub-level form and appear 
instead in the parallel Reconciled Entries-Paper Statemt sub-level form. 
 A bank statement is created based on the final reconciliations and can be viewed in the 
Reconciled Paper Statements form. 
Stage II: Canceling Pending and Final Reconciliations 
 To cancel a pending reconciliation: 
 Enter the Entries to Reconcile sub-level of the Reconcil Work Area-Paper Statemt form, 
move to the line whose reconciliation you want to cancel and remove the check mark from the 
Reconcile column.  
Tip: To remove the check marks from all entries in the Entries to Reconcile sub-level form, 
select Remove Flags From Entries from the list of Direct Activations in the upper-level form. 
 To cancel a final reconciliation: 
1. Enter the Reconciled Entries-Paper Statemt sub-level of the Reconcil Work Area-Paper 
Statemt form, move to the line you want to cancel and flag the Cancel column. 
2. Return to the upper-level form and select Cancel Reconcil w/Paper Statemt from the list of 
Direct Activations. 
Result 
 The entries for which reconciliation has been canceled reappear in the Entries to Reconcile 
sub-level form and can again be reconciled.
