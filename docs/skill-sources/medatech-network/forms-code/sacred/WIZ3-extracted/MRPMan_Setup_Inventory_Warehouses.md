# MRPMan_Setup_Inventory_Warehouses

- **Source:** `MRPMan_Setup_Inventory_Warehouses.htm`

MRP for Manufacturers - Inventory Setup: Warehouse Types and Inventory Status 
 
 
- 
 
 
 
# To check warehouse types:

 

 1 .  Enter the Warehouses form and retrieve all warehouses. 
 

 2 .  Make sure that each warehouse has been assigned the correct Type (in the General tab): 
 

 ·      The inventory in type D warehouses is always taken into account by MRP (i.e., you cannot check the Ignored by Planning flag). 
 

 ·      The inventory in type W warehouses is never taken into account by MRP (i.e., you cannot clear the Ignored by Planning flag). 
 

 3 .  If you are setting MRP to take floor inventory into account, retrieve all floor (type F ) warehouses. Flag the Ignored by Planning column for any floor warehouse whose inventory MRP should disregard. 
 
## To check inventory statuses:

 

 1 .  Enter the Inventory Statuses form. 
 

 2 .  For each status that is to be taken into account by MRP, flag the Available Inventory column. Only inventory with a status that is flagged in that column will be considered available to reduce demands. 
 Note: You can run MRP to take into account parts packed for a customer (i.e., with the customer number as their status) by selecting the Consider Packed Inv. runtime option. This option includes packed goods in every warehouse, with the exception of those warehouses flagged as Ignored by Planning .
