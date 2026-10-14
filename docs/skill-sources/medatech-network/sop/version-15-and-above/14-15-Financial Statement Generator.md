# 14-15-Financial Statement Generator

- **Source:** `14-15-Financial Statement Generator.pdf`

Cat.No. LB10000426 1 Ver.2 – Sep. 22,’10 
 
SOP: Financial Statement Generator* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To design custom financial statements for use by the company. The financial 
statement generator gives you the freedom to choose which data to display, and to 
create a wide range of variations that enable you to analyze many different cross-
sections in different companies. 
Working Assumption 
Various types of reports have been created (trial balance, profit and loss, balance 
sheet), for which items and accounts will be defined. Reports can be of regular format or 
include a schedule. Report items are defined once for each type of report. 
Setups 
 Balance sheet/profit and loss report headings 
 Trial balance headings 
 Balance sheet/profit and loss items 
 Trial balance items 
 Accounts with defined balance sheet/P&L items, trial balance items or classification 
into groups. 
 Account groups 
Procedure 
Stage I: Creating Report Templates 
Aim: To define a customized report, including headings, items, and accounts, once for 
each report type. 
Option A: Creating report templates automatically 
1. Run 
the Create Customized Statement program. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

 Choose the report type: Balance Sheet, Profit and Loss or Trial Balance. 
 Choose between a Regular report, which combines account sums, or a Schedule, 
which displays each account sum separately. 
 Record a Report Title. 
2. To check the program results, enter the Makeup of Financial Statements form and 
move to the desired report line. 
3. Enter the Items in Statement sub-level form, and make any necessary revisions to 
the following: 
 The headings that will appear in the report 
 The position of each heading 
 The kind of underlines used 
 The addition of sums on additional levels 
4. In the parallel Accounts in Statement  sub-level form you can define the way data 
are displayed, according to: 
 Accounts displayed in the report 
 Balance sheet/P&L items 
 Trial balance items 
 Account group 
Note: In the Debit Item column, you can only choose lines defined as information level 
"3" in the Items in Statement sub-level form. Data for the accounts linked to the debit 
line are only displayed if they have a debit balance. 
Result 
 
The report template is created, with the headings, items and accounts you selected. 
Option B: Creating report templates manually 
1. Enter 
the Makeup of Financial Statements form. 
 Record a  Statement Title (for example, "Foreign Currency Cash Analysis"). 
 To allow the new report to be available to all users, flag the General Use column. 
 Enter the Items in Statement sub-level form. 
 In the Ln column, specify the position of the line in the report (in ascending order). 
 In the Title column, specify the line title. You can leave this column empty to 
create a blank line in the report. 
 Define the appropriate Information Level for the line (for example, accounts, 
items or groups can only be displayed in lines on level 3). 
 You can only flag the Detail column for lines on level 3. 
 You can only flag the 100 Percent column for lines on level 3. This allows the line 
to serve as the basis for percentage calculations in the column bar. 
Cat.No. LB10000426 2 Ver.2 – Sep. 22,’10

 In the Debit/Credit column, specify how the balance is to appear in the report line. 
For example, in a balance sheet you can define active as debit ("D" = assets/fixed 
assets) and passive as credit ("C" = various liabilities). 
 To display a line, select the desired line type in the Underline column, and define 
whether the line is solid or dotted in the Solid Line column. 
2. In the parallel Accounts in Statement  sub-level form you can define the way data 
are displayed, according to: 
 Accounts displayed in the report 
 Balance sheet/profit and loss items 
 Trial balance items 
 Group 
Note: In the Debit Item column, you can only choose lines defined as information 
level "3" in the Items in Statement sub-level form. Data for the accounts linked to the 
debit line are only displayed if their balance is in debit. 
3. Enter the parallel Schedule Definition  sub-level form. 
4. In the Schedule Title column, select an already defined report from which data will 
be retrieved. 
5. In the Line in Schedule column, select the line in the schedule from which to 
retrieve the sums. You can only choose line on information level 3 (without detail) 
and higher. 
6. In the To Line in Statement column, specify the line in the target report, to which the 
sums will be copied from the line in the schedule. You can only choose line on 
information level 3 (without detail). 
Result 
 
The report template is created, with the headings, items and accounts you selected. 
Stage II: Defining Column Bars 
1. Enter the Definition of Column Bars form and define a Column Bar Title that will be 
easy to identify when running the report (e.g., "3rd Quarter in 2008"). 
2. To allow the new report to be available to all users, flag the General Use column. 
3. Dual-currency users: In the Adjustment Date column, you can define the base date 
for indexed reports. In such a case, the report currency must be "index" (In). 
4. Leave the check mark in the In Use column so that the column bar will appear 
among the available options when running the report. 
5. Enter the Columns in Bar sub-level form and fill in the following details: 
 Specify a Column Number from 1 to 20. Columns are displayed in ascending 
order (lowest numbers on top). 
 Specify a Title for the column. 
Cat.No. LB10000426 3 Ver.2 – Sep. 22,’10

Cat.No. LB10000426 4 Ver.2 – Sep. 22,’10 
 Select the appropriate Column Type.  
Note: If, for example, you choose the Period Start type, you also need to specify 
the From Period and the Fiscal Year. 
 In the Curr column, select the currency in which the column values will be 
displayed. 
Tip for dual-currency users: You can prepare a column bar that displays two 
currencies, for example, the local currency and American dollars. To do so, define 
two different columns. In such a case, it is recommended to include the currency in 
the column title to avoid any confusion in the presentation of the data. 
 Flag the Hidden column to hide the current column. This is useful when defining a 
column whose value is used in an expression. 
 Specify the Full Company Name of the company whose data is displayed in the 
report. If you do not specify the name, the column bar will serve to display data 
from the current company. 
 If relevant, specify the appropriate Affiliate. 
 You can use the Group  column to restrict the report to accounts belonging to a 
specific group. 
 You can use the Expression column to record a mathematical formula that uses 
the values in other columns defined in the column bar, and displays the results. 
For example, to display the value in Column #5 as a percentage of Column #3, 
you would record (#3/#5)*100. 
Result 
 
You have created column bars that can be integrated into a variety of reports. 
Stage III: Running the Report 
1. Run the Run Financial Statement program and select the desired report and column 
bar. 
2. To include accounts with zero balances in the report, flag the Display 0 Balances 
input parameter. 
Tips: 
 You can save the report results to MS-Word in a pre-defined template.  
 To add the report to a menu, navigate to it, right-click the menu title, select Add 
User-Defined Report, select Makeup of Financial Statements and choose the 
desired report. 
Process Summary 
 A financial statement template was defined according to the user's requirements, 
including variations on headings, items and accounts. 
 A column bar was defined, which allows you to run the statements in different 
periods, for different companies, and in different currencies, and by which you can 
run comparisons between different periods.
