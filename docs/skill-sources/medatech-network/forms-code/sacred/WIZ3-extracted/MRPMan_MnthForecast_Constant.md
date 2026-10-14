# MRPMan_MnthForecast_Constant

- **Source:** `MRPMan_MnthForecast_Constant.htm`

MRP for Manufacturers - Demand Setup: Forecast Orders 
 
 
- 
 
 
 
# How Forecast Orders Are Considered

 

MRP, when planning raw material issues, also takes into account forecast orders (representing anticipated future demand). Use the MnthForcast production constant to determine how the program handles forecast orders when actual sales orders have also been opened for the same month. 
 

The preset value of 0 causes actual sales orders to cancel out existing forecast orders, but only when the sales order due dates fall on or after those of the forecast orders. 
 

The value 1 causes total sales orders to cancel out total forecast orders on a monthly basis, regardless of their due dates. 
 
## Note: 

 

For more information regarding forecast orders, run the Demand Forecast Wizard . 
 
## To set the MnthForecast constant:

 

 1 .  Enter the Production Constants form. 
 

 2 .  Move to the MnthForecast constant and make sure the desired setting has been selected.
