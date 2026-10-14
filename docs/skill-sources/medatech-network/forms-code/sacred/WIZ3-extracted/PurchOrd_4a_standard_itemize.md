# PurchOrd_4a_standard_itemize

- **Source:** `PurchOrd_4a_standard_itemize.htm`

Purchase Orders - Recording a Standard Order.2 
 
 
- 
 
 
 
# Itemizing the Order

 

 1 .  Enter the Order Items sub-level form. 
 

 2 .  Record either the part number used by the vendor or the internal part number for the order item (in the Vend/Manuf Part No. and Part Number columns, respectively). 
 Note: If the part has been assigned a manufacturer's part number (in the Manufacturers of Parts form), it will automatically be added to the vendor's part list the first time it is ordered. 
 

 3 .  Do one of the following: 
 

 ·              If you are ordering packed goods, designate the Crate Type Code and the number of crates. The ordered quantity will be calculated automatically, based on crate capacity. 
 

 ·              Otherwise, record the Quantity manually. 
 

 Tip: To check existing and expected inventory levels, use the Inventory for Part and the Part Availability sub-level forms. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the ordered quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the ordered quantity. 
 

 4 .  Make sure that the part description is suitable.
 Tip: You can change the description of any part that is flagged in the Change Desc. column of the Part Catalogue form. 
 

 5 .  Make sure that the price appearing in the Unit Price column is correct. This will be taken from the appropriate vendor price list or the purchase price in the part catalogue, whichever is relevant. If no vendor prices are available, it will be taken from the last purchase order for this part to be received from this vendor.
