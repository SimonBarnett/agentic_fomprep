# Data Migration Script

- **Source:** `Data Migration Script.pdf`

Data Migration Script 
Clip Link: http://www.eshbel.com/Movie_Search/Data_Migration_clip.htm  
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-01:47) 
The purpose of this video is to help professionals with the task of data 
migration into Priority. When used correctly, our ready-made interfaces can 
save you a great deal of time and effort when loading your data into Priority. 
After watching this video, you are invited to view the data structures most 
commonly migrated, which are listed in the Appendix of the script that 
accompanies the video. 
Before loading all of your data into Priority, it's a good idea to perform the 
process outlined in this video with a small sample of data, in order to learn the 
process and identify potential difficulties. 
For this example, we're going to demonstrate how to load part records from 
your existing catalogue into the system, but the process is similar for other 
types of records, as well. 
Most of the forms and programs you will need for this process can be found in 
the Data Migration menu. 
The first thing you need to do is to make sure that all of the necessary basic 
data have been set up in the forms listed under the Forms for Recording 
Data menu. For instance, before loading part data, make sure you've set up 
the relevant part units, currencies and warehouses. Records for which the 
required data have not been defined in the system will not be loaded into the 
system. 
Next, we'll locate and open the sub-menu that refers to the type of data we'll 
be loading; in this case, Part Data Migration When loading data into Priority 
for the first time, it is recommended to proceed according to the order of 
topics displayed in this menu. Loading your data in the proper order ensures 
that each round of data is integrated smoothly with the data from previous 
rounds. 
Stage I: Defining the File Structure for Migration (01:48-04:07) 
Before you can begin data migration, you need to prepare the text file to be 
loaded. This can be a file generat
ed by your previous system or a tab-
delimited file such as you might generate in MS-Excel. The input file should 
consist of a single line for each record that you want to migrate and the fields 
in this file must match the corresponding fields in Priority. Make sure that the 
file includes all of the mandatory fields in the table to which you are migrating 
the data (e.g., Part Number). Each field can be assigned a fixed width, or 
separated from the next field by a tab. 
Cat.No. LB120128  Ver.2 – July 22,’12 1

Make a note of the position of each field in the file (for tab-delimite
d files) or its 
precise location within the record (for text files with columns of a fixed width). 
Once you have this information handy, you're ready to open the menu for the 
desired data (e.g., Part Data Migration) and define the parameters of the data 
file in the relevant Load File Definitions form. 
The Title column lists all the fields that can be migrated to Priority for records 
of this type. Flag the Inactive column for any field that you do not want to load 
into the interim table. 
Next, we need to fill in the First Character and Last Character of each field. 
Since we are currently loading a file separated by tabs, we'll fill in the same 
number in both columns; in this case, they represent the relative position of 
the field within the record. However, if you wanted to load a file containing 
fields with a fixed width, you would use these values to indicate where each 
field begins and ends in the record. 
If the field is a date, select the appropriate date format. 
When loading journal entries and accounts, you can also use the Definition 
of Load Parameters form  to define different load parameters for various data 
sources. 
Stage II: Loading the File into the Interim Table (04:08-04:57) 
We're now ready to load the data into an intermediary work area called the 
interim table, where it can be adjusted and errors can be corrected, before 
they are transferred to the actual system database. Run the Load File into 
Interim Table program in the relevant data migration sub-menu.  
You will be prompted to specify the path to the data file. Click the folder icon 
in the Load File input screen to browse to the file you've prepared. 
Once the program finishes running, you can proceed to check the data in the 
interim table.  
Stage III: Checking Data in the Interim Table (04:58-10:28) 
Run the Check for Errors in Interim Tbl report from the relevant data migration 
sub-menu. This report displays various errors in the data loaded into the table, 
according to category. Such errors are usually the result of missing mandatory 
data, data fields that fall under the wrong column titles or data inconsistent 
with the existing data in the system. 
Any of these errors may involve valid data that are nonetheless the source of 
error. It is therefore advisable to enter the relevant interim table and inspect 
the contents. A significant part of the problems that occur during data 
migration can be identified in this manner, through a good knowledge of the 
data and it’s desired structure. 
For instance, if you see that some of the data has fallen under the wrong 
column title, close the interim table form and run the Clear Interim Table 
program in the relevant data migration sub-menu. This will delete all records 
from the interim table. 
Cat.No. LB120128  Ver.2 – July 22,’12 2

Next, you can either update the fields in the input file itself or change the 
settings in the relevant load file definitions form. In this example, it should be 
sufficient to correct the relative positions of the relevant fields in the First 
Character and Last Character columns. Once you've corrected these errors, 
reload the input file. 
Let's examine the data in the interim table again. If you notice any errors in 
the data that appear for a particular record, you can correct the values in 
question directly in the interim table. You can also use the interim table to 
delete any records that don't need to be loaded into the database. 
Alternatively, you can run a variety of programs in the Auxiliary Programs sub-
menu to revise certain data automatically.  
Some of these programs are common to all data types. For example, you may 
need to remove quotation marks (relevant mainly to files based on Excel) or 
delete any data that already exist in the system. 
Other programs are specific to the type of data in question, for example:  
changing part units or fixing the value in Boolean fields such as Inventory 
Control. 
You may also need to revise or add to your system data. For instance, the 
data we loaded in this example refer to several part units and part families 
that haven't been set up yet in the system. 
You can use the relevant form in the Forms for Recording Data menu to 
record the missing part units. You can record the missing part families 
manually, as well. Alternatively, you can run a program that adds any missing 
part families to the database automatically. 
Depending on the type of data with which you're working, you may also be 
able to use the data in the interim table to populate Priority tables with 
permitted values for customer categories or part specs at this stage. In our 
example, we can use the data in the interim table to create Choose lists of 
part specs on the basis of the specs appearing in the interim table. To do so, 
let's run the Set Permitted Values-Part Spec program.  
Once you've addressed all of the errors in the report, rerun the report to make 
sure that there are no longer any errors. If the report still contains errors, you'll 
have to repeat the process we have just described until there are no errors. 
Note that additional error checks will be run when the data are loaded into the 
system. 
Before you proceed to load the records from the interim table into the 
database, run the report provided in each sub-menu to check whether any of 
these records already exist in the system. If one or more records already 
exist, you can automatically remove them from the interim table before you 
proceed. To do so, let's run the Delete Existing Parts from Table program. 
Should you choose not to remove these records from the interim table, the 
overlapping records will be overwritten with the records in the interim table 
when you load data into the system. 
Cat.No. LB120128  Ver.2 – July 22,’12 3

Stage IV: Loading Data into the System (10:29-11:08) 
When you are ready to load data into the system database, run the Load 
from InterimTbl to Database program. When the program finishes running, it 
will report the number of lines that were successfully loaded into the various 
system forms. A successful load results in the transfer of all data from the 
interim table to the system, accompanied by an empty errors report. 
Stage V: Troubleshooting Problems Encountered During the Sy stem 
Load (11:09-13:55) 
In most interim tables, an error in one of the records prevents it from being 
loaded; in other tables – those that load data into multiple system forms – a 
record may be partially loaded (i.e., some its data is transferred). For this 
reason, we've gone back and made a few changes to the data in the interim 
table and then rerun the load program, and are now going to demonstrate 
how to locate and handle any errors encountered during the system load. 
These errors are listed in the Load Errors report that was created 
automatically after the load. This report can also be run manually from the 
appropriate sub-menu. 
To correct any lines that were not loaded into the database at all, we’ll retrieve 
all records that are not flagged as loaded. In our example, since data from the 
Parts interim table is loaded into multiple forms, we'll use the Query 
Generator to retrieve all records that are not flagged in at least one of the load 
confirmation columns.  
Since the Loaded column can also be flagged manually, it's a good idea to 
check the query results against the error report to make sure you haven't 
missed any problematic records. Next, we'll make the necessary corrections 
in each line. 
And now we're ready to load the data. To load only those lines (or line data) 
that were not already loaded, run the Load from InterimTbl to Database 
program from the appropriate sub-menu, using the default Unloaded Lines 
Only option. 
Alternatively, you have the option of reloading all data in the interim table (and 
overwriting any data that is already in the system). To do so, you would select 
the Reload option. 
When the program finishes running, check the errors report again. An empty 
report indicates that all of the data has been successfully loaded. 
At this point it is recommended to remove all data from the interim table, in 
order to prevent the same data from being reloaded at some later time, when 
it is no longer up-to-date. To do so, run the Clear Interim Table program from 
the appropriate Auxiliary Programs sub-menu. 
This concludes our explanation of data migration into Priority. 
 
 
 
Cat.No. LB120128  Ver.2 – July 22,’12 4

Cat.No. LB120128  Ver.2 – July 22,’12 5
 
 
 
Appendix 
In most cases, we reco
mmend that new customers load the following types of 
records from any external system they may have used previously: 
 customers; 
 vendors; 
 GL accounts; 
 parts; 
 bills of materials; and 
 journal entries from the current fiscal year. 
Some customers may also wish to migrate data for one or more of the following types 
of records:  
 customer price lists; 
 customer parts; 
 customer contacts; 
 vendor price lists; 
 vendor parts; 
 vendor contacts; 
 alternate parts; 
 manufacturer parts; and 
 child part designations. 
Finally, you also have the option of migrating certain types of documents (e.g., open 
sales (or purchase) orders, GRVs and inventory counts), with the following provisos: 
 Data can be loaded into the root (upper-level) form and the itemized sub-level 
form only. 
 Any document and/or item remarks will not be loaded. 
 When loading open sales or purchase orders, the remaining balance for each 
item will be loaded into the quantity column. 
 In the event that basic data (e.g., customer, vendor or part numbers) have not 
yet been defined, documents will still be loaded, but the description column will 
be left blank. In such a case, it is the customer's responsibility to examine the 
data manually once the file has been loaded and to manually enter descriptions, 
if necessary.
