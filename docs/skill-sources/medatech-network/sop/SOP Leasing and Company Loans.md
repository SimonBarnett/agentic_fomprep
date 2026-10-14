# SOP Leasing and Company Loans

- **Source:** `SOP Leasing and Company Loans.pdf`

Cat.No. LB110539 1 Ver.1 – Aug. 22, ’11 
 
SOP: Leasing and Company Loans* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aims 
 To set up and maintain the basic parameters required to process leasing 
transactions (financing) and company loans (installment payments). 
 To record and maintain actual leasing and loan transactions. 
 To produce invoices for the monthly payments recorded in the amortization 
schedule. 
 To prepare receipts for leasing or lo an transactions for customers paying via 
standing order. 
Setups 
 Define bank accounts (including the days the bank is open) – if a loan was taken 
from the bank to finance the leasing transaction. 
 Define accounts: the leasing transaction, various income accounts – principal, 
interest, linkage (for dual-currency users) 
 Define statuses for leasing transactions (run the BPM Flow Chart-Leasing 
program) 
 Define leasing purposes (see below) 
 Define types of interest (see below) 
 Dual-currency users: Record the consumer price index in the system (see 
below). 
Defining Leasing Purposes 
By defining purposes for leasing transactions, you can group together all transactions 
that serve the same purpose and define default GL accounts required for 
transactions with each purpose. 
1. Enter the Purposes of Leasing Transactions form. 
2. Record each Purpose of Loan. 
3. Select the relevant Leasing Type . 
4. Dual-currency users: If you are not charging interest, flag the Charge Linkage 
Only column. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

5. In the Display Order column, specify a number to determine the relative order of 
this purpose in Choose lists. 
6. Record the default GL accounts for all loans that are assigned this purpose: 
Principal Income Account, Interest Income Account, Linkage Income 
Account (for dual-currency users) and Income Contra Account (relevant to 
leasing transactions). 
Defining Types of Variable Interest 
Interest rates for loans with variable interest are defined according to their base rate. 
1. Enter the Currencies form. 
2. Record the interest code in the Curr column (e.g., "P" for prime). 
3. Flag the Interest  column. 
4. To record the interest rate, click  Exchange Rates from the list of Direct 
Activations. 
5. Record the Date the rate goes into effect. 
6. Enter the Itemized Rates sub-level form and, in the appropriate interest line, fill in 
the Exchange Rate. 
Dual-currency Users: Recording the Consumer Price Index 
To record the index for a given month (generally released on the 15th of the following 
month), you need to record the index on two dates: the first day and the last day of 
the month. 
1. Enter the Currencies form and make sure that a "currency" has been defined for 
the Price Index. 
2. Click  Exchange Rates from the list of Direct Activations. 
3. Record the first date of the month. 
4. Enter the Itemized Rates sub-level form and fill in the Exchange Rate for the 
Price Index line. 
5. Do the same for the last day of the month. 
Procedure 
Stage I: Recording a Leasing Transaction 
For each leasing transaction you can plan the payment sum, interest rate or number 
of payments. 
1. Enter the Leasing and Company Loans form. 
2. Fill in the columns in the Details  tab: 
 The Bk Acct and Loan Number columns are only necessary when a bank 
loan is taken for this transaction. 
 The sum paid when the leasing transaction is signed is recorded in the Deposit 
(Loan#) column. 
 If a customer invoice was prepared for a company loan, record it in the Cust. 
Invoice column. 
Cat.No. LB110539 2 Ver.1 – Aug. 22, ’11

3. Dual-currency users: In the Linkage tab, you can choose the Linked Currency, 
record the Linked Rate Date (appears automatically, but may be revised), 
Principal Linkage % and Interest Linkage %. 
4. Click the Interest Data tab and fill in one of the following: 
 The Fixed Interest column 
Notes: 
 You can calculate the interest per number of days by flagging the Int by 
Month Length column. 
 You can calculate fixed interest by clicking Calculate Interest Rate  from the 
list of Direct Activations. This program takes into account the number of 
payments and amount of each payment (as recorded in the Payment tab), 
provided that the value selected in the Amortization Sched. column is 
"Equal Payments". 
 The Variable Interest column (from the Choose list) together with the Margin. 
Note: To take all interest changes into account, flag the Incl All Rate Chngs 
column. 
5. Click the  Payment tab and select the appropriate value in the Amortization 
Sched. column. Fill in the No. of Paymts and Amt Ea Paymt columns. 
Note: If you chose a custom schedule, fill in the relevant details for the entire 
payment period in the Custom Amortization Schedule sub-level form. 
6. Revise the Pay Freq-Principal and Pay Freq-Interest columns, as needed. 
7. Specify the appropriate Adjustment Code. 
8. If the payments are debited at the end of the month, flag the Paymt at Month End 
column. 
9. Click Calculate Payment Amount or Calculate Number of Payments from the 
list of Direct Activations. 
10. If there are more payments for this transaction, enter the Additional Payments 
sub-level form. 
11. Click Prepare Amortization Schedule from the list of Direct Activations. 
12. To view the amortization schedule, enter the Amortization Schedule sub-level 
form or click Amortization Schedule from the list of Direct Activations. 
13. You can make any desired revisions and rerun the Prepare Amortization 
Schedule until you achieve the desired results. 
14. 
If there are guarantors for the loan, enter the Loan Guarantors sub-level form. 
15. If there is a bank guarantee for the loan, enter the Bank Guarantees sub-level 
form. 
16. Attach various documents like the contract or agreement in the Attachments 
sub-level form. 
17. Dual-currency users: If the payments are made via credit card or standing 
order, enter the Bank Acct/Credit Card to Charge sub-level form and fill in the 
relevant columns. 
Calculating and Checking the Leasing Transaction 
1. Click Prepare Amortization Schedule from the list of Direct Activations. 
Cat.No. LB110539 3 Ver.1 – Aug. 22, ’11

2. To view the amortization schedule, enter the Amortization Schedule sub-level 
form or click Amortization Schedule from the list of Direct Activations. 
3. In the Details tab, change the Status to Active.  
Result: 
 The details of the leasing transaction or loan are recorded in the system. 
Stage II: Preparing Customer Invoices for Leasing Transactions 
Before each payment is actually debited, it may be necessary to adjust the 
amortization schedule (e.g., in the case of variable interest). After the payment is 
debited, a journal entry needs to be recorded for the payment. 
1. Run the Update Interest Amounts program. 
2. Enter the Leasing and Company Loans form. 
3. Make sure the  Status is Active. 
4. To view the updated amortization schedule, enter the Amortization Schedule 
sub-level form. 
5. Run the Prepare Invoices program. 
6. In the input screen, specify the start and end dates of the period for which to 
prepare invoices, as well as the desired invoice date. 
Note: When the entry is recorded, the payment line in the Amortization 
Schedule sub-level of the Leasing and Company Loans form is flagged as 
Paid. 
7. If this is the last payment, change the Status of the transaction to Closed. 
8. Complete and finalize the invoices according to standard operating procedures. 
Results 
 Customer invoices are prepared according to the amortization schedule. 
 In the Amortization Schedule sub-level form, you can see the relevant invoice 
number for each line. 
Stage III: Receiving Early Payments 
Before each payment is actually debited, it may be necessary to adjust the 
amortization schedule (e.g., in the case of variable interest). After the payment is 
debited, a journal entry needs to be recorded for the payment. 
1. Run the Update Interest Amounts program. 
2. Run the Redo Schedule for Early Repaymt program. 
3. Enter the Leasing and Company Loans form and retrieve the desired leasing 
transaction. 
4. Make sure the  Status is Active. 
5. To view the updated amortization schedule, enter the Amortization Schedule 
sub-level form. 
6. Continue according to Stage II of these operating procedures. 
7. If this is the last payment, change the Status to Closed. 
Cat.No. LB110539 4 Ver.1 – Aug. 22, ’11

Cat.No. LB110539 5 Ver.1 – Aug. 22, ’11 
Stage IV: Postponing Payments 
If an agreement is made to freeze some of the payments, you need to update the 
amortization schedule accordingly. 
1. Enter the Leasing and Company Loans form and retrieve the desired transaction. 
2. Enter the Postponement of Payment Dates sub-level form. 
3. Specify the Payment Number of the postponed payment and record the new 
payment date in the Payment Due on column. 
4. If compounded interest is charged, flag the  Compounded Interest column. 
5. Return to the upper-level form and click Prepare Amortization Schedule from 
the list of Direct Activations. 
6. Change the Status to Frozen. 
7. When the postponed payment is received, change the Status back to Active. 
Result 
 The amortization schedule is updated according to the payment postponements. 
Stage V: Recording Credit Memos 
In the case of a deposit loan (from the customer), it is necessary to prepare credit 
memos. 
1. Run the Prepare Credit Memos program.  
2. Complete and finalize the memos according to standard operating procedures. 
Results 
 Credit memos are prepared that include interest charges and (in the dual-currency 
system) linkage of the amounts paid upon signing of the agreement (deposit loan). 
 In the Amortization Schedule sub-level form, you can see the relevant memo 
number for each line. 
Stage VI: Preparing Receipts 
Receipts must be prepared for incoming leasing and company loan payments made 
by standing order. 
1. Enter the Leasing and Company Loans form and retrieve the desired transaction. 
2. Enter the Bank Acct/Credit Card to Charge sub-level form and make sure the 
details are correct  
3. Run the Prepare Receipts program. 
4. If an error is received when running the program, run the Prepare Invs/Receipts - 
Errors program. 
5. Complete and finalize the receipts according to standard operating procedures. 
Results 
 Receipts are prepared for customers paying via standing order. 
 In the Amortization Schedule sub-level form, you can see the relevant receipt 
number for each line.
