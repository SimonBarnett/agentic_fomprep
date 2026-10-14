# CustInv_Setup_General_Const

- **Source:** `CustInv_Setup_General_Const.htm`

Customer Invoices - General Setup: Constants that Affect Invoices 
 
 
- 
 
 
 
# Setting the Source of Prices 

 

In order to insert a unit price into an invoice (or memo), Priority considers several sources, as follows: 
 

 ·        The original document that is being billed (or the return being credited). 
 

 ·        If there is no document, the sales order linked to the invoice (or memo). 
 

 ·        If there is no sales order, the price list in effect for the customer. 
 

You can define precisely where in the hierarchy Priority will begin retrieving prices, for example, you can choose always to start with the order rather than the document. 
 
## To set the price source:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Set the value of the DocPrice constant as follows: 
 

  1  Document 
 

  0  Sales Order 
 

  4  Price List in effect on the shipment date 
 

  3  Price list in effect on the invoice date. 
 
## Notes:

 

 ·        In the case of sales invoices and over-the-counter invoices, the values of 1 and 0 have the same effect. 
 

 ·        The constant also affects prices in shipping documents: If the constant value is 3 or 4 , prices are taken from the price list even when the shipment is based on an order. 
 

 ·        The constant has no effect on invoices for service contract payments, reported project hours/expenses or project payments. Prices in such invoices are always taken from the contract or project. 
 

 ·        A price list assigned specifically to an invoice always overrides this constant.
