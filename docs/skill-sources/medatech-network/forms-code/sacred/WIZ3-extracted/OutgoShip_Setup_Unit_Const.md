# OutgoShip_Setup_Unit_Const

- **Source:** `OutgoShip_Setup_Unit_Const.htm`

Outgoing Shipping Vouchers - Setting Up Part Units 
 
 
- 
 
 
 
# Determining the Part Unit by Which Shipping Expenses are Distributed

 

Shipping expenses are distributed among the parts in a shipping voucher on a proportional basis. This constant determines the part unit the system uses to calculate the relative burden of the purchased parts – the buy/sell unit or the factory unit. 
 
## To determine the unit used to calculate burdens in a shipping voucher:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the ImpFileQuant constant. 
 

 3 .  Do one of the following: 
 

 ·     To distribute burdens according to each part's buy/sell unit, leave the preset value of 1 . 
 

 ·     To use factory units, change the value to 0 . 
 
## Note:

 

This constant affects incoming shipping vouchers as well.
