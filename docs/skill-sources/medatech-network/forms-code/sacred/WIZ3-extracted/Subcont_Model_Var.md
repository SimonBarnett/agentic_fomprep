# Subcont_Model_Var

- **Source:** `Subcont_Model_Var.htm`

Working With Subcontractors - Operations Sometimes Performed by Subcontractors.1 
 
 
- 
 
 
 
# Modeling Operations that are Sometimes Performed by a Subcontractor

 

Define all possible variations of the operation separately – one operation for production in the factory, and one for each subcontractor that can perform the operation, specifying the relevant work cell and plant-floor warehouse. 
 
## To model a single operation that is sometimes performed by a subcontractor:

 

 ·        Define the operation for the work cell linked to a warehouse in your factory, and flagged with an R in the Inventory/Costing Control column. 
 

 ·        Define the same operation again for the work cell linked to a subcontractor warehouse, and flagged with a T in the Inventory/Costing Control column.
 Note: If there is more than one subcontractor, each with a separate warehouse, define an operation and work cell for each warehouse, flagged with a T . 
 
## Modeling a series of operations

 

To model a series of operations where the final operation is always performed by a subcontractor, and where intermediate operations are sometimes performed by a subcontractor: 
 

 1 .  Define the first operation in the series, once for the factory and once for each subcontractor linked to a separate warehouse, as above. 
 

 2 .  Define the intermediate operations, for the factory and for the subcontractors, specifying L in the Inventory/Costing Control column. 
 

 3 .  Define the last operation for the subcontractor, specifying T in the Inventory/Costing Control column.
