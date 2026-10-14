# 16-17-Financial Statement Generator

- **Source:** `16-17-Financial Statement Generator.pdf`

www.priority -software.com   
1/4 Feb. 25, '15 Ver. 2 Cat.No. LB130059  
 
 SOP: Financial Statement Generator1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
General 
Priority comes with many built-in financial statements: balance sheet, profit and loss, and trial 
balance. Occasionally the need arises for a financial statement of a different structure than those 
provided with the system. For example, a publicly traded company may require a report in a special 
format, or a conglomerate may need a consolidated report that does not include sales between 
companies in the group. 
Aim 
 To design custom financial statements for use by the company. The financial statement 
generator gives you the freedom to choose which data to display, and how to display them. This 
provides a wide range of data cross-sections with which to analyze your financial data. 
Setups 
 Define headings in the Bal. Sheet/P&L Report Headings form. 
 Define balance sheet/profit and loss items in the following forms: Bal. Sheet/P&L Items-GL 
Accounts, Bal. Sheet Items - A/R Account, and Bal. Sheet Items - A/P Account. 
 Define items in the Trial Balance Items form. 
 Assign the appropriate Trial Balance Item and Bal. Sheet/P&L Item to GL, A/R and A/P 
accounts. 
 Define account groups in the Account Groups form, so that you can display data per group.  
 For companies that produce account tree reports: Define an account tree in the Account Tree 
form. Account tree reports are hierarchical in nature. When defining the tree, build it to reflect the 
account hierarchy used in the company. The length of the string in the Account No column 
determines the level within the hierarchy, and the numbers themselves determine their relation 
to other accounts. For example, account number 1 is defined as “Properties”; account number 
11 is defined as “Joint Properties” and is automatically placed below and linked to “Properties”; 
and so on for account numbers 110 and 1101. In contrast, account number 2 starts a new 
branch in the tree, with number 21 related to number 2 as above. The Account No also serves 
to link the accounts from which the data is derived to their respective rows in the report.    
Procedure 
Stage I: Creating Report Templates Automatically 
Aim: To define a customized report, including headings, items, and accounts, once for each report 
type. 
                                                
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 Feb. 25, '15 Ver. 2 Cat.No. LB130059  
 
1. Run the Create Customized Statement program. 
 Choose the desired report type: Balance Sheet, Profit and Loss, Trial Balance or Account 
Tree. 
 Choose between a Regular report, which combines account sums, or a Schedule, which 
displays each account sum separately. 
 Record a Report Title. 
Result: A balance sheet, profit and loss or trial balance report is built automatically based on 
the items assigned to each account in the appropriate chart of accounts form.. Or an account 
tree report is built based on definitions in the Account Tree form. 
2. To verify that all appropriate accounts have been included in the report, run the Check Custom 
Statement report, which displays accounts and items that are missing from a custom financial 
statement. 
3. To check the program results, enter the Makeup of Financial Statements form and move to the 
desired line in the newly created report. 
Tip: If you want sums to appear before the detailed data, make sure that the Totals Above 
Sums column is flagged for the report. This option is primarily used in account tree reports. 
4. Enter the Items in Statement sub-level form, and make any necessary revisions to the 
following: 
 The headings that will appear in the report 
 The position of each heading 
 The addition of sums on additional levels 
 
Tip: For trial balance or account tree reports, it is recommended that you add a line at the end, 
with a Ln number higher than any other in the report (e.g., 99999), that will help you check 
report definitions. Record “Check Statement Integrity” as the Title, set the Information Level to 
3, and flag the Detail column. 
5. In the parallel Accounts in Statement sub-level form you can modify the way data are 
displayed, according to: 
 Accounts displayed in the report 
 Balance sheet/P&L items 
 Trial balance items 
 Account group. 
 
Notes  
 If you have added a line at the end of the report in the parallel sub-level form, you must add it 
manually in this form as well. Record an asterisk (*) in the Account No. column, so that every 
account in the system that has not already been assigned to another item will appear in this 
item. When you run this report, if it has been properly defined, this line will be blank. 
 In the Debit Item column, you can only choose lines defined as information level "3" in the 
Items in Statement sub-level form. Data for the accounts linked to the debit line are only 
displayed if they have a debit balance. 
Result 
 The report template is created, with the headings, items and accounts you selected.

www.priority -software.com   
3/4 Feb. 25, '15 Ver. 2 Cat.No. LB130059  
 
Stage II: Defining Column Bars 
1. Enter the Definition of Column Bars form and define a Column Bar Title that will be easy to 
identify when running the report (e.g., "Quarterly P&L"). 
2. To allow the new report to be available to all users, flag the General Use column. 
3. Dual-currency users: In the Adjustment Date column, you can define the base date for indexed 
reports. In such a case, the report currency must be "index" (In). 
4. If this column bar is to be used for varying fiscal periods, define an Original Date, which will be 
used to adjust the fiscal period covered by the report. It is recommended that you define the 
Original Date as January 1st in the current year so that it will be easy for you to calculate the 
offset. 
5. Leave the check mark in the In Use column so that the column bar will appear among the 
available options when running the report. 
6. Enter the Columns in Bar sub-level form and fill in the following details: 
 Specify a Column Number from 1 to 50. Columns are displayed in ascending order (lowest 
numbers on top). 
 Specify a Title for the column. If this column bar is to be used for varying fiscal periods, avoid 
including a specific date in the title. If desired, you can use the <P1> and <P2> expressions to 
add a variable date. 
Tip: On how to use variable dates in the title, see the online column help (press F1). 
 Select the appropriate Column Type.  
Note: If, for example, you choose the Period Start type, you also need to specify the From 
Period and the Fiscal Year. 
 In the Curr column, select the currency in which the column values will be displayed. 
Tip for dual-currency users: You can prepare a column bar that displays two currencies, for 
example, the local currency and American dollars. To do so, define two different columns. In 
such a case, it is recommended to include the currency in the column title to avoid any 
confusion in the presentation of the data. 
 Flag the Hidden column to hide the current column. This is useful when defining a column 
whose value is used in an expression. 
 If the column bar will be used to produce consolidated reports: 
 To display data per company, specify the Full Company Name of each company 
whose data is displayed in the report. 
 To display data per division, specify the name of the Division, as defined in the 
Companies form. 
 If relevant, specify the appropriate Subsidiary. 
Tip: To allow users to select a subsidiary when running the report, record a question mark 
(“?”) here. 
 You can use the Group column to restrict the report to accounts belonging to a specific group. 
 You can use the Expression column to record a mathematical formula that uses the values in 
other columns defined in the column bar, and displays the results. For example, to display the 
value in Column #5 as a percentage of Column #3, you would record (#3/#5)*100. 
Result 
 You have created column bars that can be integrated into a variety of reports.

www.priority -software.com   
4/4 Feb. 25, '15 Ver. 2 Cat.No. LB130059  
 
Stage III: Running the Report 
 Run the Run Financial Statement program. In the input screen: 
1. Select the desired report. 
2. Select the desired column bar. 
3. Specify whether to run the report based on transaction dates or reference dates. 
4. To include accounts with zero balances in the report, flag the Display 0 Balances input 
parameter. 
5. To include the name of the user that ran the report, as well as the date and time it was run, 
flag the Show User+Time Stamp input parameter. 
6. If you are using a column bar that is meant for varying fiscal periods, and you wish to change 
the date range covered by it, specify a Report Date. The date range covered by the report is 
determined by the difference between the Report Date input parameter and the Original 
Date defined in the column bar. 
Tips: 
 You can save the report results to MS-Word in a pre-defined template. 
 To add the report to a menu, navigate to it, right-click the menu title, select Add User-Defined 
Report, select Makeup of Financial Statements and choose the desired report. 
Process Summary 
 A financial statement template was defined according to the user's requirements, including 
variations on headings, items and accounts. 
 A column bar was defined, which allows you to run the statements in different periods, for 
different companies, and in different currencies, and by which you can run comparisons between 
different periods.
