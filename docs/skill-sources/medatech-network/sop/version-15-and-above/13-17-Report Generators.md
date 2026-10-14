# 13-17-Report Generators

- **Source:** `13-17-Report Generators.pdf`

www.priority -software.com   
1/4 Feb. 11,'15 Ver. 02 Cat.No. LB09000311 
 
 SOP: Report Generators 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To produce customized reports adapted to the user’s needs. 
Report Generators in the System 
Executive Reports 
 Sales Report Generator 
 Customer Invoice Rept Generator 
 Sales Order Report Generator 
 Purchase Order Report Generator 
 Purchase Invoice Report Generator 
 Commission Order Rep Generator 
 Invoice Rep Generator(CommSales) 
 Project Report Generator 
 Ledger Rep Generator(Trans Date) 
 Ledger Rep Generator (Ref Date) 
 Transaction Report Generator 
 Comparative Statement Generator 
 Customized Report Generator 
Sales, Inventory, and Purchasing 
 Lead Report Generator 
 Sales Opportunity Rep. Generator 
 Customer Data Report Generator 
 Sales Rate by Part Report Generator 
 Sales Rate by Store Report Generator 
 Vendor Data Report Generator 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 Feb. 11,'15 Ver. 02 Cat.No. LB09000311 
 
 Part Catalogue Report Generator 
 Inventory Report Generator 
 Warehouse Task Report Generator 
 Warehouse Assm Report Generator 
Fixed Assets 
 Fixed Assets Report Generator 
 Tax Report Generator (Assets) 
Loans and Leasing 
 Loan Report Generator 
 Leasing Report Generator 
Customer Service 
 Serialized Parts Rep. Generator 
 Service Call Report Generator 
 Servicing Report Generator 
Office Management 
 Library Report Generator 
Human Resources 
 Employee Report Generator 
 Candidate Report Generator 
 Job Report Generator 
Production 
 Production Report Generator 
Procedure 
Notes: 
 The following procedure addresses all of the report generators listed above. 
 To open any of the report generators from the list, use the “Search for Entity” function.  
Stage I: Creating a New Report 
1. Enter the desired report generator. 
2. In the screen that opens, click New at the bottom of the screen to design a new report. Two 
screen panes open: 
 The left pane displays a list of Selected Fields, with report columns divided into categories, 
appearing in various colors and with suggested titles. 
 The right pane, called Displayed Fields, serves as a blank template for the new report.

www.priority -software.com   
3/4 Feb. 11,'15 Ver. 02 Cat.No. LB09000311 
 
3. To build the report, use the mouse to select a field from the left pane and drag it into the desired 
position in the Displayed Fields list. Continue for the remaining fields. 
Notes: 
 The display order of the columns in the report is determined by their order in the list, from the 
top down. 
 To change the display order, you can drag the displayed columns higher or lower within the 
list. 
 You can also drag columns to positions that are already "taken", and their order will be 
adjusted accordingly. 
 To remove columns from the Displayed Fields list, drag them back into the Selected Fields 
list. 
 To include a custom column that is based on other columns, select one of the Add 
Expression fields. 
4. When you have finished selecting columns, click Next. The screen that opens is divided into two 
panes: Explanations and Report Definitions. 
5. In the Report Definitions pane, flag any relevant report parameters and revise the Report 
Name, if desired. 
 Highlight the report's temporary name and replace it with your own. 
 Flag General Use to allow all system users to run the report. 
 Flag In Use to have the report appear in the generator's List of Reports. 
 Flag Vertical Tbl Display to have columns displayed one under the other in a tabular report 
(vertical display). Otherwise, these columns will be displayed side by side (horizontal display). 
6. The titles of the selected report columns are listed in the Description column. Highlight any of 
these titles and replace them with your own, if desired. 
7. Flag any columns that will be used as Input for the report. 
8. To create a tabular report, select the column that will appear in the X axis of the table. Sum and 
quantity columns will appear automatically in the table, and the remaining columns will appear in 
the Y axis. If two or more sum/quantity columns appear in the table, you can determine whether 
they appear side by side (horizontal display) or one under the other (vertical display). 
9. To create an expression for a custom column based on sum/quantity columns, specify the latter 
by recording their numbers preceded by the # symbol, or use the mouse to drag the desired 
columns into the Expression column. For each column, indicate the operator applied to the 
column values: SUM (total), MAX (maximum), MIN (minimum) or AVG (average). 
Examples: 
 100.0 * SUM(#120)/SUM(#33)  
 MAX(#130) - MIN(#130)  
 AVG(#135) 
10. Click Run to run the report now, or click End to save the report definitions and return to the main 
report generator screen. 
11. To close the report generator, click X in the upper right-hand corner of the window. 
Stage II: Editing an Existing Report 
1. Enter the desired report generator.

www.priority -software.com   
4/4 Feb. 11,'15 Ver. 02 Cat.No. LB09000311 
 
2. In the screen that opens, select the desired report from the List of Reports, do one of the 
following: 
 To make your changes directly in the saved report, click Edit. 
 To make your changes in a new copy of the report, click Copy. A copy of the report is added 
to the List of Reports. Select the copy and click Edit. 
3. In each screen that opens, make the desired changes. When you are done, click Next to 
continue to the next screen. 
4. When you are done editing the report, click Run to run the report now, or click End to save the 
new report definitions and return to the main report generator screen. 
5. To close the report generator, click X in the upper right-hand corner of the window. 
Stage III: Adding a User-Defined Report to the Priority Menu 
Note: Only the system manager and users in the manager's group are authorized to add such 
reports to a menu. 
1. Navigate to the desired sub-menu and right-click the menu title. 
2. Select Add User-Defined Report. 
3. Choose the desired report type. 
4. Choose the desired report. 
Stage IV: Deleting an Existing Report 
1. Enter the desired report generator. 
2. In the screen that opens, select the desired report from the List of Reports and click Delete. 
3. To close the report generator, click X in the upper right-hand corner of the window.
