# COGS_Process

- **Source:** `COGS_Process.htm`

COGS - (Perpetual) Sales and Purchase Transactions.1 
 
 
- 
 
 
 
# How Sales and Purchase Transactions Affect COGS Entries

 

The following accounts are used when recording journal entries for transactions involving sales and purchases. 
 
## Note: 

 

 ·        In the Commercial package, a single inventory account and a single COGS account are used. In the Manufacturing package, additional accounts for labor and burden are also involved. Details. 
 
## Sales Transactions

 
## Shipping Document (including shipments linked to a service call) 

 

 ·        Credits the Purchases /Inventory account, debits the Unbilled Shipments account. 
 

 ·        With one exception, the entry is recorded when the Post Cost of Goods Sold program is run (entry code = CSP ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 ·        Exception (online COGS): When the COGSPeriod constant is set to 2 (entries recorded when documents are finalized) and customer shipments are flagged to Record COGS Online . 
 

 Note s : 
 

 ·      When a multi-shipment invoice linked to this shipment is finalized, the Unbilled Shipments account is credited and the COGS – Material account is debited. For non-billable shipments, the COGS – Material account is debited immediately. 
 

 ·      For shipments to a consignment warehouse, the warehouse's inventory account (if one has been defined) is debited instead. 
 

 ·      Entries recorded for non-billable shipping documents in which parts are shipped by the customer to a defined repairs warehouse (which is not flagged for inventory valuation) debit the warehouse's inventory account and credit its COGS account. 
 
## Return Document 

 

 ·        Debits the Purchases /Inventory account, credits the Unbilled Shipments account. 
 

 ·        With one exception, the entry is recorded when the Post Cost of Goods Sold program is run (entry code = CSP ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 ·        Exception (online COGS): When the COGSPeriod constant is set to 2 and customer returns are flagged to Record COGS Online . 
 

 Note: Entries recorded for non-billable return documents in which repaired parts are returned to the customer from a defined repairs warehouse (which is not flagged for inventory valuation) credit the warehouse's inventory account and debit its COGS account. 
 
## Sales/Over-the-Counter Invoice

 

 ·        Credits the Purchases /Inventory account, debits the COGS – Material account. 
 

 ·        With one exception, the entry is recorded when the Post Cost of Goods Sold program is run (entry code = COG ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 ·        Exception (online COGS): When the COGSPeriod constant is set to 2 and sales/over-the-counter invoices are flagged to Record COGS Online . 
 
## Multi-Shipment Invoice

 

 ·        Credits the Unbilled Shipments account and debits the COGS – Material account. 
 

 ·        With one exception, the entry is recorded when the Post Cost of Goods Sold program is run (entry code = C OG ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 ·        Exception (online COGS): When the COGSPeriod constant is set to 2 .
