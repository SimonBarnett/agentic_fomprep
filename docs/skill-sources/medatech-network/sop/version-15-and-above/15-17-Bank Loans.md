# 15-17-Bank Loans

- **Source:** `15-17-Bank Loans.pdf`

www.priority -software.com   
1/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110541 
 
 SOP: Loans 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To set up and maintain the basic parameters required to process loans 
 To use available tools to create various scenarios before taking a loan from the bank 
 To record and maintain actual loans. 
Setups 
 Define bank accounts (including the days the bank is open) 
 Define statuses for loans (run the BPM Flow Chart-Bank Loans program) 
 Define loan purposes (see below) 
 Define types of interest (see below) 
 Dual-currency users: Record the consumer price index in the system (see below). 
Defining Loan Purposes 
By defining purposes for loans, you can group together all loans that serve the same purpose and 
define default GL accounts required to open loans for each purpose. 
1. Enter the Purposes of Loans form. 
2. Record each Purpose of Loan. 
3. Record the default GL accounts for all loans that are assigned this purpose: Loan Account, 
Interest Expense Account, PrincipalLinkage Acct and Interest Linkage Acct (the last two 
for dual-currency users). 
Defining Types of Variable Interest 
Interest rates for loans with variable interest are defined according to their base rate. 
1. Enter the Currencies form. 
2. Record the interest code in the Curr column (e.g., "P" for prime). 
3. Flag the Interest column. 
4. To record the interest rate, select Exchange Rates from the list of Direct Activations.  
5. Record the Date the rate goes into effect. 
6. Enter the Itemized Rates sub-level form and, in the appropriate interest line, fill in the 
Exchange Rate. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110541 
 
Dual-Currency Users: Recording the Consumer Price Index 
To record the index for a given month (usually released on the 15th of the following month), you 
need to record the index on two dates: the first day and the last day of the month. 
1. Enter the Currencies form and make sure that a "currency" has been defined for the Price Index. 
2. Select Exchange Rates from the list of Direct Activations. 
3. Record the first date of the month. 
4. Enter the Itemized Rates sub-level form and fill in the Exchange Rate for the Price Index line. 
5. Do the same for the last day of the month. 
Procedure 
Stage I: Recording a Trial Loan 
Before taking a loan, you can create test scenarios in the system. There are two tools with which 
you can plan loans: the Loan Calculator and the Bank Loans form. 
The Loan Calculator 
The Loan Calculator is useful for planning loans that include monthly payments at a fixed rate of 
interest – whose percentage of principal and interest are identical in each payment – or equal-
principal payments). This is more accurate than using the Bank Loans form. 
1. Run the Loan Calculator report. 
2. In the first input screen, choose the desired Amortization Type (Equal Payments or Equal 
Principal). 
3. In the second input screen, record either the Interest Rate or Monthly Payment amount. 
The Bank Loans Form 
In the Bank Loans form, you can plan loans with more frequent payments or with variable interest. 
The basic parameters that can be revised are: interest rate, number of payments and payment 
amounts. 
1. Enter the Bank Loans form and fill in all the mandatory columns (e.g., Date of Loan, Loan 
Number). 
2. Click the Interest Data tab and fill in either the Fixed Interest or the Variable Interest (select a 
value from the Choose list), as well as the Margin. 
3. Click the Payment Data tab and fill in the Amortization Sched. (see the F1 help to understand 
the different types), the No. of Payments and the Amt of Each Paymt. 
4. Revise the Pay Freq-Principal and Pay Freq-Interest columns, as needed. 
5. If the payments are debited at the end of the month, flag the Paymt at Month End column. 
6. Select one of the following programs from the list of Direct Activations: Calculate Payment 
Amount, Calculate Interest Rate, or Calculate Number of Payments. 
7. Select Prepare Amortization Schedule from the list of Direct Activations. 
8. To view the amortization schedule, enter the Amortization Schedule sub-level form or select 
Amortization Schedule from the list of Direct Activations. 
9. You can make any desired revisions and rerun the Prepare Amortization Schedule until you 
achieve the desired results.

www.priority -software.com   
3/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110541 
 
Stage II: Recording a New Loan 
1. Enter the Bank Loans form and fill in all the mandatory columns (e.g., Date of Loan, Loan 
Number). 
2. In the Loan tab, record the Account Number (the account from which the loan will be repaid) 
and Contract Number. 
3. Dual-currency users: Click the Linkage tab and fill in the following details: 
 If the loan is linked to the consumer price index, select the index in the Linked Currency 
column. 
 Specify the Linked Rate Date and Base Rate. 
 To allow negative linkage, flag the Negative Price Adj column. 
 If the principal and/or interest are partially linked, record the linked percentages in the 
Principal Linkage % and Interest Linkage % columns. 
4. Click the Interest Data tab and fill in either the Fixed Interest or the Variable Interest (select a 
value from the Choose list), as well as the Margin. 
5. If there are guarantors for the loan, enter the Loan Guarantors sub-level form. 
Preparing the Amortization Schedule 
1. Click the Payment Data tab and fill in the Amortization Sched. column (see the F1 help to 
understand the different types). 
Note: If you chose a custom schedule, fill in the relevant details for the entire payment period in 
the Custom Amortization Schedule sub-level form. 
2. Fill in the No. of Payments and Amt of Each Paymt, frequency of payments and first pay 
dates, and the Calc. Interest as of column. If the payments are debited at the end of the month, 
flag the Paymt at Month End column. 
3. If a fee is collected for each payment, specify the fee in the Fixed Fee/Paymt column. 
4. For a loan with fixed interest, you can calculate the interest per number of days and flag the Int 
by Month Length column (in the Interest Data tab). 
5. For a loan with variable interest you can take all interest changes into account by flagging the 
Incl All Rate Chngs column. 
Calculating and Checking the Loan 
1. Select Prepare Amortization Schedule from the list of Direct Activations. 
2. To view the amortization schedule, enter the Amortization Schedule sub-level form or select 
Amortization Schedule from the list of Direct Activations. 
3. In the Loan tab, change the Loan Status to Active.  
Stage III: Making Loan Payments 
Before each payment is actually debited, it may be necessary to adjust the amortization schedule 
(e.g., in the case of variable interest). After the payment is debited, a journal entry needs to be 
recorded for the payment. 
1. Run the Update Interest Amounts program. 
2. Enter the Bank Loans form and retrieve the desired loan. 
3. Make sure the Loan Status is Active.

www.priority -software.com   
4/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110541 
 
4. To view the updated amortization schedule, enter the Amortization Schedule sub-level form. 
5. Run the Loan Payments - Posting Preview report and check the results. 
6. Run the Record Loan Payments in Journal program. 
Note: When the entry is recorded, the payment line in the Amortization Schedule sub-level of 
the Bank Loans form is flagged as Paid. 
7. If this is the last payment, change the Loan Status to Closed. 
Stage IV: Making Early Loan Payments 
Before each payment is actually debited, it may be necessary to adjust the amortization schedule 
(e.g., in the case of variable interest). After the payment is debited, a journal entry needs to be 
recorded for the payment. 
1. Run the Update Interest Amounts program. 
2. Run the Redo Schedule for Early Repaymt program. 
3. Enter the Bank Loans form and retrieve the desired loan. 
4. Make sure the Loan Status is Active. 
5. To view the updated amortization schedule, enter the Amortization Schedule sub-level form. 
6. Run the Loan Payments - Posting Preview report and check the results. 
7. Run the Record Loan Payments in Journal program. 
Note: When the entry is recorded, the payment line in the Amortization Schedule sub-level of 
the Bank Loans form is flagged as Paid. 
8. If this is the last payment, change the Loan Status to Closed. 
Stage V: Postponing Loan Payments 
If the bank agrees to freeze some of the payments, you need to update the amortization schedule 
accordingly. 
1. Enter the Bank Loans form. 
2. Enter the Postponement of Payment Dates sub-level form. 
3. Specify the Payment Number of the postponed payment and record the new payment date in 
the Payment Due on column. 
4. If the bank charges compounded interest, flag the Compounded Interest column. 
5. Return to the upper-level form and select Prepare Amortization Schedule from the list of Direct 
Activations.  
6. Change the Loan Status to Frozen. 
7. When you are ready to make the postponed payment, change the Loan Status back to Active.
