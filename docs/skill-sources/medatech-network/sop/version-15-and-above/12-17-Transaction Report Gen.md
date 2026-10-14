# 12-17-Transaction Report Gen

- **Source:** `12-17-Transaction Report Gen.pdf`

www.priority -software.com   
1/2 ‏Feb. 02, '15 Ver.03 Cat.No. A7000254 
 
 SOP: Transaction Report Generator 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The following explains how to create a customized report (one not found in the system) for a specific 
user or user group. You can create and run an unlimited number of such reports. 
Procedure 
Stage I: Creating the Report 
1. Enter the Transaction Report Generator form. 
2. Record a Report Title. This is the title that will appear at the top of each report printout, as well 
as in the menu of reports to run. 
3. Enter the sub-level form, Report Columns, and select the columns to include in the report (from 
the Choose list). 
Tip:  You can change the title of any column displayed in the report by leaving the line, returning 
to it and revising the Title. 
Important Note: The sequence of columns in the generator determines the order in which they 
are displayed in the customized report (as well as the default sort for the report data). To change 
the position of a column that you have already included in the report, do the following: 
 Delete the line in which it appears. 
 Move to the line immediately above the one in which you want to insert the column and open a 
new line (Ctrl+Enter). 
 In the new line, reselect the column in question. 
4. To define the column as an input column for the report, flag the Input column. When the report is 
run, such columns will appear in the Parameter Input Screen. 
5. To revise the column width, change the value in the Width column. 
6. By default, report records are first sorted by the data in the first column, then by the second, and 
so on. If you want a different column to determine the primary sort, flag the Sort column in the 
appropriate line. 
7. To add a new column to the report (one not in the Choose list): 
 Move to a blank line in the Report Columns sub-level form. 
 Record a title for the column in the Title column and approve the warning message that 
appears. 
 Change the Width, as desired (the default is 20 characters). 
 If this is to be an input column in the report, flag the Input column. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 ‏Feb. 02, '15 Ver.03 Cat.No. A7000254 
 
 Use the Expression column to define a mathematical formula that determines the values 
appearing in this report column. To refer to an existing column in the expression, specify # 
before its column number. (For example: If #130*0.75 is the expression defining a given 
column, its output would be 0.75 times the value of the data in column 130.) 
8. To allow all users access to this customized report, return to the upper-level form and flag the 
General Use column. 
9. Make sure the In Use column is flagged. 
Stage II: Running the Report 
1. Run the Run Transaction Report program. 
2. Select the title of the report you have designed and click OK.
