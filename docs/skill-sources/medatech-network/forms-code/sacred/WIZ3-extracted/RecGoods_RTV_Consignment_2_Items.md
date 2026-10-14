# RecGoods_RTV_Consignment_2_Items

- **Source:** `RecGoods_RTV_Consignment_2_Items.htm`

Receipt of Goods - Itemizing a Return to the Consignment Warehouse 
 
 
- 
 
 
 
# To check the returned items:

 

 1 .  Enter the Returned Items sub-level form. All of the items recorded in the original GRV appear with their received quantities. 
 

 2 .  For each line item, do one of the following: 
 

 ·      If you are not returning any of the current item, delete the line ( Ctrl + Delete ). 
 

 ·      If you are returning the entire quantity of this part, flag the Approve column. The value of the Balance to Return column will be copied into the Quantity column. 
 

 ·      Record the Quantity of returned parts manually. The system will automatically subtract this quantity from the Balance to Return column of the original GRV. 
 

 ·      If you are returning packed goods, designate the Crate Type Code and the number of crates. The Quantity will be calculated automatically, based on crate capacity. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 3 .  Make sure that the lot number is correct. 
 

 4 .  Specify the Status of the returned parts (e.g., Reject ). 
 

 5 .  To record the serial numbers of the returned goods, use the Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form. 
 

 6 .  Click to link this line item to a project or project activity . 
 

 7 .  Enter the Line Items - Remarks sub-level form and check the remarks recorded there. Change them as needed.
 Notes: 
 

 ·      The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 

 ·      To include these remarks in the printout of the return, select a suitable print format . 
 
## Notes:

 

 ·        Click to finalize the return document . 
 

 ·        Click to return to the main screen .
