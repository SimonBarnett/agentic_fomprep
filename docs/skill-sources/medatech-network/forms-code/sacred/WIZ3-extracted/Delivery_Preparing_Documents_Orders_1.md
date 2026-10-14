# Delivery_Preparing_Documents_Orders_1

- **Source:** `Delivery_Preparing_Documents_Orders_1.htm`

Delivery Scheduling - Preparing Documents for Deliveries Based on Sales Orders.1 
 
 
- 
 
 
 
# Preparing Documents Based on Sales Orders

 

You can prepare shipping documents or sales invoices for a delivery automatically, on the basis of one or more sales orders. The type of document opened for each customer depends on whether the Delivery with Sales Inv. column (in the Financ. Parameters for Customers form) is flagged. If you want to accompany a specific order with a different document than the customer default, you can change the document type. 
 

Normally, the documents are opened and itemized automatically, under the assumption that all ordered parts are being shipped together. However, if you want to determine which of the order items are being shipped, you can set a constant that will prevent automatic itemization. The same constant can also be set to have the system open a second line for any additional quantity that is available for delivery and exceeds the order balance, provided there is another order for the same part. The line opened for this surplus will be linked to the second order. By default, details of the ordered goods are subsequently updated (in the Schedule Orders by Distr. Route form) based on the new balance to ship. However, you can set a constant that will prevent such automatic updates, if desired. 
 

By default, the resulting document only specifies the total ordered quantity if it is available in inventory. Otherwise, only the quantity to be delivered is specified, and the order remains open. If you are accustomed to preparing shipping documents before your inventory data is fully updated in the system (e.g., in a buy/sell situation, where deliveries are scheduled before receipts can be recorded in the system), you can set up the program to always use the total ordered quantity, whether or not it is recorded in the system as available for delivery. You can later run a report to view scheduled deliveries for which inventory is unavailable in the warehouse.
