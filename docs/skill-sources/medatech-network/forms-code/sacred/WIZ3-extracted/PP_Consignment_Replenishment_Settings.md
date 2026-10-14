# PP_Consignment_Replenishment_Settings

- **Source:** `PP_Consignment_Replenishment_Settings.htm`

PP_Consignment_Replenishment_Settings 
 
 
- 
 
 
 

The following parameters are defined for a part: 
 

 ·        a minimum inventory level of 100 
 

 ·        a maximum inventory level of 200 
 

 ·        a minimum replenishment quantity of 40 
 

 ·        a replenishment increment of 20 
 

If the inventory level of this part falls to 50 units, the program will open an order for 140 (the minimum 40 plus five increments of 20), so as to reach 190. This exceeds the minimum level of 100 without passing the maximum of 200.
