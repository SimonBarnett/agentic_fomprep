# PurchInv_VI_Manual_Items

- **Source:** `PurchInv_VI_Manual_Items.htm`

Purchase Invoices/Memos - Recording a Vendor Invoice Manually.4 
 
 
- 
 
 
 
# To itemize the invoice:

 

 1 .  Enter the Invoice Items sub-level form. 
 

 2 .  Record the received part in one of the following ways: 
 

 ·              Specify the system's internal Part Number .
 OR 
 

 ·              If the vendor's part number is recorded in the system, specify the number in the Vend/Manuf Part No. column, and the internal part number will appear automatically. 
 

 Tip: For more information about defining vendor parts, run the Vendor Parts and Prices Wizard . 
 

 3 .  Make sure that the Part Description is suitable.
 Tip: You can change the description of any part that is flagged in the Change Desc. column of the Part Catalogue form. 
 

 4 .  Do one of the following: 
 

 ·              If the item is received in packing crates, specify the Crate Type Code and the number of crates. The received quantity will be calculated automatically, based on crate capacity.
 OR 
 

 ·              Record the Quantity manually. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the received quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the received quantity. 
 

 5 .  Make sure that the Unit Price and Item Discount are correct. The item's Extended Price is filled in automatically, as well as the total Amount Owing in the upper-level form.
 Note: The unit price is taken from the vendor's price list, if any, or from the purchase price in the part catalogue. If no vendor prices are available, it will be taken from the last purchase order for this part.
