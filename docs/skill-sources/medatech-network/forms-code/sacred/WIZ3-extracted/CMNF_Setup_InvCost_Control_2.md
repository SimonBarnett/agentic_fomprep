# CMNF_Setup_InvCost_Control_2

- **Source:** `CMNF_Setup_InvCost_Control_2.htm`

Costing for Manufacturers - Setup: Inventory/Costing Control.2 
 
 
- 
 
 
 

There are five possible Inventory/Costing Control settings: 
 

 ·        R : The operation is subject to inventory control and is always performed in the factory; it is taken into account in inventory calculations and costing and must be reported. When reported, inventory is created in the reported operation, and the raw materials issued to the operation are reduced accordingly. Material and production costs are added to the cost of the work order. 
 

 ·        C : The operation is not subject to inventory control and is only taken into account for costing purposes. That is, material and production costs are added to the cost of the work order when a "C" operation is reported, but no new inventory is created for this operation and the inventory of raw materials is not reduced (materials defined for issue to a "C" operation are reduced when the next "T" or "R" operation is reported). Conversely, no negative inventory balances occur if you do not report the operation. 
 

 ·        T : The operation is always performed by a subcontractor. It is the last in a series of operations performed by the subcontractor, and is reported by recording a GRV for the manufactured parts. When a GRV from a subcontractor is recorded, inventory is created for the operation, and the raw materials issued to the operation are reduced accordingly. Material and production costs are added to the cost of the work order. 
 

 ·        L : The operation is sometimes performed in the factory, and sometimes performed by a subcontractor, as an intermediate step in a multi-step process. 
 

 ·              When performed in the factory and reported, inventory is created in the reported operation, and the raw materials issued to the operation are reduced accordingly. Material and production costs are added to the cost of the work order. 
 

 ·              When performed by a subcontractor, the operation is not reported until a subsequent "T" operation is performed. When the subcontractor completes the assigned operations and a GRV is recorded for the received parts, any parts that were issued to intermediate "L" operations are now reduced from inventory, and their material and production costs are added to the cost of the work order. 
 

 ·        Blank: If no inventory/costing control setting has been assigned to an operation in a work order routing, and no settings have been assigned to either the operation itself or to the work cell in which it is performed, the standard cost of the operation is automatically added to the actual cost of the work order, whether or not that operation is reported in a production report.
