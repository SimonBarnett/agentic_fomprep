# Subcont_Setup_BOM_2

- **Source:** `Subcont_Setup_BOM_2.htm`

Working With Subcontractors - Adjusting a Bill of Materials for a Subcontractor 
 
 
- 
 
 
 
# To adjust a subcontractor's bill of materials:

 

 1 .  Run the Create BOM for Subcontractors program. This program prepares a copy of the part's standard BOM for each of the designated subcontractors, expanded to all depths (including sub-components of processed child parts).
 Note: If you only want to flag one or two child parts, you can skip this step and record them manually. 
 

 2 .  Enter the BOMs for Subcontractors form. This form displays a line for each child part needed to produce the parent part (or parts) for which you ran the Create BOM for Subcontractors program, for each designated subcontractor. 
 

 3 .  Retrieve the BOM lines created for the desired subcontractor, using the Subcontractor Number column. 
 

 4 .  In the Phantom/No Issue column, specify the appropriate setting for each child part: 
 

 ·      If the subcontractor produces the child part from components you supply, choose P . Explanation. 
 

 ·      If the subcontractor acquires the child part independently or otherwise does not need it, choose N . 
 

 ·      If you supply the child part to this subcontractor, leave the column empty. 
 

 5 .  In the Effect Date column, specify the date from which the above setting goes into effect for the current part and subcontractor. MRP will only take this BOM into account for work orders opened (for this subcontractor) on or after this date.
 Note: If you know that the BOM is going to change on a given date (e.g., as of June 1 you will return to providing this component to the subcontractor), use the In Effect Until column instead. The Effect Date will be deleted automatically. 
 
## Note:

 

Click to perform additional setups.
