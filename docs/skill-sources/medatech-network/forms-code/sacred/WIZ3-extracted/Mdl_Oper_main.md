# Mdl_Oper_main

- **Source:** `Mdl_Oper_main.htm`

Modeling - Defining Operations.1 
 
 
- 
 
 
 
# To define an operation:

 

 1 .  Enter the Operations form. 
 

 2 .  For each new operation, specify an identifying code and description. 
 

 3 .  Specify the Work Cell in which this operation is performed. 
 

 4 .  If inventory and costing control for this operation is the same as that defined for the work cell, leave the Inv./Costing Control column blank. Otherwise, select the appropriate value: 
 

 ·      Select R if production is always reported, inventory is maintained and actual costing is calculated for this operation. 
 

 ·      Select T if the operation is the last of a series of operations performed by a subcontractor (in which case it affects inventory and costing). 
 

 ·      Select L if the operation performed at this work cell is sometimes (or always) sent out to a subcontractor and if it is in the middle of such a series. 
 

 ·      Select C for actual costing only (inventory balances are not maintained).
 Note: Do not use this setting if you intend to run COGS. 
 

 5 .  If there are similar operations that may be performed in other work cells in place of the current one, enter the Alternate Operations sub-level form and specify each operation on a separate line. If you do not want the planning programs to take an alternate operation into account, flag the Ignore When Planning column.
