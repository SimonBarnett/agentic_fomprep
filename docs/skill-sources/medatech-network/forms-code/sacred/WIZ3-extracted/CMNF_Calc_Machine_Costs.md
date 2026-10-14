# CMNF_Calc_Machine_Costs

- **Source:** `CMNF_Calc_Machine_Costs.htm`

Costing for Manufacturers - Calculating Production Costs: Machines 
 
 
- 
 
 
 
# Machine Costs

 
## Step 1: Actual Cost per Work Order

 

For each work order, actual machine costs are calculated on the basis of work time, as recorded in production reports. 
 

For example, if the direct cost of one machine hour in Work Cell X is $50, and 3 hours were reported for Work Order 0011 for an operation in that work cell, the work order's direct machine cost will be $150. If the indirect cost of one work hour in Work Cell X is $10, an indirect cost of $30 will be added to the work order cost. 
 

The machine cost of Work Cell X for Work Order 0011 will thus be $180. The same calculations will then be performed for all other work cells included in the work order routing (and in the work order routings of any manufactured child parts). 
 
## Note:

 

If production reports record a break (i.e., a B appears in the Set - up/Break column for the reported operation), break times are added to the work order's machine and labor times, which are used to calculate actual direct and indirect machine and labor costs. 
 
## Step 2: Actual Cost Per Work Order Item

 

Machine costs for one part unit are calculated by dividing the overall cost of the work cell for that work order by the quantity of finished parts. If, for example: 
 

 ·        The part's bill of materials contains only raw materials (that is, there are no manufactured child parts with their own machine costs), 
 

 ·        Work Order 0011 is manufactured entirely at Work Cell X , 
 

 ·        100 finished parts were produced for Work Order 0011 , 
 

the work cell's machine cost for one part unit will be $1.80. 
 
## Step 3: Average Machine Cost

 

The actual machine cost for one part unit is determined by calculating the total machine cost of all closed work orders for that part, and dividing it by the number of finished parts.
