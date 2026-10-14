# PQ_91_Itemizing_after_models

- **Source:** `PQ_91_Itemizing_after_models.htm`

Price Quotations - Recording a Price Quotation for Product Bundles.5 
 
 
- 
 
 
 
# To itemize the price quotation: 

 

 1 .  Enter the Itemized Quotation sub-level form. 
 

 2 .  Record the system part number of the quoted item. 
 

 3 .  Make sure that the part description is suitable.
 Tip: You can change the description of any part that is flagged in the Change Desc. column of the Part Catalogue form. 
 

 4 .  In the Qty column, record the minimum quantity for which the quoted price is valid.
 Notes: 
 

 ·      To record different prices for different quantities of the same item, record a new line for each quantity. Example. 
 

 ·      To check part availability, enter the Part Availability sub-level form. 
 

 5 .  If a unit price appears automatically, make sure it is correct; if not, record the price manually.
 Notes: 
 

 ·      Click for a review of resources to consult when pricing manually . 
 

 ·      If an item is not to be billed, remove the check from the Billable column, and the price will revert to 0.00. Example.   
 

 ·      The Price Source column displays the source of the quoted price (e.g., special part price, customer price list, manual entry). 
 

 ·      Only discounts and special prices that are valid for the full period in which the price quotation is in effect are used to calculate item prices. 
 

 6 .  Specify the number of days generally required to supply each item.
 Note: This value will generate a corresponding due date for this part in any sales order based on this quote. 
 

 7 .  If you work with projects, click to link the quoted item to a project or project activity. 
 

 8 .  Click if an item requires a customized bill of materials. Example. 
 Notes: 
 

 ·      If you make any changes in the BOM, these will affect the quoted item's price and cost, with two exceptions:
1) If they were recorded manually, the only way to change them is by selecting Calculate Price/Cost by BOM from the list of Direct Activations .
2) If the SBOMPrice constant is set to 0 , the item's price will not be affected, even by running Calculate Price/Cost by BOM . 
 

 ·      Before printing the quote, select the With Custom BOM print format. 
 

 9 .  Enter the Quoted Item - Remarks sub-level form and check the remarks recorded there for the quoted item. Revise them if necessary.
 Notes: 
 

 ·      Any part remarks recorded in the part catalogue appear in this form automatically if Copy Part Remarks has been flagged for price quotations (in the Copy Part Remarks to Document form). 
 

 ·      The text may not be open to revision (if the IChgPartText constant is set to 1 and the part description is not changeable). 
 

 ·      To include these remarks in the printout of the quote, select a suitable print format .
