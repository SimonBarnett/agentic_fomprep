# COGS_Process_2

- **Source:** `COGS_Process_2.htm`

COGS - (Perpetual) Sales and Purchase Transactions.2 
 
 
- 
 
 
 
# Purchase Transactions

 
## Note:

 

 ·        The accounts used for purchase transactions are identical in both the Commercial and Manufacturing packages, except for transactions involving subcontractors. 
 
## Goods Receiving Voucher

 

 ·        Credits the Purchases Not Yet Billed account and debits the Purchases /Inventory account. 
 

 ·        With one exception, the entry is recorded when the Post Cost of Goods Sold program is run (entry code = IT ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 ·        Exception (online COGS): When the COGSPeriod constant is set to 2 and GRVs are flagged to Record COGS Online . 
 

 Note: The Purchases Not Yet Billed account is debited when the multi-GRV invoice for this receipt is finalized. If the goods are non-billable, you need to record an adjustment entry manually. 
 
## Return to Vendor

 

 ·        Credits the Purchases Not Yet Billed account and debits the Purchases /Inventory account, but with negative values. 
 

 ·        With one exception, the entry is recorded when the Post Cost of Goods Sold program is run (entry code = IT ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 ·        Exception (online COGS): When the COGSPeriod constant is set to 2 and vendor returns are flagged to Record COGS Online . 
 
## Vendor Invoice

 

 ·        Credits the vendor account with the invoice price (including VAT, in the dual-currency package) and debits the Purchases/Inventory account with the part's standard cost (calculated during cost analysis) multiplied by the invoice quantity; in the dual-currency package, also debits the Input VAT account with the VAT amount. Any variance between purchase price and standard cost is recorded against the Price Variance account. The entry is recorded when the invoice is finalized. Explanation: standard shipping expenses. 
 
## Multi-GRV Invoice 

 

 ·        Credits the vendor account with the invoice price (including VAT, in the dual-currency package) and debits the Purchases Not Yet Billed account with the part's standard cost (calculated during cost analysis) multiplied by the invoice quantity; in the dual-currency package, also debits the Input VAT account with the VAT amount. Any variance between purchase price and standard cost is recorded against the Price Variance account. The entry is recorded when the invoice is finalized. Explanation: standard shipping expenses. 
 
## Receipt from Subcontractor

 

 ·        Credits the Purchases Not Yet Billed account with the standard subcontracting cost and credits the subcontractor's inventory account with the standard material cost. Debits the Inventory-Burde n account with the standard subcontracting cost and debits the Purchases/Inventory account defined for the receiving warehouse with the standard material cost. After the invoice is recorded, debits the Inventory-Burden account with the standard subcontracting cost, debits the Purchases/Inventory account defined for the receiving warehouse with the standard material cost, and debits or credits the Price Variance account with the difference between these costs and the invoice amount. 
 

 ·        The entry is recorded when the Post Cost of Goods Sold program is run (entry code = IT ). The entry sum is equal to the manufactured part's standard cost (calculated during costing) multiplied by the invoice quantity. 
 

 Note: Define all labor and burden as subcontracting costs. That is, define part cost in terms of just two components: material costs and subcontracting costs. 
 
## Note:

 

Click to return to the main Perpetual COGS screen.
