# Branches_6_Documents

- **Source:** `Branches_6_Documents.htm`

Branches - How Branches are Assigned to Documents 
 
 
- 
 
 
 
# How Branches are Assigned to Documents

 

Branches are assigned to documents automatically, according to the following hierarchy: 
 

 ·        the branch in the previous linked document (e.g., in the case of a sales invoice, the branch in the original order) 
 

 ·        the branch of the customer or vendor for which the document is opened 
 

 ·        the branch of the user recording the document 
 

 ·        the branch for the warehouse appearing in the document. 
 

In any case, the branch can be revised manually, unless a final document number has already been assigned and that number includes a branch signifier. 
 
## Notes:

 

 ·        In the case of a customer invoice, the InvoiceBranch constant can be set to supersede the hierarchy, so that the user always determines the branch assigned to the document. For details, see the Customer Invoices Wizard . 
 

 ·        The branch assigned to the document determines the document number, as well as the default warehouse for the transaction (where applicable). If the warehouse is revised to that of a different branch and the number template includes the branch signifier, the document numbering system automatically uses the template defined for that other branch. 
 

 ·        If you work with subsidiaries, the branch also determines the subsidiary for which the transaction is recorded. 
 

 ·        The branch assigned to financial documents is copied into the corresponding journal entry.
