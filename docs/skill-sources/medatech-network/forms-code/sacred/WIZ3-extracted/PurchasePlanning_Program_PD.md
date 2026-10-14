# PurchasePlanning_Program_PD

- **Source:** `PurchasePlanning_Program_PD.htm`

Purchase Planning - Running the Purchase Planning Program.5 
 
 
- 
 
 
 
# To view and handle the resulting purchase requisitions:

 

 1 .  Enter the Purchase Demands form and retrieve the new purchase demand document.
 Tip: Retrieve by today's Date . 
 

 2 .  Enter the Itemized Purchase Requisitions sub-level form. 
 

 3 .  For each requisition, the part's preferred vendor appears in both the Preferred Vendor and Vendor for PR columns. Revise the vendor, if necessary.
 Note: You cannot choose a vendor whose quality level (overall or specific) is lower than that defined for the part (in the Purchase/MRP Parameters for Part form). For more information, run the Vendor Parts and Prices Wizard . 
 

 4 .  To link the requisition to an item in a vendor price quote, specify the Quote Number and the Quote Line in which the item appears. Purchase orders based on this requisition will use the price appearing in the quote for this item.
 Tip: Enter the Price Quotes for PR sub-level form to view more information regarding any price quotes recorded for this item. 
 

 5 .  If the part price is listed in the vendor's price list, it appears automatically in the Estimated Unit Price column. Otherwise, the price is taken from the next available source in the price hierarchy .
 Note: Once the requisition is linked to an item in a vendor price quote, the quoted price is used, and the Price Source is changed to 'Price Quotation'. 
 

 6 .  If necessary, specify a Budget Item . This value will then be copied to any purchase order or invoice based on this requisition, where the budget item will determine the account to be debited for the purchased parts. 
 Note s : 
 

 ·      The method by which budget usage is calculated is determined by the BudPRPrice constant (in the Financial Constants form). 
 

 ·      To view information on usage of the specified budget item, enter the Budgeted vs. Actual sub-level form.
