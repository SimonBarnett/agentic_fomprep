# Ord_Profit_2_Purchase_Price_Source

- **Source:** `Ord_Profit_2_Purchase_Price_Source.htm`

Profitability - Determining Cost Source 
 
 
- 
 
 
 
# Determining the Source of the Cost

 

In order to calculate profitability, you must determine the basis of the part's cost. There is a hierarchy of four possible sources from which the system can take the cost: 
 

 ·        The part's user-defined standard cost. 
 

 ·        If there is no standard cost, the preferred vendor's price list (or the part's recorded purchase price if price lists are not maintained). 
 

 ·        If no price is found, the last price paid for the part. 
 

 ·        If no last price is available, the part cost calculated by online costing. 
 

You can determine precisely where in the hierarchy Priority will begin, for example, choosing always to start with the standard cost rather than the vendor's price list (the default). 
 
## Note:

 

How the source of the part's cost is defined for an order item may affect the subsequent cost of any shipped or invoiced item based on that order item. That is, if the Upd Transaction Cost column of the Price/Cost Sources form is flagged for the cost source, the cost of the part will be copied from the order and considered a manual cost source (i.e., it will not be updated by costing programs).
