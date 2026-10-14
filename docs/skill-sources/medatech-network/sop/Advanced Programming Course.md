# Advanced Programming Course

- **Source:** `Advanced Programming Course.pdf`

Advanced Programming Course 
Cat.No. LB09000267  Ver.1 – July 5,’09 i

The information contained in this manual is subject to change without notice. 
We assume no responsibility for errors or omissions, nor is liability assumed for 
damages resulting from the use of the material contained herein. 
No portion of this manual may be reproduced or transmitted in any form, except 
for the purchaser’s personal use, without the express written consent of Eshbel 
Technologies Ltd. 
Copyright Eshbel Technologies Ltd., 2008. All rights reserved. 
Eshbel Technologies Ltd. 
28 Mishol Hadkalim St. 
Jerusalem, Israel  
http: www.eshbel.com 
Priority™ is a trademark of Eshbel Technologies Ltd. 
Cat.No. LB09000267  Ver.1 – July 5,’09 ii

Contents 
Preface.........................................................................................................................1  
Introduction.................................................................................................................1 
Course Outline ...........................................................................................................1 
Guidelines for Developers............................................................................................2  
Implementation...........................................................................................................2  
The ESHBAL System Constant..................................................................................2 
SQL Syntax ..................................................................................................................4 
System Functions.......................................................................................................4  
String Functions .........................................................................................................4 
Numeric Functions .....................................................................................................4 
Date Functions ...........................................................................................................4 
Output Formats ..........................................................................................................5 
Conditional Expressions.............................................................................................5  
Outer Join...................................................................................................................6  
Variables ....................................................................................................................6 
System Variables.................................................................................................................. 6 
Assigning Values to Variables .............................................................................................. 6 
The SQL Development Program (WINDBI)................................................................6 
Tables ..........................................................................................................................7 
Columns .....................................................................................................................7 
Keys ...........................................................................................................................8 
Table Access..............................................................................................................8  
WINDBI ......................................................................................................................8 
Modifying the Database from Priority .........................................................................9 
Rules for Customizing Tables ....................................................................................9 
Form Generator..........................................................................................................11  
Form Attributes.........................................................................................................11  
Form Columns..........................................................................................................11  
Form Variables ................................................................................................................... 11 
Built-in Triggers ........................................................................................................12 
Built-in Triggers at the Column Level ................................................................................. 12 
Built-in Triggers at the Record Level .................................................................................. 12 
User-defined Triggers...............................................................................................12 
Events at the Column Level................................................................................................ 13 
Events at the Record Level ................................................................................................ 13 
Events at the Form Level.................................................................................................... 14 
Order of Trigger Execution – Events at the Column Level................................................. 15 
Order of Trigger Execution – Events at the Record Level.................................................. 15 
Rules for Customizing Forms ...................................................................................15 
WINDBI ....................................................................................................................15 
Sub-level Forms .......................................................................................................15 
Procedure Generator..................................................................................................18 
Procedure Uses........................................................................................................18 
Rules for Customizing Procedures...........................................................................18  
Procedure Attributes.................................................................................................18 
Procedure Steps.......................................................................................................18 
Step Types.......................................................................................................................... 19 
Basic Commands................................................................................................................ 19 
Cat.No. LB09000267  Ver.1 – July 5,’09 iii

Cat.No. LB09000267  Ver.1 – July 5,’09 iv
Procedure Parameters .............................................................................................20 
User Input ........................................................................................................................... 20 
Retrieving Records Into a Linked File................................................................................. 21 
A Special Parameter – PAR ............................................................................................... 23 
Using a Form for Input........................................................................................................ 23 
Step Queries....................................................................................................................... 23 
The Form Load...........................................................................................................26  
Creating a Form Load Interface.......................................................................................... 26 
Forms in the Load...............................................................................................................2 7 
Running the INTERFACE program .................................................................................... 27 
Executing the Form Load .........................................................................................28 
Basic Form Load Parameters............................................................................................. 28

Preface 
Introduction 
This booklet is intended to accompany Eshbel's advanced programming 
course, and it reviews those topics covered by the course. The booklet also 
contains a number of practical exercises for further study. 
The advanced programming course is based on Priority's SDK manual. 
Course Outline 
The following topics are covered by this course: 
 Form Generators 
 Report Generators 
 Procedure Generators 
 Form Load Interface 
Cat.No. LB09
000267  Ver.1 – July 5,’09 1

General Guidelines for Developers 
Implementation 
It is recommended that you maintain separate installations of Priority for each 
of the following 3 purposes: 
 Development 
 Testing 
 Working 
Note: The development environment and testing environment can be 
maintained on the same physical machine (using two separate installations), 
but the working installation must be maintained on a separate machine.  
1. Custom development should be performed in the development 
environment, and version updates should be prepared and installed in 
the testing environment. 
2. Any necessary fixes should be performed in the development 
environment and new updates should be prepared for installation in the 
testing environment. 
3. Initial QA should be performed by the programmer in the testing 
environment; follow-up tests should be performed in conjunction with the 
party that requested the update. 
4. This process should be repeated until the desired results are obtained. 
At this point, the latest updates prepared in the development 
environment should be installed in the working environment. 
Adopting this workflow for all custom development ensures that all updates and 
the accompanying installation files have been properly tested. 
The ESHBAL System Constant 
The number of characters to be used in the prefix for custom tables and other 
Priority entities is determined by the ESHBAL system constant. To view the 
constant value, run the following query using the SQL Development (WINDBI) 
program: 
SELECT * FROM SYSCONST WHERE NAME = 'ESHBAL'; 
Cat.No. LB09
000267  Ver.1 – July 5,’09 2

The pre-set value of 1 requires a 4-character prefix, as is the norm for outside 
developers. It is recommended that you do not revise this value. A value of 0 
requires a 3-character prefix and is used in-house by Eshbel developers. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 3

SQL Syntax 
The following is a partial list of SQL functions recognized by Priority. For 
further details, see the SDK manual. 
System Functions 
 SQL.DATE 
 SQL.DATE8 
 SQL.USER 
 SQL.TIME 
String Functions 
 STRIND — retrieves a substring in a given string 
 STRCAT — outputs the concatenation of given strings  
 STRPIECE — breaks up an input string into parts according to a given 
delimiter  
Numeric Functions 
 ITOA  
 RTOA  
 INTQUANT — inputs a real number and translates it to a shifted integer. 
Example: 1.0  1000 
 REALQUANT — inputs a shifted integer and translates it to a real number. 
Example: 1000  1.0 
Date Functions 
 ATOD — inputs a string and translates it to a date, using the specified 
format.  
 DTOA — inputs a date and translates it to a string, using the specified 
format. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 4

Output Formats  
Output format commands can also be used to obtain ASCII files containing 
data retrieved from Priority. 
 FORMAT  
 TABS  
 SQLSERVER  
 ASCII  
 UNICODE  
 DATA — generates file structure information (header), marked as comment 
lines by the symbol #, as well as the data; useful for exporting Priority data 
to an external database.  
 ORACLE  
 ADDTO — adds data to end of specified file, rather than replacing the 
contents of the file.  
Conditional Expressions 
The syntax of a conditional expression is:  
(condition ? true_action : false_action )  
If the condition yields a True value, the operation defined as the true_action is 
performed, otherwise, the operation defined as the false_action is performed. Of 
course, either operation can be defined as another conditional expression. 
Example 1: 
SELECT (ORDERS.CURDATE < 01/01/09 ? 'Before 2009' : '2009') 
FROM ORDERS WHERE ORDERS.ORD <> 0 AND ORDERS.CURDATE <= 
31/12/09; 
In this example, for all sales orders dated earlier than 31/12/09: If the order date is 
later than 01/01/09, the query displays the string '2009'; otherwise, the query 
displays the string 'Before 2009'. 
Example 2: 
SELECT (ORDERS.CURDATE < 01/01/09 ? 'Before 2009'  
(ORDERS.CURDATE < 01/07/09 ? 'First half of 2009' : 'Second half of 2009'))  
FROM ORDERS WHERE ORDERS.ORD <> 0 AND ORDERS.CURDATE <= 
31/12/09; 
This example includes an additional check: If the order date falls within the first half 
of 2009, the query displays the string 'First half of 2009'; otherwise, the query 
displays the string 'Second half of 2009'. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 5

Outer Join 
 Outer joins affect query optimization 
 Use of an exclamation mark (!) affects query optimization 
Variables  
 Variables are identified within the SQL statement by the prefix “:” (colon). 
 Variable type is defined according to context, as explained in the SDK 
manual. 
System Variables 
 A list of system variables appears in the SDK manual. One of the most 
useful system variables, RETVAL, is used to store the result of the last 
operation. 
Assigning Values to Variables 
 Assigning a value directly — :NUM = 5 
 Assigning a value by means of an SQL statement —  
SELECT ORDNAME INTO :ORDNAME FROM ORDERS…; 
Note: Additional related topics are discussed in the Procedure Generator 
section (page 18). 
The SQL Development Program (WINDBI)  
Used to execute SQL statements and check query optimization. 
This program can be run either from the main menu (System Management  
Generators  Procedures) or from the upper Tools menu (Tools  Run Entity 
(Advanced)  WINDBI). 
Cat.No. LB09
000267  Ver.1 – July 5,’09 6

Tables 
Columns 
Table columns are defined with the following attributes: 
 Column Name: Every column must be assigned an internal name that is 
unique to the table (using capital letters and digits). 
 Column Type: The following column types are available in Priority: 
 CHAR: This type of column may contain a single character or a string 
of characters. A single character is often used for Boolean columns. 
 INT: This type of column contains an integer; this can be defined with 
a decimal precision of 3 in order to create a shifted integer. Most 
quantity columns in Priority use shifted integers. Regular integers, on 
the other hand, are often used in tables for auto-unique key columns. 
 REAL: This type of column contains a REAL number. To designate a 
number with indefinite decimal precision, use decimal precision 0. 
 DATE: This type of column contains a date, represented in either 
American (MMDDYY) or European (DDMMYY) format, depending on 
system definitions. If the column width is defined as 8 characters, 
dates are represented as DD/MM/YY or MM/DD/YY; if the column 
width is 10 characters, the year is represented using 4 digits (e.g., 
12/01/2009); if the column width is defined as 14, the time is also 
represented, using the 24-hour clock (useful in signature columns). 
 TIME: This type of column may be defined with a width of 5 characters, 
to represent the time of day using the 24-hour clock (e.g., 23:59), or 
with a width of 6 characters, to represent a span of time, in hours and 
minutes (useful for storing labor/machine times). 
 DAY: This type of column contains the day of the week, represented 
by 3 characters. This column can also be used to join the current 
table to the standard DAYS table. 
 UNSIGNED: This type of column contains a positive integer. There are 
no standard tables in Priority that include this type of column. 
 Decimal Precision: Decimal precision (the number of places to display to 
the right of the decimal point) is optional; it is used in real numbers and 
shifted integers. 
 Column Title: The column title is utilized in the user interface (forms, 
reports, programs, ODBC). A title may be easily changed (even 
translated into another language) as often as necessary. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 7

Keys 
Keys are used to provide access to records in the table. The following types of 
keys are used in Priority: 
 Unique Keys (Type U): Every table must include at least one unique key. 
A unique key may be comprised of multiple columns. The order in which 
key columns are designated determines their priorities during data retrieval. 
The header (first column or group of consecutive columns) of any key is 
automatically treated as a non-unique key by the system. 
Example: Take a phone book in which entries are sorted first by last names and 
then by first names (i.e., the unique key is comprised of two columns: LASTNAME 
and FIRSTNAME). If you know the person's last name (the header of the unique 
key), you can skip to this last name and then move through all entries until you 
find the correct one. Moreover, you can stop checking when you have finished 
scanning the entries with this last name. On the other hand, if you only know 
the person’s first name, you would have no means of finding his or her 
telephone number without checking every single entry. 
 Auto-Unique Keys (Type A): An auto-unique key is included in most 
tables as it is an effective means of joining tables in a form; however, it is 
not mandatory. 
 Non-Unique Keys (Type N): The non-unique key is used to provide rapid 
access to data in the table. It is not mandatory 
Table Access   
There are three types of table access:  
 Direct — A conditional query is performed on a unique or auto-unique key 
column; this method accesses only those records whose values in a given 
unique or auto-unique key column satisfy the specified condition. 
 Sequential — A query is run without specifying a condition, or the specified 
condition does not pertain to a key column; all records are accessed. 
 Skip — A conditional query is performed on a non-unique key column, or 
on the first column of a unique key. Records are accessed directly (using 
keys) up to a given point in the table. From this point on, records are 
accessed sequentially. 
WINDBI  
The WINDBI program provides a Dump Table utility (Dump  Table), which 
displays the SQL queries used for the table. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 8

Modifying the Database from Priority  
A number of options for creating and modifying database tables, columns, and 
keys are available in Priority. These include:  
 Create Table  
 Delete Table 
 Change Table Name 
 Add Column to Table  
 Delete Column from Table  
 Add Key to Table 
 Add Column to Key 
 Delete Key from Table 
Rules for Customizing Tables 
 Do not delete or rename a standard table 
 When adding a new column to a standard table, the column name must 
begin with the appropriate prefix.  
 Only non-unique keys (type N) can be added to a standard table 
 When creating a new table, the table name should begin with the 
appropriate prefix. 
Exercise – Creating Tables 
Pilots Table: 
 Internal ID No. – This column serves as an auto-unique key. 
 First Name 
 Last Name 
 ID No. (may contain numbers and letters) – This column 
serves as a unique key. 
 Phone Number 
 Address 
 Date of Birth 
Airlines Table: 
 Internal ID No. – This column serves as an auto-unique key. 
 Company No. (may contain numbers and letters) – This 
column serves as a unique key. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 9

 Company Name 
 Country – This column is used to create a join with the 
standard Countries table. 
Aircraft Table: 
 Internal ID No. – This column serves as an auto-unique key. 
 Aircraft No. – This column serves as a unique key. 
 Capacity 
 Manufacturer – This column is used to join this table to the 
standard Manufacturers table. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 10

Form Generator 
Forms can be seen as windows into specific database tables, and are used to 
maintain the data in these tables. In fact, most of the work in the system is 
carried out by means of forms. For example, when a part is shipped as a result of 
a sales order, the balance to ship is updated according to definitions recorded in 
the Shipping Documents form. 
Form Attributes  
A form is characterized by:  
 A unique name  
 A title  
 A base table 
 Basic operations performed in the form (adding, updating and deleting 
entries) automatically affect records in the base table. 
 If a form is assigned the same name as an existing table, this table is 
automatically designated as the form's base table, and a set of form 
columns are derived from the columns of the base table. 
 All columns that are defined as  unique or auto-unique keys in the 
base table must be included in any form based on that table. 
 Application – An informative column used to classify forms. For new forms, 
specify the three- or four-letter prefix used for new entities. 
 Module –Specify “Internal Development”. 
Form Columns  
Join Columns  
To designate an outer join, add a question mark (?) in the relevant Column ID 
or Join ID column, next to the number of the ID. 
Form Variables 
Two form variables are derived from each form column:  
 FORMNAME.FORMCOL – This variable holds the value currently displayed 
in the form column. A corresponding variable exists and can be called 
for any form column. 
 FORMNAME1.FORMCOL – This variable holds the value currently defined 
in the corresponding column of the base table. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 11

Exercise – Create forms based on each of the tables you created in the 
previous exercise. 
Built-in Triggers 
Built-in triggers are included automatically in every form created via the Form 
Generator. These form triggers are essentially SQL statements that are 
activated when a form column or row is exited. 
Built-in Triggers at the Column Level 
 CHECK-FIELD — This type of trigger is used to verify column values. 
Example: When recording a sales order, a built-in CHECK-FIELD trigger 
verifies that the specified customer exists in the CUSTOMERS join table. 
 POST-FIELD — This type of trigger is used to fill in column values. 
Example: To continue the previous example, once a valid customer 
number is designated in the Sales Orders form, the corresponding 
internal customer ID is filled in automatically. 
Built-in Triggers at the Record Level 
These types of built-in triggers perform the following functions: 
 INSERT —inserts records into the form's base table. 
 UPDATE — updates records in the form's base table. 
 DELETE —deletes records in the form’s base table. 
Example: Add a Country column to the Pilots table, joining it the Countries 
table. If the join column is not hidden, you will be able to see that when a 
country is specified, the join column is filled in automatically. 
User-defined Triggers 
User-defined triggers can be divided into two groups: 
 Triggers that have been developed by Eshbel and are included in every 
installation of Priority. 
 Customized triggers that are only included in the specific installation in 
which they were developed/installed. 
These triggers enable you to write SQL statements designating the operation(s) 
to be performed when a particular event occurs in a Priority form. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 12

Events at the Column Level 
 CHECK-FIELD trigger — Before exiting a column, CHECK-FIELD triggers 
perform verification checks for the column. 
Example: A CHECK-FIELD trigger can be used to verify that the quantity 
specified in a given column is greater than zero, or to verify that the date in 
a given column falls in the future. 
 POST-FIELD trigger — Upon exiting a column, POST-FIELD triggers perform 
a designated operation or operations (used primarily to record default 
values in other form columns). 
 PRE-FIELD trigger — Upon entering a column, PRE-FIELD triggers perform a 
designated operation or operations (used primarily to record the default 
value in a mandatory form column). This type of trigger is not included in 
most forms, so there are very few examples of its use. 
 CHOOSE-FIELD/SEARCH-FIELD trigger — When the user presses F6 in a 
column, these triggers display a Choose list or Search dialog box, 
respectively, in which the user can locate the desired value(s). 
Note: These triggers are discussed further in the Events at the Form 
Level section.  
Events at the Record Level 
 PRE-LINE trigger — Upon entering a row, PRE-LINE triggers perform a 
designated operation or operations. Like PRE-FIELD triggers, this type of 
trigger is not included in most forms. 
 PRE-INSERT trigger — Before exiting a new record and inserting the record 
in the database, PRE-INSERT triggers perform verification checks. 
 PRE-UPDATE trigger — Before exiting an updated record and updating the 
record in the database, PRE-UPDATE triggers perform verification checks. 
Note: Both this trigger and the previous one are used primarily for 
verification checks performed on the entire record; that is, they can only 
be performed once the relevant values have been recorded in all 
columns. 
 POST-INSERT trigger — Upon exiting a new record and inserting the record 
in the database, POST-INSERT triggers perform a designated operation or 
operations. 
 POST-UPDATE trigger — Upon exiting an updated record and updating the 
record in the database, POST-UPDATE triggers perform a designated 
operation or operations. 
 PRE-DELETE trigger — Before deleting a record from the database, 
PRE-DELETE triggers perform verification checks. 
 POST-DELETE trigger — After a record has been deleted, POST-DELETE 
triggers perform a designated operation or operations. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 13

Events at the Form Level 
 PRE-FORM trigger — Upon entering a form, PRE-FORM triggers perform a 
designated operation or operations. Common examples include: 
 Setting the values of global variables (e.g., variables that hold the 
internal numbers of target forms activated from this one). 
 Automatic retrieval of all records when a user opens the form, using 
the KEYSTROKES command (often used in status forms). 
 POST-FORM trigger —Upon exiting a form, POST-FORM triggers perform a 
designated operation or operations (provided that the user has made at 
least one change in the database). This type of trigger is useful, for 
example, for updating values in the upper-level form on the basis of values 
specified in the sub-level form. 
 CHOOSE-FIELD trigger — In addition to creating a CHOOSE-FIELD trigger for 
a specific form column, you can also define a CHOOSE-FIELD trigger at the 
form level. When defining a CHOOSE-FIELD query: 
 The syntax of the CHOOSE-FIELD query requires you to specify either two 
or three columns. 
 When three columns are specified, only the first two columns are 
displayed in the Choose list. The third column is used for sorting 
purposes. 
 The columns to be displayed must be of CHAR type. In order to display a 
number or date, you must first convert it into a string. 
 If you want to display a single column in the Choose list, you must add 
an empty string ('') to the CHOOSE-FIELD query. 
 The number of records in the Choose list cannot exceed the number 
specified in the CHOOSEROWS system constant. 
 SEARCH-FIELD triggers — There are two main types of SEARCH-FIELD 
triggers that can be defined at the form level: 
 The SEARCH-DES-FIELD trigger searches by name or description. The 
name or description column is the first column in the query. The key 
column (the one linked to the search field) is the second column in the 
query. The search is performed on the name or description column. 
 The SEARCH-NAME-FIELD trigger searches by number. The key column is 
the first column in the query (the one linked to the search field). The 
name or description column is the second column in the query. The 
search is performed on the number column. 
Note: A third type (SEARCH-EDES-FIELD) is used only in a non-English system, to 
search by the name/description in English.  
Cat.No. LB09
000267  Ver.1 – July 5,’09 14

Order of Trigger Execution – Events at the Column Level 
 Built-in triggers precede user-designed triggers. Thus, for example, built-
in CHECK-FIELDs precede user-designed CHECK-FIELDs. 
 CHECK-FIELD triggers precede POST-FIELD triggers. 
 Standard and custom triggers are sorted alphabetically (e.g., 
AXXX_POST-INSERT precedes ZXXX_POST-INSERT). 
Order of Trigger Execution – Events at the Record Level 
 PRE-INSERT triggers precede the built-in INSERT trigger, which, in turn, 
precedes POST-INSERT triggers. The same principle applies to the 
UPDATE and DELETE triggers. 
Rules for Customizing Forms 
 Do not use a standard base table to create your own form, except when 
creating a query form. 
 When modifying a standard form, any newly added column must start with 
the appropriate prefix.  
 Do not use a standard table column to create your own form column. Even 
if a given table column is hidden and does not appear to be in use, it should 
not be used to create a custom form column. 
 Any trigger you add must start with the appropriate prefix. 
WINDBI  
The following WINDBI utilities are used when working with forms:  
 Dump  Form Cursor 
 Dump Form (Dump  Form) — displays the SQL queries of the form, 
including the triggers of that form, both built-in and user-defined. 
Sub-level Forms 
A sub-level form is used to display data that are relevant for a single record in its 
upper-level form. This linkage between the upper and sub-level form is executed 
through one or more columns. 
Exercise – Creating Forms: 
1. Create the following forms, displaying all columns defined in the 
tables from the previous exercise, unless otherwise directed: 
 Pilots 
 Airlines 
Cat.No. LB09
000267  Ver.1 – July 5,’09 15

 Aircraft 
2. Add a sub-level to the Airlines form, enabling users to link pilots to 
their respective airlines: 
3. Each pilot can be linked to multiple airlines. 
 The sub-level form should display the pilot's ID number. 
 Define a Choose list and Search lists for the Pilot ID No. 
column. The remaining columns should be defined as 
read-only. 
4. Add an Aircraft Fleet sub-level to the Airlines form, enabling users 
to link aircraft to their respective airlines: 
 Each aircraft can be linked to multiple airlines. 
 The sub-level form should display the aircraft number. 
 Define a Choose list and Search lists for the Aircraft No. 
column. The remaining columns should be defined as 
read-only. 
5. Create a Flights form with the following form columns: 
 Date 
 Flight No. 
 Airline 
 Aircraft 
 From Airport — Define a Choose list to enable selection 
from the standard PORTS form. 
 To Airport — Define a Choose list to enable selection from 
the standard PORTS form. 
 Pilot — Define this column to enable selection of any pilots 
that are linked to the specified airline. 
Note: This form should enable users to define flights with the 
same flight number and different departure dates. 
6. Add a Passengers sub-level to the Flights form: 
 The form should enable users to choose the customers that 
will be passengers on the flight in question. 
 The number of passengers on each flight should be 
restricted to the capacity of the specified aircraft for that 
flight. 
7. Add a Customer Flights sub-level to the Customers form: 
Cat.No. LB09
000267  Ver.1 – July 5,’09 16

 The form should enable user s to choose the flights on 
which the customer in question will be a passenger. 
 The form should prevent user s from assigning a customer 
to a flight that has been filled to capacity. 
 Selection of a flight shoul d be based on two values: date 
and flight number. To this end, define the following Choose 
lists: 
Date of Departure – This Choose list should display the 
dates of departure for all future flights (each date should 
appear once). 
Flight No. – This Choose list should display the numbers of 
all flights that are scheduled to depart on the specified date.  
Cat.No. LB09
000267  Ver.1 – July 5,’09 17

Procedure Generator 
Procedures are a set of executable steps carried out in a predefined order. 
Procedure Uses 
 Creating processed reports — reports that are generated following data 
manipulation.  
 Creating documents — special procedures that collect data from more 
than one report and display a final file using an Internet browser. 
 Creating a new document (e.g., a sales order) on the basis of another 
document, by means of an interface to a form. 
 Running the SQLI  program and/or internal programs, which perform data 
manipulations and other tasks (e.g., the Backflush program). 
Rules for Customizing Procedures 
 Do not customize an existing procedure. Rather, you must copy it and 
make revisions to the copy. 
Procedure Attributes 
A procedure is characterized by the following attributes:  
 Procedure Name  
 Procedure Title  
 Procedure Type — used to specify whether this is a regular procedure, 
a procedure that runs a report, or a procedure that creates a Dashboard 
or a web part within a Dashboard.  
 Application 
 Module 
Procedure Steps 
A procedure is composed of a set of entities and/or commands that are 
executed in a fixed order. Each entity, identified by its name and type, 
constitutes a separate step in the procedure. The order of execution is 
determined by the Step column. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 18

Step Types 
There are several different types of procedure steps, each of which is a valid 
entity: 
 a report ( R), which generates a report after data processing 
 a form (F) , used to input data 
 a procedure ( P), which activates a sub-procedure 
 a Basic command ( B), e.g., INPUT, SQLI, or CHOOSE 
 a form load interface (I), used to run a form interface 
 a table load file (L ), used to import external data into a Priority table 
 a compiled program (type C), used to manipulate data. 
Basic Commands 
The following is a list of useful Basic commands. A full list appears in the SDK 
manual. 
 CHOOSE — Creates a menu of exclusive options, one of which must be 
chosen by the user (by flagging one of the radio buttons). This Choose 
menu will not be displayed if the procedure is run by Direct Activation 
from a form. This command is useful when creating a procedure that can 
be used to run two different reports (e.g., a detailed report or a 
summary). 
 CHOOSEF — Same as CHOOSE, except that the menu will be displayed 
when the procedure is run by Direct Activation. 
 CONTINUE — Opens a pop-up menu of two exclusive options, one of 
which must be chosen by the user. The procedure will continue if the OK 
option is chosen; it will halt if the Cancel option is selected. 
 END — Ends execution of the procedure; generally used in conjunction 
with the GOTO command. 
 GOTO — Causes a jump to a designated procedure step. 
 HTMLCURSOR — Declares the cursor for an HTML document. This step 
first creates a linked file that holds the records selected in the PAR input 
parameter. 
 INPUT — Inputs parameter values; in the case of user input, creates a 
parameter input screen. The input screen will not be displayed if the 
procedure is run by Direct Activation from a form. In document 
procedures, this command is also used (as a final step) to display the 
document. 
Note: User input can also be defined for the SQLI program. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 19

 INPUTF — Same as INPUT, except that the parameter input screen will 
be displayed when the procedure is run by Direct Activation. 
 MESSAGE — This command and the following commands are used to 
displays a procedure message on screen. 
 PRINT 
 PRINTCONT 
 ERRMSG  
 WRNMSG  
Procedure Parameters 
Most procedure steps incorporate parameters. To define parameters, use the 
Procedure Parameters form, a sub-level of the Procedure Steps form. You 
should define the following attributes: 
 Parameter Name — restricted to 3 characters 
 Width — the width of the column in the parameter input screen 
 Type — there are three distinct types of procedure parameters: 
 Those which are constants or variables ( INT, CHAR, REAL). 
 Those which are ASCII files ( ASCII). 
 Those which are linked files ( FILE, LINE). 
User Input 
When the values of parameters are determined by the user, use the Procedure 
Parameters sub-level of the Procedure Steps form to define input. 
 In the Input column, specify I to indicate user input, or M if the input is 
mandatory. The procedure will not run if no value has been specified in a 
mandatory input column. 
 If, during input, the user is to spec ify new values (not in the database), 
you must record a parameter (of any type except ASCII, FILE or LINE), 
together with a valid width and a title. In such a case, an equal sign (=) 
will appear in the first line of the column in the parameter input screen. 
 You can insert a pre-set, revisable value into the input screen — for 
instance, the current date (SQL.DATE8) for a DATE parameter. The user 
can then choose between using that value or modifying it. To do so, 
specify the pre-set value in the Value column (of the Procedure 
Parameters form) for the parameter in question. 
Note: The pre-set input value appears the first time the user runs the 
procedure. If that value is then revised, the revised value will appear the 
next time the user runs it. You can, however, ensure that the pre-set 
Cat.No. LB09
000267  Ver.1 – July 5,’09 20

value always appears. To do so, enter the Procedure Parameter 
Extension sub-level form and specify d in the Type column.  
 If you want the user to choose between several predefined options 
within a given input field, create a parameter of INT type, and record the 
various options in consecutive messages (in the Procedure Messages 
form). Then enter the Procedure Parameter Extension sub-level form 
and specify C in the Type column. Indicate the range of message 
numbers in the From Message and To Message column. 
Note: To use messages recorded for a different procedure, designate its 
name in the Entity Name column. 
 Additional options can be defined in the Procedure Parameter Extension 
sub-level form: 
 You can encode user input (e.g.,  when a password is given) by 
flagging the Hide User Input column. 
 You can add a Browse Button to allow users to input a file 
attachment. 
Retrieving Records Into a Linked File 
Another type of user input involves retrieval of records from a given database 
table into a linked file. A linked file is a copy of a database table that includes all 
the columns and keys from the original table. The content of a linked file is 
input by the user via a parameter input screen or by means of a form. To work 
with linked files in Priority, you must designate one of two parameter types: 
FILE or LINE. In addition, you must specify the names of the table and column to 
which the file is linked. A linked file can serve as a procedure parameter 
comprised of a batch of records. 
Example: Use an input parameter of type FILE to input records from the Sales 
Orders table into a procedure. The Sales Orders form is accessed by pressing 
F6 from the relevant field in the input screen. The user chooses one or more 
orders and exits the form. After exiting the form, a copy of the table is created, 
containing the selected records. 
 
Note: If the user enters a wildcard (*) in the input field, the linked file will contain a 
copy of all records in the table. If the table contains a large amount of data, this 
operation will require heavy processing and take a long time to complete. It is 
therefore recommended that you restrict this type of input when working with large 
tables (e.g., TRANSORDER, FNCITEMS). 
Linked files can also function as a work area in which data manipulation is 
performed prior to report output. After the database manipulations are 
Cat.No. LB09
000267  Ver.1 – July 5,’09 21

completed, the required data is stored in the linked file and you can simply 
display the results in a processed report, without affecting the database table. 
To create a linked file, use the LINK command: 
LINK ORDERS TO :FILEVAR; 
Where :FILEVAR is a variable of type FILE or LINE. 
After executing the LINK command, check the :RETVAL variable to make sure 
that the LINK command was successful. If the link fails, halt execution of the 
procedure, to ensure that the subsequent operations are not performed on the 
real table. Data manipulations, such as inserting or updating records, should 
never be performed directly on the real table, as this bypasses the integrity 
checks and other actions defined in the form triggers.  
Once the LINK command is successful, all subsequent operations that refer to 
the original table are actually executed upon the temporary file. Data 
manipulations can then be carried out on the linked file. 
If you wish to refer to the original table (e.g., to retrieve additional records) after 
executing the LINK command, use an alias.  
Example: To retrieve additional records from the ORDERS table after executing 
the command: 
LINK ORDERS TO :$.PAR; 
use the following syntax: 
INSERT INTO ORDERS 
SELECT * FROM ORDERS O 
WHERE…..; 
You cannot link the same table more than once. However, you can circumvent 
this restriction by using an alias to refer to the table (e.g., ORDERS A and 
ORDERS B). In this case, you will obtain another copy of the table for each link, 
and these may be used as separate files. 
Example: While you cannot link the ORDERS table twice, you can link both 
ORDERS A and ORDERS B: 
LINK ORDERS A TO :FILE1; 
LINK ORDERS B TO :FILE2; 
You can then specify either ORDERS A or ORDERS B when performing a query. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 22

A Special Parameter – PAR 
The name assigned to a procedure step is generally of no significance. 
However, in procedures that are run by Direct Activation from a form and in 
procedures in which an HTML document is created, there is significance in the 
naming of the PAR parameter, which is a parameter of type FILE or LINE. 
When a procedure is activated from within a form, input is taken from the 
current form record(s). That is, a linked file is created, based on the form’s base 
table and consisting of the selected record(s). This linked file is input to the 
procedure by the PAR parameter, which must be a parameter of type FILE or 
LINE. 
The difference between using a FILE or LINE parameter is as follows: 
 A LINE parameter is used to create a linked file that can receive a single 
record only (the record on which the cursor rests). 
 A FILE parameter is used to create a linked file that can receive an 
unlimited number of records. 
Thus, the decision to use one parameter type over the other depends on 
whether you want to restrict the user's selection to a single record from the 
table in question. 
Using a Form for Input 
As mentioned earlier, you can also define a form as a procedure step. 
(procedure step of type F). When the procedure is run, this form is loaded and 
users are able to retrieve records that are copied to a linked file and serve as 
input for the procedure. 
When setting up a form step, define a FILE parameter for the step in which the 
form is linked to the procedure. When the form is exited, the FILE parameter is 
used to create a linked file, based on the form’s base table. This file receives 
the records that were selected by the user. 
Example: See the CLOSEAIVS procedure. 
Step Queries 
INPUT and SQLI steps can be accompanied by SQL statements that serve as 
step queries. To record such statements, use the Step Query form, a sub-level 
of the Procedure Steps form. When defined in conjunction with an INPUT step, 
these queries are carried out after parameter input. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 23

Parameter Variables 
Step queries can include SQL variables that refer to specific parameters. The 
system defines an SQL variable for each parameter, which stores its value 
(i.e., :PROCNAME.PAR). For example, if the INPUT step in the ESH_OPENDOC 
procedure includes an input parameter called CHI of type CHAR, and you want 
to refer to the content of this parameter in a later step of this procedure, you 
can use the variable :ESH_OPENDOC.CHI. Alternatively, the procedure name can 
be replaced by the wildcard “$” if reference is to the current procedure 
(i.e., :$.CHI). 
Error and Warning Messages 
The contents of error or warning messages generated by a procedure can be 
specified in the Procedure Messages sub-level of the Procedure Generator, or 
as part of a step query, in the Procedure Messages sub-level of the Step Query 
form. 
An error or warning message can include parameters (a maximum of three per 
message) — <P1>, <P2> and <P3>. The values to be assigned to these 
parameters are defined by means of the system variables :PAR1, :PAR2 and 
:PAR3. 
Passing Procedure Parameters to a Report 
When using a procedure to run a report, you can pass input parameters from 
the procedure to the report. This is done by entering the Procedure Parameters 
sub-level form from the report step and recording the name of the parameter. In 
order to refer to the procedure parameter in the report query, specify a colon (:) 
followed by the parameter name (e.g., to refer to the procedure parameter ABC, 
the report query should specify the parameter variable :ABC). 
To pass a parameter of type FILE or LINE to a report, you must also specify the 
name of the table to which the parameter is linked in the Value column. When 
the report is run, the report will refer to the linked table, rather than the original 
database table. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 24

Declaring a Cursor 
A cursor enables you to fetch multiple records from Priority tables and execute 
conditional data manipulations on each record. To do so, use the following 
query: 
DECLARE mycursor CURSOR FOR …; 
OPEN mycursor ; 
:N = :RETVAL ; :I = 0; 
GOTO 9 WHERE :N < 0 ; 
LABEL 1; 
FETCH mycursor INTO … ; 
GOTO 8 WHERE :RETVAL < 0; 
:I = :I + 1; 
DISPLAY :I OF :N ; 
{processing of current record} 
LOOP 1; 
LABEL 8 ; 
CLOSE mycursor ; 
LABEL 9; 
Exercise: 
1. Write a procedure that receives  a customer name as its input 
(restrict input to a single customer name). The procedure checks 
how many open sales orders have been recorded for the 
designated customers, and finally displays the following 
message: “There are X open orders for customer CUSTNAME”. 
2. Write a procedure that runs  a report. The procedure should 
receive the following input: 
 Part Number (users can choose one or more parts from the 
Part Catalogue) 
 From Date 
 To Date 
For each part number, the procedure counts how many order items for the 
specified part appear in purchase and sales orders recorded over the 
designated period. The procedure then displays a report that contains the 
following data: 
 Part Number 
 Part Description 
 Number of Sales Order items 
 Number of Purchase Order items 
Cat.No. LB09
000267  Ver.1 – July 5,’09 25

The Form Load 
As explained earlier, forms are a means of correctly inserting data into Priority 
tables. The integrity checks and other actions defined in the form triggers are 
performed only when records are inserted into forms. Thus, records should 
never be inserted directly into standard Priority tables.  
Priority's form load utility provides programmers with a means of automatically 
importing records into Priority forms. The form load utility is accessed via the 
menu path: System Management  Database Interface  Form Load (EDI)  
Form Load Designer. 
Example: Shipping documents can be opened automatically for a batch of 
sales orders, rather than opening these documents manually. In this case you 
must use the Form Load Designer to insert new records into the Sales Orders 
form and its sub-levels.  
Creating a Form Load Interface 
When creating a form load interface, the following attributes should be defined: 
 Load Name 
 Title 
 Load Table — When using a load table to import or export data, this table 
must contain certain columns, defined as follows (name, type, width): 
 LINE (INT,8) — The LINE column must be the unique key of the table 
 RECORDTYPE (CHAR,3) 
 LOADED (CHAR,1) 
 KEY1 (CHAR,20) 
 KEY2 (CHAR,20) 
 KEY3 (CHAR,20) 
 Module Name — Specify “Internal Development”. 
 Ignore Warnings —Priority forms may generate errors and warnings 
when records are added or updated. If you want the INTERFACE program 
to treat warning messages as errors, leave this column blank. This 
column is usually flagged, in order to prevent load errors that are caused 
by warning messages in the form. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 26

 Record Size — This is a mandatory column. In most cases, it is 
recommended to indicate a record size of 1,000. 
 File Name — When using an external data source, rather than a load 
table, indicate the relevant file. 
Note: Detailed instructions on using use the Form Load Designer appear in the 
SDK manual.  
Forms in the Load 
Use the Forms to be Loaded sub-level form to specify which forms participate 
in the load. Indicate the name of each form, as well as the code representing its 
record type. For each form, use the Link Form Cols to Load Tbl Cols sub-level 
form to indicate which form columns are equivalent to which load table columns 
and to specify the order of column insertion. 
When you want to create a form load that updates records, make sure you link 
a load table column to a unique (or auto-unique) key column in the form's base 
table. In such a case, make this column first in order of insertion. This ensures 
that the interface first retrieves the record in question and then updates the 
remaining columns. 
Note: You can also use advanced interface definitions both to insert new form 
records and to update existing ones.  
Running the INTERFACE program 
The program processes records in the load table in the order defined in the 
LINE column. 
The value defined in the RECORDTYPE load table column determines the form 
into which each record is inserted. 
The definitions in the Link Form Cols to Load Tbl Cols form determine which 
column in the designated form is updated by each load table column. 
Once a record is successfully loaded into a form (after the INTERFACE program 
is run), the LOADED column is assigned the value Y and the values of the key 
columns are updated by the new record that was opened. If there is an auto-
unique key, that will serve as KEY1. If not, the columns making up the unique 
key will be inserted in as many keys as necessary. Therefore, you need at least 
as many key columns in your table as the number of columns in the unique 
key. 
Cat.No. LB09
000267  Ver.1 – July 5,’09 27

Executing the Form Load 
To execute a form load, you can include it as a step in a procedure, or activate 
it from an SQLI step in a procedure, using the EXECUTE command. 
Basic Form Load Parameters 
 ' msgfile' — An ASCII parameter in which error messages will be recorded. 
This can later be passed to a PRINT procedure step in order to display the 
resulting message to the user (e.g., "5 out of 6 records were loaded."). 
if you want the INTERFACE program to refer to a linked copy of the load table 
when executing a form load from a procedure, add the following two 
parameters: 
 '-L' — A CHAR parameter that tells the load program to insert records into 
a linked table. 
 ' link_file' —A FILE parameter. Before running the INTERFACE program, use 
this parameter to create a linked copy of the load table defined for this 
form load.  
If errors are encountered by the INTERFACE program, they will be sent to the 
ERRMSGS table. These errors can be viewed in the Load Errors report 
(INTERFACERR). 
Note: Additional information on executing a form load appears in the SDK 
manual. 
Exercise: 
1. Write a procedure t hat creates sales orders. The procedure 
should receive the following input: 
 Customer Number (receives only one customer at a time) 
 Part Number (users can press F6 to choose one or more 
parts from the Part Catalogue) 
 Due Date 
The procedure should use a form load interface to create an order for the 
designated customer and itemize it using the specified parts. Each item will 
be defined with an initial quantity of 1. The unit price will be recorded 
according to the definitions in effect for the Order Items form. When the 
procedure finishes running, one of the following messages is displayed: 
Cat.No. LB09
000267  Ver.1 – July 5,’09 28

Cat.No. LB09000267  Ver.1 – July 5,’09  29
 If no order was opened: 
"The program did not run successfully. No order was 
opened for customer Y." 
 If an order was opened and no e rrors were encountered: 
"Order X was opened for customer Y." 
 If an order was opened, but errors were encountered when 
adding one ore more order items: 
"Order X was opened for customer Y. However, errors 
were encountered when adding order items." 
2. Write a similar procedure,  with the following difference: 
Instead of only a single customer number, the procedure can 
receive one or more customer numbers as input. 
When the procedure finishes running, one of the following messages is 
displayed: 
 If all orders were opened and no errors were encountered: 
"X orders were opened for the specified customers." 
 If errors were encountered: 
"X orders were opened for the specified customers. 
However, errors were encountered." 
3. Write a procedure that updat es the due date of a designated 
order. The procedure should receive the following input: 
 Order Number 
 Date 
For order items with a due date that precedes the date received as input, 
the procedure updates the due date with the date received as input (e.g., if 
the input specified the date 15/6/09, and the due dates of all order items is 
defined as 18/6/09, no dates will be revised). 
The procedure should be written so as to enable either Direct Activation 
from a form or activation from a menu. 
When the procedure finishes running, an appropriate message should be 
displayed. 
Note: The second exercise requires you to declare a cursor which passes 
through all the selected customers. Use of a cursor ensures that the relevant 
records are loaded correctly.
