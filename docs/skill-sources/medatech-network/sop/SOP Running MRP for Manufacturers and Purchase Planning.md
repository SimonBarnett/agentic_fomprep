# SOP Running MRP for Manufacturers and Purchase Planning

- **Source:** `SOP Running MRP for Manufacturers and Purchase Planning.pdf`

Cat.No. LB130379 1 Ver.1 – Aug 15,’13 
 
SOP: Running MRP for Manufacturers and Purchase 
Planning* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up and run the Material Requirements Planning  and Purchase Planning 
programs.  
Working Assumptions 
 Inventory is properly defined and maintained. 
 Issue types are properly defined and assigned to the appropriate parts. 
 Sales and forecast orders have been defined for participation in MRP, where 
appropriate.  
Procedure 
Stage I: Setups 
1. Make sure that the system manager has defined MRP for Manufacturers as the 
system's default planning method (i.e., the value of the ProdPlan constant in the 
Planning Constants form should be 0). 
2. Make sure that any warehouses whose inventory should not be taken into account 
during MRP calculations (e.g., Rejects Warehouse) are assigned a W in the Type 
column of the Warehouses form. 
3. Make sure that any inventory statuses signifying inventory that should be taken into 
account by MRP are flagged in the Available Inventory column in the Inventory 
Statuses form. 
4. Make sure that all parts relevant to MRP planning are flagged in the Inv. Control 
column of the Part Catalogue form.  
5. Make sure each manufactured part is assigned a routing defined with factory 
production operations (in the Routing column of the Parts form), and not a routing 
such as "Assemb" or "Issue". For TOP parts, leave the default "Assembly" routing. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

6. Enter the  Assign WO/Lot Templates to Parts form. 
7. If you want MRP to automatically open work orders for a given part, flag the Open 
Automatically column. 
8. In the Wk/Ord Lot Template column, link a work order template to the part so that 
work orders will be automatically opened with the proper number. 
9. Enter the Purchase/MRP Parameters for Parts form to define part parameters. 
a. In the General tab, assign a Replenishment Type to each part (both buy parts 
and make parts): 
 R: Parts whose required quantities are planned according to open sales 
orders and work orders 
 B: Parts whose required quantities are constant at defined intervals (for such 
parts, also define Production Quantity and Production Days; see below). 
b. In the  Preferred Vendor column, specify the vendor from which the part is 
usually purchased. 
c. Fill in the following parameters: 
 Safety Stock (Planning Quantities tab) - The minimum quantity of the part 
that must be available in inventory at any given time. The system takes this 
value into account when opening work orders/purchase orders for the part. 
 Min for Order/W.Ord (Planning Quantities tab) - The minimum quantity that 
must be included in every work order or purchase order opened for the part. If 
this quantity exceeds demand for the part, an order will be opened for the 
minimum quantity. 
 Increment for Ord/WO (Planning Quantities tab) - The increment (beyond 
the minimum quantity) by which work orders/purchase orders can be opened 
for the part. If the required quantity of parts is not a multiple of the increment 
value, it will be "rounded" up to the nearest increment. For example, if the 
increment is 100 units and the demand is for 105 units, an order will be 
opened for 200 units. 
 Max for Work Order (Planning Quantities tab) - The maximum quantity that 
can be included in a single work order for the part. If demand exceeds this 
quantity, additional work orders will be opened until the demand is met. For 
example, if the maximum is 100 units and the demand is for 105 units, two 
work orders will be opened: one for 100 units and another for 5 units. 
 Qty to NotOpen WkOrd (MRP Definitions tab) - The minimum quantity for 
which a work order will be opened. If the demand for processed parts is less 
than this quantity, the demand will be ignored, and no work order will be 
opened. 
 Purchase Lead Time (Planning Time tab) - The average number of days 
that pass before purchased parts are shipped. You can also define the 
average number of Shipping Days and Testing Days. 
 Demand Range (Planning Quantities tab) - The number of days for which 
part demand is unified into one work order/purchase requisition. For example, 
if the demand range is 30 days, and a lack is anticipated on day X and again 
15 days later, a single purchase requisition is opened for the earlier of the two 
dates for the combined quantity of parts. 
Cat.No. LB130379 2 Ver.1 – Aug 15,’13

10. Define production timing parameters. Such parameters can be defined at three 
different levels: 
a. Per part: In the Purchase/MRP Parameters for Parts form, click the MRP 
Definitions tab and define the following values: 
 Production Quantity and Production Days for each processed part - If the 
part's production rate is defined for the entire production process, 
independently of the individual operations in the part's routing, record the 
number of production days and the quantity produced during that period. 
Note: If you define the production rate manually in these columns, you 
cannot run MRP to open work orders according to an optimized work plan or 
calculate projected workloads. By default, the production time defined for a 
part is continuously updated by operation timing parameters (after the 
operation data has been recorded in a part routing). 
 If production is managed in batches, flag the Time per Batch column. This 
indicates that the production rate recorded in the Production Quantity and 
Production Days columns refers to an entire batch; that is, the amount of 
time required to produce an entire batch of parts is equal to the amount of 
time required to produce a lesser quantity. For example, if it takes 10 days to 
produce 10 parts and a work order is opened for 2 parts, the required 
production time is 10 days and not 2 days. 
b. Per operation: When you define production timing parameters at this level, any 
new part routing that includes the operation in question automatically inherits the 
defined values, regardless of the part being produced. Then, if necessary, you 
can revise the operation parameters for that specific routing. To define 
production timing parameters for the operation itself, enter the Operations form 
and define the following values: 
 MRP-Production Qty and MRP-Production Time - The operation's duration 
(in minutes) and the quantity of parts on which the operation is performed 
during that period. For example, if you record a production quantity of 100 
units and production time of 100 minutes, the production time required to 
perform this operation on 120 units is 120 minutes. 
 MRP %Overlap w/Child - The percentage of the operation's production time 
during which the current operation may be performed in parallel with the 
preceding one. The working assumption is that most operations are 
performed serially (you cannot begin any operation until the previous one in 
the routing is completed). If it is possible to begin an operation when the 
previous one is still only partially completed, this value represents the time 
remaining to complete the previous operation at which point the current 
operation may begin.  
c. Per part routing: To define production timing parameters for the operation in a 
specific part routing, enter the Routings form, retrieve the desired routing and 
enter the Operations in Routing sub-level form. Define the same values listed in 
step  10 b above. 
Result 
 
The data infrastructure required to run the Material Requirements Planning and 
Purchase Planning programs is in place. 
Cat.No. LB130379 3 Ver.1 – Aug 15,’13

Stage II: Flagging Order Items for MRP 
MRP takes into account parts with a defined safety stock, as well as designated sales 
and forecast orders. To prepare orders for consideration by MRP: 
1. To automatically flag order items for participation in MRP, run the Retrieve Sales 
Orders - MRP program. In the program's input, you can choose to automatically flag 
all relevant order items by due date or choose the Selected Orders option to 
manually select the items to be flagged. In the latter case, a form will open in which 
to retrieve orders for inclusion in MRP. You can retrieve orders by a variety of 
different parameters (e.g., status, customer, date).  
2. When the program is completed, enter the Release Orders for Planning form and 
make sure that the lines defined for participation in MRP meet your needs. You can 
remove the "Y" from any lines (in the MRP column) and add a "Y" to lines that are 
not so defined. 
Stage III: Running MRP for Manufacturers 
 Run the Material Requirements Planning program. This program receives a number 
of parameters as input, such as: 
 Type of Planning - Choose whether to run a Simulation or run the program 
in Real mode. In Real mode, the program opens actual work orders with the 
initial status (e.g., Draft). 
 Combine Into Wk Ords - Choose whether to aggregate required quantities 
into work orders By Demand Range (i.e., within the period defined for the 
part in the Purchase/MRP Parameters for Parts form) or On Monthly Basis 
(i.e., the program will create one work order per month). 
 Create Issues - Choose the strategy used to create the issues plan: Each 
WO Separately; By Month per Parent; or Monthly. 
 Run for - Choose whether to run MRP for all (flagged) sales order items (All 
Orders) or New Orders Only. 
 Consider Work Ords - Choose whether MRP takes released open work 
orders into account when calculating part demand. 
 Revise Forecst Ords - Choose whether MRP will reduce demand resulting 
from forecast orders in keeping with existing inventory. 
 Consider Packed Inv - Choose whether MRP will take into account inventory 
that has already been packaged for a specific customer when calculating part 
demand.  
 Work Plan - Choose whether MRP will create a detailed work plan for the 
opened work orders. 
 Consider Flr Stock - Choose whether MRP takes existing floor inventory into 
account when calculating part demand. 
 To Date - Specify the end date of the planning period. This cannot be any 
earlier than the date of the last flagged order.  
Results 
 Work orders have been opened for processed parts. 
 The Analysis of MRP Results (ATP) report is available.  
 An issues plan has been created for raw material demands. 
Cat.No. LB130379 4 Ver.1 – Aug 15,’13

Stage IV: Analyzing MRP Results 
 Run the Analysis of MRP Results (ATP) report to view the work orders opened by 
MRP. 
 Enter the MRP Analysis - Processed Parts form (sub-level of the Purchase/MRP 
Parameters for Part form) to view MRP results for processed parts. 
 Enter the MRP Analysis - Raw Materials form (sub-level of the Purchase/MRP 
Parameters for Part form) to view MRP results for raw materials   
Note: You can also enter the Use of Open Work Orders-Details sub-level of that 
form to view open work orders for turnkey parts, as well as the parallel Use of 
Alternate Stock-Details sub-level form, to view inventory of alternate parts that was 
taken into account. 
 If you chose to create a Work Plan when running MRP, you can: 
 view this work plan by running the Work Plan report or the MRP Gantt Chart; 
 run period load reports. 
Stage V: Releasing Work Orders 
1. Enter the Work Orders form and retrieve the work orders opened by MRP. 
Tip: Retrieve those with a check mark in the Opened Auto column and the MRP run 
date in the Date Opened column. 
2. Flag the Release column in each work order. 
Result 
 The work orders generated by MRP are now released for production. 
Stage VI: Running Purchase Planning 
The Purchase Planning program uses the issues plan prepared by MRP, as well as 
additional data defined in the Purchase/MRP Parameters for Part form (see Stage I 
above). 
1. Run 
the Purchase Planning program. 
2. The date of the last run of  MRP is displayed. To guarantee the most up-to-date 
results, this should be today's date. Click OK to proceed.  
3. In the input screen that opens, choose the Create Purch. Demand option. In the To 
Date column, specify the end date of the planning period. 
Results 
 Purchase requisitions have been opened for type R parts. Continue to the next stage 
to view and handle these purchase requisitions. 
 For type P parts whose production routing includes operations performed by a 
subcontractor, purchase requisitions have been opened and linked to a work order. 
Stage VII: Analyzing Purchase Planning Results 
 To view the purchase requisitions opened by the Purchase Planning program: 
Cat.No. LB130379 5 Ver.1 – Aug 15,’13

Cat.No. LB130379 6 Ver.1 – Aug 15,’13 
 Enter the Purchase Demands form and retrieve the new purchase demand 
document that was opened. 
Tip: Retrieve by today's Date. 
 Enter the Itemized Purchase Requisitions sub-level form to view 
recommended items, quantities and demand dates. 
Tip: To open purchase orders from these purchase requisitions, see the 
relevant SOP. 
 To view the system's recommendations for handling existing purchase orders, run 
the Purchase Recommendations report. 
 To view projected balances of purchased parts: 
 Enter the relevant projected balances form (sub-level of the Part Catalogue, 
Purchase Demands and Purchase/MRP Parameters for Part forms). 
 Run projected balances reports.
