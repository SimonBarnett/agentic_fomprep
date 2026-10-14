# SOP Data Migration

- **Source:** `SOP Data Migration.pdf`

Cat.No.A8000051 1 Ver.1 – Jan.11, ’09 
 
SOP: Data Migration* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aims 
 To perform data migration using a l ead employee rather than an implementor. 
 To use ready-made interfaces that save time and effort when loading basic data 
into Priority. 
 To prevent the acceptance of erroneous data before it enters the system, by 
loading data into interim tables and running checks on those tables. 
Note: All the relevant forms and programs can be found in the Data Migration menu 
(menu path: System Management > Data Interface). 
Working Assumptions 
 Migrations will be performed on the basis of tabular files, consisting of a single 
line for each record. 
 Migrations will be performed on the basis of only two types of files: ASCII files 
and tab-separated files (MS-Excel). 
Note: Secondary migrations are often required when loading complex files to the 
database. These processes will be defined in advance. 
Setup 
 Before loading the data files into Priority , you need to define basic data in the 
system. Enter the forms in the Forms for Recording Data sub-menu and record 
the relevant data. 
Procedure 
Stage I: Defining the File Structure for Migration 
Before using the Data Migration module, you need to prepare the file to be loaded. 
The file should include the records that you want to migrate. Make sure that the file 
includes all of the mandatory fields in the table to which you are migrating the data 
(e.g., Part Number). You also need to know the position of each field in the file (for 
tab files) or its range within the record (for ASCII files). 
1. Open the menu for the desired data (e.g., Part Data Migration. Customer Data 
Migration). 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Cat.No.A8000051 2 Ver.1 – Jan.11, ’09 
2. Enter the relevant Load File Definitions  form. The Title column lists all the fields 
that can be migrated to Priority. 
3. Fill in the First Character and Last Character of each field. 
 If you are loading a file containing fields with a fixed width, use these values to 
specify where each field begins and ends in the record. 
 If you are loading a file separated by tabs, specify identical values in these 
columns; in this case, they represent the relative position of the fields in the 
record. 
Tip: For fields that are not relevant to the migration, it is recommended to define 
unrealistic values (e.g., 999). 
4. If the field is a date, select the appropriate date format. 
Stage II: Loading the File into the Interim Table 
 Run the relevant Load File into Interim Table program. 
Tip: Click the folder icon in the Load File input screen to browse to the file. 
Stage III: Checking the Data in the Interim Table 
1. Run the Check for Errors in Interim Tbl report. The report displays various 
errors in the data loaded into the table, according to category. These errors are 
usually the result of missing mandatory data or data inconsistent with the existing 
data in the system. 
2. To correct the errors or delete records that you do not want to load into the 
database, enter the interim table form and perform the necessary revisions. 
Stage IV: Performing Global Corrections in the Interim Table 
 You can run a variety of programs in the Auxiliary Programs sub-menu to 
perform automatic corrections in the table – e.g., remove quotation marks 
(relevant mainly to files based on Excel), change the order currency, update price 
list dates and delete data already in the system. 
Stage V: Loading the Data into the System 
1. Before loading part records into the system, you can create Choose lists of part 
specs on the basis of the specs appearing in the interim table. To do so, run the 
Set Permitted Values-Part Spec program. In addition, if you did not define part 
families when initializing basic data, you can do so at this stage by running the 
Create Part Families from IntTbl program. 
2. Run the Load from InterimTbl to Database program. You can choose between 
loading only those records that have not previously been loaded to Priority forms 
(which will prevent existing data – which may have already been updated – from 
being overwritten), and loading all records in the interim table. The program will 
report the number of lines that were successfully loaded into the various system 
forms. 
3. You can view any lines that were not loaded due to errors in the Load Errors 
report. 
4. After loading the data into the system, it is recommended to run the  Clear Interim 
Table program (usually in the Auxiliary Programs sub-menu) in order to prevent 
old data from being reloaded into the system.
