# ProdRep_setup_warehouse_transfer

- **Source:** `ProdRep_setup_warehouse_transfer.htm`

Production Report - Setup: Automatic Warehouse Entry.1 
 
 
- 
 
 
 
# Setting Up Automatic Warehouse Entry

 

Once production of the work order has been completed, the Backflush program automatically transfers the finished parts from the plant floor to the factory warehouse designated in the production report. Furthermore, you can define whether all of the finished parts are transferred to the factory warehouse, including rejected parts and parts referred to MRB, or only parts that have been assigned the Goods status. 
 

In cases where you choose not to use this mechanism, you need to record a warehouse transfer. 
 

Automatic warehouse entry is triggered by the designation of a target warehouse in the production report for a particular operation; this designation is taken from the work order routing, which in turn is taken from the part routing, though it can be revised at every stage. The Backflush program then transfers the finished parts automatically to the designated warehouse. 
 

When the last reported operation is the last operation in the routing, the Backflush program automatically saves the work order number in the transferred inventory. You can also flag an operation for removal of the operation code and/or the work order number while reporting production. If you want these definitions to be made automatically in the production report, you need to define them in the part routing or the work order routing. 
 
## What do you want to do?

 

 Define automatic warehouse entry in the part routing 
 

 Define automatic warehouse entry in the work order routing
