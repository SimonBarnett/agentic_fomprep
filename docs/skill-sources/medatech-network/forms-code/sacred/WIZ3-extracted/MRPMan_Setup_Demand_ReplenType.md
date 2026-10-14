# MRPMan_Setup_Demand_ReplenType

- **Source:** `MRPMan_Setup_Demand_ReplenType.htm`

MRP for Manufacturers - Demand Setup: Replenishment Type 
 
 
- 
 
 
 
# Defining the Replenishment Type

 

Replenishment type determines the method used to calculate the required quantity of a given part: 
 

 ·        Replenishment Type R: Part demand is calculated dynamically, on the basis of sales and forecast orders. If the part is manufactured, you can choose to base demand calculations on open work orders, rather than sales orders. 
 

 ·        Replenishment Type B: Part demand is static; that is, the part is required in fixed amounts at regular intervals. If the part is purchased, MRP does not prepare issues for routine consumption; purchase planning opens requisitions directly for such parts, according to their defined consumption parameters. 
 

 Note: 
 

Replenishment type affects the calculation of direct demand for the part itself . In both cases, that demand is added to the quantities required by open or planned work orders for parent parts (which require the part in question as a child part), as well as to safety stock. 
 
## To define a part's replenishment type:

 

 1 .  Enter the Purchase/MRP Parameters for Part form, and retrieve the desired part. 
 

 2 .  In the Replenishment Type column (in the General tab), specify the desired value.
 Note: If you leave this column empty, MRP will not take the part into account. 
 

 3 .  Do one of the following: 
 

 ·      If the part is Type B , click the Planning Quantities tab. Specify the required quantity and the regular interval (in days) at which it is required (in the Required/Sold Qty and Freq. of Need/Sale columns, respectively). 
 

 ·      If the part is Type R , click the MRP Definitions tab. To calculate demand on the basis of open work orders, check the MRP by Wk Order column; to calculate it on the basis of sales orders, leave the column empty.
