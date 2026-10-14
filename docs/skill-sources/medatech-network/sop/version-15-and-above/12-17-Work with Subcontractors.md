# 12-17-Work with Subcontractors

- **Source:** `12-17-Work with Subcontractors.pdf`

www.priority -software.com   
1/5 ‏Feb. 05, '15 Ver.03 Cat.No. A8000103 
 
 SOP: Working With Subcontractors 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Setups 
1. Define a Type F subcontractor warehouse in the Warehouses form. 
 Assign this warehouse a default Kit Warehouse. 
2. Link the warehouse to a vendor in the Subcontractor Warehouse column of the Vendors form. 
3. Define a subcontractor work cell in the Work Cells form: 
 Record a code and description in the Work Cell and WorkC Description columns. 
 Select “T” in the Inv./Costing Control column. 
 Select the defined subcontractor warehouse in the Warehouse column. 
4. In the Operations and Routings forms, define the production routing for the part in question, and 
its component operations. 
Note: In the last operation in the routing, flag the Remove Oper. Number and Remove Wk 
Order No. columns. 
5. Define the raw materials to be issued in bulk to the subcontractor. That is, make sure that the 
Kit Component column in the Parts form is not flagged. 
6. Define the raw materials to be issued to a kit. That is, make sure that the Kit Component 
column in the Parts form is flagged. 
Procedure Summary 
1. Open a work order (manually or automatically via the MRP program). 
2. Open a purchase order (manually or on the basis of a purchase requisition). In the itemization 
sub-level, make sure to:  
 link the work order to the manufactured part (the work order must already be released)  
 specify the operation to be performed by the subcontractor. 
3. Send the required materials to the subcontractor’s warehouse via a shipment to subcontractor 
document. 
4. Receive the finished goods from the subcontractor in a GRV based on the purchase order. 
Notes: 
 The system automatically fills in the From Warehouse column in the upper-level form with the 
subcontractor’s warehouse. 
 The inventory balance of raw materials in the subcontractor’s warehouse is reduced according 
to the work order BOM and the quantity received. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 ‏Feb. 05, '15 Ver.03 Cat.No. A8000103 
 
 The order balance in the purchase order is updated automatically, as well as the work order’s 
progress report. 
5. Run the Backflush program in order to receive warnings from the system regarding reductions 
of raw material inventory that did not actually occur, for example, due to lack of the required 
quantities. 
Procedure 
Stage I: Opening a Work Order Manually 
1. Enter the Work Orders form and open a new work order, filling in the following columns: 
 Part Number of the parent part 
 Work Order Qty 
 Begin Production (in the Prod. Data tab) 
 Flag the Release column (in the Details tab). 
2. Enter the Kit List sub-level form. This form displays the required child parts in the BOM 
according to the work order quantity recorded in the upper-level form. It only displays those parts 
required by the subcontractor, and does not display child parts flagged as Info Only. Make sure 
the Issued to Kit column is not flagged. 
3. To issue kit components, enter the Issues to Kits sub-level form and designate the quantity of 
each part to issue to the subcontractor's kit warehouse. 
4. Enter the parallel Routing for the Work Order sub-level form, and check the following details: 
 Make sure the routing is correct and includes the operation to be performed by the 
subcontractor. 
 Make sure that the work cell linked to the operation is the work cell linked to the subcontractor 
warehouse. 
 Make sure the subcontractor operation is marked with a “T” in the Inv./Costing Control 
column. 
 For the last operation in the routing, make sure the warehouse to which the finished goods will 
be transferred is recorded, and the Remove Oper. Number and Remove Wk Order No. 
columns are flagged. 
Stage II: Handling a Work Order Opened by MRP 
1. Enter the Purchase Requisitions form and retrieve the PRs opened automatically by MRP. 
2. Press F6 from the To Work Order column to enter the Work Orders form. 
3. Release the work order by flagging the Release column. 
4. To issue kit components, use the Issues to Kits sub-level form. 
Stage III: Opening a Purchase Order from a Subcontractor 
1. Enter the Purchase Orders form. 
2. Specify the subcontractor in the Vendor No. column. 
3. Enter the Order Items sub-level form. 
4. For each manufactured part, fill in the following columns:

www.priority -software.com   
3/5 ‏Feb. 05, '15 Ver.03 Cat.No. A8000103 
 
 Part Number (of the parent part) 
 Operation (the operation to be performed by the subcontractor) 
 To Work Order (make sure the work order has been released) 
 Quantity. 
Note: To open a purchase order on the basis of purchase requisitions opened automatically by 
MRP, see the relevant Standard Operating Procedure. 
Stage IV: Shipping Parts to the Subcontractor 
1. Make sure the IFloorInv constant (in the Logistical Constants form) is set to 2 (so that issues 
are prepared on the basis of open work orders on the plant floor). 
2. Enter the Shipmt to Subcontr/Issue of Kit form. 
3. Specify the Subcontractor Number. 
4. In the From Warehouse column, specify the warehouse from which the parts are to be sent (if 
they are to be sent from a number of warehouses, specify them per part in the Shipped Items 
sub-level form). The To Warehouse column is filled in automatically with the subcontractor’s 
warehouse. 
5. To itemize the shipping document with parts issued in bulk, select Prepare Bulk Shipments 
from the list of Direct Activations. This program itemizes the Shipped Items sub-level form with 
the bulk issue parts required in the subcontractor’s warehouse. 
6. To itemize the shipping document with parts issued to kits, enter the parallel Kits to Ship sub-
level form and specify the relevant work orders. 
7. Move to the Shipmt to Subcontr/Issue of Kit form, a parallel sub-level. Issues to kits for the 
specified work orders are listed automatically. 
8. Specify the actual quantity to be shipped in the Qty (Factory Units) column. 
Results 
 The inventory balances of raw materials in the subcontractor’s warehouse are automatically 
increased according to the shipped quantity of each part and its work order BOM. 
 Accordingly, the inventory balances of parts in the kit/main warehouse are automatically 
reduced. 
Stage V: Receiving Goods from the Subcontractor 
1. Enter the Goods Receiving Voucher form. 
2. Open a new GRV from the subcontractor, specifying the following: 
 In the References tab, specify the original purchase order in the Order No. column. The 
From Warehouse appears automatically and the order items are listed automatically in the 
sub-level form. 
 In the Received Items sub-level form, specify the received Quantity of each item. 
 In the upper-level form, change the Status to a status defined as final. 
Results 
 The system automatically increases the inventory balance of each part in the receiving 
warehouse according to the received quantity (rather than the ordered quantity).

www.priority -software.com   
4/5 ‏Feb. 05, '15 Ver.03 Cat.No. A8000103 
 
 The inventory balances of raw materials in the subcontractor’s warehouse are automatically 
reduced according to the received quantity of each part and its work order BOM. 
 The order balance of each part in the original purchase order is updated automatically, as well 
as the progress report of the work order in question. 
Stage VI: Running the Backflush Program 
This program displays warning messages regarding inventory reductions of raw materials that did 
not actually occur, for example, due to lack of required quantities at the subcontractor's warehouse. 
1. Make sure the OnlineBF constant (in the Production Constants form) is set to 1. 
2. Run the Backflush program, choosing the From Last Past Bal. option. 
Results 
 Order balances are calculated in the purchase order. 
 In the Progress Report sub-level of the Work Orders form, the second line displays the 
“GRV” operation and the received quantity. 
 The Inventory Balance for Part sub-level of the Parts form displays the received inventory 
as a regular incoming inventory transaction. 
 The inventory balances of raw materials in the subcontractor’s warehouse are reduced 
according to the received quantity of each part and its work order BOM. 
3. Enter the Missing Issues form and perform a query for the current date (the date Backflush was 
run). This form displays all missing issues and raw materials that could not be reduced, due to 
lack of required quantities in the subcontractor’s warehouse. The following are possible causes 
of such lacks, and ways to handle them: 
 Problem: Insufficient raw materials were sent to the subcontractor. 
 Solution: Open a new shipment to subcontractor document for the missing inventory. 
Balances will be updated the next time Backflush is run. 
 Problem: Parts were not flagged as Info Only. 
 Solution: Flag the parts in question and remove the checkmark from the Issued to Kit 
column in the work order kit list. 
Important: Run the Backlfush program automatically (via the Tabula Task Scheduler) on a 
daily basis, and manually once a week. 
Stage VII: Performing an Inventory Count in the Subcontractor Warehouse 
Reduction of child parts from the subcontractor’s warehouse is performed according to the BOM 
and does not always reflect the actual quantities. 
An inventory account should be performed periodically in the subcontractor’s warehouse, in order to 
update the actual balances. 
Note: The inventory count will only include parts in the subcontractor’s warehouse that were issued 
in bulk. 
To perform the inventory count: 
1. Run the Prepare for Inventory Count program. Specify the date for the inventory count form and 
select the subcontractor’s warehouse. The form will display all parts for which there is inventory 
in the designated warehouse.

www.priority -software.com   
5/5 ‏Feb. 05, '15 Ver.03 Cat.No. A8000103 
 
2. Enter the Itemized Inventory Count sub-level of the Inventory Count form. For each bulk part, 
record the actual quantity in the Counted Qty (Fact.) column.  
3. After checking the recorded quantities, flag each line in the Approve Counted Qty column. 
Inventory balances in the subcontractor’s warehouse are adjusted automatically. 
4. Return to the upper level form and change the Status to “Final”. 
Results 
 Inventory balances in the subcontractor’s warehouse are updated by the quantities recorded in 
the Inventory Count form. 
 For each counted part, an “inventory count” transaction is recorded in the subcontractor’s 
warehouse for the difference between the calculated quantity and the actual quantity recorded in 
the Inventory Count form.
