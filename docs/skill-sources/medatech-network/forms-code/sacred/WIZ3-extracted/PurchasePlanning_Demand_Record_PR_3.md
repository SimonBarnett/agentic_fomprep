# PurchasePlanning_Demand_Record_PR_3

- **Source:** `PurchasePlanning_Demand_Record_PR_3.htm`

Purchase Planning - Recording a Purchase Requisition.3 
 
 
- 
 
 
 

 11 .  Flag the Notify of Receipt column to receive an e-mail message when the goods are received into inventory. When receipt of the goods is recorded in either the Goods Receiving Vouchers form or the Vendor Invoices form, a message is sent to the user who opened the request and to the user appearing in the For User column in the Purchase Demands form. 
 

 12 .  If you want the current purchase requisition to be excluded from any purchase orders that are opened on the basis of this purchase demand, flag the Do Not Open Order column. 
 

 13 .  If you do not want all requisitioned items to be included automatically in RFQs that are opened for this purchase demand, flag the Open RFQ column for the items that you want to include in an RFQ.
 Note: If no purchase requisitions are flagged in this column, any RFQs that are opened for this purchase demand will be itemized automatically with all requisitioned items. 
 

 14 .  If necessary, specify a Budget Item . This value will then be copied to any purchase order or invoice based on this requisition, where the budget item will determine the account to be debited for the purchased parts.
 Note s : 
 

 ·      The method by which budget usage is calculated is determined by the BudPRPrice constant (in the Financial Constants form). 
 

 ·      To view information on usage of the specified budget item, enter the Budgeted vs. Actual sub-level form. 
 

 15 .  Click to link this requisition to a project or activity. 
 

 16 .  Use the Purchase Requisition - Remarks sub-level form to record remarks for the requisitioned item. These remarks will be copied to any RFQ, vendor price quote or purchase order item linked to this PR.
 Note: Any part remarks recorded in the part catalogue appear in this form automatically if Copy Part Remarks has been flagged for purchase demands (in the Copy Part Remarks to Document form). 
 

 17 .  Return to the Purchase Demands form. 
 

 18 .  If the purchase demand is mainly for a particular vendor and that vendor has not yet been recorded in this form, specify the Vendor Number now. All of the Vendor for PR columns that were left empty in the sub-level form will be filled in automatically with this number. 
 

 19 .  Do one of the following: 
 

 ·      If the document does not require authorization, assign a status that allows you to link it to an RFQ or purchase order (e.g., Current ). 
 

 ·      If you are authorizing via BPM rules, change the document status to Pending Auth . 
 

 ·      If you are using an authorizer list, notify the user whose name appears in the Next Signature column. 
 
## Note:

 

Click to return to the main screen.
