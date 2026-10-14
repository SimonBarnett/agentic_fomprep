# Past_Balances_Setup

- **Source:** `Past_Balances_Setup.htm`

Past Balances - Setup 
 
 
- 
 
 
 
# Setting Up for Past Balances

 
## Deletion of Zero Inventory Balances

 

You can set the system so that calculating past balances automatically deletes all inventory balances of 0 . 
 
## To determine how zero inventory balances will be handled:

 

 1 .  Enter the Production Constants form. 
 

 2 .  Move to the NullBalance constant and select the appropriate value. 
 
## Note:

 

If this constant is set to delete all zero balances, they will also be deleted when inventory counts are automatically prepared and when the Backflush program is run. 
 
## Floor Inventory Setups

 

If you maintain floor inventory, calculations of past balances also run various stages of the Backflush to update that inventory. It is therefore recommended that the setups required for the Backflush program be performed. For details, run the Backflush Wizard .
