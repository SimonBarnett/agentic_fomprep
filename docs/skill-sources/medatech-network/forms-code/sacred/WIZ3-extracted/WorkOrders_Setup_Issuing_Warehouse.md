# WorkOrders_Setup_Issuing_Warehouse

- **Source:** `WorkOrders_Setup_Issuing_Warehouse.htm`

Work Orders - Setup: Issuing Warehouse 
 
 
- 
 
 
 
# Defining the Issuing Warehouse

 

An issuing warehouse is used to store kit components needed on a particular plant floor (for all work orders) or needed for a particular work order. It must be of type D and have a 0 bin defined (other bins may be defined as well). You should define an issuing warehouse for a given plant floor/work order whenever kit components should be taken solely from that warehouse. When you issue to a kit, the system will only take into account inventory in that warehouse (including alternate parts, when needed), in all its bins, when creating the issues and calculating warehouse balances for each kit component. Example. 
 
## To define a plant floor's issuing warehouse:

 

 1 .  Enter the Warehouses form and retrieve the warehouse from which issues to kits are to be taken. Make sure a 0 bin is defined for it.
 Note: If there is no 0 bin for the warehouse, add a new line for the warehouse with bin 0 . 
 

 2 .  Retrieve the floor warehouse in question, and record the code of the Issuing Warehouse (in the General tab). 
 
## To define a work order's issuing warehouse:

 

 1 .  Enter the Work Orders form and retrieve the work order in question. 
 

 2 .  Move to the Prod. Data tab and specify the warehouse from which issues to kits are to be taken in the Issuing Warehouse column. 
 
## Note:

 

The issuing warehouse defined for a work order overrides the issuing warehouse defined for an entire plant floor.
