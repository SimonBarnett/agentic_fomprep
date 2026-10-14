# 12-17-Shipment to Subcontractors of WIP Parts

- **Source:** `12-17-Shipment to Subcontractors of WIP Parts.pdf`

www.priority -software.com   
1/4 ‏Feb. 05, '15 Ver.03 Cat.No. A8000104 
 
 SOP: Defining a Routing  
Manufactured Partially by a Subcontractor 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To define and manage a subcontractor routing, where the subcontractor performs one (or some) 
of the operations in the routing, and work in progress is sent to the subcontractor.  
Setups 
1. Define a Type F subcontractor warehouse in the Warehouses form. 
2. Link that warehouse to a vendor in the Subcontractor Warehouse column of the Vendors form. 
3. Define a subcontractor work cell in the Work Cells form: 
 Record a code and description in the Work Cell and WorkC Description columns. 
 Select “T” in the Inv./Costing Control column. 
 Select the defined subcontractor warehouse in the Warehouse column. 
4. Define a subcontractor operation in the Operations form. 
5. Specify the subcontractor operation in the part’s production routing in the Routings form. 
6. Make sure the OnlineBF constant (in the Production Constants form) is set to 1. 
Procedure 
Stage I: Opening a Work Order 
Work orders can be opened manually, or automatically by the MRP program. 
Option A: Opening a work order manually 
1. Enter the Work Orders form. 
2. Record the Part Number of the manufactured part. 
3. In the Work Order Qty column, indicate the quantity of the part to be produced. 
4. In the Begin Production column (in the Prod. Data tab), specify the date that production is 
expected to start. 
5. Release the work order by flagging the Release column (in the Details tab). 
Option B: Releasing a work order opened by MRP 
1. Enter the Work Orders form.  
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Feb. 05, '15 Ver.03 Cat.No. A8000104 
 
2. Retrieve the work order (F11) that was opened automatically.  
Tip: Retrieve the work order by part number, Release column (unflagged), and/or Opened Auto 
flag (flagged). 
3. Release the work order by flagging the Release column. 
Note: The work orders opened by MRP are for the production of the entire parent part, and one or 
more operations in the work order routing are defined for manufacture by the subcontractor. 
Result 
 A work order that is partially manufactured by a subcontractor is released. 
Stage II: Reporting Production 
See the SOP for this process. 
Stage III: Opening a Purchase Order for a Subcontractor 
1. Enter the Purchase Orders form. 
2. Specify the subcontractor in the Vendor No. column. 
3. Enter the Order Items sub-level form. 
4. For each part that is sent to the subcontractor, fill in the following columns: 
 Part Number (of the parent) 
 To Work Order (the work order opened and released for the subcontractor) 
 Operation (the operation to be purchased, that is, performed by the subcontractor) 
 In the Unit Price column, specify the price to be paid to the subcontractor for the work 
performed on each unit of the parent part. 
 In the Due Date column, specify the date the ordered part is due to leave the subcontractor's 
premises. 
Stage IV: Shipping Parts to the Subcontractor 
1. Enter the Shipmt to Subcontr/Issue of Kit form. 
2. Specify the Date. 
3. Specify the Subcontractor Number. 
4. In the From Warehouse column, specify the warehouse from which the parts are to be sent 
(usually the plant floor warehouse). The To Warehouse column is filled in automatically with the 
subcontractor’s warehouse. 
5. Enter the Shipped Items sub-level form and fill in the following columns for each shipped part: 
 Part Number (of the manufactured parent part) 
 Work Order/Lot (the work order of the part sent to the subcontractor) 
 Operation (the last reported operation for the work order, that is, the operation preceding the 
one to be performed by the subcontractor) 
 Qty (Factory Units) (the quantity of parts to be sent to the subcontractor, in factory units). 
6. Return to the upper-level form and finalize the subcontractor shipping document by changing its 
Status to a status defined as final.

www.priority -software.com   
3/4 ‏Feb. 05, '15 Ver.03 Cat.No. A8000104 
 
Results 
 The inventory balance for the part in the defined work order and operation is increased in the 
subcontractor’s warehouse according to the quantities specified in the shipping document. 
 In the Progress Report sub-level of the Work Orders form, a line is added displaying 
“Shipment to Subcontr” and the shipped quantity. 
Stage V: Receiving Goods from the Subcontractor 
1. Enter the Goods Receiving Voucher form. 
2. Specify the Date and Vendor No. 
3. Click the References tab and specify the original purchase order in the Order No. column.  
4. The Vendor Warehouse column is filled in automatically with the subcontractor’s warehouse, as 
recorded in the purchase order. Make sure it is correct. 
5. In the Receiving Warehouse column, specify the warehouse into which the goods from the 
subcontractor are received. 
6. Enter the Received Items sub-level form. The ordered items appear automatically, based on the 
purchase order. The From Operation column should display the operation performed by the 
subcontractor.  
7. Specify the received Quantity of each item. 
8. Return to the upper-level form and change the Status to a status defined as final. 
Results 
 The order balance of each part in the original purchase order is updated. 
 A new line appears in the Progress Report sub-level of the work order, with the “GRV” 
operation and the quantity of received units. 
Stage VI: Running the Backflush Program 
This program calculates and reduces inventory balances of child parts on the plant floor, according 
to recorded production reports and inventory transactions. In addition, it displays warning messages 
regarding inventory reductions of child parts that did not actually occur, for example, due to lack of 
required quantities at the subcontractor. 
 Run the Backflush program, choosing the From Last Past Bal. option. 
Results 
 The Inventory Balance for Part sub-level of the Parts form displays the received inventory 
with the number of the original work order and the code of the operation performed by the 
subcontractor. If that operation is the last in the routing, the inventory appears with no work 
order number or operation code (unless work order numbers are retained for finished goods). 
 The inventory balance of parts in the subcontractor’s warehouse is reduced for the work order 
sent to the subcontractor and for the previous operation (i.e., the one performed by the 
subcontractor). 
Important:   
 Run the Backflush program automatically (via the Tabula Task Scheduler) on a daily basis, and 
manually once a week.

www.priority -software.com   
4/4 ‏Feb. 05, '15 Ver.03 Cat.No. A8000104 
 
 When the OnlineBF constant is set to 1, the deduction of child parts occurs automatically when 
inventory transactions and production reports are recorded, rather than when the Backflush 
program is run. Neverthless, the Backflush program must be run routinely in order to deal with 
missing issues. 
Stage VII: Handling Negative Inventory in the Subcontractor’s Warehouse 
You should routinely enter the Current Warehouse Inventory form and retrieve inventory balances 
for the part in the subcontractor’s warehouse. 
If negative inventory is found for the part in the work order and operation in question, it signifies a 
discrepancy between the quantity of parts recorded in the Shipmt to Subcontr/Issue of Kit form and 
the quantity received and recorded in the Goods Receiving Voucher form. 
To correct this error, open a new shipment to subcontractor document for the part number, work 
order and operation in question, and specify the missing quantity, in order to reset balances to 
zero in the subcontractor’s warehouse.
