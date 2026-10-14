# SOP Payments to Vendors

- **Source:** `SOP Payments to Vendors.pdf`

Cat.No. LB130443 1 Ver.2 – Dec.08,’13 
 
SOP: Payments to Vendors* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
(A)  Preparing checks to vendors in batch on the basis of purchase 
invoices recorded in the system 
Working Assumption 
 The system contains purchase invoices with a status that allows payment. 
Procedure 
Stage I: Flagging Invoices for Payment - Automatic 
1. Enter the Flag Invoices for Payment form and retrieve all purchase invoices that have 
not yet been paid. 
2. Flag the Checking column of any invoice for which you do not want to prepare payment. 
3. To flag a batch of invoices, run the Flag Invoices for Payment program, specifying the 
vendor that you want to pay, and the range of invoice dates for which to prepare the 
payment. 
4. To view the flagged invoices, enter the Flag Invoices for Payment form and retrieve 
all records. You can remove or add the check mark for a specific invoice manually. 
5. To flag a single invoice, flag the Prepare Payment column in the Flag Invoices for 
Payment form (without running the program).  
6. To automatically split payments to a vendor into equal monthly installments, flag the 
invoice(s) for which to split payments and run the Split Payment program from the 
list of Direct Activations. The installments created by the program appear in the 
Payments for Invoice sub-level form. 
7. To split a payment into installments manually: 
 Retrieve the vendor invoice that you want to split. 
 Enter the Payment Installments sub-level form. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. LB130443 2 Ver.2 – Dec.08,’13 
 Record the sum of the partial payment in the Amount of Payment column. 
 Record the date of the payment in the Payment Date. 
Stage II: Preparing Payments 
In this stage we will prepare payments for the invoices flagged in the previous step. 
1. Run the Prepare Payments program. 
2. Select the bank from which the checks will be prepared and specify their dates. 
Stage III: Checking Payments 
In this stage we will check the payments that were prepared. 
1. Enter the Check Payments form and retrieve all of the payments prepared in the 
previous step. 
2. Check the payment details. If necessary, you can make revisions in the Payment 
Details, Flag Invoices for Payment or Check Payment – Add'l Details sub-level 
form. 
Stage IV: Finalizing Payments 
In this stage we will finalize the payments that were prepared and checked, prior to 
printing the actual checks. 
1. Run the Finalize Payments program. 
2. In the query form that opens, retrieve all of the payments awaiting finalization. 
3. If a payment is displayed that you do not yet want to finalize, you can remove it from 
the list by pressing F7. 
4. Close the form. The program will finalize all the selected payments and display a 
message when it ends. 
Stage V: Setting Up Check Printing 
In this stage we will set up the required definitions for printing checks. 
The system allows you to print checks with or without using a Word template. To update 
the default check printing definitions, run one of the following programs (depending on 
the print program you use): 
 Definitions for Check Printing 
 Design Word Template for Checks 
Note: If you work with the Rich interface, checks must be printed based on a Word 
template. For details, see the User Interface Guide.  
Stage VI: Printing Checks 
In this stage we will print the actual checks, using the relevant printing program. 
1. Run either of the following check printing programs: 
 Print Checks – to print checks without a Word template (Windows only).

Cat.No. LB130443 3 Ver.2 – Dec.08,’13 
 Print Checks Via Word Template – to print checks based on a Word template. 
2. If you are printing checks based on a Word template, choose the desired Template. 
3. In the query form that opens, retrieve the final payments for which you want to print 
checks – you can retrieve all or some of the final payments. Since you can only print 
multiple checks from one bank account at a time, it is advisable to retrieve payments 
per account. In any case, only payments that have no value in the Check Number 
column will appear in the form. 
4. To remove a specific check from the list, clear that line by pressing F7.  
5. Close the form. The dialogue box that opens automatically displays the number of the 
first check to be printed in the From Check Number column (according to the current 
value appearing for the account in question in the Next Check to Print column of the 
Bank Accounts form). It may be revised. 
6. In the Max. Checks to Print column, specify the number of checks you want to print. 
Note: The number of copies of each check that will be printed is determined by the 
CheckCopies constant, defined in the Financial Constants form. 
7. If an error is encountered when printing a check, make a note that the check number 
in question has been canceled (in order to monitor the sequence of check numbers), 
and reprint the payment with a different check number: 
 Enter the Check Payments form, specify the Vendor's Account and Check 
Number and click Void the Check from the list of Direct Activations. 
 Enter the Update Check Numbers form, retrieve the canceled payment and delete 
its number. This allows you to include the payment in the next round of check 
preparation. 
Results 
 An invoice for which a check is prepared is reconciled against the payment. 
 If the check only constitutes partial payment of a given invoice, the current payment 
appears in the Prior Payments on Invoice sub-level of the Flag Invoices for 
Payment form. 
 When the payment is finalized a journal entry is posted automatically to the ledger.

Cat.No. LB130443 4 Ver.2 – Dec.08,’13 
(B) Preparing a single check on the basis of a vendor invoice 
recorded in the system 
Working Assumption 
 The system contains purchase invoices with a status that allows payment. 
Setups 
The system allows you to print checks with or without using a Word template. To update 
the default check printing definitions, run either of the following programs (depending on 
the print program you use): 
 Definitions for Check Printing 
 Design Word Template for Checks 
Note: If you work with the Rich interface, checks must be printed based on a Word 
template. For details, see the User Interface Guide.  
Procedure 
Stage I: Preparing the Payment 
1. Enter the Check Payments form. 
2. Specify the Vendor's Account and Paying Bank Account. 
3. Check the values appearing in the Check Date column and the Currency column (in 
the Payment Data tab). 
4. If the payment is for a purchase invoice, enter the Flag Invoices for Payment sub-
level form and flag the Pay column for every invoice that you want to pay with the 
current check. 
5. In the Payment Details sub-level form specify the Sum, or leave the amount that 
appears automatically. 
6. Return to the upper-level form and change the Status of the payment to Approved. 
7. From the Check Payments form, click Finalize Payments from the list of Direct 
Activations. 
Stage II: Printing the Check 
1. Select Print Checks Via Word Template from the list of Direct Activations, 
specifying the desired Template.  
Note: To use the Print Checks program, follow the directions for printing a batch of 
checks (Stage VI) and retrieve a single payment document. 
2. The Check Number is filled in automatically based on the Next Check to Print 
column of the Bank Accounts form. Revise if necessary, then click OK to confirm. 
Note: The number of copies that will be printed is determined by the CheckCopies 
constant, defined in the Financial Constants form.

Cat.No. LB130443 5 Ver.2 – Dec.08,’13 
3. If you want to reprint the check: 
 Enter the Update Check Numbers form, retrieve the payment in question and 
delete the number of the check. 
 Enter the Check Payments form, retrieve the payment in question and rerun the 
check printing program, specifying the original check number. 
Results 
 Any invoice for which the check is prepared is reconciled against the payment. 
 If the check only constitutes partial payment of a given invoice, the current payment 
appears in the Prior Payments on Invoice sub-level of the Flag Invoices for 
Payment form. 
 When the payment is finalized a journal entry is posted automatically to the ledger.

Cat.No. LB130443 6 Ver.2 – Dec.08,’13 
(C)  Preparing bank transfers in batch on the basis of purchase 
invoices recorded in the system 
Working Assumption 
 The system contains purchase invoices with a status that allows payment. 
Required Setups 
 Vendor bank accounts, to which the transfers can be made, have been defined in the 
Bank Account Details sub-level of the Financial Parameters for Vendors form. 
Procedure 
Stage I: Preparing Bank Transfer Payments 
1. Enter the Payments By Bank Transfer form. 
2. Specify the Vendor's Account and Paying Bank Account. 
3. Check the values appearing in the Payment Date column and the Currency column 
(in the Payment Data tab). 
4. If the payment is for a purchase invoice, enter the Flag Invoices for Payment sub-
level form and flag the Pay column for every invoice that you want to pay with the 
current transfer. 
5. Enter the parallel Payment Details sub-level form and check the payment sums. 
6. If the transfer constitutes partial payment of a given invoice, change the payment 
amount in the Sum column. 
7. Return to the upper-level form and change the Status of the payment to Approved. 
Stage II: Finalizing Payments 
1. Run the Finalize Bank Transfers program. 
2. In the query form that opens, retrieve all of the payments awaiting finalization. 
Tip: If a payment is displayed that you do not yet want to finalize, you can remove it 
from the list by pressing F7. 
3. Exit the form. 
4. To finalize a single bank transfer, enter the Payments by Bank Transfer form, retrieve 
the desired payment and click Finalize Bank Transfer Payment from the list of 
Direct Activations. 
Stage III: Printing Transfer Confirmations 
1. Enter the Payments By Bank Transfer form and retrieve the transfer payment that you 
want to print.

Cat.No. LB130443 7 Ver.2 – Dec.08,’13 
2. Click Print Bank Transfer (Bank Copy) or Print Bank Transfer (Vend Copy) from 
the list of Direct Activations to print a confirmation to send to the bank and the vendor, 
respectively. 
Results 
 An invoice for which a bank transfer is prepared is reconciled against the payment. 
 If the transfer only constitutes partial payment of a given invoice, the current payment 
appears in the Partial Payment for Invoice sub-level of the Flag Invoices for 
Payment form. 
 When the payment is finalized a journal entry is posted automatically to the ledger.
