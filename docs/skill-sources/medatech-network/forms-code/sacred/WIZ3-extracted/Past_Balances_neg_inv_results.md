# Past_Balances_neg_inv_results

- **Source:** `Past_Balances_neg_inv_results.htm`

Past Balances - Handling Negative Inventory.1 
 
 
- 
 
 
 
# Handling Negative Inventory Balances

 

If the calculation of past balances created negative inventory balances, these need to be corrected. Such negative balances may result from: 
 

 ·        incorrect documentation of inventory transactions 
 

 ·        missing issues from plant floor inventory. 
 
## Tip:

 

To avoid negative past balances, deal with existing negative inventory balances and run the Backflush program before calculating past balances. 
 
## To find negative inventory balances, do one of the following:

 

 ·        In the Past Balances form, retrieve all records for the date on which past balances were calculated where the Balance is less than 0 . OR 
 

 ·        Run the Inv. per Warehouse as of Date report for the date on which past balances were last calculated. 
 
## Before You Begin

 

To make any adjustments to transactions recorded before the last calculation of past balances, you must first delete the past balance. 
 

 ·        Run the Delete Last Past Balance program to delete the last calculation of past balances.
