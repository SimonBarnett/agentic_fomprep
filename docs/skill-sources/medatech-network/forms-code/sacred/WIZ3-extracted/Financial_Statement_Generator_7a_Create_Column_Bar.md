# Financial_Statement_Generator_7a_Create_Column_Bar

- **Source:** `Financial_Statement_Generator_7a_Create_Column_Bar.htm`

Financial Statement Generator - Creating a Column Bar.2 
 
 
- 
 
 
 
# Creating a Column Bar

 

 1 .  Move to the sub-level form, Columns in Bar . 
 

 2 . Assign each column a number to determine its relative position in the report. 
 

 3 . Specify a title; this will appear as each column’s heading.
 Tip: If the columns in this column bar are defined using a rolling date, you can update the title dynamically each time the report is run, based on the actual dates in use. Explanation . 
 

 4 .  Indicate the column type. Choose between: 
 

 ·              period start - account balances at the beginning of a specified fiscal period; used to display opening balances 
 

 ·              period total - all data over a span of fiscal periods; does not take opening balances into account 
 

 ·              period end - account balances at the end of a specified fiscal period 
 

 ·              calculated - e.g., the difference between two other columns (first quarter totals in 2013 less first quarter totals in 2012), the total of two other columns (company A data plus company B data in a consolidated report) 
 

 ·              percentage - can be used in P&L reports to display percentiles 
 

 ·              period debit - total of all debits over a span of fiscal periods 
 

 ·              period credit - total of all credits over a span of fiscal periods. 
 

 5 .  For all types except calculated and percentage columns, indicate the range of dates covered. 
 

 6 .  For calculated columns, write an expression in the Expression column. 
 

 7 .  To take account data from a different company (in a consolidated statement), fill in the Full Company Name column, or for divisions, the name of the division in the adjacent Division column. 
 

 8 . To limit the account data to a given subsidiary, designate the subsidiary code in the Subsidiary column. Alternatively, specify a question mark (?) in order to prompt the user to specify a subsidiary or subsidiary group when running the report.
 Note: The question mark cannot be used in the Subsidiary column when a value is specified in the Full Company Name column. 
 

 9 .  The column bar is now available for your private use. If you want all users to have access to it, return to the upper-level form and flag the General Use column. 
 

 10 .  In the upper-level form, make sure the In Use column is flagged. 
 
## Notes:

 

 ·        Click to create report items. 
 

 ·        Click to test the report (using existing report items). 
 

 ·        Click to see examples of column bars. 
 

 ·        Click to return to the main screen.
