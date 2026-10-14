# MRPMan_explaining_MRP_Report

- **Source:** `MRPMan_explaining_MRP_Report.htm`

MRP for Manufacturers - Analyzing MRP Results.1 
 
 
- 
 
 
 
# Analyzing MRP Results

 

Both the report and the form display the data used by MRP to plan the work orders. This includes the following items: 
 

 Inventory: The existing inventory of a part at the time the program is run. Existing inventory includes parts: 
 

 ·        in type D warehouses 
 

 ·        with a status flagged for participation in planning 
 

 ·        that are not packed for a particular customer (if you chose the runtime option of taking packed inventory into account, it appears below in a separate category) 
 

 ·        are not in production (i.e., have completed their routing). 
 

 Note s : 
 

 ·      MRP only takes into account existing inventory of manufactured (Type P ) parts. Inventory of purchased (Type R ) parts is taken into account during purchase planning. 
 

 ·      If you ran MRP choosing the Consider Packed Inv runtime option, the program will take any inventory that was packed for a customer into account separately. 
 

 Inventory of Alternate Parts: Existing inventory of alternate parts. If the UsePart Alt planning constant is set to 1 , the program automatically takes into account the balances of those parts defined as alternatives to other parts, provided they fulfill the conditions listed above, under Inventory .
 Note: Analysis reports display results for alternate manufactured parts under the heading Invent for Alt Part . 
 

 Floor Stock: Existing inventory in plant floor warehouses. This includes inventory of processed parts in the middle of production, as well as raw materials issued in bulk (but not to a kit). 
 Note: MRP only takes floor inventory into account if you choose the relevant run-time option, and ignores any inventory whose status excludes it from MRP, or whose warehouse has been flagged for exclusion from MRP. 
 

 Inventory Packed for a Customer: Existing inventory of the part that has already been packed for a specific customer. 
 Note: MRP only takes this inventory into account when you choose the relevant run-time option. Packed inventory in any warehouse flagged as Ignored by Planning is disregarded. 
 

 Demand from Orders: The quantity of parts recorded in open sales orders and flagged for inclusion in MRP. Each order is displayed separately. The number of sales orders for which a single work order is opened is determined by the Combine into Wk Ords runtime option. This item only appears for parts of replenishment type R ( dynamic demand , in this case based on sales orders). 
 

 Demand for Fixed Quantity: The fixed quantity of parts to be produced at set intervals, according to the quantity and frequency defined for the part. This item only appears for processed parts of replenishment type B ( static demand ).
