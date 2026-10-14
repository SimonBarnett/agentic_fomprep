# Mdl_Phantom

- **Source:** `Mdl_Phantom.htm`

Modeling - Defining Phantom Parts 
 
 
- 
 
 
 
# To define a phantom part:

 

 1 .   Enter the Parts form. 
 

 2 .   Specify the Part Number and Description of your phantom. 
 

 3 .   In the General tab, specify P in the Type column. 
 

 4 .   In the Routing column, specify the predefined Phanto routing. 
 

 5 .   Enter the Child Parts sub-level form and record all the child parts in this set. 
 

 6 .  Return to the upper-level form and retrieve each parent that requires this particular set of children. Assign the new phantom as its child part. 
 
## Note:

 

Work orders are never opened for phantoms; whenever such a part appears in a kit list, the system skips over it and issues its child parts directly. Similarly, phantoms do not appear in production reports; again, the system skips over them and reduces inventory from its child parts directly. The costing program also ignores phantoms.
