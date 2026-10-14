# Check Payment Script

- **Source:** `Check Payment Script.pdf`

Check Payment Script 
Clip Link: http://www.eshbel.com/Movie_Search/Check_Payment.htm  
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:40) 
In this clip, we will show you how to record payments by check and how to print the 
checks. The payment document can be recorded manually or automatically. We'll 
begin by demonstrating how to prepare a check payment using each of these 
methods, and then show you how to print the prepared check from within Priority. 
Before you begin, you may want to review your outstanding debt to the vendor by 
running the Outstanding Invoices - Detailed report, which displays invoice sums 
owing for a specified vendor. Or you can run any of the Aged Payable reports found 
in the Accounts Payable > Accounts Payable Reports > Aging and Open 
Invoices menu. 
Preparing a Check Payment Manuall y (00:41-03:16) 
We'll begin by demonstrating how to record a check payment manually, in the Check 
Payments form. 
First, choose the vendor for which the check payment is being prepared. 
If this is a one-time vendor, you can change the vendor's name, provided that the 
Change Name column is flagged for this vendor in the Vendors form. 
Today's date appears automatically in the Date column, where it may be revised, 
and a temporary number beginning with "T" appears in the Payment Number 
column. 
Choose the account from which to make the payment to the vendor in the Paying 
Bank Account column, and record the date of the check in the Check Date column. 
Fill in the Check Number column only if the check is written by hand, and not printed 
out by the program. In the Payment Data tab, the Currency column is filled in 
automatically with the vendor's defined billing currency.  
To select the invoices to be paid by this check, enter the Flag Invoices for Payment 
sub-level form. This form displays all open invoices from this vendor, together with 
their Payment Date. Any check payments issued for invoices flagged in this form are 
automatically reconciled with the journal entry for the invoices, thus saving you the 
trouble of having to later reconcile the entries via account reconciliation.  
Flag the Pay column for every invoice to be paid by this check.  
Any invoice that is flagged in the Checking column cannot be included in the 
payment. If a particular invoice has been partially paid, the remaining sum appears in 
the Payment Balance column. 
After all the relevant invoices have been flagged, move to the parallel Payment 
Details sub-level form.  
Cat.No. LB130530  Ver.1 – Nov. 28,’13 1

If you want to pay only part of the amount owing in the invoice, you can change the 
sum here. The remainder will appear as an open debt in the vendor account, and a 
temporary reconciliation number will be recorded for the partial sum paid.  
If there is a small difference between the amount paid in the check and the invoice 
payment balance, you can record an Adjustment Account to which the variance will 
be transferred. Press F1 for a more detailed explanation on how the system works 
with variance.  
And if the current check payment is not related to an invoice, you can use this form 
to record payment details manually.  
To finalize the payment document and post a journal entry for the payment to the 
ledger, return to the upper-level form and run the Finalize Check Payment program 
from the list of Direct Activations. As a result, the Payment Number is replaced by a 
permanent number, and a Journal Entry Number appears in the References tab.  
Preparing a Check Payment Automatically (03:17-06:51) 
Check pay
ments can also be prepared automatically in a batch. The payments are 
based on the invoices flagged in the Flag Invoices for Payment  form. You can flag 
the invoices manually, or use a program to flag them automatically. The Prepare 
Payments program opens payments for the flagged invoices; and  the Finalize 
Payments program finalizes the payment documents and records a journal entry for 
each. Now I'll explain these steps in detail.  
Open the Flag Invoices for Payment form. Retrieve the invoices you wish to pay 
and flag them in the Prepare Payment column. Payments cannot be opened for 
invoices flagged in the Checking column. The Payment Date is filled in with the 
date defined for the invoice or according to the payment terms defined for the vendor, 
but can be revised. You can use the Payments for Invoice sub-level to split the 
payment into a number of installments. Record each installment's Pay Date, 
Payment Amount, and Details.  
The sum of the payment amounts recorded here has to match the total invoice sum; 
if there is variance, the system will display an error message.  
To automatically flag the invoices for payment, rather than manually, run the Flag 
Invoices for Payment program. In the input screen, select the vendor account for 
which invoices will be flagged, and a range of dates on which payment is due or a 
range of dates on which invoices were opened. Then press OK. A message notifies 
you of the number of invoices that were flagged. You can now open the form and 
retrieve the flagged invoices.  
If you want to start over, you can delete the invoice payment flags using a 
designated program. The program deletes all flags, regardless of whether they were 
recorded automatically or manually. Then flag the invoices you want again. 
To prepare payments for the invoices you flagged, run the Prepare Payments 
program. In the Bank Account Code column, specify the bank account from which 
payments will be made. Also specify the Payment Date. You can flag the Postdated 
Payments column to open payments for future dates, based on the invoices' 
payment date.  
Cat.No. LB130530  Ver.1 – Nov. 28,’13 2

In the next input screen, select whether to prepare checks or bank transfers, or to 
use the definition in the Financial Parameters for Vendors form, in the Pay by 
Bank Transfer column. If the column is empty, payments will be made by checks.  
Return to the program input, select the currency and press OK. A message appears 
indicating the number of payments opened. These payments are temporary. If an 
error message displays, run the Prepare Payments – Errors report to see a list of 
the payments that were not prepared and the reasons for it, and fix accordingly.  
Let's open the Check Payments form and retrieve the temporary payments. Press 
F11 to switch to Query mode, and retrieve by the date you recorded in the Payment 
Date column of the Prepare Payments program; and by the Payment Number: 
record a "T" and add an asterisk to retrieve all the temporary payments. You can 
switch to Multi-Record display mode to see the payments you retrieved in the form of 
a list.  
To finalize a single payment document, you can run the Finalize Check Payment 
program from the list of Direct Activations. Or you can finalize a group of payments 
together by running the Finalize Payments program from the menu.  
Printing Checks (06:52-10:01) 
Let's now see how checks are pri
nted in Priority. To print checks, you will need a 
special printer with magnetic ink. Before you begin, open the Financial Constants 
form and check the value of the CheckCopies constant, which determines the 
number of copies printed for each check.  
To define the format for printing checks, open the Word Templates – Check 
Printing form from the Check Printing menu. A template for printing checks in the 
U.S. is already defined, including the Number of Lines in the check details, and the 
number of characters that will appear in the first line of the Amount in Words.  
Due to changes made in MS-Office, in order to create and edit templates in Priority 
16, you must use Office 2013, or Office 2007 or 2010 with an installation of a special 
add-in for working with XML tags. 
Note that there is an older version of a predefined template which was in use in 
earlier releases of Priority and should be ignored by users of version 16. If you 
defined your own template in earlier versions, you can still use it in Priority 16 – 
provided your version of Office is 2010 or lower – but you cannot edit or copy it.  
You can copy new templates by running the Copy Template program from the list of 
Direct Activations. Specify the Template Name and Description to be assigned to it. 
This template will receive the design of the original template, which you can change 
as needed. You can also press Ctrl+Enter to open a new line and record a new 
template manually, then design it in Word, as demonstrated shortly. To delete a 
template, run the Delete Template program from the list of Direct Activations.  
After making sure templates are defined properly, run the Print Checks Via Word 
Template program from the same menu. Let's select the default template defined for 
U.S. checks. Flag the 4-Digit Year Format column to display the year in four digits, 
and the Asterisks Before Amt if you want asterisks to appear before the amount in 
words, rather than after it.  
After pressing OK, the Checks to Print form opens, in which you retrieve the checks 
to be printed. You can only retrieve checks in a final status, for which a check 
Cat.No. LB130530  Ver.1 – Nov. 28,’13 3

Cat.No. LB130530  Ver.1 – Nov. 28,’13 4
number has not yet been recorded, and which are issued from the same bank 
account. You can clear checks that you don't wish to print at the moment by using F7, 
then return to the program input by pressing Esc. The From Check Number column 
is automatically filled in with the number recorded for this account in the Next Check 
to Print column of the Bank Accounts form. Fill in the Max. Checks to Print 
column if you wish to restrict the number of checks to be printed, for example if your 
printer is not loaded with sufficient paper. Press OK and a dialogue box opens in 
which to select the printer.  
After printing, a Check Number is recorded in the Check Payments form, beginning 
with the number that appeared in the input screen. You can make sure the process 
ended smoothly by retrieving the check in the Check Payments form.  
Designing and Reprinting a Check (10:02-11:14) 
It is recommended that you print a test check the first time you work with checks in 
Priority. If you need to change the template design, you can run the Design Word 
Template for Checks program. Let's demonstrate using the copy of the U.S. 
template we just created.This opens a Word page with XML tags, which can then be 
designed as needed. To edit the tags, click on the Developer ribbon and press XML 
Mapping Pane. Open the Custom XML Part choose list, and select the name of the 
form: Print_checks. The pane is populated with the relevant columns in the form, 
which you can add to the template. You can design the template using regular Word 
tools. Remember to save the changes you make using "Save" and not "Save as", or 
the changes will not be registered in the system.  
If, for example, you printed a check to test the design and wish to reprint it after 
modifications, open the Update Check Numbers form from the same menu, retrieve 
the check and erase the assigned Check Number. You can then repeat the printing 
process, as explained earlier.  
Check Payment Reports (11:15-11:31) 
You can run the reports in the Check Payment Reports menu and in the Payment 
Reports menu to view the details of check payments recorded in the system, and of 
payments made to vendors, respectively.  
This concludes our demonstration of check payments in Priority.  
Related Documentation 
 Check Payments wizard 
 Check Paymt Troubleshoot wizard 
 User Interface Guide
