# Backflush_Inventory_Control

- **Source:** `Backflush_Inventory_Control.htm`

Backflush - Inventory/Costing Control Settings 
 
 
- 
 
 
 
# Inventory/Costing Control Settings

 

The basic process performed by the Backflush program is determined by the inventory/costing control method assigned to the reported operation (in the Inv./Costing Control column): 
 
## Setting R

 

 R indicates an operation subject to both inventory control and costing. Its execution must be reported (in a production report). Parent parts are added in this operation (and reduced in the previous operation) according to the reported quantity; child parts are reduced proportionally. 
 
## Setting C/No Setting

 

 C indicates an operation that does not affect inventory, yet must be reported in order for its costs to be taken into account. The Backflush program ignores production reports for such an operation. 
 

When no control setting is assigned (i.e., the column is empty), the Backflush program ignores production reports recorded for the operation, and its actual production costs are not taken into account during costing. However, standard production costs defined for the operation are taken into account automatically by costing, independently of the production report. 
 
## Setting T/L

 

 L operations can be performed either on the plant floor or by a subcontractor. When performed on the plant floor, they are treated like R operations. T operations are always performed by a subcontractor, and are assigned to the last operation performed before the part is returned. All other operations are assigned L . 
 

When the processed parts are received from the subcontractor, the T operation is recorded in a GRV. Consequently, the Backflush reduces all the child parts needed for the entire series of operations performed by the subcontractor, and adds the received parts to the parent inventory, in the T operation. 
 
## Note:

 

If child parts are linked to L or C operations, they are reduced from inventory by the next production report recorded for an R operation.
