# Vendor_Prices_9b_updating_prices_2

- **Source:** `Vendor_Prices_9b_updating_prices_2.htm`

Vendor Parts/Prices - Updating Prices According to Base Products 
 
 
- 
 
 
 
# Updating Prices According to Base Products

 

If a given price list contains a base product, you can define the price policy for that part as " 01 ", so that when you change its price manually, the price of all its linked parts is updated automatically, in accordance with the system-wide price policy: 
 

 ·        If linked parts are included in price lists (i.e., the value of the IPricePolicy constant is set to 0 ), changes to the base product price are automatically copied to any linked parts, provided their list price has not been revised manually. 
 

 ·        Alternatively, if the value of the IPricePolicy constant is set to 1 , price lists will only be maintained for the base product itself. When the system assigns a price to a linked part, it will take that price directly from its base product. 
 
## Note: 

 

Click to u pdate the value of the IPricePolicy constant. 
 
# To set up automatic price updates according to a base product:

 

 1 .  Enter the Part Catalogue form and retrieve the relevant base product. 
 

 2 .  Click the Prices & Costs tab. In the Price Policy column, choose " 01 ". 
 
# To update prices according to a base product:

 

 1 .  Enter the Vendor Price Lists form and retrieve the desired price list. 
 

 2 .  Move to the relevant base product in the Part Prices sub-level form and record the new price. All parts linked to the current base product are updated automatically. 
 
## Notes:

 

 ·        Click to view vendor prices per base product . 
 

 ·        Click to use other price list tools.
