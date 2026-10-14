# MRPMan_Setup_Demand_SafetyStock

- **Source:** `MRPMan_Setup_Demand_SafetyStock.htm`

MRP for Manufacturers - Demand Setup: Safety Stock 
 
 
- 
 
 
 
# To define a part's safety stock:

 

 1 .  Enter the Purchase/MRP Parameters for Part form and retrieve the desired part. 
 

 2 .  Click the Planning Quantities tab. 
 

 3 .  In the Safety Stock column, record the quantity of parts that must always be maintained in inventory. 
 
## Note:

 

MRP only takes into account safety stock that is defined for manufactured parts. When safety stock is defined for a purchased part, it is taken into account during purchase planning, in the following manner: beginning from the date of the planning run, and on the date of every issue opened by MRP, the plan ensures that the part's inventory balance does not fall below the minimum defined as safety stock. If a deviation occurs, a purchase requisition is opened automatically, to return part inventory to the defined level.
