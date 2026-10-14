# Add_Expenses_Setup_Units

- **Source:** `Add_Expenses_Setup_Units.htm`

Shipping Expenses - Setup: Measuring Unit 
 
 
- 
 
 
 
# Determining the Part Unit by Which Shipping Expenses are Distributed

 

Shipping expenses are distributed among the parts in a shipping voucher on a proportional basis. This constant determines the part unit the system uses to calculate the relative burden of the purchased parts – the buy/sell unit or the factory unit. 
 
## To determine the unit used to calculate burdens in a shipping voucher:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the ImpFileQuant constant. 
 

 3 .  To have the system calculate burdens in terms of factory units, change the constant value to 0 . Otherwise, leave the default value of 1 . 
 
## Note:

 

This constant also affects outgoing shipping vouchers.
