# SalesOrd_16_bom

- **Source:** `SalesOrd_16_bom.htm`

Sales Orders - Building a Customized Bill of Materials 
 
 
- 
 
 
 
# Creating a Customized Bill of Materials for an Order Item

 

When an item in the sales order has a customized bill of materials, its cost is calculated in accordance with the costs of the designated child parts. Its price is also based on the prices of the child parts in the BOM, with the following exceptions: 
 

 ·        If the value of the SBOMPrice constant is set at 0 , the part price is taken from the usual price source instead of the customized BOM. 
 

 ·        If the unit price was recorded manually, it is not revised. 
 
## Notes:

 

 ·        If you want the customized bill of materials to affect a unit price that was originally recorded manually, delete that price (leaving the column empty) before creating the BOM. 
 

 ·        To check the value of the SBOMPrice constant, enter the Logistic Constants form. 
 
## To build a customized bill of materials for an ordered part:

 

 1 .  Select Create BOM for Order Item from the list of Direct Activations . 
 

 2 .  Enter the BOM for Order Item sub-level form to view the bill of materials. 
 

 3 .  Make any necessary changes in the bill of materials. You can revise, add and/or delete lines.
 Note: This affects the price and cost of the order item. As child parts are added, deleted or revised, the parent price and cost are updated automatically. 
 

 4 .  If the child part has its own children, select Replace Part with Its BOM from the list of Direct Activations . This program replaces the child part with its components, thus providing an accurate account of the part's price and cost. 
 

 5 .  Return to the Order Items form to view the updated price and cost.
 Note: The Price Source and Cost Source values will change to BOM for Item . 
 
## Note:

 

Custom BOMs for ordered parts can be displayed in the printout of the order confirmation, by selecting the With Custom BOM print format.
