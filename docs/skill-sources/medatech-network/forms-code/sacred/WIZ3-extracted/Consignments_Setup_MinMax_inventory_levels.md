# Consignments_Setup_MinMax_inventory_levels

- **Source:** `Consignments_Setup_MinMax_inventory_levels.htm`

Consignments - Defining Replenishment Levels 
 
 
- 
 
 
 
# Defining Replenishment Levels for a Consignment Warehouse

 

When calculating the quantities of parts required to replenish inventory levels in consignment warehouses, the Replenish Consignment Warehouses program is constrained by the minimum and maximum quantities defined for each part. Consequently, it will determine for each part the quantity needed to raise its inventory level as close as possible to the defined maximum. If the maximum level remains undefined, or is defined as 0 , the program will determine the quantity needed to raise the inventory level above and as close as possible to the defined minimum. 
 
## To define replenishment levels:

 

 1 .  Enter the Warehouses form and retrieve the desired consignment warehouse. 
 

 2 .  Enter the Warehouse Inventory Levels sub-level form. 
 

 3 .  Specify the Part Number of an item that is stored in this warehouse. 
 

 4 .  In the Minimum-Fact. Unit or Minimum column, record the minimum quantity of this part (in factory units or buy/sell units, respectively) that should always be available in the current warehouse.
 Tip: When you fill in one of these columns, the other is filled in automatically. 
 

 5 .  In the Maximum-Fact. Unit or Maximum column, record the maximum quantity of this part (in factory units or buy/sell units, respectively) that should be stored in the current warehouse.
 Tip: When you fill in one of these columns, the other is filled in automatically. 
 

 6 .  Repeat Steps 3-5 for every part in the current warehouse for which you want to replenish inventory levels.
