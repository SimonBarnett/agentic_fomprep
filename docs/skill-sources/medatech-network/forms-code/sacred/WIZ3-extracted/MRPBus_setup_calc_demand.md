# MRPBus_setup_calc_demand

- **Source:** `MRPBus_setup_calc_demand.htm`

MRP for Distributors - Setup: Replenishment Type 
 
 
- 
 
 
 
# Defining the Replenishment Type

 

The Replenishment Type determines the method used to calculate the required quantity of purchased goods. 
 

 ·      Replenishment Type R: Part demand is calculated dynamically, on the basis of incoming sales and forecast orders, either for the part itself or for its immediate parent. 
 

 ·      Replenishment Type B: Part demand is static; that is, the part is required in fixed amounts at regular intervals. Purchase planning ignores planned issues of such parts, instead using the part`s defined routine demand. 
 
## To define a part`s replenishment type:

 

 1 .  Enter the Purchase/MRP Parameters for Part form, and retrieve the desired part. 
 

 2 .  In the Replenishment Type column (in the General tab), specify the desired value.
 Note: If you leave this column empty, purchase planning will not take the part into account. 
 

 3 .  If you have chosen Type B , click the Planning Quantities tab. Specify the required quantity (in buy/sell units) and the regular interval (in days) at which it is required (in the Required/Sold Qty and Freq. of Need/Sale columns, respectively).
 Note: This data will be used by the Purchase Planning program to create purchase requisitions for the required parts.
