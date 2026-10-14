# SOP Project Reporting

- **Source:** `SOP Project Reporting.pdf`

Cat.No.LB09000171 1 Ver.2 – June 15,’10 
 
S  
C  
A  
OP: Project Reporting*
 
ustomer:   Comp any Inc.
ssigned to: Dept./Position
Aim 
After work on a project has commenced, employees involved with the project can report 
work hours devoted to the project, as well as travel time and other expenses. 
s 
The followin
g describes the details that should be filled in when reporting hours to a 
project. 
Working Assumption
 A project has been set up in the Projects form, so as to enable reporting of hours and
expenses. Project sites have been defined, including travel times and corresponding 
miles (or kms) to charge. 
 
Manually Reporting Project Hours and Expenses 
eports of Project Hrs/Expenses
 
A project plan has been recorded. 
 The part numbers required for reporting have been set up. 
 System users have been defined. 
Procedure 
1. Enter the R  form. 
d. Your username is filled in 
o. column, indicate the project to which hours are being reported. 
 
2. Record the Date on which the work was performe
automatically. 
3. In the Project N
Tip: To link a default project number to an employee, update the Project column in
the Company-Specific Information form, a sub-level form of Personnel File. 
4. In the WBS Code column, select the code for the activity being reported. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
n 
 
deve
lop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their ow
requirements and work practices.

Cat.No.LB09000171 2 Ver.2 – June 15,’10 
5. Select the appropriate part number. 
Tip: To link a default part number to an employee, fill in the Work Hr. Part column in 
the Company-Specific Information form, a sub-level form of the Personnel File. 
6. Click the References tab. If the project is being conducted on several customer 
sites, select the Site where the work was performed (this data is used to determine 
travel time and distance charges agreed upon with the customer).  
7. If the reported hours are based on a sales order, select the Order and indicate the
appropriate line in the order. These hours will then be deducted from the order 
balance. 
8. Click the 
 
 tab and check if the appropriate price is 
ct.  
to Charge (without 
r travel time, flag the Charge Travel Tm column. As 
 
ccess the Project Activities form. 
rs/Expenses form. 
rding 
 define an incoming interface that is used to load project reports into the system, 
 the definition of the load file structure, through loading data into an interim table 
1. Make sure to include fields for all mandatory columns that are in the Reports of 
Ho
urs/Expenses to Charge
indicated in the Price/Hour column. 
9. Record the From Hour and To Hour for work on this proje
Note: When reporting project expenses, indicate only the Total 
specifying a start and end time). 
10. If there is an additional charge fo
a result, the default travel time defined for the specified customer site is added to the
total hours to charge. If there is an additional charge for distance, ensure that the 
value in the Miles to Chrg (dual-currency users: Kms to Charge) column is correct. 
11. If the reported hours are for an activity that constitutes a Milestone, whose 
completion must be reported, enter the Projects/Accounts sub-level form and 
indicate the Percent Completed. 
12. To update the status of the project activity: 
 Press F6 from the Activity ID column to a
 Revise the Activity Status of the milestone activity. 
 Press Esc twice to return to the Reports of Project H
13. To record remarks about reported work hours, as well as clarifications rega
expenses, use the Project Reports – Remarks sub-level form. 
Loading Project Reports via an Interface 
Aim 
 To 
from
and checking them for errors, and finally transferring data to the system database. 
Procedure 
Stage I: Preparing the Load File  
Project Hrs/Expenses form (e.g., Project No.). 
2. Note the location of each field in the load file.

Cat.No.LB09000171 3 Ver.2 – June 15,’10 
 If you are
column. 
 loading a text file with columns of a fixed width, note the width of each 
ab separations, note the relative position of each 
 
 
If you are loading a text file with t
column within the record.  
Stage II: Defining the Load File Structure
1. Enter the Load File Defs-Project Reporting form. The Title column displays the titles 
rst Character and Last Character columns in one of the following ways: 
umn. 
tions, fill in the same number in both 
sition of the column within the record, 
u do not want to load into the interim 
the appropriate Loaded Date Format for the each date column. 
of all columns that can be loaded into Priority. 
2. Fill in the Fi
 If you are loading a text file with columns of a fixed width, use these values to 
define the width of each col
 If you are loading a text file with tab separa
columns. This number will determine the po
relative to the other columns. 
3. Flag the Inactive column for any column that yo
table. 
4. Select 
Stage III: Loading the File into the Interim Table 
1. Run the Clear Project Reports from Table program. 
2. Run the Load File of Project Hr Reports program and specify the path to the data file 
containing the project reports. 
Tip: Click the folder icon and use the browser to locate the file. 
ps
Result 
 
Data in the file have been loaded into the Interim Table-Project Hour Re  form. 
 Stage IV: Checking Errors in the Interim Table
1. Run the Check for Errors in Interim Tbl  report. This report checks for errors in the 
data that were loaded into the Interim Table-Project Hour Reps form. These errors 
are generally a result of mandatory columns that have not been filled or 
discrepancies between data in 
2. Enter the 
the interim table and existing data in the system. 
Interim Table-Project Hour Reps form to correct these errors and/or delete 
records which do not need to be transferred into the database. any 
Stage V: Transferring Data to the System Database 
1. Run the Load from InterimTbl to Database program.
all records or only those records that have not yet be
 You can choose whether to load 
en loaded into the Reports of 
y 
Project Hrs/Expenses form. The program displays a notification of the number of 
records that were successfully loaded into the form. 
2. If errors were encountered which prevented specific records from being loaded, the
will appear in the Load Errors report.

Cat.No.LB09000171 4 Ver.2 – June 15,’10 
3. Once all data has been successfully loaded, it is recommended that you run the 
Clear Project Reports from Table program, in order to prevent the same data from 
being reloaded at some later time, when it is no longer up-to-date. 
 t 
rt is updated. 
Results 
 The reported hours are added to the total of actual hours worked and to the projec
cost. 
 The balance to supply in the order linked to the repo
 You can compare planning to execution for each activity and for the project as a 
whole. 
 If the project is defined as billable, the customer can be billed based on project 
reports.
