# RecGoods_GRV_Item1

- **Source:** `RecGoods_GRV_Item1.htm`

Receipt of Goods - Recording a GRV Based on a Purchase Order.4 
 
 
- 
 
 
 
# To check the GRV items:

 

 1 .  Enter the Received Items sub-level form. The received parts and their details are filled in automatically according to the purchase orders or order items linked to the GRV. If an original GRV has been designated, the returned parts appear as well. 
 

 2 .  Do one of the following: 
 

 ·      If the quantity of parts received equals the Balance to Receive , flag the Approve column. The Quantity column will be filled in automatically. 
 

 ·      If you are receiving packed goods, designate the Crate Type Code and the number of crates. The received Quantity will be calculated automatically, based on crate capacity. 
 

 ·      Specify the received Quantity manually. Make sure that you do not exceed order tolerance . 
 

 Notes: 
 

 ·      If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 ·      For returned goods, make sure to record a negative quantity. 
 

 ·      Leave a quantity of 0 for any ordered part that has not been received, or for any part from an original GRV that is not being returned. All line items with a quantity of 0 are deleted when the GRV is finalized.
