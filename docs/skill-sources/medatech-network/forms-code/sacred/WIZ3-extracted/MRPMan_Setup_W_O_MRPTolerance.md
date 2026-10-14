# MRPMan_Setup_W_O_MRPTolerance

- **Source:** `MRPMan_Setup_W_O_MRPTolerance.htm`

MRP for Manufacturers - Work Order Setup: Tolerance 
 
 
- 
 
 
 
# Setting Up Work Order Tolerance

 

The MRPTolerance constant allows you to define a time range, within which a new work order will not be opened if a work order is already open for that part, even if the completion date of the existing work order is later than the due date of the sales order it is supposed to fill. This can occur when a work order is opened to fill a sales order whose due date is moved up after the work order has already been released. 
 

It also determines the number of days the due date of a purchase order (for a processed part ordered from a vendor that is not a subcontractor) may lag behind the start date of a work order and still be considered available inventory for that work order. Example. 
 
## To set work order tolerance:

 

 1 .  In the Production Constants form, move to the MRPTolerance constant. 
 

 2 .  In the Value column, enter the maximum number of days that the end date of an open work order may lag behind the due date of the sales order for which it was originally opened, or its start date may precede the due date of the purchase order for which it was opened. 
 

 Notes: 
 

 ·        Work orders whose end dates fall beyond the assigned tolerance range are not taken into account during MRP calculations, and appear in MRP results under the heading Surplus Work Orders . 
 

 ·        Purchase orders that fall beyond the tolerance range of work orders nonetheless remain open and (assuming the order is for type R parts) will appear in purchase recommendation reports. 
 

 ·        The constant does not affect the opening of purchase requisitions, nor the way the system takes purchase orders for type R parts into account.
