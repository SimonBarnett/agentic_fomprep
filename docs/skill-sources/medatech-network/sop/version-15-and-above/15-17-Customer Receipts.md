# 15-17-Customer Receipts

- **Source:** `15-17-Customer Receipts.pdf`

www.priority -software.com   
1/3 ‏Mar. 12,'15 Ver. 02 Cat.No. LB130005 
 
 SOP: Receipts from Customers 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To document the receipt of payment, based on invoices. 
Setups 
 Reconciliation definitions 
 Reconciliation variance definitions 
 Bank and bank account definitions 
 Cashier definitions 
 Means of payment definitions 
 General receipt definitions 
 Definitions governing the tracking of payment dates 
Procedure 
Stage I: Preparing a Receipt 
1. Enter the Receipts form. 
2. Select a Customer's Account. The Customer/Acct Name is filled in automatically. 
3. Make sure that the Cashier appearing in the form is suitable to your needs. When recording the 
receipt of a bank transfer or credit card payment, you can use this column to record the number 
of the bank account receiving the payment. 
4. Enter the Flag Invoices for Payment sub-level form. 
5. Flag all invoices for which the payment was received (in full or partial payment) in the Paid 
column. 
6. Enter the parallel Invoice Amounts Being Paid sub-level form. This form displays the invoices 
flagged in the previous step. 
7. If necessary, you can change the amounts appearing in the Sum column. 
8. To specify a cash receipt: 
 Return to the upper-level form and click the Receipt Data tab. 
 In the Cash Receipts column, record the sum of cash received. 
9. To specify a payment by check: 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Mar. 12,'15 Ver. 02 Cat.No. LB130005 
 
 Enter the Check Payment (Details) sub-level form. 
 Record the necessary details of each check.  
Note for Dual-Currency Users: If the payment consists of several sequentially numbered 
checks, record the details of the first check and then select Create Additional Checks from 
the list of Direct Activations. The program automatically creates additional records for the post-
dated checks. 
10. To specify the receipt of a different means of payment: 
 Enter the Other Forms of Payment (Details) sub-level form. 
 Select the appropriate Payment Code (e.g., Bank Transfer, Visa, Promissory Note). 
 Fill in the details of the receipt. 
Stage II: Approving a Receipt via Another User 
Aim: To have another user approve a receipt so that it may be finalized. 
Note: If your company does not require that an additional user approve a receipt before it may be 
finalized, you may skip this stage. 
To assign the receipt to another user for approval: 
1. Enter the Receipts form and retrieve the document in question. 
2. Assign the document to the user who needs to approve it by selecting their user name in the 
Assigned to column. 
To approve receipts assigned to you: 
1. Enter the Receipts form and retrieve all pending documents assigned to you. 
2. Change the status of each document to “Approved”. 
3. If it is company policy to have a third user finalize the document, transfer each receipt to a third 
user by selecting their user name in the Assigned to column. Otherwise, move directly to Stage 
III. 
Notes: 
 To restrict receipts from being finalized by the user who created them, enter the Financial 
Documents form and make sure that Disallow Single User is flagged for the Receipt line. 
 To additionally require that a third user finalize the receipt after the second user approves it, flag 
Auth. Can't Finalize as well. 
Stage III: Finalizing a Receipt 
 To finalize a single receipt: 
 Enter the Receipts form. 
 Retrieve the receipt you want to finalize. 
 Click Finalize Receipt from the list of Direct Activations. 
 To finalize a batch of receipts: 
 Run the Finalize Receipts program.  
 In the query form that opens, retrieve the receipts that you want to finalize. If, in the process, 
receipts were retrieved that you are not yet ready to finalize, you can delete them from the list 
by pressing F7.

www.priority -software.com   
3/3 ‏Mar. 12,'15 Ver. 02 Cat.No. LB130005 
 
 Close the form and click OK in the Continue Execution window. 
 When the program ends, a message appears displaying the number of receipts that were 
finalized. If an error occurred while finalizing a receipt, a message appears referring you to the 
errors report. 
 To view the errors in question, run the Final Receipts - Errors report. 
Results 
 A journal entry is posted to the ledger. 
 Invoices that were flagged for full payment will no longer appear in the Unreconciled 
Transactions sub-level of the Chart of Accounts Receivable form, nor in aged receivables 
reports. 
 The receipt and any invoices linked to it are reconciled automatically, according to the 
reconciliation parameters defined in the setup stage. 
Stage IV: Deleting a Receipt 
 To delete a single receipt: 
 Enter the Receipts form. 
 Retrieve the receipt you want to delete. 
 If the receipt is pending (i.e., not yet finalized), click Delete Pending Receipt from the list of 
Direct Activations. 
 If the receipt is final, click Cancel Document (Original Date) or Cancel Document (Today's 
Date), as needed. 
 To delete a batch of receipts: 
 Run the Delete Pending Receipts program.  
 In the query form that opens, retrieve the receipts that you want to delete. If, in the process, 
receipts were retrieved that you do not want to delete, you can remove them from the list by 
pressing F7. 
 Close the form and click OK in the Continue Execution window. 
 When the program ends, a message appears displaying the number of receipts that were 
deleted.
