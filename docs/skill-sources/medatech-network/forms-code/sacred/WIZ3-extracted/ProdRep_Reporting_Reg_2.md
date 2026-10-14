# ProdRep_Reporting_Reg_2

- **Source:** `ProdRep_Reporting_Reg_2.htm`

Production Report - Reporting a Regular Operation .2 
 
 
- 
 
 
 
# Additional Details 

 

 1 .  If your factory works in shifts, click the Details tab and specify the Shift during which the operation was performed. If certain operations were performed in a different shift, you can change the shift code in the Reporting Workers sub-level form.
 Note: Click to view and/or revise shift details. 
 

 2 .  If this operation involves rework, specify R in the Rework column.
 Notes: 
 

 ·              If you are reporting production of a work order flagged as rework, each operation in the work order routing is automatically flagged as rework. 
 

 ·              If you do not flag the operation as rework, the Backflush program will perform a second reduction of child parts, which will result in missing issues of those parts. 
 

 3 .  If this is the last reported operation in the routing, make sure the warehouse to which the finished parts will be transferred appears in the To Warehouse column.
 Notes: 
 

 ·              If you want to remove the work order number from the finished inventory, make sure a check mark appears in the Remove Wk Order No. column. You can only remove the work order number if you have also removed the operation number and defined a warehouse to which to transfer the manufactured inventory. 
 

 ·              Removing the number of an operation in the middle of the production routing is likely to result in negative inventory when the following operation is reported. 
 

 ·              If you want to remove the operation number from the finished inventory, make sure that a check mark appears in the Remove Oper. Number column. Otherwise, the operation number will appear for the finished parts in the warehouse inventory. 
 

 ·              Whatever was defined for these three parameters in the work order routing appears here automatically, but may be revised. 
 

 4 .  If serial numbers are assigned to this part, use the Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form to record the serial numbers of the parts undergoing this operation.
 Tip: For more information on working with serialized parts, run the Serial Numbers Wizard . 
 

 5 .  If the part has an expiration date that you want to extend, enter the Expiration Date Extensions form. 
 

 6 .  Click to document manual issues that were made for the current reported operation. 
 

 7 .  When you are finished, click the Form tab and flag the Final column.
 Notes: 
 

 ·              You can only flag this column for reports that were recorded in this form. 
 

 ·              You can reopen the report for revision by removing the check mark from this column. 
 
## Notes:

 

 ·        If you are reporting the first or last operation in a work order routing, the work order status changes accordingly. For more information about work order statuses, run the Work Orders Wizard . 
 

 ·        Click to return to the main screen.
