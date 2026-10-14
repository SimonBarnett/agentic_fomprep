# CMNF_Results_Std_Costs

- **Source:** `CMNF_Results_Std_Costs.htm`

Costing for Manufacturers - Results: Standard Costs.1 
 
 
- 
 
 
 
# Standard Costs of Raw Materials and Manufactured Parts

 

The costing program calculates standard costs for both raw materials ( Buy items) and manufactured parts ( Make items). 
 

 ·        The standard cost of raw materials appears in the Part Catalogue and Parts - Std Costs forms, where they serve both as input data to standard costing calculations (together with standard shipping costs) and as default values for actual raw material costs. 
 

 ·        The standard cost of a manufactured part is composed of the following elements: 
 

 ·              The total cost of all purchased child parts (i.e., raw materials) used to produce it (according to the Standard Part Costs option chosen when running the Set Costing Parameters program). 
 

 ·              The total standard cost of all manufactured child parts (as calculated according to the same Standard Part Costs option). 
 

 ·              Standard production costs (direct and indirect), including the standard cost of labor, machines and setup for each operation in the part's routing. 
 

 ·              Additional standard costs incurred during production of the part and its child parts (e.g., subcontractor costs, non-standard costs, materials issued as supplies). 
 
## Note: 

 

If the standard cost of a Type R part has been revised manually in the Part Catalogue or Parts - Std Costs form, it does not affect costing calculations and is not updated by the costing program, with the exception of manufactured parts when the UpdStdCost constant is set to 1 .
