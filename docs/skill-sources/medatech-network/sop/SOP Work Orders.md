# SOP Work Orders

- **Source:** `SOP Work Orders.pdf`

Cat.No.A8000090 1 Ver.1 – Dec.8,’08 
 
SOP: Work Orders* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To open work orders manually, and release them for production.  
Work orders serve to document and track the production of a given quantity of a 
manufactured part. Each work order contains data regarding the quantity of parts 
produced, the child parts used in the work order's production routing and a progress 
report. 
Setups 
 Production modeling, by which all aspects of production are defined: the factory, 
work cells, operations, routings and parts. 
 Linking each part to a work order template. 
Procedure 
Stage I: Opening a Work Order Manually 
1. Enter the Work Orders form. 
2. Record the Part Number and Work Order Qty (in factory units). A new work order is 
opened, numbered automatically according to the part's work order template. 
Note: Work orders are also opened automatically by the MRP program. In such work 
orders, the Opened Auto column is flagged in the Details column. 
Stage II: Releasing a Work Order 
In order to begin production, you need to release the work order. An unreleased work 
order is not active within the system. When the work order is released, it is assigned a 
bill of materials (BOM) and production routing as defined for the part during production 
modeling. In addition, the work order's status is changed automatically to "Released". 
1. In the Work Orders form, click the Prod. Data tab and record the Begin Production 
date. 
2. Click the Details tab and flag the Release column. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No.A8000090 2 Ver.1 – Dec.8,’08 
3. You can make certain revisions to the work order even after it is released, such as 
increasing (but not decreasing) the work order quantity. 
4. You can see all of the required child parts in the Kit List sub-level form. You can 
change the part quantities in the kit list in the Qty (Factory Units) column. 
Stage III: How Production Reports Affect the Work Order 
Production reports document the work order's progress, by recording the performance of 
operations in the production routing. See the operating procedures for production 
reports. 
 When the first production report is recorded, the Status of the work order is changed 
automatically to "First Report". 
 When production is reported for the full quantity of parts in the last operation in the 
work order routing, the Status of the work order is changed automatically to "Last 
Report". 
 You can track the progress of the work order in the  Progress Report sub-level form. 
Result 
 
When the work order is fully reported, all of the child parts used during production of 
the work order part are reduced from inventory, and the finished quantity of the work 
order part is added to the existing inventory.
