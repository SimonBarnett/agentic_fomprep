# RecGoods_GRV_Consignment_Item1

- **Source:** `RecGoods_GRV_Consignment_Item1.htm`

Receipt of Goods - Receiving Goods for the Consignment Warehouse.2 
 
 
- 
 
 
 
# To itemize the GRV:

 

 1 .  Enter the Received Items sub-level form. 
 

 2 .  For each received item, choose the most convenient option: 
 

 ·      Record the system's internal Part Number .
 OR 
 

 ·      If the vendor's part number is recorded in the system, record the appropriate number in the Vend/Manuf Part No. column, and the internal part number will appear automatically. 
 

 Note: For more information about defining vendor parts, see the Vendor Parts and Prices Wizard . 
 

 3 .  Make sure that the Part Description is suitable.
 Tip: You can change the description of any part that is flagged in the Change Desc. column of the Part Catalogue form. 
 

 4 .  Do one of the following: 
 

 ·      Specify the Quantity of the received part manually. Make sure that you do not exceed order tolerance . 
 

 ·      If you have received packed goods, designate the Crate Type Code and the number of crates. The Quantity will be calculated automatically, based on crate capacity. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 5 .  To record serial numbers for this part, move to the Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form. 
 

 6 .  Click to link this line item to a project or project activity . 
 

 7 .  Enter the Line Items - Remarks sub-level form and check the remarks recorded there. Change them as needed.
 Note s : 
 

 ·      Any part remarks recorded in the part catalogue appear in this form automatically if Copy Part Remarks has been flagged for GRVs (in the Copy Part Remarks to Document form). 
 

 ·      The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 
## Notes:

 

 ·        Click to finalize the GRV . 
 

 ·        Click to return to the Vendor Consignment menu. 
 

 ·        Click to return to the main screen .
