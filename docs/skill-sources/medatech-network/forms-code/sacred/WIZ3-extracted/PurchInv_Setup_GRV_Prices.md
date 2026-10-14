# PurchInv_Setup_GRV_Prices

- **Source:** `PurchInv_Setup_GRV_Prices.htm`

Purchase Invoices/Memos - Setup: Price Source for Multi-GRV Invoices 
 
 
- 
 
 
 
## Setting the Price Source for Multi-GRV Invoices

 

In order to insert a unit price into an invoice (or memo), Priority considers several sources, as follows: 
 

 ·        The original GRV that is being billed (or the return being credited). 
 

 ·        If there is no document, the purchase order linked to the invoice (or memo). 
 

 ·        If there is no purchase order, the vendor's price list. 
 

You can define where in the hierarchy Priority will begin retrieving prices. For example, you can choose always to start with the order rather than the document. You can also choose to ignore document prices if they are 0 , going directly to the order instead. 
 
## To set the price source:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Set the value of the PurchDocPrice constant as follows: 
 

  1  Document (regardless of price) 
 

  0  Purchase Order (ignore document) 
 

  2  Document (only if price is not 0 ; otherwise, the order)
