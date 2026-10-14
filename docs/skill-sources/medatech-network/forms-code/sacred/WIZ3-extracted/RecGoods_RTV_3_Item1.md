# RecGoods_RTV_3_Item1

- **Source:** `RecGoods_RTV_3_Item1.htm`

Receipt of Goods - Recording a Return Based on a GRV.3 
 
 
- 
 
 
 
# To check the returned items:

 

 1 .  Enter the Returned Items sub-level form. The parts and their details are filled in automatically according to the GRV. 
 

 2 .  For each line item, do one of the following: 
 

 ·      If you are returning the entire quantity of this part, flag the Approve column. The value of the Balance to Return column will be copied into the Quantity column. 
 

 ·      Record the Quantity of returned parts manually. The system will automatically subtract this quantity from the Balance to Re turn column of the original GRV (in the original purchase order, the Balance column). 
 

 ·      If you are returning packed goods, designate the Crate Type Code and the number of crates. The Quantity will be calculated automatically, based on crate capacity. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 3 .  Make sure that the lot number is correct. 
 

 4 .  If the part is being returned from a different warehouse and/or bin than that specified in the upper-level form, change the Warehouse and/or Bin values accordingly. 
 

 5 .  Specify the Status of the returned parts (e.g., Reject ).
