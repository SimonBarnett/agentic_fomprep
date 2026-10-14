# MRPMan_Setup_W_O_WorkPlan_2

- **Source:** `MRPMan_Setup_W_O_WorkPlan_2.htm`

MRP for Manufacturers - Work Order Setup: Timing Parameters per Operation.2 
 
 
- 
 
 
 
## To define operation parameters governing production time and quantity:

 

 1 .  Enter one of the following forms: 
 

 ·      For the operation itself, enter the Operations form. 
 

 ·      For the operation in a specific routing, enter the Routings form, retrieve the desired routing and enter the Operations in Routing sub-level form. 
 

 ·      For the operation in a specific work order routing, enter the Work Orders form, retrieve the desired work order and enter the Routing for the Work Order sub-level form. 
 

 2 .  Retrieve the desired operation (or move to the appropriate line). Do one of the following: 
 

 ·      If the operation is performed in batches , flag the MRP-Time per Batch column. Then, record the batch quantity and the time span required for its production in the MRP-Production Time and MRP-Production Qty columns. 
 

 ·      Otherwise, record the production quantity and time in the MRP-Production Time and MRP-Production Qty columns. 
 

 3 .  In the MRP %Overlap w/Child column, specify the percentage by which the current operation is permitted to overlap with the previous one. If the operation is the first in the routing, this value indicates the percentage of parent parts that can undergo that operation at the same time that the last operation is performed on any child parts. MRP will time the operations according to the recorded percentage. Example. 
 

 4 .  If the production resources at your disposal allow you to produce more than one quantity of parts in parallel, specify the number of simultaneous quantities in the MRP-Workers/Machines column. Explanation. 
 
## Notes:

 

 ·        If you have manually recorded production timing values for a part, these values are no longer updated by operation timing values. Click to learn how to return to automatic updating of the timing parameters on the basis of operation values. 
 

 ·        Click to perform additional work order setups.
