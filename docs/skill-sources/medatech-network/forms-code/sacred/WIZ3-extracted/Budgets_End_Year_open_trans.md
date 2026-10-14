# Budgets_End_Year_open_trans

- **Source:** `Budgets_End_Year_open_trans.htm`

Budgets - Budgeting Unbilled Transactions and Documents 
 
 
- 
 
 
 
# Budgeting Unbilled Transactions and Documents

 

The issue of how to budget transactions that have not yet been billed, are still on order, or have only been requisitioned is not a simple one. The following explains how Priority handles these transactions. 
 
## Open PRs, Purchase Orders and Sales Orders

 

When calculating actual expenses/income, the system takes into account the due date of open orders (and the Best On-Hand date of open PRs) together with the value assigned to the BudOrdPeriod constant (in the Financial Constants form). 
 

Depending on these settings, the system considers one of the following as part of the current budget: 
 

 ·        Current and previous transactions : the constant is set to 0 and the order (or PR) is due by the end of this year.
 Note: Next year’s transactions are considered part of next year’s budget. 
 

 ·        All open transactions , regardless of due date (or on-hand date): the constant is set to 1 . 
 

 ·        Only this year ’s transactions : the constant is set to 2 .
 Note: Last year’s transactions are included in last year’s budget; next year’s transactions are part of next year’s budget. 
 
## Unbilled GRVs and Customer Shipments

 

Like billed transactions, unbilled GRV’s and shipment documents are always budgeted on the date of the actual transaction. For instance, a receipt of goods dated last year belongs to last year’s budget until the invoice is written. If the invoice is also dated last year, the transaction remains in last year’s budget. If it is dated this year, the transaction is moved to the current budget. 
 
## Notes : 

 

 ·        Click to view budgeted vs. actual expenses/income. 
 

 ·        Click to return to the main screen .
