# Backflush_handling_negative_quantities_algorithm_2a

- **Source:** `Backflush_handling_negative_quantities_algorithm_2a.htm`

Backflush - Troubleshooting Negative Inventory.3 
 
 
- 
 
 
 
# Possible Lines of Investigation:

 

 ·        Is the total reported quantity in the current operation smaller than the quantity reported in the following operation? 
 

If so, there seems to be an error in the production report (insufficient reporting for the current operation or excessive reporting in the following one). Correct the erroneous report. 
 

 ·        Is the following operation rework that was not flagged as such (in the production report or subcontractor GRV)? 
 

If so, flag the production report or GRV as rework.
 Notes: 
 

 ·      If the document is a final production report, you must first reopen it by removing the check mark in the Final column. 
 

 ·      If the document is a final subcontractor GRV, reopen it by selecting Reopen Document from the list of Direct Activations . If the GRV has already been billed, it cannot be reopened and updated. In this case, you need to either record an additional GRV correcting the error, or perform a warehouse transfer. 
 

 ·        Is the operation’s inventory/costing control setting correct? 
 

If not, fix the setting: 
 

 ·      First, run the Reported Production by Work Ord. report for the work order, to preserve a record of the production report(s) you are about to delete. 
 

 ·      Enter the Reporting Production Details form, and delete all production reports for that operation and work order. 
 

 ·      Revise the setting for the current work order, in the Routing for the Work Order form, sub-level of the Work Orders form. 
 Note: If the source of the problem is the standard inventory/costing control setting, you can prevent the problem from recurring by fixing the definition of the work cell or operation. 
 

 ·      Repeat production reporting for the operation, using the Reported Production by Work Ord. report as your guide. 
 

 ·        Is the warehouse in which the current operation was performed different from the warehouse in which inventory is supplied for the operation? Explanation. 
 

If so, correct the discrepancy (e.g., by warehouse transfer, by fixing the inventory/costing control setting).
