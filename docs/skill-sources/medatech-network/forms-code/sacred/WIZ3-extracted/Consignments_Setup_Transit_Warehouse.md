# Consignments_Setup_Transit_Warehouse

- **Source:** `Consignments_Setup_Transit_Warehouse.htm`

Consignments - Defining a Transit Warehouse 
 
 
- 
 
 
 
# Defining a Transit Warehouse

 

Define a transit warehouse for a given consignment warehouse if shipments are expected to take a long time. The shipped goods are considered to be in transit (i.e., located in the "transit" warehouse) until they are received into the consignment warehouse via a warehouse transfer document. The system takes goods in transit into account when calculating replenishment quantities, adding them to the existing inventory in the consignment warehouse. Furthermore, when replenishment orders are opened for the consignment warehouse, it is the transit warehouse that is recorded in the sales order and customer shipment documents. 
 
# To define a transit warehouse:

 

 1 .  Enter the Warehouses form and open a new warehouse of Type D in the normal fashion. Make a note of the warehouse number.
 Tip: For help with opening warehouses, run the Open a Warehouse Wizard . 
 

 2 .  In the General tab, flag the Inventory Valued column.
 Note: Do not flag the For Consignment column for transit warehouses. 
 

 3 .  Retrieve the consignment warehouse for which you opened this transit warehouse. 
 

 4 .  In the Consignment tab, specify the number of the new Transit Warehouse .
