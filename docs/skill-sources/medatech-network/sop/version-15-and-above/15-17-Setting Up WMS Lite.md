# 15-17-Setting Up WMS Lite

- **Source:** `15-17-Setting Up WMS Lite.pdf`

www.priority -software.com   
1/5 Feb. 01, '15 Ver.3 Cat.No. LB110363 
 
 SOP: Setting Up Warehouse Management  
(WMS Lite) 1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up definitions required for working with Priority's WMS Lite module. 
Working Assumptions 
 The company from which the WMS module is being run has been flagged as the WMS 
Company in the Companies form. 
 Warehouses have been set up in the Warehouses form (see the relevant standard operating 
procedure), the default 0 bin is defined in each warehouse, and warehouses have been flagged 
in the AutoShip Pack Crates column in the WMS tab. 
 The AutoShip Pack Crates column in the Shipments tab of the Customers form has been 
flagged for all customers for which you will be opening shipping documents/sales invoices from 
pick tasks that conclude with a packing slip.  
 Task numeration has been set up in the Warehouse Task Templates form. 
 Pallet numeration has been set up in the Pallet Number Templates form. 
 Label numeration has been set up in the Label Templates form. 
 Separators (e.g., period or hyphen) have been defined for use in bin numeration, either by 
means of the IBinSeparate constant (in the Logistic Constants form) or in the Separators for 
Warehouse Bins form. 
 Bin types have been defined in the Bin Types form. 
 Shipping pallets have been defined in the Shipping Pallets form. 
 The following constants have been set up in the Logistic Constants form: 
 IVolumeCoef – The coefficient that is used to calculate volume. This is the ratio between the 
product of dimensions (length, width and height) that are measured in the "std length unit" and 
a volume measured in the "std volume unit". The default is 1,000,000. 
Note: In the Financial Parameters for Parts and Bin Types forms, after recording an item's 
length, width and height, the volume is calculated automatically by multiplying these three 
values and then dividing the result by this value. For example, for an item with the dimensions 
100x100x100, and given the default value for this coefficient, the volume in the "std volume 
unit" is 1. 
                                                
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 Feb. 01, '15 Ver.3 Cat.No. LB110363 
 
 SCratesQuant – Determines whether, when recording a shipping document based on packing 
slips, the contents of the packing crates (including quantities) are automatically approved for 
inclusion in the document. 
 A Default-Pack Slips has been defined in the Packing Crate Codes form. This will serve as the 
default crate in packing tasks handled via a mobile device. 
 Possible reasons have been defined in the Reasons for Pick/Put Exceptions form. 
 Shipping pallets have been defined in the Shipping Pallets form. 
 A primary weight unit has been defined by running the Flag Primary Weight Unit program. 
 A volume and/or weight has been defined for all parts in the Financial Parameters for Parts form. 
 Warehouse employees (e.g., storekeepers, pickers, forklift operators) have been defined as 
system users and assigned the necessary privileges to work in the WMS module and to create 
inventory documents in the Inventory Control module. 
 The relevant employee is flagged as a Main Warehs Employee in the Company-Specific 
Information sub-level of the Personnel File form. 
 The appropriate print program and print format are defined in the Inv. Transaction Documents 
form. The inventory documents that are prepared at the conclusion of the tasks will be printed 
using these definitions. 
Procedure 
Stage I: Assigning a Task Template to a Warehouse 
1. Enter the Warehouses form. 
2. Retrieve the relevant warehouse (one with a 0 bin). 
3. In the WMS tab, specify the Template used to number tasks created for this warehouse. 
4. Specify the Label Template used to number labels created for inventory documents associated 
with this warehouse. 
Result 
 Tasks created for this warehouse (either manually or automatically), as well as labels created for 
inventory documents associated with this warehouse, will be numbered according to the defined 
templates. 
Stage II: Defining Storage Zones 
1. Enter the Storage Zones form. 
2. For each zone, specify the Warehouse in which the current storage zone is located. 
3. Fill in the Storage Zone and Zone Description columns. 
4. For each zone, fill in the appropriate values and flag the appropriate columns: 
 Velocity – Select the default part velocity of new bins in this zone. 
 Unloading Deck – Select the unloading deck in this warehouse that is assigned to this zone. 
 Main Zone – Flag this column if this zone is used to group together a number of secondary 
storage zones. 
 Unloading Deck – Flag this column if this zone is used to receive incoming goods.

www.priority -software.com   
3/5 Feb. 01, '15 Ver.3 Cat.No. LB110363 
 
 Main Unloading Deck – Flag this column if this is the default unloading deck assigned to 
GRVs that are recorded for the current warehouse. 
 Loading Deck – Flag this column if this is the zone from which goods are shipped. 
 Returns – Flag this column if this zone is used for returned goods. 
Note: When a sales invoice is canceled, goods are transferred to the returns zone and not to 
the bin from which they were originally picked. 
 Bin Control – Flag this column if this zone is used mainly for storage. 
5. Enter the Aisles in Storage Zone sub-level form and define the aisles in this storage zone. 
Stage III: Defining Bin Types 
1. Enter the Bin Types form. 
2. For each type of warehouse bin, define a Bin Type Code and Bin Type Description. Specify 
the Maximum Weight and Maximum Volume that can be stored in bins of this type, and/or the 
Maximum Qty. 
3. If bins of this type include pallets, flag the Pallet Control column and specify the appropriate 
Maximum No. Pallets. If bins of this type are only used to store one type of pallet, specify the 
Pallet Type Code. 
Stage IV: Defining Warehouse Bins 
1. Enter the Warehouses form and retrieve the relevant warehouse with a 0 bin. 
2. Enter the Storage Zones in Warehouse sub-level form and move to the line for the desired 
storage zone. 
3. Enter the Bins in Storage Zone sub-level form. 
4. Indicate the Aisle, Row, Level and Slot in which the bin is located. A Bin code is filled in 
automatically. 
5. Specify the Velocity of inventory stored in this bin (A – fast, B – medium or  
C – slow). 
6. Specify the appropriate Bin Type Code. Additional columns (such as Pallet Control, Maximum 
No. Pallets, Pallet Type Code, Maximum Weight and Maximum Volume) are filled in 
automatically, based on the attributes defined for the specified bin type in the Bin Types form. 
7. In the Report Display Order column, you can indicate the order in which the current bin will 
appear in various reports (bins with a lower number appear first). 
8. If the current bin is linked to a specific project, specify the Project Number. 
Stage V: Task Type Definitions (PIK and SHP) for Specific Customers  
1. Enter the Target Doc per Task Type/Cust. form. 
2. Specify the customer in question. 
3. Choose a Warehouse Task Type (PIK or SHP). 
4. In the Document Code column, select the type of inventory transaction document to be 
prepared upon the completion of tasks of that type that were opened for the customer in 
question.

www.priority -software.com   
4/5 Feb. 01, '15 Ver.3 Cat.No. LB110363 
 
Result 
 When the Prepare Documents program is run for a PIK or SHP task opened for this customer 
(via a mobile device or by Direct Activation from the Warehouse Tasks form), the appropriate 
target document will be opened. This definition overrides the general task type definitions 
recorded for the task type in the Warehouse Task Types form. 
Stage VI: Defining Pallet Types  
Aim: To define pallet types and assign them a numeration template. 
1. Enter the Pallet Types form. 
2. For each type of pallet, specify a Pallet Type Code, Pallet Type Desc. and indicate the 
maximum loaded Weight of a pallet of this type.  
3. Specify a Template to be used when assigning pallet numbers to new pallets of this type.  
4. Flag one pallet type as the Initial Pallet Type. This will serve as the default type for all new 
pallets, even those that are opened via a mobile device. 
Results 
 It will not be possible to store goods on pallets of a given type if their total weight exceeds the 
maximum defined for that pallet type. 
 Pallet numbers are generated automatically based on the template assigned to the relevant 
pallet type. 
Stage VII: Delivery Definitions for Specific Customers  
Aim: To define the type of document to be sent when delivering picked goods to customers (a sales 
invoice or a shipping document). 
1. Enter the Financ. Parameters for Customers form and retrieve the customer in question. 
2. Click the Invoices tab. Flag the Delivery with Sales Inv column. 
Note: Leave this column blank to deliver goods together with a shipping document, and to bill 
customers for these goods via a multi-shipment invoice. 
3. If you want orders to be delivered with sales invoices only up until a particular day of the month, 
indicate the day in question in the To Day of Month column. 
Note: If the Delivery with Sales Inv column is not flagged or if the designated day of the month has 
already passed, shipping documents will be opened instead. 
Stage VIII: Defining Work With Mobile Devices 
1. Open the Mobile Device Screens form, and set up the appropriate device screens. 
2. For each screen, define the users that are authorized to use it in the Users Authorized for 
Screen sub-level form, including the Main Warehs Employee (as defined in the Company-
Specific Information sub-level of the Personnel File form; see "Error! Reference source not 
found."). 
3. Define the permitted storage zones for the main warehouse employee in the next sub-level, 
Authorized Zones. 
Result 
 On the mobile device, all users will see those warehouse task s assigned to the main 
warehouse employee performed in storage zones for which that employee is authorized.

www.priority -software.com   
5/5 Feb. 01, '15 Ver.3 Cat.No. LB110363 
 
 
Process Summary 
 Warehouses, storage zones and warehouse bins have been defined, enabling you to maintain 
inventory data and plan warehouse tasks.
