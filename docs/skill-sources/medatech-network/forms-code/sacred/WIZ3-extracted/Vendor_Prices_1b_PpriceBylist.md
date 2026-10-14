# Vendor_Prices_1b_PpriceBylist

- **Source:** `Vendor_Prices_1b_PpriceBylist.htm`

Vendor Parts/Prices - Setup: Vendor Prices for Linked Parts 
 
 
- 
 
 
 
# Determining How Prices are Assigned to Linked Parts 

 

When working with base products, you can define the part's price policy as 01, such that changes to the base product price (in a given price list) automatically update the price of all linked parts. In such a case, the IPricePolicy constant determines whether the price of each linked part is maintained separately in price lists (and can then be revised as needed) or whether such parts are automatically assigned the price defined for the base product in question. The constant is pre-set to maintain separate vendor price lists for all such linked parts. 
 
## To maintain price lists for the base product only (when the Price Policy is defined as 01):

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Change the value of the IPricePolicy constant to 1 . 
 
## Note:

 

Click to perform additional setups for vendor parts and prices .
