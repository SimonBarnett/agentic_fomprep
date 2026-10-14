# 291123 preparing for new year

- **Source:** `291123 preparing for new year.pdf`

1 
PREPARING PRIORITY FOR THE NEW YEAR  
This document describes all the steps needed for working in the new fiscal year. See below for an instructional video. In addition, 
in this document you can find full written details of the steps you should take , as well as troubleshooting information.  
 
CONTENTS  
 
Moving to the New Fiscal Year in a Multi Company Environment ................................ ................................ ................................ ....... 2 
Operations to Perform During December Before Working in the New Year ................................ ................................ .......................  2 
Define the New Fiscal Year ................................ ................................ ................................ ................................ ................................ . 2 
Document Numeration ................................ ................................ ................................ ................................ ................................ ....... 3 
Operations to Perform on the Last Working Day of the Year ................................ ................................ ................................ ................ 4 
Compare the Contents of the Cashier to the Cashier Balance ................................ ................................ ................................ ...... 4 
Run Additional Reports ................................ ................................ ................................ ................................ ................................ ........ 4 
Follow the End of Fiscal Period Guide ................................ ................................ ................................ ................................ ................ 5 
Operations to Perform at the Beginning of the New Year ................................ ................................ ................................ .................... 5 
Transfer Opening Balances ................................ ................................ ................................ ................................ ................................ . 5 
Troubleshooting ................................ ................................ ................................ ................................ ................................ ........................  5

2 
MOVING TO THE NEW FISCAL YEAR IN A MULTI COMPANY ENVIRONMENT  
Starting from version 21.1 if you work in a multi -company environment, you can perform several of the procedures covered in 
this document simultaneously for all the companies defined in Priority. The procedures are:  
1. Open a new fiscal year 
2. Prepare document numeration templates 
3. Transfer opening balances 
OPERATIONS TO PERFORM DURING DECEMBER BEFORE  WORKING IN  THE NEW YEAR  
DEFINE THE NEW FISCAL YEAR  
Open a new fiscal year in the Define Fiscal Years form for the new year.  
Path: Financials > Nominal Ledger > Fiscal Periods > Define Fiscal Years 
 
Twelve fiscal periods will be automatically defined in the Fiscal Periods sub-level form and may be modified here if required. 
 
To enable users to record journal entries for the month of January, run the Open Fiscal Period program for the first period in the 
new year or for the entire year (until period 12). 
Path: Financials > Nominal Ledger > Fiscal Periods > Open Fiscal Period 
 
Note: In versions 19.0 and higher, Priority Software made it more convenient to work with non-calendar fiscal years. To define 
non-calendar fiscal years, see the instructions here.

3 
DOCUMENT NUMERATION  
Document numbers in the system are determined on a yearly basis. To prepare for a new fiscal year, initialize document 
numbers by running the Open Numeration Templates program for the new year. 
Path: Financials > Maintenance of Financials > Auxiliary Programs > Open Numeration Templates 
 
To use the same document number prefixes as those used in the prior year, flag the Base Prefix on Prev field.  
After running the program, you can change prefixes from the defaults set by the program in the Document Numeration 
Templates form. 
Path: Inventory > Inventory Maintenance > Document Numeration Templates  
 
When using the same numbering, you may reach the maxim um number of the template. Starting from version 20.1, you can 
extend the template numbering. Just run the program Extend Document No. in the Document Numeration Template form (see 
action in above screenshot).  
The Preview field displays the number of the first document that will be produced when running the Open Numeration Templates 
program. This lets you to see how documents in the upcoming year will be numbered based on these definitions and modify 
them if necessary.  
WARNING: Once you record a document of a particular type in the new year, you will no longer be able to change the 
numbering of that document type for the current year. Therefore, check the numberings carefully before beginning to record 
documents. For example: 
a. Make sure there are enough continuous numbers available and that similar documents do not begin with 
the same prefix. 
b. The total number of characters for each document type is sufficient to include the prefix. 
c. The starting number and the estimated number of documents are sufficient for your needs. 
Should you require any additional information or assistance please contact Medatech support desk on: 
02380 460 400 or support@medatechuk.com

4 
OPERATIONS TO PERFORM ON THE LAST WORKING DAY OF THE YEAR  
Note: For those not working on Dec. 31st, these operations should be performed at the close of business on the last working day 
of the year. 
COMPARE THE CONTENTS OF THE CASHIER TO THE CASHIER BALANCE  
1. Perform a comparison between the following items:  
• The actual contents of your cashiers (by checking the physical contents) 
• The data in the Cashier Balance sub-level of the Cashiers form: Financials > Cash Management > Cashiers 
• The balance in each cashier ’s ledger account in the Chart of Accounts : Financials > Nominal Ledger > Chart of 
Accounts > Chart of Accounts  
2. Run the Cashier Balance report at the end of the last working day of the year to obtain balances for all cashiers: 
Financials > Cash Management > Cash Management Reports > Cashier Balance 
3. After verifying that the contents are correct, it is recommen ded that you rec ord Dec 31 of the current year in the Closing 
Date column in the Cashiers form. 
 
After recording a date in this column:  
• You will no longer be able to record receipts or deposits for an earlier date (thereby ensuring the cashier content data 
will not change).  
• You will have an accurate picture of cashier contents at the end of the year.  
Note: It is recommended to save printed copies of any such reports and/or flag the Block Deletion option on the saved copy of 
the report. 
 
RUN ADDITIONAL REPORTS  
In addition to the Cashier Balance report, there are other important end-of-year reports that can only be run for the current 
date, and therefore should be run by the end of the year: 
• Each of the reports in the Unbilled Shipmt/S. Call Reports menu: 
Financials > Accounts Receivable > Accounts Receivable Reports > Monthly Closing Reports > Unbilled 
Shipmt/S. Call Reports

5 
• Unbilled GRVs: 
Financials > Accounts Payable > Accounts Payable Reports > Purchasing Analysis Reports > Vendor Analysis 
Reports > Unbilled GRVs 
 
• Principal Payments per Year (for users of the Loans module):  
Financials > Bank Loans > Reports on Loans > Principal Payments per Year 
 
• Postdated Cheques Held in Bank (for non-US users): 
Financials > Cash Management > Cash Management Reports > Postdated Cheques Held in Bank 
 
• Run all financial statements from the following menu: Financials > Nominal Ledger > Financial Statements 
FOLLOW THE END OF FISCAL PERIOD GUIDE  
There are procedures in place that you should run at the end of every fiscal period. They also apply at the end of the fiscal  
year. See instructions here. 
OPERATIONS TO PERFORM AT THE BEGINNING OF  THE NEW YEAR  
Note: For those organizations not working on 1st January, these operations may be performed on the first day you return to work. 
TRANSFER OPENING BALANCES  
Run the Transfer Opening Balances program. 
Path: Financials > Nominal Ledger > Fiscal Periods > Transfer Opening Balances 
Notes: 
• For installations on version 22.1 or higher, when additional entries are added retroactively in the previous fiscal year , the 
balances in the current fiscal year are automatically updated and no additional action is needed.  
• For installations on version 22.0 or lower, rerun the Transfer Opening Balances program each time entries are added for the 
previous fiscal year, to update the opening balances for the current fiscal year, based on the new entries. 
TROUBLESHOOTING  
 
Problem  Solution  
System  
You cannot open documents for the new year  Record the new year in the Define Fiscal Years form. 
Run the Open Numeration Templates program for the new year. 
Check the Financial Documents or Inv. Transaction Documents form to 
see if there is a pre or post-date limit on the document in question. 
Inventory 
You need to perform an inventory count  Run the Inventory Count Wizard  
You want to approve all lines of inventory at once  Select Approve Inventory Count  program from the list actions in the 
Inventory Count form.  
You need to run an inventory valuation report  These reports can be found in the financials menu, for additional 
information click here  
You want to prevent the recording o f inventory 
transactions in the year that just ended. 
Run a pa st balance  for the end of the year, using the Calculate 
Balance for Date program.  
Inventory transactions were recorded for the year 
that just ended after an inventory count was 
recorded for that year  
First, make sure that the line of the last inventory count is not flagged in 
the approve Counted qty column. Then run the Prepare for Recount  
program, which will update the Calculated qty column in a new 
inventory count. 
The balance in an inventory report differs from the 
recorded counted quantity 
Run the Update Invent. By Past Balance  program to recalculate 
inventory levels. 
Financials  
You want to prevent all users , except specified 
finance staff, from writing entries for the previous 
year.  
Close all fiscal periods in the previous year and record the accountant 
in the Users Authorised for closed per. Form (sub -level of the fiscal 
period's form, itself a sub-level of the Define Fiscal Years form)  
You cannot record a journal entry for the new year  Record the new year in the Define Fiscal Year form.  
Run the Open Fiscal Period program for the period in which the journal 
entry falls 
The balance recorded for a cashier differs from, its 
actual contents.  
This usually occurs because of manually recorded journal entries. Run 
the Check Cashiers report to identify the problematic entries.

6 
The trial balance total differs from the sum of the 
ledger’s entries.  
Run the Transfer Opening Balances program for the previous year, then 
run the Transfer Opening Balances program again for the new year. If 
this does not solve the problem, try the solution in the box below.  
A trial balance does not balance  Run the Update Account Balances program for the previous year, then 
run the Transfer Opening Balances program again for the new year. If 
this does not solve the problem, try solution in the box below.  
Run the Check Journal Entries report. 
A profit & loss item does not show a balance at the 
beginning of the year  
In the Chart of Accounts form, change the Bal Sheet/P&L Item to one 
that belongs to a heading in the correct section (press f6 on the Bal 
Sheet/P&L Item to view the headings and their sections). Then run the 
Transfer Opening Balances program again for the new year.  A balance sheet item was reduced to 0 by mistake 
 
 
You need to record a document or journal entry for 
the previous year.  
You can continue recording journal entries and issuing documents for 
the previous year. You should run the Transfer Opening Balances  
program periodically for the new year, to update the balance.  
You need to check the details of an end -of-year 
account balance  
Run the Open Transactions as of Date report.  
You need to record depreciation of a fixed asset  Run the Fixed Assets Wizard.
