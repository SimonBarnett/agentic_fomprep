# ProdRep_floor_inventory_missing_inv_of_parent

- **Source:** `ProdRep_floor_inventory_missing_inv_of_parent.htm`

Production Report - Calculating Floor Inventory: Negative Quantities of Parent Parts 
 
 
- 
 
 
 
# Calculating Floor Inventory: Negative Quantities of Parts

 

The Backflush program calculates plant-floor inventory on the basis of production report data (as well as other data, such as issues, shipments to subcontractors and receipts from subcontractors). 
 

The program reduces the inventory of the part in the operation previous to the one reported. If for some reason the previous operation was not reported, or reported a smaller quantity of parts than that reported in the current operation, a negative inventory balance is created for the part in the previous operation. Example. 
 
## Note:

 

For more information about floor inventory calculations, run the Backflush Wizard .
