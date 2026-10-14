# PurchInv_VI_PurchOrd_Items

- **Source:** `PurchInv_VI_PurchOrd_Items.htm`

Purchase Invoices/Memos - Recording a Vendor Invoice Based On Purchase Orders.4 
 
 
- 
 
 
 
# To check itemization:

 

 1 .  Enter the Invoice Items sub-level form. The parts, with their quantities and other details, are filled in automatically according to the purchase orders linked to the invoice. 
 

 2 .  Do one of the following: 
 

 ·              If the actual received quantity of a line item is identical to the quantity displayed in the Order Balance column, flag the Approve column. This value is then copied automatically into the Quantity column. 
 

 ·              If the item is received in packing crates, specify the Crate Type Code and the number of crates. The received quantity will be calculated automatically, based on crate capacity. 
 

 ·              Otherwise, record the Quantity manually. 
 

 Note s : 
 

 ·              If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 ·              The received quantity cannot exceed the order balance by a percentage greater than the order tolerance. Example. 
 

 3 .   Prices are filled in automatically from the purchase order. If, however, the Unit Price differs from the price listed in the invoice, revise it manually to conform with the invoice, and note the discrepancy in the Invoice/Memo - Remarks sub-level form. 
 

 4 .  If you maintain lots for this part, record the Vendor Lot Number . Depending how lot numbering is set up, the system may automatically open a lot for the part, and record its number in the Internal Lot/Wk Ord column.
 Notes: 
 

 ·              If the received part belongs to a lot that is already recorded in the system, specify its lot number in the Internal Lot/Wk Ord column. 
 

 ·              Click to change the default lot numbering method for future vendor invoices.
