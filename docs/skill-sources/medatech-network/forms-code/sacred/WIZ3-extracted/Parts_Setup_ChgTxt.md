# Parts_Setup_ChgTxt

- **Source:** `Parts_Setup_ChgTxt.htm`

Part Definition - Blocking Revision of Item Remarks in Documents 
 
 
- 
 
 
 
# Blocking Revision of Item Remarks in Documents

 

Every document in which parts are itemized has a Remarks sub-level form for each part, which can display an extended description of that part. These item remarks are appended to the part description in certain print formats (e.g., W/Extended Part Desc. ). 
 

If a given document is itemized on the basis of a previous document in the work flow, item remarks are taken from the original document. If the part is recorded manually in the document, the item remarks are taken from the Parts - Remarks sub-level of the Part Catalogue form. 
 

In either case, you can make these remarks read only, so that no one can revise them in the documents, provided that the part in question is not flagged to allow description change (in the Part Catalogue form). 
 
## To make item remarks read only:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the IChgPartText constant and change its value to 1 . 
 
## Tip:

 

To see whether a given part will be affected, retrieve it in the Part Catalogue form. If it is not flagged in the Change Desc. column (in the Additional Details tab), it will have read-only remarks.
