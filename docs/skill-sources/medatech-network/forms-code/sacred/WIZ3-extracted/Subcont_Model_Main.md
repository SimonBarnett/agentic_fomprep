# Subcont_Model_Main

- **Source:** `Subcont_Model_Main.htm`

Working With Subcontractors - Modeling Production Operations.1 
 
 
- 
 
 
 
# Modeling Production Operations for Subcontractors

 

The procedure for modeling production operations performed by subcontractors varies when: 
 

 ·        The operation is always performed by the same subcontractor 
 

 ·        The operation is always performed by any of several subcontractors 
 

 ·        The operation is sometimes performed in the factory, and sometimes by one or several subcontractors. 
 

You can also define an operation to be performed by a subcontractor in a specific work order, even if it is not so defined in the part's standard production routing. 
 
## Choosing the Inventory/Costing Control Setting

 

The production process inside the factory is subject to strict inventory control; consequently, every operation performed in the factory usually represents a single stage of production, and creates an inventory transaction (e.g., reduction of child parts, change of operation) when it is reported. 
 

By contrast, production by a subcontractor does not require this kind of control, and the operations they perform may represent a series of production steps. 
 

To define a series of operations that is sometimes performed in the factory and sometimes by a subcontractor, you need to use the inventory/costing control setting to distinguish the last operation in the series ( T ) from the first and intermediate operations ( L ). Explanation.
