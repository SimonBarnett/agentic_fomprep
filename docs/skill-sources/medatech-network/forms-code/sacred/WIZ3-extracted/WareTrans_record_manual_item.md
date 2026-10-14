# WareTrans_record_manual_item

- **Source:** `WareTrans_record_manual_item.htm`

Warehouse Transfers - Recording a Transfer Manually.3 
 
 
- 
 
 
 
# To itemize the transfer document:

 

 1 .  Enter the Transferred Items sub-level form. 
 

 2 .  Specify the Part Number of the transferred item. 
 

 3 .  Specify the Work Order/Lot to which the part belongs. 
 

 4 .  If you maintain part revisions, make sure that the appropriate value appears in the Part Revision No . column. 
 

 5 .  Make sure that the part's Status is correct. 
 

 6 .  Make sure the sending and receiving warehouses and bins are correct. 
 

 7 .  The Warehouse Balance of the part (for the designated work order/lot, status, warehouse and bin) is filled in automatically. Do one of the following: 
 

 ·      Flag the Approve column. The entire warehouse balance will be copied into the Quantity column. 
 

 ·      If you are transferring packed goods without a packing slip (e.g., materials that were purchased in crates), specify the type of crate in the Crate Type Code column, and the number of crates in the Packing Crates (No.) column. The Quantity will be calculated automatically, based on the crate capacity. 
 

 ·      Otherwise, specify the transferred quantity manually in the Quantity column. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the transferred quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the transferred quantity.
