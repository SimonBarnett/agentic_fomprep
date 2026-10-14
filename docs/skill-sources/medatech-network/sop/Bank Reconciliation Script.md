# Bank Reconciliation Script

- **Source:** `Bank Reconciliation Script.pdf`

Bank Reconciliation Script 
Clip Link: http://www.eshbel.com/Movie_Search/Bank_Reconciliation_clip.htm  
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:36) 
In this clip, we'll demonstrate how to reconcile the entries in your bank statement 
against journal entries recorded in Priority. Before performing the reconciliation, you 
can first record the statement you received from the bank in Priority. You can then 
choose to reconcile the recorded statement either manually or automatically. 
Alternatively, you can manually reconcile journal entries with a paper statement 
(without first recording the statement in Priority). We'll begin by demonstrating the 
reconciliation process for a recorded bank statement and will then demonstrate the 
same process for a paper statement. 
Setting Up Bank Statements (00:37-01:22) 
Before you begin working with bank statements in Priority, you mus
t make sure that 
the banks and bank accounts you work with are defined in the Bank Accounts form. 
If a given bank account is not yet defined, define it now using the instructions 
provided in the Set Up Bank Accounts Wizard. Similarly, make sure that all bank 
transactions are defined in the Bank Transaction Codes form, using the codes that 
are used by the relevant bank when issuing statements. Note that the descriptions 
defined for each transaction code in this form will appear automatically when the 
transaction in question is recorded in a Priority bank statement, so try to be as 
precise as possible when recording these descriptions. 
Recording Bank Statements (01:23-03:01) 
Now, we'll record the statement received from the bank in the Record Bank 
Statements form. We'll first retrieve any previous statements recorded for the bank 
account in question. In a new line, we'll begin recording the new statement by 
selecting the relevant Bank Account Code. Note that a number of details have been 
filled in for us automatically; for instance, the Statement Number column receives 
the next consecutive statement number for this bank account, or, if you're recording 
a statement for a new year, will receive "1". In any case the number can be revised 
manually. The Opening Balance has been filled in based on the closing balance of 
the preceding statement. Of course, the first time you record a statement for a given 
account, all of these details will need to be written manually. 
Next, enter the sub-level form, Itemized Statement, and record all transactions that 
appear on your bank statement, one per line. For each transaction, indicate the 
transaction date and Due Date and select a Transaction Code from the Choose list. 
While Details are filled in automatically for each transaction code, you may want to 
add a few brief remarks in this column, describing each item in greater depth, as well 
as a Reference number, where appropriate, in order to facilitate reconciliations. 
Finally, record the transaction amount in the Debit or Credit column, as appropriate. 
Cat.No. LB130387  Ver.1 – Aug 21,’13 1

Once you're done recording all statement items, return to the upper-level form. Note 
that the statement's Closing Balance has been updated automatically, based on the 
recorded items. 
Checking Bank Statements (03:02-03:30) 
At this stage, it's recommended that you check for problems, such as breaks in date 
continuity or differences between the closing balanc
e of one statement and the 
opening balance of the next. To do so, run the Check Bank Statements report for 
the bank account  and year in question. Any problems that appear in the report 
should be corrected manually in the relevant bank statement before you proceed 
with the reconciliation. 
Preparing for Reconciliation (03:31-04:22) 
Once you have recorded any recent bank statements in Priority, you'll need 
to 
prepare all of the relevant transactions for reconciliation. If you work with post-dated 
checks, you must first make sure to update the bank's GL account with any post-
dated checks that have come due. The dual-currency system offers a designated 
program, Cash Postdated Checks, that can be run for this purpose. 
Once all journal entries and statement items are up-to-date, we're going to load them 
into the reconciliation worksheet by running the Prepare for Reconciliation program 
Select the internal code of a single bank account  and indicate today's date. All 
unreconciled journal entries and statement items recorded against this account 
dated up to today's date are prepared in the reconciliation worksheet. 
Performing Reconciliation with a Recorded Bank Statement (04:23-04:58) 
You are now ready to perform reconciliation. You can choose between two types of 
reconciliations: automatic and manual. In either case, reconciliation is not final until 
you run the Finalize R
econciliations program. 
In this video, we'll begin by demonstrating how to perform reconciliation manually 
inside the reconciliation worksheet, and then run a program that provisionally 
reconciles the bank account against journal entries automatically. Afterwards, we'll 
review and then finalize pending reconciliations. 
Performing Manual Reconciliation (04:59-07:21) 
Let's open the Reconciliation Worksheet and manually reconcile a few of the items 
appearing in the worksheet, by assigning two or more matching items the same 
reconciliation number.  
One way of locating a match is by using the Entries for Reconciliation sub-level 
form. The items appearing here are potential matches for the item selected in the 
upper-level form. Once you locate the matching item, assign it a reconciliation 
number that has not yet been used. As a result, the same number is filled in 
automatically in the upper-level form. 
Another option is to sort all items in the worksheet by sum, by clicking the relevant 
column title. Note that the same amount also appears in either the Statement 
Amount column or in the Journal Entry Amount column; this distinction can be 
used to differentiate between bank statement items and journal entry items. 
Cat.No. LB130387  Ver.1 – Aug 21,’13 2

Let's begin with a bank statement item: note the transaction amount recorded in the 
bank statement and, further to the right, the number of the bank statement in which 
this transaction appeared. Next, we'll look for an item with a matching amount in the 
Journal Entry Amount column. Now, we'll assign the two items the same 
reconciliation number. Make sure that the number you choose is one that has not yet 
been used in the worksheet. In the Reconciliation Status sub-level form, you can 
see a message confirming that the entries match. If the entries do not match, you 
would instead see a message indicating that debit and credit sums are not equal.  
You can now return to the upper-level form and select the Finalize Reconciliation 
program from the list of Direct Activations. The journal entries and statement items in 
question will be reconciled in the ledger and in the recorded bank statement and 
deleted from the worksheet. Note that you should run the program with the cursor 
placed on the topmost line of the reconciliation you wish to perform. To help locate 
that line, you can retrieve the reconciliation by its Reconciliation Number.  
It may, however, be more convenient to prepare multiple reconciliations in the 
worksheet, and later run the Finalize Reconciliations program from the menu, 
finalizing them all at once. 
Dealing With Service Fees (and Similar Bank Entries) (07:22-09:36) 
Some lines
 in the bank statement may require special treatment. For example, your 
statement may contain several items, such as service fees, that do not have 
corresponding journal entries. In order to balance your accounts regardless, you can 
use the Adjustment Entry sub-level form of the Reconciliation Worksheet to 
create the “missing” entry and then reconcile it with its matching bank statement item. 
Begin by assigning the same reconciliation number to all relevant bank statement 
items, as you would for any other reconciliation. Then, from the last statement item in 
question, enter the Adjustment Entry Definitions sub-level form to create a 
corresponding adjustment entry. Select an Account Number for the journal entry 
and specify the relevant Account Number, Transaction Date and Due Date. Finally, 
return to the upper-level form and finalize the reconciliation. Subsequently, the items 
in question are reconciled together, and a new journal entry is created that debits or 
credits the adjustment account with the variance. 
There may be cases where you wish to record a more complex journal entry for a 
line in the bank statement that lacks a corresponding entry. To do so, use the same 
Adjustment Entry Definitions form, recording the first account in the Account 
Number column, then moving to the Add'l Accounts tab and recording the other 
accounts in the other two Adjustment Account columns. Finally, record relevant 
amounts in the Sum 1, Sum 2 and Sum 3 columns.  
Alternatively, you can define the adjustment entry while you are finalizing a given 
reconciliation. When you run the  Finalize Reconciliation program from the upper 
level form, if debit and credit sums do not match, an input screen appears in which 
you can record the details of the adjustment entry. Like in the sub-level form, you 
can define up to three adjustment accounts. While this method is quicker, it does not 
allow you to provide more advanced definitions, such as cash flow codes, budget 
items or profit centers, which do appear in the sub-level form. So you should select 
the method best suited to your needs. 
Cat.No. LB130387  Ver.1 – Aug 21,’13 3

Setting Up the Automatic Reconciliation Process (09:37-10:59) 
You can also have the system automatically select matching account items for 
reconciliation using an automated multi-step process, represented by a reconciliation 
code. Two default reconciliation codes are provided by the system, one for bank 
reconciliations and one for account reconciliations. You can also define as many 
custom reconciliation codes as you need. For instance, if you work with different 
banks, you may need a different code for each one. Proper use of well-defined 
reconciliation codes minimizes the remainder of odd items that need to be reconciled 
manually after running the Automatic Reconciliation program.  
Reconciliation is carried out in a series of steps, listed in the Itemized Code sub-
level form, each of which attempts to reconcile an increasingly narrow selection of 
unreconciled items by applying broader criteria than the previous ones. Each step 
employs one of a set of predefined reconciliation methods (such as "match by 
amount" or "match by reference number"), whose functional parameters (e.g., date 
range and permitted variance) are set specifically for the relevant step in the 
reconciliation process. To view an explanation of a particular reconciliation method, 
press F6 from this column to activate the Reconciliation Methods form. The help 
text appears in the help text sub-level form. 
Performing Automatic Reconciliation (11:00-13:01) 
Instead of manually r
econciling the items, you can run an automatic reconciliation, 
then deal individually with the items that were not reconciled. To perform automatic 
reconciliations, run the Automatic Reconciliation program , designating the desired 
reconciliation code. When the program finishes running, it displays a notification 
indicating the number of reconciliations that have been created. Such reconciliations 
are considered pending until they have been finalized.  
At this point, you can finalize all pending reconciliations in a batch by running the 
Finalize Reconciliations program; however, you may prefer to review them first. 
Pending reconciliations can be reviewed and reconciled one by one from within the 
reconciliation worksheet, or you can run the Pending Reconciliations report from 
the Reconciliation Reports menu for a quick, overall view of all pending 
reconciliations. As you can see, successfully matched journal entries and statement 
items are assigned the same reconciliation number. If any of these reconciliations 
are incorrect, they can now be canceled from within the Reconciliation Worksheet.  
For instance, say that the statement items that are assigned the reconciliation 
number 1 should not be reconciled with the entry item assigned the same 
reconciliation number. We can easily locate the corresponding items in the 
worksheet by their reconciliation number. To cancel the pending reconciliation, 
replace the reconciliation number with 0, in all the involved lines, or run the Cancel 
Pending Reconcil'ns program from the list of Direct Activations. 
You may now want to rerun the reconciliation program using a different reconciliation 
code, or reconcile the rest of the items manually. Once you are satisfied with all 
pending reconciliations, you can finalize them using either of the programs 
mentioned earlier. 
Cat.No. LB130387  Ver.1 – Aug 21,’13 4

Results (13:02-13:52) 
As a result of the reconciliation process, whether manual or automatic, all the 
selected items have been reconciled, and adjustment entries have been recorded as 
necessary.  
Returning our attention for a moment to the bank statement itself, we can see that 
the itemized statement now shows a reconciliation number next to each item that 
has been successfully reconciled. Similarly, if you retrieve the relevant bank account 
and adjustment account in the Chart of Accounts form, reconciled transactions 
appear in a sub-level of this form with the same reconciliation number. 
Should you need to cancel a reconciliation for any reason, you can do so at any time 
by running the appropriate program from the Cancel Reconciliations menu, even 
after the reconciliation has been finalized . 
Reconciling a Paper Statement with Journal Entries (13:53-14:08) 
If bank statements have not been recorded in Priority, you can still manually 
reconcile journal entries with the paper statement received from the bank, if desired. 
This process is similar in many w
ays to manual reconciliation with a recorded bank 
statement. 
Preparing Transactions for Reconciliation  (14:09-15:23) 
Here, too, you will need to prepare the relevant entries for reconciliation and then 
proceed to  reconcile these entries in a designated work area. When you are done 
preparing pending reconciliations in the worksheet such that all designated journal 
entries are properly balanced against the received statement, you can run a second 
program to finalize these reconciliations. Once the reconciliation process is complete, 
a bank statement is constructed based on the final reconciliations and can be viewed 
in the Reconciled Paper Statements form. 
Remember that if you work with post-dated checks, you must first update the bank's 
GL account with any post-dated checks that have come due, using the Cash 
Postdated Checks available in the dual-currency package. 
Once all journal entries and statement items are up-to-date, we're going to load them 
into the reconciliation worksheet by running the Prep for Recon. w/Paper Statemt 
program. Select the internal code of a single bank account [X] and indicate the range 
of dates which the statement covers, as well as the statement's opening and closing 
balances, the statement number and the year in which the statement was prepared. 
Performing Reconciliation with a Paper Statement (15:24-20:06) 
All unreconciled journal entries recorded against this account for the dates indicated 
are prepared for reconciliation. Let's enter the reconciliation work area for paper 
statements in order to select those entries that are actually covered by this bank 
statement. Note the opening and closing bank balances appearing in this form; these 
should match the corresponding amounts appearing on the bank statement to be 
reconciled. The difference between these two amounts appears in the Statement 
Amount column. You can view a running total of the journal entries being reconciled 
with this statement in the Total Reconc Amount column as you select entries for 
reconciliation; this amount should eventually match the statement amount. 
Cat.No. LB130387  Ver.1 – Aug 21,’13 5

As you can see, this work area has two sub-level forms: Entries to Reconcile and 
Reconciled Entries - Paper Statemt. As their titles indicate, the Entries to 
Reconcile form displays potential matches for the items in the current bank 
statement, any of which can be flagged for reconciliation with this statement. Once 
you finalize one or more of these reconciliations, they are deleted from this form and 
appear instead in the parallel sub-level form, Reconciled Entries - Paper Statemt.  
Let's enter the Entries to Reconcile sub-level form in order to begin flagging journal 
entries that match the items in the current bank statement. For instance, if the bank 
statement shows a bank transfer that was ordered on xx/yy/zz in the amount of $A, 
we'll look for a journal entry for the same amount with a Transaction Date falling on 
or around the xx/yy/zz. The Details recorded for the entry we've located also indicate 
that this entry was recorded for a bank transfer, so we'll flag this entry for 
reconciliation. Note that as you flag more and more entries, several columns in the 
upper-level form are being updated automatically: 
 ClosingBal in Ledger – This balance is calculated by adding the amount of the 
entries that are flagged for reconciliation to the opening balance in the ledger. 
 Flagged for Reconcil  – This column displays the total amount of those journal 
entries that have been flagged for reconciliation with the current statement. 
 Total Reconc Amount – The total amount of the journal entries to reconcile with 
the current statement. This amount consists of the amount flagged for 
reconciliation plus any amount that has already been reconciled, as displayed in 
the parallel sub-level form, Reconciled Entries-Paper Statemt. 
You can finalize pending reconciliations at any time, even if you have not yet finished 
flagging all of the relevant journal entries, by returning to the upper-level form and 
selecting Finalize Recon. w/Paper Statemt from the list of Direct Activations. As a 
result, bank statement items are reconciled with the flagged journal entries and are 
added to a simulation bank statement, which can be viewed in the Reconciled 
Paper Statements form. You can then continue with the reconciliation at a later time, 
if necessary. To view a report displaying any journal entries that still appear in the 
Entries to Reconcile sub-level of the reconciliation work area, select Entries in 
Reconcil Work Area  from the list of Direct Activations and choose whether to view 
all entries or only those that are flagged for reconciliation. 
Should you need to cancel a reconciliation for any reason, you can do so at any time 
from the relevant sub-level form. 
To cancel a pending reconciliation, enter the Entries to Reconcile sub-level form, 
move to the line whose reconciliation you want to cancel and remove the check mark 
from the Reconcile column. Alternatively, you can remove the check marks from all 
entries in the Entries to Reconcile sub-level form in a batch by selecting Remove 
Flags From Entries from the list of Direct Activations in the upper-level form. 
To cancel reconciliations after they have been finalized, move to the Reconciled 
Entries-Paper Statemt sub-level form to view all journal entries that have been 
reconciled with the current bank statement. Move to the line you want to cancel and 
flag the Cancel column. Return to the upper-level form and select Cancel Reconcil 
w/Paper Statemt from the list of Direct Activations to cancel the reconciliation of all 
flagged items. The entries for which reconciliation has been canceled reappear in the 
Cat.No. LB130387  Ver.1 – Aug 21,’13 6

Cat.No. LB130387  Ver.1 – Aug 21,’13 7
Entries to Reconcile sub-level form and can again be reconciled, and the amount in 
the ClosingBal in Ledger column is updated automatically. 
Viewing the Progress of Reconciliations (20:07-20:26) 
Priority provides a variety of reports that allow you to view different cross-sections of 
reconciled bank transactions, as well as items that have not yet been recon
ciled. 
These reports can all be accessed from either the Reconciliation Reports menu or 
the Bank Reconcils-Paper Statement menu. 
Cancelling and Restoring Reconciliations (20:27-21:06) 
If necessary, you can cancel reconciliations, as well as restore those that have been 
canceled, from the Cancel Reconciliations menu. Run a programto cancel 
reconciliations, even those that are already final.  
You can view final reconciliations that have been canceled by running the Canceled 
Final Reconciliations report for one or more accounts. If you want to restore a 
canceled reconciliation, simply run the Restore Canceled Reconciliationsprogram, 
rather than going through the reconciliation process once again.  
This concludes our demonstration of the bank reconciliation tools available in 
Priority. It should be noted that a similar process works for credit card statements. 
Related Documentation 
 Set Up Bank Accounts Wizard 
 Bank Reconciliation Wizard
