# DataMig_Upload_TS

- **Source:** `DataMig_Upload_TS.htm`

Data Migration - Troubleshooting the System Load 
 
 
- 
 
 
 
# Troubleshooting Problems Encountered During the System Load

 

A successful load results in the transfer of all data from the interim table to the system, accompanied by an empty errors report. In most interim tables, an error in one of the records prevents it from being loaded; in others tables – those that load data into multiple system forms – a record may be partially loaded (i.e., some its data is transferred). 
 

Run the errors report and correct any problems that were encountered in the interim table. When you are done, reload the corrected records and check the errors report again. An empty report indicates that all of the data has been successfully loaded. 
 

At this point it is recommended to remove all data from the interim table, in order to prevent the same data from being reloaded at some later time, when it is no longer up-to-date.
