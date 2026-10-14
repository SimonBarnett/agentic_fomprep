# PurchasePlanning_Demand_Record_PR_2

- **Source:** `PurchasePlanning_Demand_Record_PR_2.htm`

Purchase Planning - Recording a Purchase Requisition.2 
 
 
- 
 
 
 

 6 .  If a vendor is recorded in the upper-level form, the vendor's number appears automatically in the Vendor for PR column, and cannot be changed. If the purchase demand is mainly but not entirely for a particular vendor and no vendor appears in the upper-level form, do one of the following: 
 

 ·      If the part is to be purchased from its preferred vendor, leave the vendor number in the Vendor for PR column. If not, delete the preferred vendor's number from that column. 
 

 ·      If the part is to be purchased from a different vendor than the majority of parts, specify that vendor in the Vendor for PR column. 
 

 ·      For all other parts, leave the Vendor for PR column empty. It will be filled in at a later stage. 
 

 Note: You cannot record a vendor whose quality level (overall or specific) is lower than that defined for the part (in the Purchase/MRP Parameters for Part form). For more information, run the Vendor Parts and Prices Wizard . 
 

 7 .  To link the requisition to an item in a vendor price quote, specify the Quote Number and the Quote Line in which the item appears. Purchase orders based on this requisition will use the price appearing in the quote for this item.
 Tip: Enter the Price Quotes for PR sub-level form to view more information regarding any price quotes recorded for this item. 
 

 8 .  If the part price is listed in the vendor's price list, it appears automatically in the Estimated Unit Price column. Otherwise, the price is taken from the next available source in the price hierarchy . At any rate, you can revise the price.
 Note: Once the requisition is linked to an item in a vendor price quote, the quoted price is used, and the Price Source is changed to 'Price Quotation'. 
 

 9 .  If you want the price recorded here to be copied to purchase orders based on this requisition, flag the Copy Price To Order column.
 Note: If the PR is linked to an item in a vendor price quote, this column is flagged automatically. 
 

 10 .  If the current purchase requisition is intended for a specific work order, record its number in the To Work Order column.
