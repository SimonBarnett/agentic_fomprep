# WareTrans_record_based_on_bonded_itemize

- **Source:** `WareTrans_record_based_on_bonded_itemize.htm`

Warehouse Transfers - Recording a Transfer of Goods Released from Bonded Warehouse.2 
 
 
- 
 
 
 
# To check the transferred items:

 

 1 .  Enter the Transferred Items sub-level form. The transferred parts are filled in automatically on the basis of the Release from Bonded Warehouse document. 
 

 2 .  The Work Order/Lot to which the part belongs, as well as its Part Revision , BOM Revision and From Status are filled in automatically. Make sure that they are correct. If the part is partially processed, the last operation executed upon it appears in the Operation column. 
 

 3 .  Sending and receiving warehouses and bins are filled in automatically, based on what appears in the upper-level form. Revise them if necessary. 
 

 4 .  The Warehouse Balance of the part (for the designated work order/lot, status, warehouse and bin) is filled in automatically. Do one of the following: 
 

 ·      Flag the Approve column. The entire warehouse balance will be copied into the Quantity column. 
 

 ·      If you are transferring crated goods, specify the type of crate in the Crate Type Code column, and the number of crates in the Packing Crates (No.) column. The Quantity will be calculated automatically, based on the crate capacity. 
 

 ·      Otherwise, specify the transferred quantity manually in the Quantity column. 
 

 Note s : 
 

 ·      Parts that are not assigned a quantity will be deleted from the transfer document once it is finalized. Explanation . 
 

 ·      If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the transferred quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the transferred quantity.
