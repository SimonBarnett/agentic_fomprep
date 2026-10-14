# 12-17-Setting Up Form Loads (EDI)

- **Source:** `12-17-Setting Up Form Loads (EDI).pdf`

www.priority -software.com   
1/4 ‏Jan. 04, 2015 Ver.02 Cat.No. LB09000190 
 
SOP: Setting Up Form Loads (EDI)* 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up definitions required for loading data from an Excel or text file to a predefined Priority 
form. 
Notes: 
 It may be more convenient to create the file in Excel and then save it in .txt format. 
 Data can be loaded directly from a file to the appropriate form or forms.  
 Alternatively, you can first load the file data to a load table, and from there the data can be 
loaded to the appropriate form or forms. In such a case, you must define two separate interfaces: 
one for loading data to the load table and one for loading data from the load table to the forms. 
Procedure 
Important Notes: 
 Read through these instructions once before preparing the files for loading. 
 It is recommended that you perform the first load in a test environment, and only load data in the 
working environment once you have verified that test data were loaded properly. 
Stage I: Defining the Form Load 
1. Enter the Form Load Designer form. Use this form to record general details of the form load. 
2. Record a Load Name. The following restrictions apply: 
 Only alphanumeric values (uppercase and lowercase letters and digits) and the underline sign 
may be used (no spaces). 
 The name must begin with a letter. 
 The name must include a common four-letter prefix, followed by an underscore. All 
customized entities that you add to Priority should share the same prefix, identifying them as 
such, so that they are not deleted later by standard system programs. 
3. Designate a Title. The title is the means of identifying the load when running the Load Data 
program from the menu. 
4. If you plan to load data to a load table before loading to a form, and the current interface will be 
used to load data from that table, specify the name of this Load Table. 
Notes: 
 To define a load table, use the programs in the Table Generator menu. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Jan. 04, 2015 Ver.02 Cat.No. LB09000190 
 
 To define the interface used to load data to the load table, use the items in the Table Load 
(Interfaces) menu. 
5. In the Module Name column, choose the module to which the form load will be assigned. It is 
generally advisable to assign a new form load the “Internal Development” module. 
6. Specify an "I" in the International column to define the current form load for Dual-Currency 
installations. Consequently, the form load will not appear in the menu in US installations. 
7. Flag the Ignore Warnings column if you want the interface program to ignore warning 
messages and continue loading. Otherwise, warning messages will cause the program to stop 
loading. 
Notes: 
 Using the form load interface simulates recording form data by hand. Therefore, when data 
are loaded, error and warning messages may appear (for example, when a customer is 
defined for a sales order, you may be notified that the customer has been warned of a pending 
account restriction). In such a case, you can choose to ignore the warning message and 
continue loading data. 
 You cannot choose to ignore an error message. 
 If all records have been loaded to the upper-level form but the load is stopped in one of the 
sub-level forms, any remaining data will not be loaded to this sub-level form and the program 
will continue loading data to the remaining sub-level forms. 
8. In the Record Size column, specify the maximum number of characters each record can contain 
(usually, 1000). 
9. Indicate the File Name, i.e., the full name of the external file from which data should be loaded, 
including the path. If no path is specified, Priority will attempt to locate the file in the 
system\load directory (in the Priority drive). 
Notes: 
 The file must first be saved as a tab-delimited text file. 
 To view the full file name, including the exact file path, locate the file using the Windows 
Explorer. The file path appears in the address bar of the Explorer. 
10. Choose one of the following in the File Type column: 
 Fixed column width – In files of this type, data location is defined by specifying the position of 
the first and last characters of each column (see Stage IV). 
 Tab separator – In files of this type, data are separated by tabs. Columns are identified by the 
order in which they are arranged (see Stage IV).  
Stage II: Allowing the Interface to be Run in a Priority Program 
You can set up the interface to be run as part of a given Priority program. The interface will be 
activated whenever that program is run. 
1. Enter the Procedure Link sub-level form.  
2. In the Procedure Name column, specify the desired procedure.  
Tip: If you only know the procedure's title (i.e., the name that appears in the menu), press F6 to 
enter the Procedure Generator, and perform a query for all or part of the procedure title. When 
you have located the desired procedure, press F8 to copy the procedure name into the 
Procedure Link form. 
3. In the Step column, indicate at which step in the procedure the interface should be run.

www.priority -software.com   
3/4 ‏Jan. 04, 2015 Ver.02 Cat.No. LB09000190 
 
Stage III: Defining Forms to be Loaded 
Aim: To define the forms to which data will be loaded and the columns to be updated with the data 
from each field in the external file.  
Data can be loaded into any upper-level or root form, or into a form tree (a form that is opened from 
the main menu and the sub- levels that are accessed from the form itself). 
1. Enter the parallel Forms to be Loaded sub-level form.  
2. In the Form Name column, record the name used by the system to identify any forms or form 
trees that participate in the load. The form's Title appears automatically. 
Notes: 
 If data are loaded to a form tree, record the upper-level form in the first line and record each of 
its sub-levels in a subsequent line. If data will be loaded into a sub-level of a sub-level, list all 
relevant lower-level forms right after their immediate upper-level form. 
 If you only know the form's title (i.e., the name that appears in the menu), press F6 to enter 
the Form Generator, and perform a query for all or part of the form title. When you have 
located the desired form, press F8 to copy the procedure name into the Forms to be Loaded 
form. 
3. In the Code (Record Type) column, designate a unique code for each form representing its 
record type. Each level in the form tree must be assigned its own unique record type; the upper-
level form should be assigned the value 1. 
Note: The data file should contain a column with corresponding codes for each record type, 
indicating the form to which the record should be loaded. 
4. Enter the Position of Record Type in File form (a parallel sub-level form) and specify the 
location within the file of the code indicating the record type: 
 If you defined the file type as "Fixed column width", indicate the exact location within the file 
(the position of the First Character and Last Character) of the field which contains the record 
type. 
 If you defined the file type as "Tab separator", indicate the position of the file column which 
contains the record type. 
Stage IV: Defining Columns to be Updated 
Aim: For each form, to specify the form columns to which data should be loaded when the interface 
is run and the location of the data to be loaded. 
Loading from a Load Table 
If the interface will be used to load data from a load table (and not directly from an external file), 
define the appropriate table column from which data will be loaded to each form column. 
1. Enter the Link Form Cols to Load Tbl Cols form, a sub-level of the Forms to be Loaded form. 
2. Choose the Load Table Column from which data should be loaded. 
Tip: The Choose list displays the names of all columns in the load table specified in the Form 
Load Designer. 
3. In the Form Column Name column, indicate the form column to which these data should be 
loaded. 
Tip: The Choose list displays the names of all columns in the form specified in the Forms to be 
Loaded form. 
4. In the Order column, you can indicate the order in which data will be loaded to the various form 
columns. Specify 1 for the first column to be loaded, 2 for the second column, etc. If no Order is 
indicated, data will be loaded sequentially, from the first line to the last line.

www.priority -software.com   
4/4 ‏Jan. 04, 2015 Ver.02 Cat.No. LB09000190 
 
Loading from an External File 
If the current interface will be used to load data from a file, define the appropriate position in the file 
from which data will be loaded to each form column. 
1. Enter the Position of Form Columns in File form, a sub-level of the Forms to be Loaded 
form. 
2. Choose the Form Column to which data should be loaded. 
Tip: The Choose list displays the names of all columns in the form specified in the upper-level 
form (Forms to be Loaded). 
3. For each form column, specify the location within the file from which data should be loaded, 
based on the File Type indicated in the Form Load Designer: 
 If you defined the file type as "Fixed column width", indicate the exact location within the file 
(the position of the First Character and Last Character) of the data to be loaded to the form 
column. The Width of the column is filled in automatically. 
 If you defined the file type as "Tab separator", columns are identified by the order in which 
they are arranged in the file. In the Column # in Tab File column, indicate the appropriate file 
data by its column number. 
Note: The first column in the file contains the code indicating the record type; thus, the first 
data column is column 2, not column 1. 
4. In the Order column, you can indicate the order in which data will be loaded to the various form 
columns. Specify 1 for the first column to be loaded, 2 for the second column, etc. If no Order is 
indicated, data will be loaded sequentially, from the first line to the last line. 
5. Flag the Insert Null Values column if you want the load program to treat empty strings and zero 
values as true values and overwrite any existing value in the corresponding form column. 
6. If the file contains numerical data, indicate the number of Digits After Decimal to be loaded to 
the corresponding form column. 
Stage V: Running the Form Load 
 Return to the Form Load Designer and select Run Interface from the list of Direct Activations. 
Results 
 Data are loaded into the appropriate forms and form columns. 
 If there are errors that prevent any data from being loaded, a notification is displayed, together 
with a link to a Load Errors report itemizing these errors. 
Important! This report should be viewed immediately after running the interface program. If 
another interface is run, this may generate a new Load Errors report, which will overwrite the 
existing one.
