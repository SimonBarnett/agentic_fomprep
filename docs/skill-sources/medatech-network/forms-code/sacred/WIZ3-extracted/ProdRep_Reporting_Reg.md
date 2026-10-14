# ProdRep_Reporting_Reg

- **Source:** `ProdRep_Reporting_Reg.htm`

Production Report - Reporting a Regular Operation.1 
 
 
- 
 
 
 
# To r eport a r egular o peration : 

 

 1 .  When you specify the work order number, the Operation following the last reported operation in the work order's routing appears automatically, along with the Work Cell in which it is performed. Change the operation if necessary. 
 Notes: 
 

 ·              The system automatically displays only those operations with the inventory/costing control settings R or C . To report T or L operations, you need to select them from the Choose list. 
 

 ·              The operation must be in the work order's routing, or in the part routing if you are reporting production without a work order, with the exception of rework operations. 
 

 2 .  Click the Quantities tab and record the Employee ID of the employee that performed the current operation.
 Note: If more than one employee performed the operation, use the Reporting Workers sub-level form to list them all. 
 

 3 .  Specify the quantity of parts upon which the operation was completed successfully in the Qty Completed column, the quantity of parts rejected in the Qty Rejected column, and the quantity of parts requiring inspection by a review board in the MRB column. These quantities will be added to inventory with the statuses Goods , Reject and MRB respectively.
 Note: If the parts in question are serialized, use the Serial Numbers in Transaction sub-level form to assign the appropriate status to each serial number. The Qty Completed and Qty Rejected columns in the upper-level form are then updated automatically. 
 

 4 .  If some of the goods were rejected, do one of the following: 
 

 ·              If all of the rejected goods were rejected for the same reason, specify the appropriate Defect Code . 
 

 ·              If the parts were rejected for different reasons, use the Report Defective Parts sub-level form to record the reasons for rejection in their appropriate quantities. 
 

 5 .  Click the Times tab and fill in the relevant data: 
 

 ·              Record the machine time spent performing the operation, using either the Start Time and End Time columns, or the Span column. 
 

 ·              Record each employee's start and end times on the reported operation in the Start Labor and End Labor columns, or record the employee's total work time in the Labor Span column. 
 

 Note s : 
 

 ·              If more than one employee performed the operation, use the Reporting Workers sub-level form. 
 

 ·              Costing takes into account labor costs , machine costs and indirect costs.
