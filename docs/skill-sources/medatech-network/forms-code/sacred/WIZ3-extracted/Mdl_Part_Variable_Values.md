# Mdl_Part_Variable_Values

- **Source:** `Mdl_Part_Variable_Values.htm`

Modeling - Assigning Variable Values to a Part 
 
 
- 
 
 
 
# Assigning Variable Parameter Values per Part

 

If you use variables to modify processing parameters in an operation or child part quantities in a BOM, you need to assign values for those variables to each part that they affect. 
 

For example, the machine time required for the Sawing operation will be greater for a wider board, and the quantity of lacquer required for the Polishing operation will be higher. Variables allow you to adjust production parameters to correspond to the specific attributes of each part. Example. 
 
## To assign values to a part:

 

 1 .   Enter the Parts form and retrieve the desired part.
 Note: To modify child/parent ratios, retrieve the parent part. 
 

 2 .   Enter the Part Processing Parameters sub-level form. 
 

 3 .  Any processing parameters defined for operations in the part's routing (or for parts in the BOM) appear automatically with their variables. Specify the Value of each variable.
 Note: If the variable modifies a child/parent ratio, the Operation displayed is the parent operation in which the parent and child are joined. 
 
## Note:

 

If one of the defined variables ceases to be valid for this part, you can deactivate it by removing the check mark from the Valid column.
