# PurchOrd_5_PR_purchase_demand_doc

- **Source:** `PurchOrd_5_PR_purchase_demand_doc.htm`

Purchase Orders - Recording an Order Based on a Purchase Demand Document.2b 
 
 
- 
 
 
 
# To record an order based on a purchase demand document:

 

 1 .  Enter the Purchase Orders form. 
 

 2 .  Record the vendor number The vendor name, date and order number are filled in automatically.
 Note: In the case of a one-time vendor, record the vendor number defined for one-time vendors and revise the name in the Vendor Name column. Then fill in the address and other details in the Purchase Order - Vendor Details sub-level form. 
 

 3 .  If you want to restrict the purchase order to PRs that were assigned to a particular buyer (e.g., the user assigned to the order) and/or were not yet assigned a buyer, click the Authorization & Followup tab, move to the Buyer Only column and choose the appropriate option. Leave this column blank to include all PRs, regardless of the buyer. 
 

 4 .  In the References tab, choose the desired document in the Purch Demand column. The order will be itemized automatically according to it.
 Notes: 
 

 ·              The purchase demand document must be fully authorized (unless no authorization is required) and have a status that allows linkage to a purchase order. 
 

 ·              If a value appears in the Buyer Only column, only those PRs that are assigned to the designated buyer and/or are not yet assigned to any buyer will be included in the itemized purchase order. 
 

 ·              When a purchase demand document is linked to a purchase order, the purchase demand document is closed, as are the individual PRs. 
 

 ·              If the PCopyTxtToPO constant is set at its default value of 1 , any remarks in the demand document are copied automatically into the purchase order.
