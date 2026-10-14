# MRPMan_Setup_W_O_ECOs

- **Source:** `MRPMan_Setup_W_O_ECOs.htm`

MRP for Manufacturers - Work Order Setup: ECOs 
 
 
- 
 
 
 
# Handling Unauthorized ECOs

 

If you plan to open actual work orders automatically via MRP, the MRPWkOrdECO constant determines whether MRP will also open an actual work order for a part linked to an engineering change that has not been fully authorized. 
 
## To set the constant:

 

 1 .  Enter the Production Constants form. 
 

 2 .  Move to the MRPWkOrdECO constant and do one of the following: 
 

 ·      Leave the default value 0 if you do not want MRP to open work orders for parts with unauthorized ECOs. 
 

 ·      Select the value 1 to open work orders for parts with unauthorized ECOs. 
 
## Note:

 

This constant is only relevant when MRP has been set up to open work orders automatically.
