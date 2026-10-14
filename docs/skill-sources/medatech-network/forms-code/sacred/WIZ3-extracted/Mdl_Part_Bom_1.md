# Mdl_Part_Bom_1

- **Source:** `Mdl_Part_Bom_1.htm`

Modeling - Defining a BOM.1 
 
 
- 
 
 
 
## Before You Begin

 

Make sure that all parts (parent and children) are recorded in the Parts form. 
 
## To define a bill of materials:

 

 1 .   Enter the Parts form and retrieve the desired parent part. 
 

 2 .   Enter the Child Parts sub-level form and open a line for each child part.
 Note: Record only the parent's direct child parts. If a child part is itself a processed part, you need to retrieve it in the upper-level form and define its own child parts in the same manner. 
 

 3 .  For each child part, indicate the quantity of children required per unit of the parent: 
 

 ·      If the child/parent ratio is a fixed whole number, specify the number of child parts in the Qty(Child) column. C (for constant) will appear in the Operand column, and the Coefficient column will equal the specified quantity. 
 

 ·      If the ratio is a fixed fraction (i.e., it divides the given child quantity by more than one parent), adjust the Quantity (Parent) column in the Additional Details tab of the upper-level form accordingly. The resulting per parent ratio will appear in the Coefficient column. Example. 
 

 ·      If the ratio depends on the value of a variable, select the relevant Variable and Operand in addition to the child and parent quantities. Example. 
 Note: To define a new variable, use the Variables form.
