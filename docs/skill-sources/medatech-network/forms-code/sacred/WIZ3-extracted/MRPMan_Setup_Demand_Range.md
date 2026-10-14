# MRPMan_Setup_Demand_Range

- **Source:** `MRPMan_Setup_Demand_Range.htm`

MRP for Manufacturers - Demand Setup: Demand Range 
 
 
- 
 
 
 
# To define a part's demand range:

 

 1 .  Enter the Purchase/MRP Parameters for Part form and retrieve the desired part. 
 

 2 .  Click the Planning Quantities tab. 
 

 3 .  In the Demand Range column, record the time span (in days) for which you want to calculate one unified demand. 
 
## Notes:

 

 ·        To create a monthly demand (i.e., to open a single work order for the part each calendar month), define a demand range of 31 days. 
 

 ·        The Demand Range column defines the period within which MRP aggregates all demands for the part in question into a single work order. If you leave the default value of 0 , a separate work order is opened for each demand (for example, a sales order). 
 

 ·        MRP takes demand range into account when opening planned work orders for manufactured parts. The demand range of purchased parts is taken into account by purchase planning, during the preparation of purchase requisitions. 
 

 ·        When running MRP, you can choose between referring to the demand range defined for each part individually, or to aggregate demand for all parts on a monthly basis, regardless of the defined range.
