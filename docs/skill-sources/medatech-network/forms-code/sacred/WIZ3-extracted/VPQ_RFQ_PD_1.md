# VPQ_RFQ_PD_1

- **Source:** `VPQ_RFQ_PD_1.htm`

Vendor Price Quotes - Basing an RFQ on a Purchase Demand Document.1 
 
 
- 
 
 
 
# Basing an RFQ on a Purchase Demand Document

 

Before you begin working with RFQs, set the value of the PAllPartsRFQ constant to determine whether RFQs that are based on a purchase demand document will include all parts or only those that are supplied by the vendor to which the RFQ is addressed. 
 

You should also check the demand document itself and all requisitioned items to make sure they meet the necessary criteria to be included in an RFQ that is based on this demand document. 
 
## To set the value of the PAllPartsRFQ constant:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the PAllPartsRFQ constant and assign the desired value: 
 

 ·      If the constant is set to the default value of 0 , the request will include only those items that are recorded in the part list of the vendor for which it was opened. Furthermore, if a vendor is specified in the purchase requisition, this must be the same vendor specified in the RFQ. 
 

 ·      If the constant is set to 1 , all of the requisitioned parts recorded in the demand document will appear in the RFQ. 
 
## To check the demand document and purchase requisitions:

 

 1 .  Enter the Purchase Demands form and retrieve the desired purchase demand document. Make sure the document has a status that allows it to serve as the basis of RFQs (e.g., Approved ). 
 

 2 .  Enter the Itemized Purchase Requisitions sub-level form. 
 

 3 .  For each item, check the Vendor for PR column. If the PAllPartsRFQ constant is set at 0 and the specified vendor differs from the target vendor of the RFQ, replace the specified vendor with the target vendor and make sure the requisitioned part appears in the target vendor's part list (you will receive a warning if it does not).
 Tips: 
 

 ·      Use the Vendor Parts form to add a part to a vendor's part list. 
 

 ·      To assign one vendor to all items for which no vendor is specified, return to the upper-level form and specify the Vendor Number . If necessary, you can then reenter the Itemized Purchase Requisitions sub-level form and delete the Vendor for PR for any item that you do not wish to purchase from this vendor. 
 

 4 .  For each item, check whether a buyer has been assigned. When the RFQ is recorded, if a value is defined in the Buyer Only column, only those requisitioned items that have been assigned to the relevant buyer and/or are not assigned to any buyer will be included in the RFQ. 
 

 5 .  Check whether the Open RFQ column has been flagged for any items. If one or more PRs in the demand document are flagged, the RFQ will be restricted to those items.
 Note: If no PR is flagged, all requisitioned items in the demand document will be included in the RFQ.
