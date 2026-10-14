# Financial Staement Generator Script

- **Source:** `Financial Staement Generator Script.pdf`

Financial Statement Generator Script 
Clip Link: http://www.eshbel.com/Movie_Search/Financial_Statement_Ge nerator.htm 
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-01:12) 
This clip demonstrates how to design custom financial statements in Priority that 
provide real-time, actionable information on company performance. The Financial 
Statement Generator gives you the flexibility to customize balance sheets, profit 
and loss reports, trial balances and account tree statements.Priority's customized 
financial statements are made up of two components: a template that determines 
which report items appear in each row of the statement and a column bar that 
determines the report columns to be included in the statement. This separation 
between report items and columns enables you to mix and match different types of 
statements and column bars. For instance, you can generate multiple reports based 
on the same P&L template in combination with a variety of different column bars to 
view data for different periods: a profit and loss report which displays data using a 
consolidated yearly column bar, or using a comparative quarterly report; or a 
statement of operations which displays data by company divisions, for examining the 
financial performance of different companies that operate in similar fields.  
Creating Report Templates (01:13-03:03) 
Report items for each type of statement are generally
 created automatically, by 
running the Create Customized Statement program. This program generates a new 
template for the selected type of statement based on the definitions recorded in one 
or more of the forms located in the Report Setups menu. In addition, the relevant 
accounts are attached automatically to each report item based on definitions 
recorded in the chart of accounts. In the case of an account tree statement, the 
structure and accounts used in a standard report are defined in the Account Tree 
form. We'll discuss this type of statement in greater detail later on in this video. 
Once you have ensured that the standard setup of each type of report meets your 
needs, you can begin creating customized statements. Let's run the Create 
Customized Statement program and choose the desired report type – in this case, 
a Profit & Loss report. You can then choose between a Regular report, which 
combines sums for each report item, and a Schedule, which displays the details of 
each account under each report item, together with the total balance of each item. 
Finally, assign the report a title. 
Once you have created a custom report template, it is ready for immediate use. 
Alternatively, you can use the different sub-levels of the Makeup of Financial 
Statements form to view or update definitions as desired. For instance, you can use 
the Items in Statement sub-level form to modify the structure of the report, adding 
or revising elements such as headings and sub-headings, and defining how these 
elements are organized within the statement. 
Cat.No. LB130546  Ver.1 – Dec. 5,’13 1

Defining Subtotals at Multiple Levels (03:04-06:49) 
We'll demonstrate the options for defining the statement items using a report we 
defined in advance, "Profit and Loss - Detailed".. In a custom financial statement, 
you can include as many lines for subtotals as you need. The different levels of totals 
and subtotals are defined in the system by assigning each row the appropriate 
Information Level in the Items in Statement form. Information Levels 1 and 2 are 
assigned to rows representing headings and subheadings. An Information Level of 
3 represents an individual report item. Level 4 and higher indicates a total or subtotal.  
Each total or subtotal defined in the report must be assigned one level more than the 
rows to be totaled. Let's use a profit and loss report to better illustrate this concept. A 
standard profit and loss report lists the amounts credited to various accounts over 
the designated period, displaying the sums representing various types of income and 
corresponding subtotals, followed by a row totaling all income and then adding the 
total income to the total cost of goods sold in order to attain a sum representing your 
gross profit. The report then lists any additional expenses representing your 
organization's operating costs and finally, displays a grand total representing the 
organization's net profit for the period in question.  
This hierarchy can be represented in terms of information levels as follows: Each 
report item is represented in its own line and assigned an Information Level of 3. 
After listing any report items representing a given type of income (e.g., income from 
domestic sales, income from foreign sales, commissions), a corresponding subtotal 
is inserted by adding a line with an Information Level of 4. Each Level 4 subtotal 
sums up all preceding report items at Level 3, up until the previous Level 4 subtotal. 
This pattern is repeated for each type of income in turn until all income has been 
listed, at which point we add a line representing the total income and assign it an 
Information Level of 5. We then list the report items and corresponding subtotals 
representing various costs associated with the sold goods, assigning each an 
Information Level of either 3 or 4, respectively.  
The line representing the total cost of goods sold is once again assigned an 
Information Level 5 – this indicates that the amount in this line is to be calculated 
by summing up Level 4 subtotals, but only up until the previous Level 5 subtotal. At 
this point in the report template, we'll add a line that sums up both the total income, 
and the total cost of goods sold, by assigning it an Information Level of 6. This line, 
then, represents your gross profit for the period in question. 
As you can see, proper use of Information Levels ensures that you never have to 
worry about missing an amount somewhere, or getting an incorrect total by picking 
up an amount more than once. Moreover, the same logic can be used to define 
additional levels of totals and subtotals by assigning each an information level that is 
one level higher than the lines to be totaled, up to level 99. In the current example, 
the final line of the report is assigned an Information Level of 8. This line is used to 
calculate the organization's net profit, by deducting the total operating expenses from 
the gross profit.  
This template can now be used in conjunction with any applicable column bar to 
generate a P&L statement such as the one we just saw. The use of column bars will 
be explained shortly. 
Cat.No. LB130546  Ver.1 – Dec. 5,’13 2

Defining Accounts in the Statement (06:50-12:43) 
After having defined the structure of the report, including the items, headings, totals 
and subtotals, let's demonstrate the definition of accounts in the report, so that the 
relevant data will be displayed for each item. We'll be using a trial balance report. To 
do so, move to the Accounts in Statement sub-level form.  
Accounts defined in the system are linked to the relevant report items using one of 
the following:  
 Bal Sheet/P&L Item 
 Trial Bal Item 
 Group of accounts 
 Or individual Account numbers. 
Accounts can be linked to report items automatically or manually. When you run the 
Create Customized Statement program, accounts are linked to the relevant items 
automatically, according to the type of statement being built and the statement 
structure defined in the system at the time. For example, if you build a trial balance 
statement, the items will be linked to accounts according to the Trial Bal Item 
defined for each account when you run the program. The second option is to 
manually create the report and its items, then link the accounts or group of accounts 
to the items in this form.  
Since the Financial Statement Generator is used in a multi-company setting, it's 
important to define the accounts in each company in a similar structure, so that the 
definitions you record here in one company will apply to the others as well. For 
example, you should define all your trial balance items in the same way, or decide 
that all your expense accounts begin with a 6.  
Let's examine the form closely. Note that accounts are defined here only for lines 
with an information level of 3, as defined in the parallel Items in Statement form. 
The Debit Item and Credit Item columns list the lines defined in the parallel form. 
For example, item 160 here defines the accounts included in line "160" of the parallel 
form, in this case: Main Cashier. The item includes all those accounts for which a 
trial balance item of "100" has been defined. You can combine several account 
definitions in the same line – for example, you can define a Trial Bal Item together 
with an Account No.. Note that you can include an asterisk in these definitions to 
catch a wider range of accounts or items. For example, you can record "1*" in the 
Account No. column to include all the accounts that begin with "1".  
You can use this form to include an account under different report items than the one 
they are usually assigned to, and, in trial balance reports, add a control line to make 
sure all your accounts are included, as we'll see in a moment.  
For example, you can "extract" an account from the usual group of accounts to which 
it belongs, and assign it to a different group, by adding a new line and recording the 
number of the account and the credit/debit item to which it belongs. In the Account 
No. column, press F6 to see the definitions of this account in the system. As you can 
see, the Trial Bal Item of this account is usually 104.  Returning to the report 
definitions, you can see that line 170, to which we linked this account, is assigned a 
Trial Bal Item of 102. When you produce the report, the system will automatically 
extract this account from item 104, and add it to 102.  
Cat.No. LB130546  Ver.1 – Dec. 5,’13 3

In a trial balance report, you'll want to make sure all your accounts are included. 
Therefore, we recommend you add a line at the end which "catches" any errant 
accounts. First, let's move back to the Items in Statement parallel form, and add a 
new line with an Information Level of 3. We'll call it " Non-Assigned Accounts ". In 
the "line" column, record a number that hasn't been assigned yet to any other line, 
9999, and flag the Detail column.  Back in the Accounts in Statement form, scroll 
down to the bottom of the list and open a new line. Type an asterisk "*" in the 
Account No. column, and under the Debit Item column, record the new line you just 
created, 9999. The Credit Item is filled in automatically with the same number. Since 
the new line appears at the bottom of the list, the system will automatically exclude 
all the accounts that were already included in the report, and will display only those 
accounts that don't appear anywhere else. Let's quickly run the financial statement to 
see the results. In the message that appears, you can see that, for some of the 
companies, no accounts are included in the control line, meaning the account 
definitions are correct. 
Scrolling down to the bottom of the report, you can see that an account appears 
under "Non-Assigned Accounts". Click on it to access the account definitions in 
Priority. You can see that the Trial Bal Item column is defined as 631, but returning 
to the report definition and retrieving by Trial Bal Item of 631, no result appears, 
meaning that no item in the statement has been assigned this trial balance item. To 
include the account in the report, simply add a new line with a Trial Bal Item of 631 
and record the relevant definition in the Debit Item and Credit Item columns to 
include it in the statement. When all accounts are defined correctly, the control line in 
the report should display "0".  
Defining Column Bars (12:44-15:58) 
Having reviewed repor
t templates, let's address the other component used to 
generate a custom financial statement - the column bar. Column bars determine 
which columns appear in a given custom-made report. A variety of column bars can 
be defined: one for a monthly report, another for the entire fiscal year, a third for 
comparing 1st quarter and 2nd quarter data, and so on. Moreover, you can include 
percentile columns alongside or in place of sum totals. Let's enter the Definition of 
Column Bars form to see an example. 
"Quarterly Comparison P&L"  is a column bar that compares quarterly data from this 
year with the previous one, and presents the change from one year to the next as a 
percentage. Note that this column bar is defined as available for General Use, 
ensuring that it is available for any user who runs a report.  
The columns are defined in the Columns in Bar sub-level form. We've defined 
several columns for the first quarter of 2012, one for each company, additional 
columns for the same quarter in 2011, and a calculated column which displays the 
difference between them .  
Each column is assigned both a Title, which appears at the top of the report column, 
and a number, which determines its relative position in the report. Columns appear in 
ascending order, from left to right. 
For every column you define, assign a Column Type, which can be used to display 
account balances at the beginning or end of a given period; the total value of 
transactions within a given span of time; or a calculated value or percentage based 
on the sums in other report columns.  
Cat.No. LB130546  Ver.1 – Dec. 5,’13 4

Most types of columns – with the exception of calculated or percentage columns – 
also require you to indicate a date or range of dates for which to display sums in the 
reports being run. The Period Start and Period End options are used to define 
columns displaying opening or closing balances, respectively, as of or up to a 
particular date. Together with the Period Debit and Period Credit columns, they are 
usually used in trial balance reports. Period End columns are also suitable for 
balance sheets. Period Totals are usually used in P&L reports. When selecting 
these column types, make sure you also indicate the start and end dates of the 
period in the From Date and To Date columns.  
Note that you can also specify a different Currency for different report columns. This 
option is useful in consolidated reports of several companies for which different 
currencies are defined. In such a scenario, you should define one common currency 
in the report, so that the financial data will be comparable.  
This column bar makes use of the Hidden column. In the column bar we designed, 
we opted to hide the details of the first quarter of 2011, and display only the 
summary data.  
Defining Calculated Columns (15:59-17:46) 
The last column presents the change from the first quarter in the previous year
 to the 
first quarter this year – in other words, the percentage of difference between the 
amounts in the two summary columns. This column has been defined as a 
"calculated" column so that you can define mathematical operations performed on 
the values in other columns. Let's take a closer look at the expression itself. The first 
calculated column summarized the data of all three companies in the first quarter of 
2012, and the second calculated column summarized the same data for 2011. The 
expressions can incorporate any combination of standard mathematical symbols, 
integers and predefined functions such as SUM, MAX, MIN and AVG, alongside 
references to other columns in the same column bar. Note the hash, or number sign 
(#), which denotes a reference to the other columns defined in the bar.  
In the third calculated column, we've defined the following expression: subtraction of 
the total sum for 2011 from the total sum for 2012, divided by the total sum for 2011 
and multiplied by 100, so that the number will appear as a percentage. You can see 
a detailed explanation on how to define expressions by pressing F1 within the 
column.  
Looking back at the report we ran a few moments ago using this column bar, you 
can see how the expression we've just reviewed is reflected in the last column.  
Defining Columns for a Specific Division (17:47-18:49) 
We've already seen how Priority enables you to define a report col
umn that displays 
data for a specific company, in the context of a consolidated financial report. 
Similarly, if you categorize companies into divisions, you can define a report column 
for a specific division, in order to display data for all companies in that division.  
For example, in a multi-national corporation comprising a number of smaller 
companies, each company's logistic and financial data are maintained separately in 
Priority. However, when running consolidated statements for the entire corporation, 
you may not want to display a separate column for each company, but rather display 
aggregated data for all the companies in each division. 
Cat.No. LB130546  Ver.1 – Dec. 5,’13 5

Cat.No. LB130546  Ver.1 – Dec. 5,’13 6
In this case, you would create one column for each division. If a new company is 
acquired at any time, you need only assign it to the relevant Division to ensure that 
financial data for that company is included in the relevant column in any subsequent 
financial statements. 
Tree of Accounts (18:50-21:13) 
In many companies, it's common practice to maintain a hierarchal account structure, 
or account tree. Let's move to the Account Tree form to demonstrate. The 
hierarchal structure is defined as follows: The highest level is defined as a number, 
as we see with Assets. The next level, Current Assets, is defined as 10 and so 
includes all accounts beginning with "10". The Current Assets account is, in turn, 
included in Assets; and so on. Level 2 is at the same hierarchal level as Assets, and 
is defined as Liabilities. In this fashion, we continue adding branches to the tree, 
from 1 to 6; Expenses. 
Let's return to the Makeup of Financial Statements form to check the definitions of 
the report template we've just created. Note that the Totals Above Sums option is 
flagged for this report, indicating that totals for each group appear above, rather than 
below, the list of sums included in the total. 
In the Items in Statement sub-level form, you can see how the account branches 
are linked to report items. Take for example, line 30, Assets, defined as item "1**". 
Notice the difference in the Information Level. Here, we see that headings in this 
statement have been assigned an Information Level of 98 or 99, meaning that the 
totals appear above the sums, just as we defined in the upper-level form. However, 
the account patterns which define each report item are assigned an Information 
Level of 3, as in other types of statements.  
Let's proceed to generate the report  with the Trial Balance (Account Tree) column 
bar. As you can see, the Account Tree report is organized according to the 
hierarchical account groupings defined in the Account Tree form, and the total 
balance for each group appears above the component sums for each of its sub-
groups. 
Design (21:14-21:36) 
Finally, note that when working with customized financial statements, you can use 
the Financial Statement Design form
 to modify the style used for each level of the 
report. 
This concludes our demonstration of Priority’s Financial Statement Generator. For 
additional information, run the Financ. Statemt Generator Wizard.
