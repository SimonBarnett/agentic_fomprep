# SOP Setting Up Warehouse Management WMS Pick

- **Source:** `SOP Setting Up Warehouse Management WMS Pick.pdf`

Cat.No. LB130395 1 Ver.1 – Oct. 17,’13 
 
SOP: Setting Up Warehouse Management  
(WMS Pick) * 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up definitions required for working with Priority's WMS Pick module. 
Working Assumptions 
 The company from which the WMS module is being run has been flagged as the 
WMS Company in the Companies form. 
 Warehouses have been set up in the Warehouses form (see the relevant 
standard operating procedure), the default 0 bin is defined in each warehouse, 
and warehouses have been flagged in the AutoShip Pack Crates column in the 
WMS tab. 
 The AutoShip Pack Crates column in the Shipments tab of the Customers form 
has been flagged for all customers for which you will be opening shipping 
documents/sales invoices from pick tasks that conclude with a packing slip.  
 Task numeration has been set up in the Warehouse Task Templates form. 
 Pallet numeration has been set up in the Pallet Number Templates form. 
 Label numeration has been set up in the Label Templates form. 
 Separators (e.g., period or hyphen) have been defined for use in bin numeration, 
either by means of the IBinSeparate constant (in the Logistic Constants form) or 
in the Separators for Warehouse Bins form. 
 Bin types have been defined in the Bin Types form. 
 Shipping pallets have been defined in the Shipping Pallets form. 
 The following constants have been set up in the Logistic Constants form: 
 IVolumeCoef – The coefficient that is used to calculate volume. This is the 
ratio between the product of dimensions (length, width and height) that are 
measured in the "std length unit" and a volume measured in the "std volume 
unit". The default is 1,000,000. 
Note: In the Financial Parameters for Parts and Bin Types forms, after 
recording an item's length, width and height, the volume is calculated 
automatically by multiplying these three values and then dividing the result by 
this value. For example, for an item with the dimensions 100x100x100, and 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Cat.No. LB130395 2 Ver.1 – Oct. 17,’13 
given the default value for this coefficient, the volume in the "std volume unit" is 
1. 
 SCratesQuant – Determines whether, when recording a shipping document 
based on packing slips, the contents of the packing crates (including quantities) 
are automatically approved for inclusion in the document. 
 IPickByCrate – Determines whether parts should be picked by crate or by 
individual units. Either the Planned Crate Qty or Planned Qty column will be 
filled in automatically in warehouse tasks that are created by pick waves, 
depending on the value of this constant.  
Note: The constant only affects those parts that are flagged as Pick by Crate 
(in the Part Catalogue form). 
 A master crate has been flagged as Master in the Packing Crate Types form. This 
defines a crate which can be assigned as the Master Crate Code for a regular 
crate. 
 A default packing crate code has been defined for relevant parts in the Crate 
Type Code column of the Inventory Parameters for Parts form. 
 Possible reasons have been defined in the Reasons for Pick/Put Exceptions 
form. 
 A primary weight unit has been defined by running the Flag Primary Weight Unit 
program. 
 Warehouse employees (e.g., storekeepers, pickers, forklift operators) have been 
defined as system users and assigned the necessary privileges to work in the 
WMS module and to create inventory documents in the Inventory Control module. 
 The relevant employee is flagged as a Main Warehs Employee in the 
Company-Specific Information sub-level of the Personnel File form. 
 The appropriate print program and print format are defined in the Inv. Transaction 
Documents form. The inventory documents that are prepared at the conclusion of 
the tasks will be printed using these definitions. 
Procedure 
Stage I: Assigning a Task Template to a Warehouse 
1. Enter the Warehouses form. 
2. Retrieve the relevant warehouse (one with a 0 bin). 
3. In the WMS tab, specify the Template used to number tasks created for this 
warehouse. 
4. Specify the Label Template used to number labels created for inventory 
documents associated with this warehouse. 
Result 
 Tasks created for this warehouse (either manually or automatically), as well as 
labels created for inventory documents associated with this warehouse, will be 
numbered according to the defined templates.

Cat.No. LB130395 3 Ver.1 – Oct. 17,’13 
Stage II: Defining Storage Zones 
1. Enter the Storage Zones form. 
2. For each zone, specify the Warehouse in which the current storage zone is 
located. 
3. Fill in the Storage Zone and Zone Description columns. 
4. For each zone, fill in the appropriate values and flag the appropriate columns: 
 Velocity – Select the default part velocity of new bins in this zone. 
 Unloading Deck – Select the unloading deck in this warehouse that is 
assigned to this zone. 
 Main Zone – Flag this column if this zone is used to group together a number 
of secondary storage zones. 
 Unloading Deck – Flag this column if this zone is used to receive incoming 
goods. 
 Main Unloading Deck – Flag this column if this is the default unloading deck 
assigned to GRVs that are recorded for the current warehouse. 
 Loading Deck – Flag this column if this is the zone from which goods are 
shipped. 
 Returns – Flag this column if this zone is used for returned goods. 
Note: When a sales invoice is canceled, goods are transferred to the returns 
zone and not to the bin from which they were originally picked. 
 Bin Control – Flag this column if this zone is used mainly for storage. 
5. If this zone is defined as a Main Zone, enter the Secondary Zones sub-level 
form to define its secondary zones. For each secondary zone: 
 In the Order column, indicate the order in which the secondary zone will be 
included in system recommendations when creating a wave of warehouse 
tasks for the current main zone. 
 In the Grouping column, assign the same number to secondary zones that 
should be included together in a single warehouse task, provided there is no 
other reason to split them into separate tasks (e.g., different pallets). 
Secondary zones with a unique grouping will be assigned a separate task. 
6. Enter the Aisles in Storage Zone sub-level form and define the aisles in this 
storage zone. 
Stage III: Defining Bin Types 
1. Enter the Bin Types form. 
2. For each type of warehouse bin, define a Bin Type Code and Bin Type 
Description. Specify the Maximum Weight and Maximum Volume that can be 
stored in bins of this type, and/or the Maximum Qty. 
3. If bins of this type include pallets, flag the Pallet Control column and specify the 
appropriate Maximum No. Pallets. If bins of this type are only used to store one 
type of pallet, specify the Pallet Type Code. 
Stage IV: Defining Warehouse Bins 
1. Enter the Warehouses form and retrieve the relevant warehouse with a 0 bin.

Cat.No. LB130395 4 Ver.1 – Oct. 17,’13 
2. Enter the Storage Zones in Warehouse sub-level form and move to the line for 
the desired storage zone. 
3. Enter the Bins in Storage Zone sub-level form. 
4. Indicate the Aisle, Row, Level and Slot in which the bin is located. A Bin code is 
filled in automatically. 
5. Specify the Velocity of inventory stored in this bin (A – fast, B – medium or  
C – slow). 
6. In the Pick Order and Put Order columns, indicate the order in which this bin will 
be included in system recommendations for warehouse tasks created for this 
warehouse and storage zone. 
7. Specify the appropriate Bin Type Code. Additional columns (such as Pallet 
Control, Maximum No. Pallets, Pallet Type Code, Maximum Weight and 
Maximum Volume) are filled in automatically, based on the attributes defined for 
the specified bin type in the Bin Types form. 
8. If the bin is used to store crates (C) or master crates (M), specify the appropriate 
value in the Storage Type column. As a result, the pick algorithm will recommend 
whole multiples of the contents of the relevant crate (either the part's default crate 
or its master crate, respectively) from the available inventory in the bin. 
9. In the Report Display Order column, you can indicate the order in which the 
current bin will appear in various reports (bins with a lower number appear first). 
10. If the current bin is linked to a specific project, specify the Project Number. 
Stage V: Task Type Definitions (PIK and SHP) for Specific 
Customers  
1. Enter the Target Doc per Task Type/Cust. form. 
2. Specify the customer in question. 
3. Choose a Warehouse Task Type (PIK or SHP). 
4. In the Document Code column, select the type of inventory transaction 
document to be prepared upon the completion of tasks of that type that were 
opened for the customer in question. 
Result 
 When the Prepare Documents program is run for a PIK or SHP task opened for 
this customer (via a mobile device or by Direct Activation from the Warehouse 
Tasks form), the appropriate target document will be opened. This definition 
overrides the general task type definitions recorded for the task type in the 
Warehouse Task Types form. 
Stage VI: Defining Cargo Transport Types  
1. Enter the Cargo Transport Types form. 
2. For each type of transport, specify a Transport Type Code, Transport Type 
Desc. and indicate the Maximum Level that can be reached by this transport 
type. 
3. For transport types that include a forklift, flag the Forklift column and define the 
Maximum Volume of goods that can be transported using this transport type.

Cat.No. LB130395 5 Ver.1 – Oct. 17,’13 
Stage VII: Defining a Means of Transport 
1. Enter the Means of Transport form. 
2. For each means of transportation, specify a Transport Code and assign the 
appropriate Transport Type Code. 
3. If necessary, you can also define a License Number and/or indicate that this 
means of transport is Not in Use.  
Result 
 When a warehouse task receives the "Execute" status, the system assigns it the 
most appropriate means of transport available, based on transport type 
definitions: 
 In tasks involving palleted goods, the system automatically assigns a forklift 
that can reach the level in question. 
 In tasks involving goods that are not palleted, the system automatically assigns 
a means of transport with the lowest possible capacity that can handle the 
volume of goods to be transported and can reach the level in question. 
Stage VIII: Defining Pallet Types  
Aim: To define pallet types and assign them a numeration template. 
1. Enter the Pallet Types form. 
2. For each type of pallet, specify a Pallet Type Code, Pallet Type Desc. and 
indicate the maximum loaded Weight of a pallet of this type.  
3. Specify a Template to be used when assigning pallet numbers to new pallets of 
this type.  
4. Flag one pallet type as the Initial Pallet Type. This will serve as the default type 
for all new pallets, even those that are opened via a mobile device. 
Result 
 Pallet numbers are generated automatically based on the template assigned to 
the relevant pallet type. 
Stage IX: Setting Delivery Definitions for Specific Customers 
Aim: To define the type of document to be sent to specific customers when 
delivering the picked goods (a sales invoice or a shipping document). 
1. Enter the Financ. Parameters for Customers form and retrieve the customer in 
question. 
2. Click the Invoices tab. Flag the Delivery with Sales Inv column (to send a sales 
invoice), or leave this column blank to send picked goods with a shipping 
document and later bill the customer with a multi-shipment invoice. 
3. If you want orders to be delivered with sales invoices only up until a particular day 
of the month, indicate the day in question in the To Day of Month column. 
Note: If the Delivery with Sales Inv column is not flagged or if the designated day of 
the month has already passed, shipping documents will be opened instead.

Cat.No. LB130395 6 Ver.1 – Oct. 17,’13 
Stage X: Defining Pick Strategies 
Aim: To define the strategy used when picking goods, setting the algorithm which 
determines the order of operations in pick waves. 
1. Enter the Pick Strategy form. 
2. Specify the Strategy Code and Strategy Description. 
3. Flag the By Crates column to pick master crates before regular crates, and 
regular crates before individual units (algorithm 222). 
4. Flag the Linked Wk Ords Only column if, when picking inventory managed by 
work order, you want to pick only work orders linked to a line in a sales order (as 
defined in the work order). 
5. Flag the Create Log column to create a log which will assist in analyzing 
inventory movements created when running pick waves with this strategy. You 
should flag this column only if you intend to run the Inventory Movement report 
to clarify wave results.  
6. Flag the Hot Replenishment column to simultaneously create replenishment 
tasks for fast bins that are included in pick tasks created by the pick wave. 
Note: A full explanation on the subject can be found in the Setting Up Hot 
Replenishment SOP. 
7. Flag the Ignore Cust Strategy column in order for this strategy to override the 
one defined for the customer. 
Note: This does not affect the sort algorithm for the order (see step 9 below), 
which is always taken from the pick strategy defined for the wave. 
8. In the Pick Algorithm sub-level form, customize the algorithm as needed:  
 Use the Order column to specify the sequence of steps involved in selecting 
inventory for picking. A step with a lower number will be performed before a 
step with a higher number.  
 Add a check mark to the Reverse column if you want to reverse the condition. 
For example, flag Reverse in Step 14 to pick palleted goods before non-
palleted goods.  
 If a step is not relevant, flag the Not in Use column. 
9. In the Sort Algorithm - Order Items sub-level form, define the order in which 
items should be handled when the wave includes more than one order item: 
 Use the Order column to specify the priority given to sorting the order items. A 
step with a lower number will be performed before a step with a higher number. 
 Add a check mark to the Reverse column if you want to reverse the condition. 
 If a step is not relevant, flag the Not in Use column. 
Stage XI: Assigning a Task Split Method and a Pick Strategy to a 
Customer  
Aim: To define the default method of splitting tasks and the default pick strategy for 
specific customers. 
1. Enter the Customers form and retrieve the customer in question. 
2. In the Shipments tab, specify the desired task split method in the WMS Task 
Split Method column..  
Note: The task split method defined for this customer overrides the one defined

Cat.No. LB130395 7 Ver.1 – Oct. 17,’13 
for the wave. For example, if a customer's task split method is "By Individual 
Order", and the task split method for a pick wave is "By Customer", the wave will 
open a separate pick task for each of the customer's orders rather than a single 
pick task combining all the customer's orders. 
3. Select the default Pick Strategy for the customer. The pick strategy determines 
the pick order of the selected order items (e.g., it might determine that the part in 
the work order intended to fill the order will be picked before parts in other work 
orders).  
Note: This default pick strategy for the customer overrides the definition in a 
given wave, unless the Ignore Cust Strategy column is flagged during program 
input. 
Stage XII: Defining Work With Mobile Devices 
1. Open the Mobile Device Screens form, and set up the appropriate device 
screens. 
2. For each screen, define the users that are authorized to use it in the Users 
Authorized for Screen sub-level form, including the Main Warehs Employee 
(as defined in the Company-Specific Information sub-level of the Personnel 
File form; see "Working Assumptions"). 
3. Define the permitted storage zones for the main warehouse employee in the next 
sub-level, Authorized Zones. 
Result 
 On the mobile device, all users will see those warehouse tasks assigned to the 
main warehouse employee performed in storage zones for which that employee 
is authorized.  
Process Summary 
 Warehouses and warehouse bins have been defined, enabling you to maintain 
inventory data for each bin, and indicating which bin should be used for a given 
warehouse task. 
 Storage zones have been defined, including the types of goods stored in each 
zone. These definitions affect the pick and put order in the warehouse, as well as 
warehouse task planning.
