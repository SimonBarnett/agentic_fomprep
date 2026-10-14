# ProdRep_example_of_floor_inv_calc

- **Source:** `ProdRep_example_of_floor_inv_calc.htm`

Production Report - Example of Inventory Calculations Based On Production Reports 
 
 
- 
 
 
 
# Example of Inventory Calculations Based on Production Reports

 

 1 .  The routing for the "Table" part includes the following operations: 
 

 ·              "Sawing": Entry of the child part "Board" (1:1) 
 

 ·              "Leg Attachment": Entry of the child part "Table Leg" (4:1) 
 

 2 .  A production report for the "Sawing" operation (for a quantity of 10 parts) results in the following changes to inventory: 
 

 ·              Addition of 10 units of "Table" in the "Sawing" operation 
 

 ·              Reduction of 10 units of "Board" 
 

 3 .  A production report for the "Leg Attachment" operation (for a quantity of 10 parts) results in the following changes to inventory: 
 

 ·              Addition of 10 units of "Table" in the "Leg Attachment" operation 
 

 ·              Reduction of 40 units of "Table Leg" 
 

 ·              Reduction of 10 units of "Table" in the "Sawing" operation 
 
## If the above operations were correctly reported, calculation of floor inventory will yield the following results:

 

 ·        Addition of 10 completed units of "Table" 
 

 ·        Reduction of 10 units of "Board" 
 

 ·        Reduction of 40 units of "Table Leg"
