# ProdRep_delete_doc

- **Source:** `ProdRep_delete_doc.htm`

Production Report - Deleting a Production Report 
 
 
- 
 
 
 
# Deleting a Production Report

 

If you need to revise an operation in the routing for which one or more production reports have already been recorded, you must delete the report(s) before you can make the desired revisions. 
 
## Before You Begin

 

 ·        To preserve a record of the production report(s) you are about to delete, run the Reported Production by Work Ord. report for the work order for which production was reported. 
 
## To delete a production report:

 

 1 .  Enter the Reporting Production Details form and retrieve all reports for the work order and operation in question. 
 

 2 .  In the desired report, click the Form tab and remove the flag from the Final column, if one appears.
 Note: If the original production report was recorded in the Reporting Production form, you will receive an error message preventing you from removing the flag in the current form. In such a case, press F6 from the Form Number column (in the Form tab) to enter the Reporting Production form, remove the checkmark from the Final column, then return to the Reporting Production Details form. 
 

 3 .  Delete all lines from this work order and operation. 
 

 4 .  Run the Backflush program to update production data in the system. 
 
## Note:

 

After you have made the desired revisions in the operation, you must go back and rerecord the deleted production reports, then run the Backflush program again in order to update the reports with the new data. You can use the Reported Production by Work Ord. report that you ran as your guide.
