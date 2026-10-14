# Ord_Profit_SetPrice_Custom_BOM

- **Source:** `Ord_Profit_SetPrice_Custom_BOM.htm`

Profitability - Setting Prices in a Customized BOM 
 
 
- 
 
 
 
# Setting Prices in a Customized BOM

 

When an item in a price quote or order has a customized bill of materials, the SBOMPrice constant determines whether the part price is calculated from the prices of the child parts in the custom BOM, or derived from the usual sources (e.g., price list, order price). 
 
## To set the constant value:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the line for the SBOMPrice constant, and do one of the following: 
 

 ·              Leave the preset value of 1 to calculate part prices from the prices of the child parts in the customized bill of materials. 
 

 ·              Change the value to 0 to ignore the custom BOM and assign part prices in the usual manner. 
 
## Note:

 

Part cost is not affected by this constant; unless the original parent cost was recorded manually, it is always updated by the cost of its child parts in the custom BOM. You can also run a Direct Activation from the itemized price quote or sales order, which updates the part cost even if it was recorded manually. If the SBOMPrice constant is set to 1 , the same program updates manual part prices as well.
