# PQ_6_Custom_Bill

- **Source:** `PQ_6_Custom_Bill.htm`

Price Quotations - Creating a Customized Bill of Materials for a Quoted Item 
 
 
- 
 
 
 
# Creating a Customized Bill of Materials for a Quoted Item

 

When an item in the price quote has a customized bill of materials, its cost is calculated in accordance with the costs of the designated child parts. Its price is also based on the prices of the child parts in the BOM, with the following exceptions: 
 

 ·        If the value of the SBOMPrice constant is set at 0 , the part price is taken from the usual price source instead of the customized BOM. 
 

 ·        If the unit price was recorded manually, it is not revised. 
 
## Notes:

 

 ·        If you want the customized bill of materials to affect a unit price that was originally recorded manually, delete that price (leaving the column empty) before creating the BOM. 
 

 ·        To check the value of the SBOMPrice constant, enter the Logistic Constants form. 
 
## To create a bill of materials for a quoted item:

 

 1 .  Select Create BOM for Quoted Item from the list of Direct Activations . 
 

 2 .  Enter the BOM for Quoted Item sub-level form to view results. 
 

 3 .  Make the required adjustments to the BOM. Example. You can revise, add and/or delete lines. 
 

 4 .  If the child part has children of its own, select Replace Part with Its BOM from the list of Direct Activations . This program replaces the child part with its components, thus providing a more accurate account of the item's price and cost. 
 

 5 .  Return to the Itemized Quotation form to view updated prices and costs.
 Note: The Price Source and Cost Source values will change to BOM for Item . 
 
## Note:

 

Custom BOMs for quoted items can be displayed in the price quotation printout, by selecting the With Custom BOM print format.
