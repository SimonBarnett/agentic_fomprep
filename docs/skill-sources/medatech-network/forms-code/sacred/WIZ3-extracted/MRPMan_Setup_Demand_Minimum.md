# MRPMan_Setup_Demand_Minimum

- **Source:** `MRPMan_Setup_Demand_Minimum.htm`

MRP for Manufacturers - Demand Setup: Work Order Minimum 
 
 
- 
 
 
 
# Defining a Part's Minimum Work Order Threshold

 

The Qty to NotOpen WkOrd column determines the minimum demand for which MRP will open a work order for a given part. This is not to be confused with the work order parameter Min for Order/W. Ord , which determines the minimum size of the work order itself. For example, let's say that the former parameter is set at 10 units and the latter at 20 units. If demand for the part in question is 15 units, a work order for 20 units (i.e., the minimum work order) will be opened. If the demand is 5 units, no work order will be opened and the demand will be ignored. 
 

 Note: If you are running MRP on the basis of separate work orders for each customer order, insufficient quantities are not combined. For example, if the threshold is set at 5 and you receive 3 orders for 4 units each, all 12 units will be ignored by MRP. If, on the other hand, you have defined a demand range within which these orders all fall, their demands are combined and a (single) work order is opened for 12 units. 
 
## To define the work order threshold:

 

 1 .  Enter the Purchase/MRP Parameters for Part form and retrieve the desired part. 
 

 2 .  Click the MRP Definitions tab. 
 

 3 .  In the Qty to NotOpen WkOrd column, record the minimum number of required units for which MRP is permitted to open a work order.
