# WareTrans_orderitem_2

- **Source:** `WareTrans_orderitem_2.htm`

Warehouse Transfers - Recording a Transfer to Fill a Branch Order.4 
 
 
- 
 
 
 

 4 .  The Order Balance (the balance of parts to be supplied) and the Warehouse Balance (the balance of parts with the designated work order/lot, status, warehouse and bin) are filled in automatically. Do one of the following: 
 

 ·      If the quantity of the transferred part is equal to one of these values (whichever is smaller), flag the Approve column. The transferred quantity will be filled in automatically. 
 

 ·      If you are transferring packed goods, designate the Crate Type Code and the number of crates. The transferred quantity will be calculated automatically, based on crate capacity. 
 

 ·      Otherwise, specify the transferred quantity in the Quantity column. 
 

 Notes: 
 

 ·      If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the transferred quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the transferred quantity. 
 

 ·      If the entire order balance has been transferred, the order item will be closed automatically. 
 

 ·      Parts that are not assigned a quantity will be deleted from the transfer document once it is finalized. Explanation .
