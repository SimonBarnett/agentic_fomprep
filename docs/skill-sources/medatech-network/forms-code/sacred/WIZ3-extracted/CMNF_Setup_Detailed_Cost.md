# CMNF_Setup_Detailed_Cost

- **Source:** `CMNF_Setup_Detailed_Cost.htm`

Costing for Manufacturers - Setup: Including the Costs of Processed Child Parts in Parent Costs 
 
 
- 
 
 
 
# Choosing How Processed Child Part Costs are Included in Work Order Costs of the Parent

 

 Priority allows you to choose the method by which the cost of processed child parts is added to the work order cost of the parent part. 
 

The first method adds the total child cost to the parent's raw material cost, using the cost of the child part on the date of its entry into the parent (calculated by FIFO or Moving Average). This option provides the most current cost data. 
 

The second method adds the component costs of the processed child part (e.g., materials, employees and machines, non-standard costs) to the component costs of the parent. This option allows you to calculate the total cost of each component in the production routing (e.g., the total cost of labor used to produce the final part, including manufactured child parts). This option, however, uses costing data calculated for the last past balance. 
 

These options only apply to processed parts with no work order number (i.e., the work number was removed after production, before the parts were issued). If the part is issued with a work order number, the program adds the current component costs of the processed child part (taken from the work order) to those of its parent, regardless of the chosen method. 
 
## To choose the method of adding processed child part costs to those of their parents:

 

 1 .  Enter the Financial Constants form and move to the DetailedCost constant. 
 

 2 .  Do one of the following: 
 

 ·              Leave the preset value of 0 to use the total cost of processed child parts as of their issue date. 
 

 ·              Change the value to 1 to preserve the cost breakdown of child parts as of the last past balance date.
