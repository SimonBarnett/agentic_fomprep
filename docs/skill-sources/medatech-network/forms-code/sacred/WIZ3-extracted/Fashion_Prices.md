# Fashion_Prices

- **Source:** `Fashion_Prices.htm`

Fashion - Maintaining Price Lists for Fashion Items.1 
 
 
- 
 
 
 
# Maintaining Prices for Fashion Merchandise 

 

Price lists (either yours or a vendor's) provide several methods of controlling the price of fashion items automatically through their styles. 
 
## Setting up the Price Policy for a Style

 

You can define the style's price policy so that the prices of all parts in the same style, or all parts in the same color and style, share the same price. When recording the list of styles in a given transaction document (e.g., an order), prices will appear for each line in the assortment in keeping with the policy. 
 
## To set up the price policy for a style:

 

 1 .  Enter the Part Catalogue form and retrieve the desired style. 
 

 2 .  Click the Prices & Costs tab. In the Price Policy column, select 01 to maintain the same price for all parts in this style or 02 to maintain the same price for all parts in this color and style. 
 
## Note: If you select 02 , enter the Part Colors (Fashion) sub-level form and record the main color part that will determine the prices for the entire set. 

 

When a given style is assigned a Price Policy of 01 , the IPricePolicy constant determines whether the price of each part in that style is maintained separately in price lists, or whether prices are maintained only for the style itself. In the former case, all linked parts appear automatically in whatever price lists include the style in question and are assigned the same price, but that price can be revised. In the latter case, when assigning a price to a linked part, the system takes that price directly from its style. The constant is pre-set to maintain separate price lists for linked parts. 
 
## To maintain price lists for the style only (when the part's price policy is defined as 01):

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Change the value of the IPricePolicy constant to 1 . 
 
## Note: 

 

Run the Check Compliance w/Base Product report to check that list prices and wholesale prices of individual items are identical to those of the fashion styles to which they are linked. For instance, discrepancies may result when prices are assigned manually in the Part Catalogue form. You can run the Fix Compliance with Base Product program to fix any errors.
