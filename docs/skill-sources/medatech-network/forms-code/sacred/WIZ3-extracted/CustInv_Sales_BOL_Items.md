# CustInv_Sales_BOL_Items

- **Source:** `CustInv_Sales_BOL_Items.htm`

Customer Invoices - Creating a Bill of Lading.3 
 
 
- 
 
 
 
# To itemize the bill of lading:

 

 1 .  Enter the Link Packing Slips to Invoice sub-level form. This form lists all crates that are recorded in final packing slips, earmarked for this customer (or packed for stock), and located in the warehouse and bin specified in the upper-level form. 
 

 2 .  For each crate that is to be included in the bill of lading, flag the In Invoice column. Consequently, a check mark will appear in the Bill of Lading column of the upper-level form, and the packing crates will be listed in the Packing Slips in Invoice form (another sub-level). 
 

 3 .  Enter the parallel Invoice Items sub-level form. The bill of lading is itemized with all parts in the designated crates. Prices and discounts appear automatically, but may be revised. 
 

 4 .  Make sure that prices and discounts are correct.
 Note: If you set the price list for this invoice, prices will be taken from there but may be revised. 
 

 5 .  For each shipped item, approve the shipped quantities: 
 

 ·              If the SCratesQuant constant is set at 1 , the Approve column is flagged automatically, and the quantity is filled in automatically. 
 

 ·              Otherwise, flag the Approve column manually, and the quantity will appear automatically. 
 

 Tips: 
 

 ·              To change the value of the SCratesQuant constant, which will affect future bills of lading, enter the Logistic Constants form. 
 

 ·              For help in revising/canceling a final packing slip, run the Packing Slip Wizard . 
 

 6 .  Click to link this line item to a project or project activity . 
 

 7 .  Enter the Invoice Item - Remarks sub-level form and check the remarks that appear there. Revise or add to them, as desired. 
 Notes: 
 

 ·              Any part remarks recorded in the part catalogue appear in this form automatically if Copy Part Remarks has been flagged for sales invoices (in the Copy Part Remarks to Document form). 
 

 ·              The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 

 ·              To include these remarks in the printout of the invoice, select a suitable print format .
