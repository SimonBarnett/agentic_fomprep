# PriceDiscounts_24_Updating_by_Base_Product

- **Source:** `PriceDiscounts_24_Updating_by_Base_Product.htm`

Prices and Discounts - Updating Prices According to a Base Product 
 
 
- 
 
 
 
# Updating Prices According to a Base Product

 

If a given price list contains a base product, you can define the price policy for that part as " 01 ", so that when you change its price manually, the price of all its linked parts is updated automatically, in accordance with the system-wide price policy: 
 

 ·        If linked parts are included in price lists (i.e., the value of the IPricePolicy constant is set to 0 ), changes to the base product price are automatically copied to any linked parts, provided their list price has not been revised manually. 
 

 ·        Alternatively, if the value of the IPricePolicy constant is set to 1 , price lists will only be maintained for the base product itself. When the system assigns a price to a linked part, it will take that price directly from its base product. 
 
## Note: 

 

Click to update the value of the IPricePolicy constant. 
 
# To set up automatic price updates for a base product:

 

 1 .  Enter the Part Catalogue form and retrieve the desired base product. 
 

 2 .  Click the Prices & Costs tab. In the Price Policy column, choose " 01 ". 
 
## To update prices according to a base product:

 

 1 .  Enter the Price Lists form and move to the desired price list. 
 

 2 .  Enter the Part Prices sub-level form, and revise the desired base product prices. All parts linked to that base product are updated automatically. 
 
## Note:

 

Click to view prices per base product.
