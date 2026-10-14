# 14-17-Cash Flow

- **Source:** `14-17-Cash Flow.pdf`

www.priority -software.com   
1/5 ‏Mar. 11,'15 Ver. 02 Cat.No. LB10000728 
2 
 SOP: Cash Flow 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
The Cash Flow report displays the financial transactions in which funds are deposited in and 
withdrawn from bank accounts. On the basis of the opening balances in these accounts and these 
transactions, it calculates closing balances. 
The Cash Flow Forecast report displays the expected intake and outflow of funds based on 
financial documents recorded in the system that are due in the future, as well as documents that 
have yet to become cash transactions (e.g., customer and purchase invoices) and provisional 
entries. 
Setups 
Defining Cash Flow Codes 
Cash flow codes are used to analyze financial transactions (to and from bank accounts) according 
to pre-defined categories. Any transaction involving a bank account (e.g., vendor payments by 
check or bank transfer, customer receipts, deposits, journal entries) can be linked to a cash flow 
code. 
 Enter the Cash Flow Categories form and fill in the Code and Description of every category you 
wish to create. 
Linking Cash Flow Codes to Customers and Vendors 
You can link a cash flow code to each A/R and A/P account so that every receipt or deposit (in the 
case of a customer) and every check or bank transfer payment (in the case of a vendor) is 
automatically assigned the desired category. 
1. Enter the Chart of Accounts Receivable form, press F4 and, in the Additional Definitions tab, 
select the desired Cash Flow Code for each account. 
2. Enter the Chart of Accounts Payable form, move to Full-Record Display and, in the Additional 
Definitions tab, select the desired Cash Flow Code for each account. 
Linking Cash Flow Codes to Journal Entry Codes  
(for payments and receipts) 
1. Enter the Journal Entry Codes form and retrieve the desired entry code. 
2. Enter the Entry Patterns sub-level form and move to the line for the deposit account (CASH or 
TOCASH). 
3. Select the desired Cash Flow Code. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 ‏Mar. 11,'15 Ver. 02 Cat.No. LB10000728 
2 
Linking GL Accounts to Cash Flow Forecasts  
GL accounts are linked to cash flow bank accounts rather than to cash flow codes. Linking cashier 
accounts to cash flow bank accounts allows the display of a cashier's undeposited contents as 
expected cash flow into the relevant bank account. 
1. Enter the Chart of Accounts form and retrieve the desired account. 
2. Move to Full-Record Display and, in the Additional Definitions tab, select the desired Bk Acc 
for Cash Flow. 
Procedure 
Stage I: Assigning a Cash Flow Code to a Journal Entry 
Assign cash flow codes to all relevant journal entries. An entry that has no cash flow code will 
appear in reports as an unaffiliated transaction under the general code "No Category."  Assign cash 
flow codes to payment transactions (i.e., to vendors) and receipt transactions (e.g., customer 
receipts, over-the-counter invoices). You can also assign codes to deposits, returns of customer 
payment and manual journal entries involving bank accounts (e.g., salary payments). 
A. Assigning Cash Flow Codes to Pending Entries for Payments, Receipts or Deposits 
Whenever a payment, receipt or deposit document is finalized, a journal entry is created that is 
linked to the default cash flow code defined for the bank account involved in the transaction. You 
can change the code for each line in the journal entry. 
1. Enter the relevant payment/receipt/deposit form (Check Payments, Payments by Bank Transfer, 
Over-the-Counter Invoices, Receipts, Returned Payments, Deposit Slips) and retrieve the 
transaction in question. 
2. In the References tab, press F6 from the Entry No. column. The Journal Entries form will 
open. 
3. Enter the Itemized Entry sub-level form and move to the line for the bank account in question. 
Move to Full-Record Display and, in the General tab, select the desired Cash Flow Code. 
B. Assigning Cash Flow Codes to Posted Journal Entries 
If the journal entry is already posted, you can still change the cash flow code. 
1. Enter the Entry Revisions form and retrieve the journal entry in question. 
2. Enter the Itemized Revisions sub-level form and move to the line for the bank account in 
question. Select the desired Cash Flow Code. 
Stage II: Running Cash Flow Reports 
The Cash Flow report displays the intake and outflow of funds for one or more bank accounts, 
sorted according to cash flow codes. 
1. Run the Cash Flow report. 
2. In the input screens, select the report's time frame (Yearly, Quarterly, Monthly or Detailed), 
calculation method (separate or combined accounts) and reference date for journal entries (Due 
Date, Transaction Date or Reference Date). 
Stage III: Setting Up the Cash Flow Forecast  
The Cash Flow Forecast is based on financial documents recorded in the system that are due in the 
future, as well as expected transactions who due dates fall within the designated report period.

www.priority -software.com   
3/5 ‏Mar. 11,'15 Ver. 02 Cat.No. LB10000728 
2 
You can run a forecast report for a customer, vendor, bank account, credit card account or cashier. 
A. Linking an account to a bank code 
If the sums in a given ledger account (e.g., a cashier account) are always deposited in the same 
bank account, you can include the transactions involving that ledger account in cash flow forecasts 
for that bank account. 
 Enter the Chart of Accounts, Chart of Accounts Receivable or Chart of Accounts Payable form 
and retrieve the desired account. Press F4 and, in the Bk Acc for Cash Flow column 
(Additional Definitions tab), select the bank account to which you want to link the ledger 
account. 
B. Linking an account to a cash flow code 
In the Chart of Accounts, Chart of Accounts Receivable and Chart of Accounts Payable forms, 
you can link each account to a cash flow code, in order to run a cash flow forecast broken down by 
code. 
 For the account in question, select the desired Cash Flow Code (Additional Definitions tab). 
C. Excluding an account from cash flow analysis 
You can flag an A/R or A/P account to exclude it from cash flow analysis. This is appropriate, for 
example, when accounts are defined for fictitious customers. 
 In the Additional Definitions tab, flag the Omit from Cash Flow column. 
D. Defining a main bank account 
You can define a bank account as the main bank account, such that all customer and vendors that 
are not linked to a specific bank account will be linked to it automatically. 
1. Enter the Bank Accounts form and retrieve the desired bank account. 
2. Flag the Main Bank Account column. 
E. Defining opening balances for cash flow analysis 
You can manually record a bank account's opening balance for the purpose of cash flow analysis. 
When running cash flow reports, you can choose whether to display these balances, or those 
recorded in the ledger. Manual balances are necessary when the balances appearing in the ledger 
do not reflect the actual balance (e.g., if salaries were paid but journal entries were not yet posted 
for them). 
 In the Bank Accounts form, record the amount in the Cash Flow Balance column. 
F. Defining average late payments for customers and vendors 
You can define the average amount of time that payments arrive late from customer or are delayed 
to vendors. The Cash Flow Forecasts report takes these values into account in its calculations, 
adding the defined number of days to invoice payment dates. 
For customers: 
1. Enter the Financial Parameters for Customers form and retrieve the desired customer. 
2. Click the Credit tab and fill in the Average Late Payments column. 
For vendors: 
1. Enter the Financial Parameters for Vendors form and retrieve the desired vendor. 
2. Click the Add'l Details tab and fill in the Avg Late Payments column.

www.priority -software.com   
4/5 ‏Mar. 11,'15 Ver. 02 Cat.No. LB10000728 
2 
G. Defining cash flow dates for journal entry items 
You can record a cash flow date for entries that differs from the entry's due date. This is useful when 
you do not want to change the entry's original due date, but you want to display the entry with a 
different date in cash flow reports. 
Do one of the following: 
 Enter the Entry Item Revisions form. Retrieve the entry items in question and specify the desired 
Cash Flow Date. 
 In the relevant Chart of Accounts, enter the Unreconciled Transactions sub-level form and 
specify the desired Cash Flow Date. 
Note: If no cash flow date is specified, the entry will appear in cash flow reports with the entry's due 
date. 
H. Manually recording sums for cash flow forecasts 
You can manually record one-time provisional entries or monthly ones (e.g., for salaries). 
1. Enter the Cash Flow Forecast Sums form. 
2. Specify the Date, Credit Sum or Debit Sum, Currency and Bank Account. 
3. If this sum recurs periodically, flag the Monthly Entry column and specify the expected Interval 
in Months. If the entry is only expected to be repeated until a certain date, fill in the To Date 
column. 
I. Recording provisional entries automatically 
You can include open orders and unbilled transactions in cash flow forecast reports. To do so, you 
can automatically create provisional journal entries for such transactions. 
1. Run the Delete Provisional Entries program to delete all provisional entries created automatically 
for the previous report, which are no longer relevant. This program does not delete provisional 
entries created manually in the Cash Flow Forecast Sums form.  
2. When recording a purchase demands form or a purchase order, you can exclude the document 
from cash flow forecasts by flagging the Omit from Cash Flow column. 
3. When recording a purchase order, you can define payment installments in the Payment Terms 
for Order sub-level form that will affect provisional entries for the Cash Flow Forecast report. 
4. Run the Create Provisional Entries program. 
5. Select the documents for which to create provisional entries (sales orders, purchase orders, 
purchase requisitions, unbilled shipments, unbilled GRVs). 
Notes:  
 If you chose to create provisional entries for forecast orders as well, the program will prepare 
sales orders up to the specified date and forecast orders thereafter (in order to prevent 
duplication of data). 
 To ensure that provisional entries are created for unbilled GRVs and purchase orders, enter the 
Default Accounts form and make sure that a default account has been assigned to 
Purchases/Inventory transactions.  
 To ensure that provisional entries are created for unbilled shipments and sales orders, enter the 
Default Accounts form and make sure that a default account has been assigned to Income and 
Tax Exempt Income transactions.

www.priority -software.com   
5/5 ‏Mar. 11,'15 Ver. 02 Cat.No. LB10000728 
2 
Stage IV: Running the Cash Flow Forecast Report 
1. Run the Cash Flow Forecast. 
2. In the input screen, specify the range of dates within which transactions should be included. 
Note: You cannot run this report for dates in the past. 
3. Select the bank accounts you want to include in the report. 
4. In the What to Display column, select the data to be displayed in the report (banks, vendors, 
customers or all the above). 
5. Choose the desired Level of Detail and Time Periods. 
6. Choose the desired source of Opening Balances: 
 From the Chart of Accounts: The report will display the opening balances recorded for each 
account in the ledger. 
 User-defined: The report will display the opening balances recorded manually in the Bank 
Accounts form. 
 No Opening Balances. 
7. Select the Currency in which to display the report. 
8. Flag the Provisional Entries column to include automatic and manual provisional entries in the 
report. 
Note: Make sure you ran the Create Provisional Entries program (to include open orders and 
unbilled transactions) and recorded the desired manual entries (to include transactions not 
based on orders or invoices, such as salaries). 
9. Flag the Unreconc'd Entries column to include entries linked to payments and receipts that 
were recorded in the system but not yet reconciled against bank or credit card statements. 
10. Flag the With Payment Delays column to add to due dates the average number of days 
payment is delayed from customers and to vendors. 
11. Flag the Show Past Dates column to include entries whose due dates fall before the designated 
report period, but have not yet been paid.
