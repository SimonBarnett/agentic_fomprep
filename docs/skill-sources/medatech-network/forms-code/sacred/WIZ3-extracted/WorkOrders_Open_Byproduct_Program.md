# WorkOrders_Open_Byproduct_Program

- **Source:** `WorkOrders_Open_Byproduct_Program.htm`

Work Orders - Opening Work Orders for Byproducts.2 
 
 
- 
 
 
 
# Before you begin:

 

 ·        Enter the Assign WO/Lot Templates to Parts form. Make sure each of the byproducts is assigned a work order template and is flagged in the Open Automatically column. 
 

 ·        If there is more than one possible set of byproducts for a given source part, enter the Parts form and make sure that one byproduct from each set is defined as the Main Byproduct for each byproduct. 
 
## To open work orders for the source part and its byproducts:

 

 1 .  Enter the Work Orders form. 
 

 2 .  Open a work order for one of the byproducts in question. If there is more than one possible set of byproducts for the same source part, choose a part from the appropriate set. 
 

 3 .  Select Prepare Byproduct Work Orders from the list of Direct Activations . This program will open work orders for the source part and all of its remaining byproducts automatically.
 Note: Make sure that the WorkOrdNum constant (in the Production Constants form) has been set to 1 , to allow work orders to be opened automatically. 
 
## Notes:

 

 ·        To view the open work orders, retrieve the source part in the Work Orders form and enter the Work Orders of Byproducts sub-level form. 
 

 ·        Click to return to the main screen.
