# Mdl_Part_Alternative

- **Source:** `Mdl_Part_Alternative.htm`

Modeling - Assigning Alternate Parts 
 
 
- 
 
 
 
# Alternate Parts

 

 Priority allows you to assign alternate parts that can be used when there are insufficient quantities of the original part. In order to use alternate parts, you must first set the appropriate planning constant. 
 
## To set up the system to use alternate parts:

 

 1 .   Enter the Planning Constants form and move to the UsePartAlt constant. 
 

 2 .  Set the value to 1 to allow alternate parts in kit lists, Backflush and MRP; set the value to 2 to allow alternate parts in kits lists and Backflush, but not in MRP. 
 
## To assign alternate parts:

 

 1 .  Enter the Parts form and retrieve the child part to which you want to assign alternates.
 Tip: Make sure that each alternate part has already been defined in the system. 
 

 2 .  Enter the Alternate Parts sub-level form. 
 

 3 .  For each Alternate Part , specify its catalogue number. 
 

 4 .  If the part in the upper-level form is a child of several different parent parts, and the current part may not be used as an alternate in all cases, specify the parent part for which the current alternate may be used in the Parent Part Number column. If the part may be used as an alternate for more than one parent, record a new line for each parent.
 Tip: To view the parent parts of the part in the upper-level form, enter the parallel Parent Parts sub-level form.
