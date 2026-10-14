# MRPMan_Info_Preparing_W_O

- **Source:** `MRPMan_Info_Preparing_W_O.htm`

MRP for Manufacturers - Info: Preparing Work Orders 
 
 
- 
 
 
 
# Preparing Work Orders

 

MRP plans work orders to supply the calculated part demand. The number of work orders largely depends on the method used to combine part demand: monthly unification for each part or unification within the demand range defined for each part. When no demand range has been defined (the demand range is 0 ), the program opens a separate work order for each demand. MRP does not plan work orders for assembled parts (i.e., parts with Assembly routings). 
 

The quantity of each work order is subject to various constraints, such as the maximum and minimum work order size defined for the part. 
 

The production end date of a work order corresponds to the date on which the part is needed (e.g., the due date of a sales order). The production start date is determined by the end date and the amount of time required to produce the work order quantity (according to the MRP parameters defined for the part or its operations). 
 

When a part is produced by a subcontractor, MRP opens work orders according to the priority and production capacity defined for each subcontractor. By ranking your own factory together with the subcontractors, you can set up MRP to assign the overflow from your own plant floor to the next ranking subcontractor; conversely, you can assign to your floor any quantities that could not be produced by a subcontractor.
