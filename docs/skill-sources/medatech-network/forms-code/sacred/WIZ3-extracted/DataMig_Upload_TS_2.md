# DataMig_Upload_TS_2

- **Source:** `DataMig_Upload_TS_2.htm`

Data Migration - Troubleshooting the System Load.2 
 
 
- 
 
 
 
# To view errors encountered during the system load:

 

 ·        Open the Load Errors report that was created automatically after the load (or run the report from the appropriate sub-menu). 
 
## To correct lines that were not loaded into the database:

 

 1 .  Enter the interim table. 
 

 2 . Retrieve all records that are not flagged in the Loaded column.
 Note: If the data is loaded into multiple forms, use the Query Generator to retrieve all records that are not flagged in at least one of the load confirmation columns. 
 

 3 . Make the necessary corrections.
 Tip: Since the Loaded column can also be flagged manually, check your work against the error report to make sure you haven't missed any problematic records. 
 
## To load only those lines (or line data) that were not already loaded:

 

 ·        Run the Load from InterimTbl to Database program from the appropriate sub-menu, using the default Unloaded Lines Only option. 
 
## To reload all of the data in the interim table (overwriting the data that is already in the system):

 

 ·        Run the Load from InterimTbl to Database program from the appropriate sub-menu, choosing the Reload option. 
 
## To delete all records from the interim table:

 

 ·        Run the Clear Interim Table program from the appropriate Auxiliary Programs sub-menu. 
 
## Note:

 

Click to return to the main screen.
