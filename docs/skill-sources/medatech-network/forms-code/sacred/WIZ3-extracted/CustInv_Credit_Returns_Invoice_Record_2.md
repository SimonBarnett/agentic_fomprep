# CustInv_Credit_Returns_Invoice_Record_2

- **Source:** `CustInv_Credit_Returns_Invoice_Record_2.htm`

Customer Invoices - Recording a Credit Memo Against a Sales Invoice Manually.2 
 
 
- 
 
 
 
# To itemize the credit memo:

 

 1 .  Enter the Invoice Items sub-level form. 
 

 2 .  Specify the Part Number of the item being returned and credited. 
 

 3 .  Make sure that the Part Description is suitable.
 Tip: You can change the description of any part that is flagged in the Change Desc. column of the Part Catalogue form. 
 

 4 .  Do one of the following: 
 

 ·              If packed goods were returned, designate the Crate Type Code and the number of crates with a negative quantity. The returned quantity will be calculated automatically, based on crate capacity. 
 

 ·              Otherwise, specify the returned quantity manually, with a negative value, in the Quantity column. 
 

 Note : If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the returned quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the returned quantity. 
 

 5 .  Make sure that prices and discounts are correct. 
 

 6 .  Make sure the Status , Warehouse and Bin are correct. 
 

 7 .  If you work with budgets, specify a Budget Item . 
 Tip: To view information on usage of this budget item, enter the Budgeted vs. Actual sub-level form. 
 

 8 .  Check the Income Account . Revise it if necessary. Explanation. 
 

 9 .  Enter the Invoice Item - Remarks sub-level form and check the remarks that appear there. Revise or add to them, as desired.
 Notes: 
 

 ·              Any part remarks recorded in the part catalogue appear in this form automatically if Copy Part Remarks has been flagged for sales invoices (in the Copy Part Remarks to Document form). 
 

 ·              The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 

 ·              To include these remarks in the printout of the invoice, select a suitable print format . 
 

 10 .  To record serial numbers for the returned part, move to the parallel Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form.
 Tip: For more information on working with serialized parts, run the Serial Numbers Wizard .
