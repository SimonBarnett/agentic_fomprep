# CustInv_Setup_Multi_Export_Postpone_Invoice

- **Source:** `CustInv_Setup_Multi_Export_Postpone_Invoice.htm`

Customer Invoices - Multi-Shipment Setup: Defining Entitlement to Delayed Billing 
 
 
- 
 
 
 
# Defining Entitlement to Delayed Billing

 

You can define selected customers as entitled to delayed billing. This means that any shipment that is recorded towards the end of a given month is considered, for billing purposes, as dated at the beginning of the following month. Consequently, it will not be taken into consideration in the automatic preparation of invoices for the current month, but rather will be postponed to the next month. 
 

In addition to defining customers for entitlement, you must also indicate the time frame (number of days at the end of the month) for which the delay is permitted. Any shipping documents recorded within that time frame will automatically be flagged for delayed billing (although this can be manually revised). Any flagged document will be ignored when invoices are prepared automatically for the current month. 
 
## To define customers as entitled to delayed billing:

 

 1 .  Enter the Financ. Parameters for Customers form and retrieve the desired customer. 
 

 2 .  Click the Invoices tab and flag the Delay Inv. to Next Month column. 
 
## To set the time frame for entitlement:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Move to the InvPostDays constant and indicate the number of days, counting backwards from the end of the month, within which billing will be delayed.
