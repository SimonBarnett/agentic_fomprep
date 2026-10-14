# ProdRep_exp_inv_operations

- **Source:** `ProdRep_exp_inv_operations.htm`

Production Report - Operations that Require Reporting.1 
 
 
- 
 
 
 
# Operations That Require Reporting

 

Operations subject to inventory control (as defined in the Inv./Costing Control column) must be recorded in production reports (or subcontractor GRVs for T operations). If you do not report such an operation, the child parts issued to the parent in that operation will not be reduced from inventory, and negative inventory of the parent will be created in that operation when the following operation is reported. 
 

Operations subject to costing control must also be reported, in order to add the actual costs of the operation to the cost of the work order. 
 

There are five possible settings for inventory/costing control, which determine how production reports affect inventory and/or costing: 
 

 ·        R : The operation is subject to inventory control and is always performed in the factory; it is taken into account in inventory calculations and costing and must be reported. 
 

 ·        C : The operation is not subject to inventory control and is only taken into account for costing purposes. Reporting a C operation adds actual production costs to the cost of the work order, but does not affect inventory. Child parts that enter their parent parts in a C operation are only reduced from inventory when production is reported for the next operation that is defined for inventory control. Consequently, non-reporting affects costing, but does not generate negative inventory in the operation. 
 

 ·        L : The operation is sometimes performed in the factory and sometimes performed by a subcontractor. In the former case, you must report production in order to update inventory balances, and to add actual production costs to the cost of the work order. In the latter case, it is part of a series of operations performed by the subcontractor and is not the last one in the series. A GRV should therefore not be recorded for parts in this operation. 
 

 ·        T : The operation is performed by a subcontractor. It is the last in a series of operations performed by the subcontractor, and is reported by recording receipt of the parts in a GRV. 
 

 ·        Leaving the Inv./Costing Control column empty indicates that the operation is not intended for reporting. If you record a production report for such an operation, it will not affect inventory, and actual production costs will not be taken into account by costing. However, standard production costs defined for the operation will be taken into account automatically by costing, independently of the production report.
