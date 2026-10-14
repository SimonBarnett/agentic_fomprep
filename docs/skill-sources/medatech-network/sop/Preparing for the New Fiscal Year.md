# Preparing for the New Fiscal Year

- **Source:** `Preparing for the New Fiscal Year.pdf`

Cat.No. LB120286 1 Ver.1, Dec. 02, ‘12 
 Preparing for the New Fiscal Year              
Click on  
   to see an instructional video on preparing for the new fiscal year. 
1. Operations to Perform During December 2012 Before Commencing Work in 2013 
Define the New Fiscal Year 
Open a new fiscal year in the Define Fiscal Years form for 2013. Twelve fiscal periods will be defined in the 
Fiscal Periods sub-level form. 
To enable users to record journal entries for the month of January, run the Open Fiscal Period program for the 
first period in 2013. 
Document Numeration  
Document numbers in the system are determined on a yearly basis. To prepare for a new fiscal year, initialize 
document numbers by running the Open Numeration Templates program for 2013.  
Note: To use the same document number prefixes as those used in 2012, flag the Base Prefix on Prev 
column when running the Open Numeration Templates program. 
After running the program, you can change prefixes from the defaults set by the program, in the Document 
Numeration Templates form. 
Once the first document of each particular type is recorded in the new year, you will no longer be able to 
change the numbering of that document type. Therefore, check the numberings carefully before 
beginning to record documents. For example, make sure there are enough continuous numbers available and 
that similar documents do not begin with the same number (e.g., multi-shipment invoices and sales invoices), 
that the total number of characters is enough to include the prefix, and that the starting number and the 
estimated amount of documents are sufficient for your needs. 
Tip: Run the Set Up Financial Docs Wizard for help. 
2. Operations to Perform on December 31, 2012 
Note: For those organizations not working on Dec. 31, 2012, these operations may be performed at the close 
of business on Dec. 30, 2012. 
Compare the Contents of the Cashier to the Cashier Balance 
1. Perform a comparison between the following items: 
 The actual contents of your cashiers 
 The data in the Cashier Balance sub-level of the Cashiers form 
 The balance in each cashier account in the general ledger. 
2. Run the Cashier Balance report at the end of the day to obtain balances for all cashiers on Dec. 31, 2012. 
3. After verifying that the contents are correct, it is recommended that you record Dec. 31, 2012, in the 
Closing Date column. After recording a date in this column: 
 You will no longer be able to record receipts or deposits for any earlier date (thereby ensuring the 
cashier content data will not change). 
 You will have an accurate picture of cashier contents at the end of 2012.  
Note: It is recommended to save printed copies of any such reports and/or flag the Block Delete option. 
Run Additional Reports 
In addition to the Cashier Balance report, there are other important end-of-year reports that can only be run 
for the current date, and therefore should be run by December 31, 2012: 
                                                           
  The names of all forms, programs and reports in this document are linked; clicking their titles automatically 
opens them, provided the system is running and you have the required permissions to view them. 
Alternatively, you can access them via the Search for Entity tool, which is documented in the User 
Interface Guide available on both your Help menu and the Eshbel website.

Cat.No. LB120286 2 Ver.1, Dec. 02, ‘12 
 The reports in the Unbilled Shipmt/S. Call Reports menu** 
 Unbilled GRV's 
 Principal Payments per Year (for users of the Loans module) 
 Postdated Checks Held in Bank (for Dual-Currency users) 
3. Operations to Perform at the Beginning of 2013 
Transfer Opening Balances 
Run the Transfer Opening Balances program. 
Note: You can rerun this program each time entries are added for the 2012 fiscal year. The program updates 
the opening balance for 2013 based on the new entries. 
4. Troubleshooting  
Problem Solution 
System 
Record the year 2013 in the Define Fiscal Years form. 
Run the Open Numeration Templates program. 
You cannot open documents either for 1/1/2013, 
or for 2012. 
Check the Financial Documents or Inv. Transaction Documents form, 
to see if there is a pre- or post-date limit on the document in question. 
Inventory 
You need to perform an inventory count. Run the Inventory Count Wizard. 
You want to approve all lines of the inventory 
count at once. 
Select the Approve Inventory Count program from the list of Direct 
Activations in the Inventory Count form. 
You need to run an inventory valuation report. These reports can be found in the Financial menu, under the Cost 
Analysis for Businesses sub-menu. For additional information, click 
here. 
You want to prevent the recording of inventory 
transactions in 2012.  
Run a past balance for December 31, 2012, using the Calculate 
Balance for Date program. 
Inventory transactions were recorded for 2012 
after an inventory count was recorded for that 
year. 
The balance in an inventory report differs from 
the recorded counted quantity.  
First make sure that the lines of the last inventory count are not 
flagged in the Approve Counted Qty column. Then run the Prepare 
for Recount program, which will update the Calculated Qty column in 
a new inventory count. 
Financials 
You want to prevent all users but the accountant 
from writing entries for 2012. 
Close all fiscal periods in 2012 and record the accountant in the 
Users Authorized for Closed Per. form (sub-level of the Fiscal 
Periods form, itself a sub-level of the Define Fiscal Years form). 
Record the year 2013 in the Define Fiscal Years form. You cannot record a journal entry for 2013. 
Run the Open Fiscal Period program for the period in which the 
journal entry falls. 
The balance recorded for a cashier differs from 
its actual contents. 
This usually occurs as a result of manually recorded journal entries. 
Run the Check Cashiers report to identify the problematic entries. 
The trial balance total differs from the sum of the 
ledger’s entries. 
Run the Transfer Opening Balances program for the new year. If this 
does not solve the problem, try the following solution: 
A trial balance does not balance. Run the Update Account Balances program for 2012, then run the 
Transfer Opening Balances program again for 2013. If this does not 
solve the problem, try the following solution: 
                                                           
** Under Financials > Accounts Receivable > Accounts Receivable Reports > Monthly Closing Reports.

Cat.No. LB120286 3 Ver.1, Dec. 02, ‘12 
Run the Check Journal Entries report. 
A profit & loss item does not show a 0 balance 
at the beginning of the year. 
A balance sheet item was reduced to 0 by 
mistake. 
In th
e Chart of Accounts form, change the Bal Sheet/P&L Item to one 
that belongs to a heading in the correct section (press F6 on the Bal 
Sheet/P&L Item to view the headings and their sections). Then run the 
Transfer Opening Balances program again for 2013. 
You need to record a document or journal entry 
for 2012. 
Y ou can continue recording journal entries and issuing documents for 2012. 
You should run the Transfer Opening Balances program periodically for 
2013, to update the balance. 
You need to check the details of an end-of-year 
account balance. 
Run the Open Transactions as of Date report. 
You need to record depreciation of a fixed asset. Run the Fixed Assets Wizard. 
 
5. Backing Up the System  
It is extremely important to perform regular daily backups of your database, and store your backup tapes in a 
separate, protected place (e.g., your house or one of the manager’s).  
NOBODY CAN HELP YOU if your server is stolen or destroyed! 
Unless your data is preserved on a backup tape, YOU WILL LOSE EVERYTHING! 
Instructions for backing up the system can be downloaded from the Eshbel online documentation library at 
http://www.eshbel.com/customerarea.htm, under the topic System Management. 
6. System Upgrades 
You can upgrade your system for free in the framework of a service contract. Click Help > About Priority to 
see which version you are running. 
Instructions for upgrading from version 14 or 15 to version 15.3 can be found here. Starting with version 15.3, 
you can run Priority from mobile devices, including smartphones and tablets. To see a list of new features 
included in version 15.3, click here.
