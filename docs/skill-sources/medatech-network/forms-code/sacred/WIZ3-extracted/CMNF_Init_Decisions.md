# CMNF_Init_Decisions

- **Source:** `CMNF_Init_Decisions.htm`

Costing for Manufacturers - Determining Costing Methods.1 
 
 
- 
 
 
 
# Determining Costing Methods 

 

Before you begin working with Costing for Manufacturers , you need to make the following decisions: 
 
## Costing initialization date

 

You need to determine the starting date for all cost calculations. Costing will only take into account inventory transactions recorded after this date, even if inventory transactions have been recorded previously. If you change the initialization date, the results of any costing runs prior to the new date will be deleted. 
 
## Calculation method 

 

You need to consult with your accountant to decide whether to use the Moving Average or the FIFO method to calculate the average cost of each part unit. 
 

In the dual-currency package, the system automatically indexes the cost of all inventory transactions for both methods. You also have the option of choosing FIFO Adjusted , which uses the FIFO method and adjusts local-currency costs as follows: costs that were initially converted from the second currency are adjusted according to the exchange rate on the costing date, while costs that were initially recorded in the local currency are adjusted according to the index on the costing date. Click for more information on indexing and price adjustment .
