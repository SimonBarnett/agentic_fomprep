# ord_profit_ord_bom

- **Source:** `ord_profit_ord_bom.htm`

Profitability - When Preparing a Sales Order.2 
 
 
- 
 
 
 
# Creating a Customized Bill of Materials for an Order Item

 

When an item in the sales order has a customized bill of materials, its cost and price are calculated in accordance with the costs of the designated child parts, except under the following circumstances: 
 

 ·        If a cost or price was recorded manually. 
 

 ·        If the SBOMPrice constant is set to 0 (in the the Logistic Constants form), in which case only the cost is updated, but not the price. 
 
## To create a bill of materials for an order item:

 

 1 .  Enter the Order Items sub-level form, and move to the desired item. 
 

 2 .  Select Create BOM for Order Item from the list of Direct Activation s . 
 

 3 .  Enter the BOM for Order Item sub-level form to view results. 
 

 4 .  Make the required adjustments to the BOM. Example. You can revise, add and/or delete lines.
 Note: You may be limited in the child parts you are allowed to delete. 
 

 5 .  If the child part has children of its own, select Replace Part with Its BOM from the list of Direct Activation s . This program replaces the child part with its components, thus providing a more accurate account of the item's price and cost. 
 

 6 .  Return to the Order Items form to view updated prices and costs.
 Notes: 
 

 ·              The Price Source and Cost Source values will change to BOM for Item . 
 

 ·              If the cost of the ordered item was recorded manually and you want to replace it with the cost of component parts, select Calculate Price/Cost by BOM from the list of Direct Activation s . 
 

 ·              If the price of the item was recorded manually, you can replace it with the price of component parts by selecting Calculate Price/Cost by BOM from the list of Direct Activation s , but only when the SBOMPrice constant is set to 1 .
