# RecGoods_GRV_Invoice_Items

- **Source:** `RecGoods_GRV_Invoice_Items.htm`

Receipt of Goods - Recording a GRV Based on an Invoice.3 
 
 
- 
 
 
 
# To check the received items:

 

 1 .  Enter the Received Items sub-level form. The parts and their details are filled in automatically according to the invoice linked to the GRV. 
 

 2 .  Do one of the following: 
 

 ·      If the quantity of parts received equals the Balance to Receive , flag the Approve column. The Quantity column will be filled in automatically. 
 

 ·      If you are receiving packed goods, designate the Crate Type Code and the number of crates. The received Quantity will be calculated automatically, based on crate capacity. 
 

 ·      Specify the received Quantity manually. Make sure that you do not exceed order tolerance . 
 

 Note s : 
 

 ·      If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 ·      Leave a quantity of 0 for any invoiced part that has not been received. All line items with a quantity of 0 are deleted when the GRV is finalized. 
 

 3 .  If you maintain lots for this part, record the Vendor Lot Number . Depending how lot numbering is set up, the system may automatically open a lot for the current part, and record its number in the Internal Lot/Wk Ord column.
 Notes: 
 

 ·      If the received part belongs to a lot that is already recorded in the system, specify its lot number in the Internal Lot/Wk Ord column. To view existing lots, select Raw Material Lots from the list of Direct Activations . 
 

 ·      Click to change the default lot numbering method for future GRVs .
