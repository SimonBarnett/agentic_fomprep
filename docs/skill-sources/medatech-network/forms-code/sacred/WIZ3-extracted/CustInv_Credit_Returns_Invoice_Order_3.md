# CustInv_Credit_Returns_Invoice_Order_3

- **Source:** `CustInv_Credit_Returns_Invoice_Order_3.htm`

Customer Invoices - Recording a Credit Memo Against a Sales Invoice: Based on Orders.3 
 
 
- 
 
 
 
# To itemize the credit memo:

 

 1 .  Enter the Invoice Items sub-level form. The ordered parts are filled in automatically according to the sales order(s) linked to the memo. 
 

 2 .  Do one of the following: 
 

 ·              If packed goods were returned, designate the Crate Type Code and the number of crates with a negative quantity. The returned quantity will be calculated automatically, based on crate capacity. 
 

 ·              Otherwise, specify the returned quantity manually, with a negative value, in the Quantity column. 
 

 Note s : 
 

 ·              Leave a quantity of 0 for any ordered items which were not returned by the customer. These lines will be deleted automatically when the memo is finalized. 
 

 ·              If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the returned quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the returned quantity. 
 

 3 .  Make sure that prices and discounts are correct. 
 

 4 .  Make sure the Status , Warehouse and Bin are correct. 
 

 5 .  If the item was linked to a budget item in the original sales order, this appears automatically in the Budget Item column. If necessary, revise this value or add a new one. 
 Tip: To view information on usage of this budget item, enter the Budgeted vs. Actual sub-level form. 
 

 6 .  Check the Income Account . Revise it if necessary. Explanation. 
 

 7 .  Enter the Invoice Item - Remarks sub-level form and check the remarks that appear there. Revise or add to them, as desired.
 Notes: 
 

 ·              The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 

 ·              To include these remarks in the printout of the invoice, select a suitable print format . 
 

 8 .  To record serial numbers for a returned part, move to the parallel Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form.
 Tip: For more information on working with serialized parts, run the Serial Numbers Wizard .
