# Inventory_Count_Default_Warehouse

- **Source:** `Inventory_Count_Default_Warehouse.htm`

Inventory Count - Defining the Default Warehouse 
 
 
- 
 
 
 
# Defining a Default Warehouse

 

The program that prepares the count can be set to include all parts defined as stored in a given warehouse, even if their current inventory level is zero. 
 
## To define the default warehouse for a part:

 

 1 .  Enter the Inventory Parameters for Parts form. 
 

 2 .  Retrieve the desired parts. 
 

 3 .  For each part, record the default Warehouse (and Bin ). 
 
## Deleting Zero Balances

 

You can also set the program to automatically delete all inventory balances of 0 . 
 
## To determine how zero inventory balances will be handled:

 

 1 .  Enter the Production Constants form. 
 

 2 .  Move to the NullBalance constant and select the appropriate value. 
 
## Notes:

 

 ·        If this constant is set to delete all zero balances, they will also be deleted when past balances are calculated and when the Backflush program is run. 
 

 ·        Click to prepare the count.
