# 12-17-Returned Payments

- **Source:** `12-17-Returned Payments.pdf`

www.priority -software.com   
1/3 ‏Feb. 05 '15 Ver.02 Cat.No. A8000095 
 
 SOP: Returned Payments 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To handle returned payments from customers that were received from the bank or credit card 
company: recording the return, charging the customer for the return fee and printing a 
notification to the customer regarding the return. 
Working Assumptions 
 A BPM work flow (statuses) has been defined for returned payment documents. 
 A cashier for returned checks has been defined (see the relevant Standard Operating 
Procedure). 
Procedure 
Stage I: Recording a Returned Payment 
Option A: Recording a returned check 
1. Enter the Returned Payments form. 
2. Specify the Customer Account whose check was returned.  
3. Specify the Contact to which the notification will be sent. 
4. Today's Date appears automatically. You can revise it to the date that the check was returned. 
5. In the BkAcc/CredC Code column, record the bank account in which the check was originally 
deposited. 
6. In the Payment Details tab, fill in the details of the returned check: 
 Payment Amount (the Currency appear automatically) 
 Payment Means ("Check") 
 Check Number 
 Payment Date. 
7. Click the References tab and fill in the details of the customer's bank: 
 Cust's Bank Acct 
 Customer's Bank 
 Customer's Branch. 
8. Click the Charges and Commission tab and record the Return Fee and Finance Charge. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Feb. 05 '15 Ver.02 Cat.No. A8000095 
 
Option B: Cancelling a credit card transaction 
1. Enter the Returned Payments form. 
2. Specify the Customer Account whose payment was returned.  
3. Specify the Contact to which the notification will be sent. 
4. Today's Date appears automatically. Revise it to the date that the payment was returned. 
5. In the BkAcc/CredC Code column, specify the relevant credit card company to which the 
payment was originally made. 
6. In the Payment Details tab, specify the Payment Amount. 
7. In the Payment Means column, select the relevant credit card. 
8. Click the References tab and record the customer's Credit Card Number used in the original 
transaction.  
9. The Returns Cashier defined for returned payments appears automatically. To charge the 
return directly against the customer's account, delete the cashier code. This automatically 
changes the entry code to that defined for returned payments. Consequently, the returned sum 
will be debited from the customer account. 
10. You can enter the Returned Payment – Add'l Details sub-level form and record the 
Transaction Date, if desired. 
Option C: Recording a returned standing order payment 
1. Enter the Returned Payments form. 
2. Specify the Customer Account whose standing order payment was not honored or was 
canceled. 
3. Specify the Contact to which the notification will be sent. 
4. Today's Date appears automatically. Revise it to the date that the payment was returned. 
5. In the BkAcc/CredC Code column, record the bank account from which the payment was 
returned. 
6. In the Payment Details tab, specify the Payment Amount. 
7. In the Payment Means column, select "Standing order." 
8. In the References tab, you can fill in details of the customer's bank: 
 Cust's Bank Acct 
 Customer's Bank 
 Customer's Branch.  
9. The Returns Cashier defined for returned payments appears automatically. To charge the 
return directly against the customer's account, delete the cashier code. This automatically 
changes the entry code to that defined for returned payments. Consequently, the returned sum 
will be debited from the customer account. 
10. You can enter the Returned Payment – Add'l Details sub-level form and record the 
Transaction Date, if desired. 
Stage II: Finalizing the Returned Payment Document 
1. Enter the Returned Payments form and retrieve the desired document. 
2. Select Finalize Document from the list of Direct Activations.

www.priority -software.com   
3/3 ‏Feb. 05 '15 Ver.02 Cat.No. A8000095 
 
Results: 
 A permanent document number replaces the temporary one appearing in the Document 
Number column. 
 A journal entry is recorded for the returned payment. 
 The balance of the customer account or returns cashier is reduced by the amount of the 
returned payment. 
 The status of the returned payment document is changed to a final one. 
 The customer receives a status flagged in the For Returned Payment column. 
Stage III: Printing a Notification of Returned Payment 
1. Enter the Returned Payments form and retrieve the desired document. 
2. Enter the Returned Check – Remarks sub-level form. Check the recorded text, and change it 
as needed. 
3. Enter the parallel Returned Payment – Add'l Details sub-level form and make sure the 
address recorded there is correct. 
4. Do one of the following: 
 In the case of a returned check, select Print Returned Check Notices from the list of Direct 
Activations. 
Tip: To print more than one notice, run the Print Returned Check Notices program. 
 In the case of a returned credit card or standing order payment, select Print Returned 
Payment Notices from the list of Direct Activations. 
Tip: To print more than one notice, run the Print Returned Payment Notices program. 
Stage IV: Preparing an Invoice for the Return Charge and/or Finance Charges 
1. Enter the Returned Payments form and retrieve the desired document. 
2. Select Prepare Invoice for Charges from the list of Direct Activations. 
Note: You can only prepare invoices for return documents with a final status, and only if the 
relevant data has been recorded in the Charges and Commission tab.  
3. To finalize the invoice, press F6 from the Invoice (Charges) column (in the Charges and 
Commission tab) to open the prepared invoice. Check the details in the upper- and lower-level 
forms and select Finalize Invoice/Memo from the list of Direct Activations. 
Stage V: Transferring Returned Payment from the Cashier 
You can deposit the returned payment to either the customer's account or the bank account from 
which it was made. See the Standard Operating Procedure for deposits. 
 To charge the customer account, record the account number in the To A/R Acct column. 
 To redeposit a returned check, select the relevant bank account in the To Cash/Bk/CredCd 
column.
