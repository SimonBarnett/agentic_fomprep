# MRPMan_flagging_orders_automatic

- **Source:** `MRPMan_flagging_orders_automatic.htm`

MRP for Manufacturers - Flagging Order Items Automatically 
 
 
- 
 
 
 
# Flagging Order Items Automatically

 

You can run a special program that automatically flags order items for MRP, by order number or date. The program only flags those line items that fulfill the following conditions: 
 

 ·        The item is open (i.e., it has not been fully supplied) 
 

 ·        The item is not flagged with an N in the MRP column 
 

 ·        The part is defined as subject to inventory control 
 

 ·        The part's replenishment type is R ( dynamic demand ) 
 

 ·        Demand for the part is calculated on the basis of sales orders. 
 
## To flag order items:

 

 ·        Run the Retrieve Sales Orders - MRP program. All order items that meet the above conditions will be flagged with a Y in the MRP column. 
 
## Notes:

 

 ·        To prevent MRP from taking into account items in sales orders that have not yet been approved by the customer, mark those order items with an N in the MRP column of the Release Orders for Planning form. 
 

 ·        Click to check the results. 
 

 ·        Click to return to the main screen.
