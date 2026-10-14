# SOP Creating and Using a Budget

- **Source:** `SOP Creating and Using a Budget.pdf`

Cat.No. LB110527 1 Ver.2 – Jan. 13, ’13 
 
SOP: Creating and Using a Budget* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aim 
Use the Budgets module to supervise purchasing and sales processes, from orders 
to invoices. The module allows you to appropriate funds to budget items, maintain 
budget versions, link each transaction document to the relevant budget item, and 
evaluate performance against planning at every stage. 
Setups 
Financial Constants 
Enter the Financial Constants form and check the values assigned to the following 
constants: 
 BudCheck 
 BudPRPrice 
 BudOrdPeriod 
 BudgetCurr (dual-currency users) 
Change the constant values as needed. To see an explanation of each constant, 
enter the Help Text (Base Language) sub-level form or run the Working With 
Budgets Wizard. 
Procedure 
Stage I: Setting up the Budget Tree 
Defining budget item suffixes 
1. Enter the Budget Item Suffixes form. 
2. In the Budget Item Suffix column, record the suffix code. 
3. In the Desc-Budget Suffix column, record a description of the suffix. 
4. You can assign the suffix a type (mainly for use with BI reports), which will allow 
you to group similar suffixes together (e.g., assign suffixes for "Telephone" and 
"Mail" the "Communication Expenses" suffix type). 
Note: Use the Budget Suffix Types form to define suffix types. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Defining main budget categories and sub-categories 
1. Enter the relevant forms, according to the depth of your budget hierarchy: 
 Define Budget – Level 1 
 Define Budget – Level 2 
 Define Budget – Level 3 
 Define Budget – Level 4 
2. For each level, define budget categories by recording a Budget Code and 
Budget Description. 
3. For each budget category in levels 1-3, leave the check marks in the Allow 
Suffix and Allow Another Level columns. 
Stage II: Building the Budget Tree 
A budget tree can contain from a minimum of two levels up to five (including budget 
items with suffixes). Begin by defining the highest level of the tree, then work your 
way down. 
1. Enter the Budget Items form, press F4 and click the Budget Structure tab. 
2. To define the highest level of the tree, select a value from the Level 1 Choose list 
and flag the Generate Budget Item column. The top level of the budget tree will 
be created, from which you can build additional levels. 
3. Click the Definitions tab and specify the Date Opened. The item's code and 
name appear automatically in the Budget Item and Description columns. 
4. If you want to perform different checks for budget deviations than the default 
checks defined in the BudCheck constant (see Setups), select the desired 
method in the Check Budget Deviatn colum
n.  
5. The default value P (for purchasing) appears in the Type of Budget column. 
Change it to S for a sales budget. All items in this budget will be assigned the 
defined type. If you are planning to assign to this category sub-categories that 
include both sales budget (S) and purchasing budget (P) items, specify B instead. 
6. To define main budget categories under Level 1, open a new record, return to the 
Budget Structure tab and select the Level 1 value used in the previous record. 
Select a value from the Level 2 Choose list, and flag the Generate Budget Item 
column. Repeat steps 3-4. 
7. Do the same to define sub-categories on the remaining levels. 
Stage III: Defining Budget Items 
Budget items are distinguished by a suffix and populate the lowest level on the 
budget tree. These are the items for which funds are actually appropriated. 
1. In the Budget Items form, select a value from all of the categories that are above 
the desired item in the budget tree (from Level 1 to Level 4), select the item's 
Suffix from the Choose list, and flag the Generate Budget Item column. 
2. Click the Definitions tab and specify the Date Opened. The item's code and 
name appear automatically in the Budget Item and Description columns. 
3. To link the item to a single GL account, specify the Account No.. To link the item 
to multiple GL accounts, leave this column empty and see the instructions in 
Stage III. 
Cat.No. LB110527 2 Ver.2 – Jan. 13, ’13

4. Link the item to a Bal Sheet/P&L Item. This will affect the way this item is 
displayed in the Profit and Loss for Budgets report. 
5. If you want to perform different checks for budget deviations than the default 
checks defined in the BudCheck constant (see Setups), select the desired 
method in the Check Budget Deviatn column. 
6. Flag 
the Multi-Year Budget column if you want this item to be taken into account 
when the Transfer Last Year's Budget program is run. 
Stage IV: Linking Budget Items to GL Accounts 
There are three ways to link budget items to GL accounts: 
Linking a single budget item to a single GL account 
The link is made in two places  for the budget item and for the GL account: 
1. Enter the Budget Items form and retrieve the desired item. Click the Definitions 
tab and select the desired Account No. 
2. Enter the Chart of Accounts form and retrieve the desired GL account. Press F4, 
click the Add'l Definitions tab and select the budget item in the Default Budget 
column. 
Linking a single GL account to multiple budget items 
1. Enter the Budget Items form and retrieve the desired items. For each item, click 
the Definitions tab and select the desired Account No. 
2. Enter the Chart of Accounts form and retrieve the desired GL account. Press F4 
and click the Add'l Definitions tab. Leave the Default Budget column empty 
and flag the Budget Mandatory column. 
Linking a single budget item to multiple GL accounts 
1. Enter the Budget Items form and retrieve the desired item. Click the Definitions 
tab and make sure no Account No. is recorded. 
2. Enter the Chart of Accounts form and retrieve the desired GL accounts. Press F4, 
click the Add'l Definitions tab. For each account, select the budget item in the 
Default Budget column. 
Result 
 When budget items are assigned to journal entries, the system will automatically 
debit the relevant expense account. Conversely, when a GL account is assigned, 
the entry in question is automatically assigned the relevant budget item. 
Stage V: Creating a Budget Version 
After building the budget tree, you should create a budget version, through which 
funds can be appropriated for budget items. You can create multiple versions of a 
budget, in which different sums are appropriated for each item. Budget versions 
provide flexibility in planning and revising budgets. 
1. Enter the Budget Versions form. 
2. Specify the Fiscal Year, Version, and Description. 
3. To assign budget items to the version, run the Add Budget Items to Version 
program. 
Cat.No. LB110527 3 Ver.2 – Jan. 13, ’13

4. In the Budget Versions form, retrieve the version and enter the Appropriations 
for Budget Items sub-level form. 
5. Press F4 and do one of the following: 
 If the budget is annual (i.e., without monthly sub-divisions), fill in the  Sum for 
the first budget item. 
 If the budget is on a monthly basis, fill in the columns Period 1 to Period 12. 
6. If an authorization list has been assigned to the budget version, enter the sub-
level form, Budget Version Authorization, and sign next to your name, or pass 
the budget version to the person who is supposed to authorize it. 
7. Once all authorizers have signed, change the version  Status to "In Effect" in the 
upper-level form. Only one version can be in effect for any given fiscal year. 
Stage VI: Revising a Budget Version that is Authorized or In Effect  
1. Enter the Change Version in Effect/Auth'd form. 
2. Retrieve the desired budget item.  
3. Change the appropriated sum(s) in either the Sum column or in the columns from 
Period 1 to Period 12. 
Stage VII: Routine Budget Usage 
To compare budgetary appropriations to actual expenses and revenues, you need to 
associate financial transactions with budget items. You can do this in several ways: 
 Linking documents to budget items: In the itemization sub-level of the 
document in question (e.g., purchase requisition, purchase order, purchase 
invoice), specify a Budget Item for each line item. 
 Linking journal entries to budget items: In the Itemized Entry sub-level form, 
specify a Budget Item for each entry item. 
 Specifying the account in financial documents: The account specified in a 
financial document determines the budget item appearing in the journal entry, in 
keeping with the method by which budget items are linked to GL accounts. 
Results 
 The budget item linked to each document will be copied to any future documents 
based on the current one (e.g., from a purchase requisition to a purchase order to 
a GRV to a multi-GRV invoice). 
 You can view budget usage broken down into actual usage (invoices) and 
planned usage (e.g., open orders, unbilled transactions). 
Stage VIII: Special Budget Appropriations 
Aim: To record and authorize special appropriations for special budget items.  
Note: To define statuses and business processes for special budgets, run the BPM 
Flow Chart - Special Budgets program. 
1. Enter the Special Budget Appropriations form. 
2. Specify the date and currency. The Document Number appears automatically. 
3. Specify the budget item’s Start Date and End Date. 
4. Move to the Appropriations per Budget Item sub-level form. 
Cat.No. LB110527 4 Ver.2 – Jan. 13, ’13

5. In the Budget Item column, select the desired item from the Choose list. 
Note: Only those items flagged in the Special Budget column (of the Budget 
Items form) appear in the Choose list. 
6. In the Appropriated Amount column, specify the amount to be appropriated to 
this special budget item. This can either be an initial appropriation or an 
additional one. 
7. If part (or all) of the appropriation is meant to be used in the current fiscal year, 
specify the sum to be used in the current fiscal year in the This Year’s Approp. 
column. 
Notes: 
 The Orig. Appropriation column displays the amount of the initial 
appropriation for this special budget item. 
 The Total Appropriation column displays the total amount appropriated for 
this budget item, not including the current appropriation. 
 The Revised Budget column displays the total amount appropriated for this 
budget item, including the current appropriation. 
8. Return to the upper-level form, click the Authorization  tab and indicate the 
authorizer list for this special budget item. 
Note: The authorizer lists that appear in this Choose list are defined in the Auth. 
Lists for Special Budgets form. 
9. The names of all authorizers in the designated list appear in the Special Budget 
Authorization sub-level form. After retrieving this special budget item, each 
authorizer must enter this sub-level form and sign next to their own name by 
flagging the Approve column. Once the special budget item is fully approved, its 
Status is automatically changed to "Authorized".  
10. Use the Attachments sub-level form to attach any relevant files.  
11. Change the version Status to "In Effect" in the upper-level form. 
Tip: You can use the View Special Budget Appropriatns form to view appropriations 
for special budget items (i.e., those flagged in the Special Budget column of the 
Budget Items form) by retrieving the desired budget item from the Budget Item 
column.  
Stage IX: Viewing Budgeted vs. Actual Expenses and Revenues 
Aim: To compare budget item appropriations to the total sum of actual transactions 
recorded for each item. 
1. Enter the Budget Items form and retrieve the budget item in question. 
2. Enter the Annual Budgeted vs. Actual sub-level form and view the 
appropriation, the actual usage and the budget balance. 
3. Enter the parallel Monthly Budget vs. Actual-This Yr sub-level form and view 
monthly appropriations, actual usage and budget balances. 
4. Run the Budgeted vs. Actual report to compare budgeted revenues and 
expenses with actual revenues and expenses. 
5. Run the Budgeted vs. Actual as of Date report to view relative budget usage from 
the beginning of the fiscal year until the designated date. 
6. Run the Prepare for Budget Analysis-BI program, then the Budget Analysis (BI) 
report, to analyze the management of your budget. 
Cat.No. LB110527 5 Ver.2 – Jan. 13, ’13

Cat.No. LB110527 6 Ver.2 – Jan. 13, ’13 
7. For additional reports, see in the Priority  menu: Financials > Budgets > Budget 
Reports.
