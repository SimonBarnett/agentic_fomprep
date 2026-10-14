# SOP Setting Up Warehouse Management

- **Source:** `SOP Setting Up Warehouse Management.pdf`

Cat.No. LB130394 1 Ver.1 – Oct. 17,’13 
 
SOP: Setting Up Warehouse Management (WMS) * 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up definitions required for working with Priority's full WMS module. 
Note: For information on setting up for Priority's WMS Lite module and setting up 
for Priority's WMS Pick module, see the corresponding SOPs. 
Working Assumptions 
 The company from which the WMS module is being run has been flagged as the 
WMS Company in the Companies form. 
 Warehouses have been set up in the Warehouses form (see the relevant standard 
operating procedure), the default 0 bin is defined in each warehouse, and 
warehouses have been flagged in the AutoShip Pack Crates column in the WMS 
tab. 
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
 IPickInv – Determines whether the system takes planned replenishment (i.e., 
inventory for which a replenishment task has been opened but has not yet 
been completed) into account when recommending available inventory for Pick 
waves. 
 IPartialPlt – Determines whether inventory replenishment tasks created by a 
wave can transfer quantities from part of a pallet or whether such tasks must 
use the entire pallet. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Cat.No. LB130394 2 Ver.1 – Oct. 17,’13 
 IEmptyPlt – Determines the amount (as a percentage) that can remain on a 
pallet when performing inventory replenishment tasks without emptying the 
entire pallet; if less than this amount remains after the required quantity is 
removed, the entire contents of the pallet are transferred, even if this causes 
inventory levels in the target bin to exceed the defined maximum. 
 IPalletInv – Determines whether, in inventory documents that involve pallets, 
inventory from a single pallet may be received into two different bins. 
 IVolumeCoef – The coefficient that is used to calculate volume. This is the 
ratio between the product of dimensions (length, width and height) that are 
measured in the "std length unit" and a volume measured in the "std volume 
unit". The default is 1,000,000. 
Note: In the Financial Parameters for Parts and Bin Types forms, after 
recording an item's length, width and height, the volume is calculated 
automatically by multiplying these three values and then dividing the result by 
this value. For example, for an item with the dimensions 100x100x100, and 
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
 Possible reasons have been defined in the Reasons for Pick/Put Exceptions form. 
 A primary weight unit has been defined by running the Flag Primary Weight Unit 
program. 
 Warehouse employees (e.g., warehousers, pickers, forklift operators) have been 
defined as system users and assigned the necessary privileges to work in the 
WMS module and to create inventory documents in the Inventory Control module. 
 The relevant employee is flagged as a Main Warehs Employee in the Company-
Specific Information sub-level of the Personnel File form. 
 The appropriate print program and print format are defined in the Inv. Transaction 
Documents form. The inventory documents that are prepared at the conclusion of 
the tasks will be printed using these definitions. 
Procedure 
Stage I: Assigning a Task Template to a Warehouse 
1. Enter the Warehouses form.

Cat.No. LB130394 3 Ver.1 – Oct. 17,’13 
2. Retrieve the relevant warehouse (one with a 0 bin). 
3. In the WMS tab, specify the Template used to number tasks created for this 
warehouse. 
4. Specify the Label Template used to number labels created for inventory 
documents associated with this warehouse. 
Result 
 Tasks created for this warehouse (either manually or automatically), as well as 
labels created for inventory documents associated with this warehouse, will be 
numbered according to the defined templates. 
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

Cat.No. LB130394 4 Ver.1 – Oct. 17,’13 
Stage III: Defining Inventory Attributes for a Storage Zone 
1. Enter the Storage Zones form and retrieve the relevant storage zone. 
2. Enter the Inventory in Storage Zone sub-level form. 
3. For each part stored in the current zone, indicate the appropriate Part Number 
and Velocity. You can also specify the Minimum and Maximum Qty of each 
part that can be stored in bins in this zone, and the inventory count frequency (in 
days). 
Result 
 When waves of put and replenish tasks are created for this storage zone, system 
recommendations for bin usage will take the designated minimum and maximum 
inventory levels into account. 
Stage IV: Defining Bin Types 
1. Enter the Bin Types form. 
2. For each type of warehouse bin, define a Bin Type Code and Bin Type 
Description. Specify the Maximum Weight and Maximum Volume that can be 
stored in bins of this type, and/or the Maximum Qty. 
3. If bins of this type include pallets, flag the Pallet Control column and specify the 
appropriate Pallet Type Code and Maximum No. Pallets. 
 In the Permitted Pallet Types sub-level form, specify the types of pallets 
appropriate for this bin type, as well as the location within the bin that these 
types of pallets occupy. 
Note: This form is especially useful when, for example, a bin can contain 
either 3 narrow pallets or 2 wide pallets. 
 Flag the Homogeneous Pallets column if you want the PUT algorithm to 
recommend storing pallets loaded with a single part in this type of bin. 
4. In the Max Diff. Parts/Bin column, specify the number of different parts that can 
be stored in bins of this type at any given time (i.e., specify 1 to indicate that bins 
of this type are homogenous). 
Note: For bin types that are subject to pallet control, specify 0 if you intend to 
store mixed pallets in bins of this type. 
5. In the Max. Diff Lots/Bin column, specify the maximum number of different lots 
that the PUT algorithm can recommend to be stored in bins of this type. 
6. In the No. of Slots column, specify the number of slots in bins of this type. The 
default is 1. 
Note: If dimensions (length, width and height) are defined for this bin type, they 
refer to a single slot within the bin. These dimensions are used to calculate the 
maximum volume of parts that can be put away in each bin (per slot). 
7. If this bin type represents a drawer that can slide in and out, flag the Drawer 
column. 
Note: When putting away inventory in a bin that is defined as a drawer (i.e., 
contains multiple slots), the maximum weight and volume of parts (defined in the 
Financial Parameters for Parts form) that can be put away in that bin are 
checked per slot.

Cat.No. LB130394 5 Ver.1 – Oct. 17,’13 
Stage V: Defining Warehouse Bins 
1. Enter the Warehouses form and retrieve the relevant warehouse with a 0 bin. 
2. Enter the Storage Zones in Warehouse sub-level form and move to the line for 
the desired storage zone. 
3. Enter the Bins in Storage Zone sub-level form. 
4. Indicate the Aisle, Row, Level and Slot in which the bin is located. A Bin code is 
filled in automatically. 
5. Specify the Velocity of inventory stored in this bin (A – fast, B – medium or  
C – slow). 
6. In the Pick Order and Put Order columns, indicate the order in which this bin will 
be included in system recommendations for picking and putaway in warehouse 
tasks created for this warehouse and storage zone. 
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
Stage VI: Defining Possible Warehouse Bins for Parts 
Aim: To define possible warehouse bins in which a given part can be stored. 
1. Enter the Possible Warehouse Bins per Part form. 
2. List each part that can only be stored in specific bins (based on the part velocity 
defined for the bin). 
3. For each part, define a possible warehouse and bin for storage. 
Note: The possible bins defined for the part determine where the system will 
recommend that the part be put away, even if there is a discrepancy between the 
definitions in this form and the put strategy and part velocity defined for the storage 
zone in which each bin is maintained. 
Result 
 System recommendations regarding the bin to be used for put tasks will take bin 
preferences into account.  
Stage VII: Assigning Put Strategies to Parts, Families and Family 
Types 
Aim: To define put strategies and assign them to parts/part families/family types that 
can be stored together. Put strategies are used to limit which parts can be stored in a 
given storage zone, and to indicate the rate of inventory turnover in that zone (fast, 
medium or slow).

Cat.No. LB130394 6 Ver.1 – Oct. 17,’13 
1. Enter the Put Strategies form. For each strategy, record a Put Strategy Code 
and Put Strategy Descrip. 
2. To assign a put strategy to a specific part, enter the Part Catalogue form and 
retrieve the desired part. Click the Additional Details tab and specify the 
appropriate Put Strategy. 
3. To assign a put strategy to a part family, enter the Part Families form and retrieve 
the desired part family. In the Put Strategy Code column, specify the appropriate 
strategy. 
4. To assign a put strategy to a family type, enter the Family Types form and 
retrieve the desired part. In the Put Strategy Code column, specify the 
appropriate strategy. 
Note: The put strategy defined for a specific part overrides the put strategy defined 
for its part family, which in turn overrides the put strategy defined for its family type. 
Stage VIII: Assigning Put Strategies to Storage Zones and Aisles 
Aim: To restrict storage in bins of different velocities within a given storage zone and 
aisle to one or more put strategies. 
1. Enter the Put Strategies form and retrieve the relevant strategy. 
2. Enter the Put Order sub-level form and assign the relevant storage zones to the 
current put strategy. 
Note: For each zone, record each possible velocity on a separate line. For 
example, if parts with a given put strategy can be stored in this zone at any 
velocity, record three lines for the same put strategy for each of the three 
velocities (fast, medium, and slow). 
3. For each storage zone and velocity, indicate the maximum number of bins (Max 
Diff. Bins) that can be used to store parts with the current put strategy. 
4. The All Aisles and All Bin Types columns are flagged automatically. To restrict 
storage of parts with the current put strategy to specific aisles and/or bin types in 
the storage zone, remove the check mark from the relevant column and enter the 
Permitted Aisles or Permitted Bin Types sub-level form to list the aisles and/or 
bin types in question. 
5. For each storage zone and velocity, specify the desired Put Order. 
Result 
 When waves of warehouse tasks are created for this storage zone, system 
recommendations for bin usage will take the assigned put strategies into account. 
Stage IX: Defining Warehouse Task Types 
1. Enter the Warehouse Task Types form. 
2. Retrieve all task types. 
3. For each task type, the Document Code column displays the type of inventory 
transaction document that will be prepared automatically when tasks of that type 
are completed. For certain task types (e.g., PIK and PAK), choose the desired 
document type from the Choose list. 
4. For each task type, enter the Document Types per Task Type sub-level form. 
5. For each document type, specify the initial Status to be assigned to any new 
documents prepared for warehouse tasks of this type.

Cat.No. LB130394 7 Ver.1 – Oct. 17,’13 
Note: If you do not define an initial status, each new document of this type will be 
assigned its default Initial Status, as displayed in the Inv. Transaction 
Documents form. 
Result 
 When the Prepare Documents program is run (via a mobile device or by Direct 
Activation from the Warehouse Tasks form), the appropriate inventory document 
will be opened with the initial status defined for the relevant task type. 
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
9. In the Sort Algorithm - Order Items sub-level form, customize the order in which 
order items should be handled when the wave includes more than one order 
item: 
 Use the Order column to specify the sequence of steps involved in sorting 
order items. A step with a lower number will be performed before a step with a 
higher number. 
 Add a check mark to the Reverse column if you want to reverse the condition.

Cat.No. LB130394 8 Ver.1 – Oct. 17,’13 
 If a step is not relevant, flag the Not in Use column. 
Stage XI: Setting Task Type Definitions (PIK and SHP) for Specific 
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
Stage XII: Defining Cargo Transport Types  
1. Enter the Cargo Transport Types form. 
2. For each type of transport, specify a Transport Type Code, Transport Type 
Desc. and indicate the Maximum Level that can be reached by this transport 
type. 
3. For transport types that include a forklift, flag the Forklift column and define the 
Maximum Volume of goods that can be transported using this transport type. 
Stage XIII: Defining a Means of Transport 
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
Stage XIV: Defining Pallet Types  
Aim: To define pallet types and assign them a numeration template. 
1. Enter the Pallet Types form.

Cat.No. LB130394 9 Ver.1 – Oct. 17,’13 
2. For each type of pallet, specify a Pallet Type Code, Pallet Type Desc. and 
indicate the maximum loaded Weight of a pallet of this type.  
3. Specify a Template to be used when assigning pallet numbers to new pallets of 
this type.  
4. Flag one pallet type as the Initial Pallet Type. This will serve as the default type 
for all new pallets, even those that are opened via a mobile device. 
Results 
 It will not be possible to store goods on pallets of a given type if their total weight 
exceeds the maximum defined for that pallet type. 
 When a new pallet is opened, a pallet number is generated automatically based 
on the template assigned to the relevant pallet type. 
Stage XV: Assigning a Task Split Method and a Pick Strategy to a 
Customer  
Aim: To define the default method of splitting tasks and the default pick strategy for 
specific customers. 
1. Enter the Customers form and retrieve the customer in question. 
2. In the Shipments tab, specify the desired task split method in the WMS Task 
Split Method column..  
Note: The task split method defined for this customer overrides the one defined 
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
Stage XVI: Setting Delivery Definitions for Specific Customers 
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

Cat.No. LB130394 10 Ver.1 – Oct. 17,’13 
Stage XVII: Defining Work With Mobile Devices 
1. Open the Mobile Device Screens form, and set up the appropriate device 
screens. 
2. For each screen, define the users that are authorized to use it in the Users 
Authorized for Screen sub-level form, including the Main Warehs Employee 
(as defined in the Company-Specific Information sub-level of the Personnel 
File form; see "Error! Reference source not found."). 
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
zone and the distance between zones. These definitions affect the pick and put 
order in the warehouse, as well as warehouse task planning.
