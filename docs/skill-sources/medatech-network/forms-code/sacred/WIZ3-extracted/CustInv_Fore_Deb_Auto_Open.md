# CustInv_Fore_Deb_Auto_Open

- **Source:** `CustInv_Fore_Deb_Auto_Open.htm`

Customer Invoices - Opening Export Invoices Automatically.1 
 
 
- 
 
 
 
# Preparing a Batch of Export Invoices and Credit Memos Automatically

 

The Prepare Invoices program automatically opens export invoices (and export credit memos): 
 

 ·        for selected documents 
 

 ·        for all documents within a given period 
 

 ·        for a project 
 
## Notes:

 

 ·        If customer returns are included together with shipments to this customer, they will appear (with negative quantities) alongside the shipped items in the same invoice. If there are only returns for a given customer, they will be included in a separate credit memo. 
 

 ·        The Prepare Invoices program also opens multi-shipment invoices for domestic customers (i.e., with a C in the Invoice Type column of the Financ. Parameters for Customers form). 
 
## Before you begin:

 

 1 .  Make sure you have performed all setups for export invoices and credit memos – most of these setups directly affect the outcome of this program. In particular, make sure that all customers for which you are about to prepare export invoices have been defined as foreign customers.
 Tip: Click to access the setup menu . 
 

 2 .  If possible, finalize or delete all pending invoices/memos (run the Finalize Export Invoices or Delete Pending Invoices program, respectively). This will make it easier to retrieve the invoices/memos opened by the program, as only the new ones will have temporary numbers (with the prefix T ).
