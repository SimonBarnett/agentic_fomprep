# CustInv_Setup_General_Branch

- **Source:** `CustInv_Setup_General_Branch.htm`

Customer Invoices - General Setup: Branch for Invoice/Memo 
 
 
- 
 
 
 
# Assigning a Branch to an Invoice or Memo

 

Whenever an invoice or memo is opened, a branch is assigned automatically from one of several sources – the branch of the user recording the invoice/memo, the branch of the customer for which it was opened, or the branch in the previous linked document (the shipping document or order). The InvoiceBranch constant determines the hierarchy that is used to assign the branch. 
 
## To set the constant value:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Set the value of the InvoiceBranch constant as follows: 
 

 ·              Specify 0 to use the hierarchy: branch in previous document; if none, then customer's branch; if none, then user's branch. 
 

 ·              Specify 1 to use the following hierarchy when invoices/memos are opened manually: user's branch; if none, then branch in previous document; if none, then customer's branch. In invoices/memos opened automatically, the branch will always be that of the user who ran the program; if the user has not been assigned a branch, no branch will appear in the document. 
 
## Note:

 

The constant has the following effect on multi-shipment and/or export invoices prepared automatically in a batch: If you assign a constant value of 0 , shipping documents for different branches will generate invoices for different branches, even when they are to the same customer. If you assign a constant value of 1 , all shipping documents for the customer will be invoiced together, even if the shipments were to different branches.
