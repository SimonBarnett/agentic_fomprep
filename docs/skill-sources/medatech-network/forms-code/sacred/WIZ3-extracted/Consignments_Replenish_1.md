# Consignments_Replenish_1

- **Source:** `Consignments_Replenish_1.htm`

Consignments - Replenishing Inventory in Consignment Warehouses.1 
 
 
- 
 
 
 
# Replenishing Inventory Levels in a Consignment Warehouse

 

A consignment warehouse needs to always maintain minimal inventory of all of its parts, so they are available for sale. 
 

 Priority provides a special program that calculates the quantities of all goods that are required to maintain desired inventory levels in consignment warehouses. After calculating these levels, the program produces a report detailing the required quantities and the resulting new inventory balances. You can also set up the program to open sales orders for all parts that require replenishment. 
 

The Replenish Consignment Warehouses program takes the following factors into account when calculating inventory balances: 
 

 ·        The minimum and maximum inventory levels defined for the part. 
 

 ·        Open sales orders intended for the consignment warehouse. 
 Note: If a transit warehouse has been defined, it appears as the receiving warehouse in the sales order. In such a case, the order is also taken into account when calculating inventory levels for the consignment warehouse. 
 

 ·        At the user's request, the program can also take into account open sales orders for end customers from the consignment warehouse. This parameter increases the quantity of parts required to replenish inventory levels. 
 

Inventory replenishment is only required when the program determines that the combination of these factors does not yield sufficient quantities to cover the defined minimum for each part and warehouse. In such a case, the program consults the minimum replenishment quantity and increment defined for each part and warehouse to determine recommended order quantities in order to maintain the desired inventory levels. 
 

 Tip: 
 

If you have not yet defined the above parameters, click to perform the necessary setups.
