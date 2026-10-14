# DataMig_Check_File

- **Source:** `DataMig_Check_File.htm`

Data Migration - Checking Errors in the Interim Table 
 
 
- 
 
 
 
# Checking Errors in the Interim Table

 

After loading a data file into the interim table, you need to check the data for errors by running the Check for Errors in Interim Tbl report in the relevant data migration sub-menu. This report checks for two kinds of errors: 
 

 ·        Data fields that fall under the wrong column titles. 
 

 ·        Discrepancies between data in the interim table and existing data in the system. 
 

Since both errors involve valid data that are nonetheless the source of error, it is advisable to enter the relevant interim table (e.g., for part data, enter the Interim Table-Parts form) and inspect the contents. A significant part of the problems that occur during data migration can be identified in this manner, through a good knowledge of the data and their desired structure. 
 

Additional error checks are made when the data is loaded into the system. 
 
## To correct data that fall under the wrong column title:

 

 1 .  Run the Clear Interim Table program in the relevant data migration sub-menu to delete all records from the interim table. 
 

 2 . Update the fields in the input file or change the settings in the relevant load file definitions form (e.g., for part data, enter the Load File Definitions-Parts form). 
 

 3 . Reload the input file and check again for errors. 
 

 4 . Repeat the above process until there are no errors.
