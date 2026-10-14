# RecGoods_GRV_Manual_3_Item1

- **Source:** `RecGoods_GRV_Manual_3_Item1.htm`

Receipt of Goods - Recording a GRV Manually.3 
 
 
- 
 
 
 
# To itemize the GRV:

 

 1 .  Enter the Received Items sub-level form. If an original GRV has been designated, the returned parts and their details are filled in automatically. 
 

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
 

 Note s : 
 

 ·      If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 ·      For returned goods, make sure to record a negative quantity. 
 

 ·      Leave a quantity of 0 for any part from the original GRV that is not being returned. All line items with a quantity of 0 are deleted when the GRV is finalized.
