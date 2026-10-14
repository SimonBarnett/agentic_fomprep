# SOP Defining a Warehouse

- **Source:** `SOP Defining a Warehouse.pdf`

Cat.No. LB10000428 1 Ver.1 – Sep. 14,’10 
 
SOP: Defining a Warehouse* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of defining a warehouse in the system. 
Procedure 
Stage I: Opening a Warehouse 
1. Enter the Warehouses form. 
2. Specify the desired warehouse code in the Warehouse column. The value 0 appears 
by default in the Bin column. 
3. Record the name of the new warehouse in the Description column. 
4. In the Type (D/F/W) column (in the General tab), select the desired code from among 
the following options: 
 D – a warehouse for raw materials and processed parts that are taken into account 
during production planning, MRP and purchase planning. 
 F – a warehouse on the plant floor. 
 W – a warehouse for finished products that are not taken into account during 
planning processes. 
Note: Assign type W to warehouses whose inventory you want MRP to ignore. The 
Ignored by Planning column is automatically flagged for such warehouses. 
5. All warehouses are automatically flagged for inventory valuation. If inventory in this 
warehouse does not undergo valuation, click the remove the flag in the Inventory 
Valued column. 
6. All warehouses are automatically flagged for transaction costing. If you want to 
disregard the transactions in this warehouse during costing, remove the flag in the 
Transaction Costing column.  
7. If the warehouse is used to store goods on consignment, flag the For Consignment 
column. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. LB10000428 2 Ver.1 – Sep. 14,’10 
8. Dual-currency users: If this is a bonded warehouse, flag the Bonded Warehouse 
column. 
9. Use the Kit Warehouse column to assign a kit warehouse to a subcontractor's 
warehouse. Kit warehouses are used to store kit components in a separate area until 
the kit is complete and the subcontractor is ready to receive them. 
10. Click the Address and Phone tab and record the desired details, including the 
relevant Contact. 
Stage II: Maintaining Bins 
Note: If you work with WMS, bins should be defined in accordance with the SOP for 
Setting Up WMS. 
1. Enter the Warehouses form, retrieve the desired warehouse and press F4 to move to 
Multi-Record Display Mode. 
2. Move to a new line (directly below the existing one) and copy all columns (press F10) 
from the previous line, except the bin. 
3. In the Bin column, record the code you want to assign to the bin.  
Note: Do not change the default 0 bin, which is recorded automatically whenever a 
new warehouse is opened. It is used to represent the entire warehouse. 
4. Repeat for all other bins in the warehouse.
