# Costing_exp_assembled_parts

- **Source:** `Costing_exp_assembled_parts.htm`

Costing for Businesses - Costing Assembled Parts 
 
 
- 
 
 
 
# Costing Assembled Parts

 

Every warehouse assembly involves the entry of a raw material (child part) into the assembled part (type P ). The quantities of child parts are usually determined by the assembled part's standard bill of materials. However, it is possible to specify different quantities manually for each specific assembly. 
 

The actual and standard costs of an assembled part are calculated as follows: 
 

 ·        Actual cost: According to the average cost (FIFO or Moving Average) of the part's inventory balance on the last past balance date, and the cost of any additional inventory transactions during the current balance period. Inventory receipt transactions of assembled parts are usually the result of assemby transactions, whose cost is calculated according to the cost of the issued child parts, together with the cost of the work hours reported in the assembly report. 
 

 ·        Standard cost: According to quantities in the bill of materials and either the standard or actual costs of the child parts, as determined by the method defined in the Set Costing Parameters program. 
 

These two values, actual cost and standard cost, are displayed side by side in the Product Costing form, and can be printed out in various reports. 
 

Assembly transaction costs are weighted according to the chosen costing method (FIFO or Moving Average), in order to establish the part's cost for that costing period. 
 
## Notes:

 

 ·        The standard costs appearing in the Product Costing form are calculated for each costing run on the basis of the available data. These values may differ from the standard costs appearing in the Part Catalogue or Standard Costs form. For Type R parts, the standard costs appearing in these forms are defined by the user, and are not updated by the costing program. For Type P parts, standard costs are updated when the UpdStdCost constant is set to 1 ; otherwise, the forms display a standard cost of 0 , or one entered manually by the user, which is irrelevant to costing calculations. 
 

 ·        If an assembled part is purchased from a vendor, the cost of entering inventory is determined according to the cost source hierarchy.
