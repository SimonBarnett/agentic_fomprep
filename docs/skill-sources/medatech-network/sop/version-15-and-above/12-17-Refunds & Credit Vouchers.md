# 12-17-Refunds & Credit Vouchers

- **Source:** `12-17-Refunds & Credit Vouchers.pdf`

www.priority -software.com   
1/3 ‏Feb. 05, '15 Ver.02 Cat.No. A8000094 
 
 SOP: Refunds and Credit Vouchers 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record monetary refunds to customers by check or bank transfer, as well as credit vouchers 
that can be used for future purchases. 
Customer Refunds 
Working Assumption 
A credit memo has been recorded in the system for the amount due to the customer. 
Recording a Check Refund 
Procedure 
1. Enter the Check Payments form. 
2. In the Vendor's Account column, specify the account number of the customer receiving the 
refund. 
3. Specify the Paying Bank Account from which the check is being made. 
4. If the check was recorded manually, specify the Check Number. 
5. If necessary, indicate that the check is for a customer refund in the Details column (in the 
References tab). 
6. Enter the Flag Invoices for Payment sub-level form, move to the line for the credit memo 
recorded for the customer and flag the Pay column. 
7. Enter the parallel Payment Details sub-level form. The payment amount recorded in the credit 
memo appears in the Sum column. If you are only refunding part of the sum, change the value 
accordingly. 
8. Enter the parallel Check Payment – Add'l Details sub-level form, and make sure the address 
recorded them is the one that should appear on the printed check. 
9. Return to the upper-level form and select Finalize Check Payment from the list of Direct 
Activations. 
10. To print the check, run the Print Checks program. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Feb. 05, '15 Ver.02 Cat.No. A8000094 
 
Recording a Refund by Bank Transfer 
Procedure 
1. Enter the Payments by Bank Transfer form. 
2. In the Vendor's Account column, specify the account number of the customer receiving the 
refund. 
3. Specify the Paying Bank Account from which the check is being made. 
4. If necessary, indicate that the transfer is for a customer refund in the Details column (in the 
References tab). 
5. Click the Vendor's Bank tab and specify the details of the customer's bank account. 
6. Enter the Flag Invoices for Payment sub-level form, move to the line for the credit memo 
recorded for the customer and flag the Pay column. 
7. Enter the parallel Payment Details sub-level form. The payment amount recorded in the credit 
memo appears in the Sum column. If you are only refunding part of the sum, change the value 
accordingly. 
8. Return to the upper-level form and select Finalize Bank Transfer Payment from the list of 
Direct Activations. 
9. To print a notification to the bank to perform the transfer, select Print Bank Transfers (Bank 
Copy) from the list of Direct Activations. 
10. To print a notification to the customer that the amount has been transferred, select Print Bank 
Transfer (Vend Copy) from the list of Direct Activations. 
Working With Credit Vouchers 
You can offer customers credit vouchers that can be redeemed for future purchases (e.g., when the 
customer returns merchandise or as a sales promotion). If the credit voucher is for a customer 
return, prepare an over-the-counter invoice (for a negative sum); this will both credit the customer 
and return the inventory. If there is no inventory transaction involved, prepare a customer receipt 
(for a negative sum) instead. 
Working Assumptions 
 A GL account and special cashier account have been defined for credit vouchers. 
 Credit vouchers have been defined as a means of payment. 
Setups 
 In the Payment Means form, for the means of payment used for credit vouchers, make sure the 
Allow Negative Value column is flagged. 
 In the Financial Documents form, in the line for over-the-counter invoices and/or receipts, make 
sure the Check for Neg. Sums column is not flagged. 
Issuing a Credit Voucher for Returned Goods 
Procedure 
1. Enter the Over-The-Counter Invoices form.

www.priority -software.com   
3/3 ‏Feb. 05, '15 Ver.02 Cat.No. A8000094 
 
2. Click the Cash Receipts & Terms tab and record the bank account for credit vouchers in the 
Cashier column. 
3. Enter the Invoice Items sub-level form and record the returned goods, specifying their 
quantities with negative values. 
4. Enter the parallel Payment by Credit Card/Coupon sub-level form and specify the Payment 
Code defined for credit vouchers.  
5. In the Payment Amount column, specify the total sum to be credited with a negative value. 
6. Specify the current date in the Payment Date column. 
7. Return to the upper-level form and finalize the invoice. A journal entry will be recorded debiting 
the negative sum from the credit voucher account. 
Issuing a Credit Voucher Without a Return 
Procedure 
1. Enter the Receipts form. 
2. Record the bank account defined for credit vouchers in the Cashier column. 
3. Click the Check Invoice Data tab and flag the Copy to Journal Entry column. 
4. Enter the Other Forms of Payment (Details) sub-level form and select the Payment Code 
defined for credit vouchers. 
5. In the BkAcct/Credit Cd No. column, specify the bank account for credit vouchers. 
6. Specify the total sum of credit due to the customer with a negative value in the Payment 
Amount column. 
7. Specify the current date in the Payment Date column. 
8. Enter the parallel Invoice Amounts Being Paid sub-level form and record the negative sum in 
the Sum column. 
9. Return to the upper-level form and finalize the receipt. A journal entry will be recorded debiting 
the negative sum from the credit voucher account, and crediting the negative sum to the 
designated income account.
