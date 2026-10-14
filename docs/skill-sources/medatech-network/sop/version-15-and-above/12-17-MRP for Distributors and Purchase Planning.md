# 12-17-MRP for Distributors and Purchase Planning

- **Source:** `12-17-MRP for Distributors and Purchase Planning.pdf`

www.priority -software.com   
1/4 ‏Feb. 01, '15 Ver.04 Cat.No. A7000240 
 
 SOP: MRP for Distributors and Purchase Planning1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of running the MRP for Distributors and Purchase Planning 
programs in order to generate purchase demands and run purchase recommendation reports. The 
MRP program checks the existing inventory balances of each part and the quantities recorded in 
open purchase orders against the quantities required to supply open sales orders and maintain the 
defined minimum inventory balances (and comply with other parameters described later). The 
resulting variances between these quantities are then recorded as purchase recommendations. 
Working Assumptions 
 MRP for Distributors is defined as the system's planning method (via the ProdPlan constant, 
setting 2, in the Planning Constants form). 
 Warehouses that should not be taken into account by MRP are assigned a W in the Type column 
(in the Warehouses form). 
 Inventory statuses signifying inventory that should be taken into account by MRP are flagged in 
the Basis for Planning column (in the Inventory Statuses form).  
 All relevant parts are assigned replenishment type R in the Purchase/MRP Parameters for Part 
form (R is the default value; it does not need to be assigned manually). 
 All relevant parts are flagged in the Inv. Control column in the Part Catalogue form.  
Required Setups 
 Fill in purchase planning parameters in the Purchase/MRP Parameters for Part form, in the 
Planning Quantities and Planning Time tabs: safety stock, minimum for orders, increment for 
order, purchase lead time, shipping days, testing days. 
Procedure 
Stage I: Flagging Order Items for MRP 
In this stage we flag the line items in sales orders that we want to participate in MRP planning. Items 
that are not flagged are not taken into account by MRP. Items can be flagged automatically or 
manually. 
Flagging Items Automatically 
1. In order for a line item to be flagged, it must meet the following conditions:  
 The line is open. 
                                                 
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Feb. 01, '15 Ver.04 Cat.No. A7000240 
 
 The item has a positive supply balance. 
 The item's due date falls before the input date specified when you run the flagging program. 
 The value N does not appear in the MRP column. 
 The part is flagged for inventory control. 
 The part is assigned replenishment type R. 
2. If there are certain sales orders that you do not want taken into account by MRP, select N in the 
MRP column of each line in the order, either in the Release Orders for Planning form or in the 
Order Items sub-level of the Sales Orders form. These items will not be flagged automatically in 
the following process. 
3. Run the Retrieve Sales Orders - MRP program. 
4. In the input screen, specify the due date to be used in MRP calculations: all order items with a 
positive supply balance whose due dates fall before the specified date will be flagged for 
participation in MRP. 
5. In the following input screen, do one of the following: 
 Choose the All Open Orders option to automatically flag all of the order items that fulfill the 
above conditions. 
 Choose the Selected Orders option to manually select the items to be flagged. 
6. When the program is completed, it will display a message notifying you of the number of order 
items that were successfully flagged. Click OK. 
7. To view the flagged items, enter the Release Orders for Planning form and retrieve all lines in 
which Y appears in the MRP column. 
Flagging Lines Manually 
1. Enter the Release Orders for Planning form and retrieve all lines in which Y does not appear in 
the MRP column. The form will display all open order items with a positive supply balance that 
have not been flagged for participation in MRP. 
2. Select Y in the MRP column of any order item that you want to include in MRP. 
Flagging Lines While Recording a Sales Order 
 You can select Y in the MRP column of an order item as you are recording it. 
Result 
 The items that have been flagged will be included in MRP calculations, and their quantities will be 
considered part of the demand for that part (together with the part's required safety stock).

www.priority -software.com   
3/4 ‏Feb. 01, '15 Ver.04 Cat.No. A7000240 
 
Stage II: Running MRP for Distributors 
1. Run the MRP for Distributors program. 
2. Choose the Sales Orders Only option in the input screen. 
3. When the program is completed, it will display a message to notify you that the run was 
successful and new issues have been opened. Click OK. 
Results 
 As a result of running MRP, an Issues Plan has been created, in which you can view the required 
quantities of each part within the designated period. 
 You can now run the Purchase Planning program to open purchase requisitions on the basis of 
the Issues Plan. 
Stage III: Checking the Issues Plan 
 Run the Issues Plan report. 
Result 
 The report displays the required quantities of each part during the designated period. It only 
displays the required quantities, not the recommended purchase quantities or the quantities 
existing in inventory. 
Stage IV: Running Purchase Planning 
The Purchase Planning program runs on the basis of the Issues Plan generated by the last run of 
MRP, as well as the parameters defined in the Working Assumptions and Required Setups 
sections of this document. 
1. Run the Purchase Planning program. A message will appear displaying the date of the last MRP 
run. Make sure it displays today's date, so that the data used will be up-to-date, then click OK. 
2. Choose the Create Purch. Demand option in the relevant input screen. 
Result 
 A single purchase demand document is opened dated today, with an A appearing in the 
Automatic column. 
Stage V: Checking Purchase Planning Results 
1. Run the Purchase Recommendations report. This report displays the number of the purchase 
requisition opened for each part, the recommended purchase quantity, and the recommended 
purchase date. If an open purchase order is already open for a given part, the report displays the 
number of the order and of the relevant order line, and the part's due date appears alongside the 
recommended purchase date. 
2. Run the PO Recommendations (Materials) report to check the system's recommendations for 
handling existing purchase orders – whether to cancel them or move the due date forward or 
back, according to the current Issues Plan generated by MRP. 
Procedure Summary 
 The MRP for Distributors program generates an updated Issues Plan.

www.priority -software.com   
4/4 ‏Feb. 01, '15 Ver.04 Cat.No. A7000240 
 
 The Purchase Planning program opens a purchase demand document based on the updated 
Issues Plan and generates recommendations for handling existing purchase orders. 
Follow-up 
 Continue the process by opening purchase orders on the basis of the demand document and 
revising open purchase orders according to the system's recommendations. To do so, see the 
relevant SOP documents.
