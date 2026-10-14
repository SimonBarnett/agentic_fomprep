# CustShip_6a_shipment_based_on_order_further_cont

- **Source:** `CustShip_6a_shipment_based_on_order_further_cont.htm`

Customer Shipment/Return - Itemizing a Shipping Document Automatically.5 
 
 
- 
 
 
 

 7 .  The system displays the Balance to Ship (the order balance less any goods already shipped to this customer) and the Warehouse Balance (the balance of this part for the designated receiving status, work order, warehouse and bin). Do one of the following: 
 

 ·              If the quantity of the part being shipped is equal to one of these values (whichever is smaller), flag the Approve column. The shipped quantity will be filled in automatically. 
 

 ·              If you are shipping packed goods, designate the Crate Type Code and the number of crates. The shipped quantity will be calculated automatically, based on crate capacity. 
 

 ·              Otherwise, specify the shipped quantity manually in the Quantity column. Make sure that you do not exceed order tolerance . 
 

 ·              Note: If the part is a customer return, designate a negative quantity. 
 

 8 .  To record serial numbers for the shipped part, use the Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form. 
 Tip : For more information on working with serialized parts, run the Serial Numbers Wizard . 
 

 9 .  Enter the Line Items - Remarks sub-level form and check the remarks that appear there. Revise or add to them, as desired.
 Notes: 
 

 ·              The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 

 ·              To include these remarks in the printout of the shipping document, select a suitable print format . 
 
## Notes:

 

 ·        Click to finalize and bill the document . 
 

 ·        Click to return to the main screen .
