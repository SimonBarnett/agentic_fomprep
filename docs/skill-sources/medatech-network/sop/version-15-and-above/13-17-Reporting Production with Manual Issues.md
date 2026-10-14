# 13-17-Reporting Production with Manual Issues

- **Source:** `13-17-Reporting Production with Manual Issues.pdf`

www.priority -software.com   
1/2 ‏Feb. 04, '15 Ver.02 Cat.No. A8000075 
 
 SOP: Production Reporting and Manual Issues 
Customer:   Company Inc. 
Assigned to:  Dept./Position 
 
Aim 
 To report production and record manual issues of raw materials needed for production. 
Manual issue is usually intended for raw materials whose usage needs to be carefully tracked. 
Setups 
 Define defect codes in the Defect Codes form. 
 Define the issue method as manual by flagging the Manual Issue column for raw materials in 
the Parts form. 
Note: Raw materials defined for manual issue are not backflushed from the plant floor, and do not 
appear in the Backflush Transactions form. 
Procedure 
Stage I: Reporting Production 
1. Enter the Reporting Production Details form. 
2. Specify today's Date. The Form Number is filled in automatically. 
3. Select the Work Order number for which to report production. The Operation following the last 
reported operation in the work order's routing appears automatically, along with the Work Cell in 
which it is performed. Change the operation if necessary. 
4. Select the Employee ID of the employee that performed the reported operation. If more than 
one employee performed the operation, enter the Reporting Workers sub-level form and 
specify their ID numbers and work time. 
5. In the Qty Completed column, specify the quantity of parts that were successfully completed in 
the report operation. 
6. If the quantity of rejected parts is already known: 
 Specify the quantity in the Qty Rejected column. Once you have finished reporting, these 
quantities will be added to inventory with the Reject status and the current operation. 
 In the Defect Code column, select the reason for which the parts were rejected. If there is 
more than one reason for rejection, enter the Report Defective Parts sub-level form and list 
the various defect codes. 
7. In the Qty for MRB column, specify the quantity of parts which have undergone the reported 
operation and were submitted for inspection by a review board. Once you have finished 
reporting, these quantities will be added to inventory with the MRB status and the current 
operation.

www.priority -software.com   
2/2 ‏Feb. 04, '15 Ver.02 Cat.No. A8000075 
 
8. Indicate the Start Time and End Time for the machinery used in the reported operation. The 
Span column will display the total machine time according to the specified values. 
9. In the Start Labor and End Labor columns, record the start and end times for the employees 
who performed the reported operation. The Labor Span column will display the total labor time 
according to the specified values. 
10. Specify the Shift during which the operation was performed. 
11. When reporting production of serialized parts, enter the Serial Numbers in Transaction sub-
level form and specify a Serial Number and To Status (i.e., the status of the item following 
production) for each unit of the part. 
Stage II: Issuing Raw Materials Manually 
1. To report manual issues for the current operation, enter the Manual Issues to Work Order sub-
level form. 
2. For each Part Number issued to production, specify the Quantity of the part issued for the 
current operation, and the Warehouse and Bin from which it was issued. If you work with lots, 
specify the lot from which the part was issued in the Work Order/Lot column. Raw materials 
that are issued in this manner are reduced from the inventory in the issuing warehouse. 
Stage III: Finalizing the Production Report 
 When you are finished reporting production, return to the upper-level form and flag the Final 
column. Reports that are flagged as Final cannot be revised. 
Results 
 The reported quantities will be added to inventory in the floor warehouse, or any other 
warehouse defined in the part's routing, with the status Goods, Reject or MRB and the current 
operation. 
 Raw materials that were reported as manual issues are reduced from the inventory in the 
issuing warehouse and issued to the work order – that is, they do not appear in inventory.
