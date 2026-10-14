# CustInv_Sales_Quantities

- **Source:** `CustInv_Sales_Quantities.htm`

Customer Invoices - Quantities Supplied to the Customer 
 
 
- 
 
 
 
# Quantities Supplied to the Customer

 
## Supply balances and work orders

 

When an invoice is itemized automatically on the basis of a sales order, the item quantities listed are taken from the supply balances of the original order, which are in turn updated when these items are recorded in the invoice. These balances are managed independently of their respective work orders; Priority usually opens a separate line for each work order from which a quantity of parts is taken (depending on the value of the SOnlyOneLine constant). 
 

If a quantity of the part is already packed for the customer and in a warehouse, it is taken from the warehouse and shipped to the customer. If not, parts are taken from existing warehouse inventory (i.e., those parts with a status that permits sale, such as Goods ). If the amount of goods packed and ready for the customer is smaller than the quantity to be shipped, the remaining balance is taken from available warehouse inventory. If available inventory is insufficient to fill the entire order, an additional line will appear in the invoice for a work order numbered 0 that has a warehouse balance of 0 . 
 
## Effect on inventory

 

When a line item is recorded in the invoice: 
 

 ·        The part's Warehouse Balance is reduced. 
 

 ·        The Balance to Ship for that part is reduced. 
 

 ·        The balance for that part in the holding warehouse increases (when relevant).
