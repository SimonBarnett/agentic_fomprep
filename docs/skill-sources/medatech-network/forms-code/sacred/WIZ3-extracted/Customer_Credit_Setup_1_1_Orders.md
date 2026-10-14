# Customer_Credit_Setup_1_1_Orders

- **Source:** `Customer_Credit_Setup_1_1_Orders.htm`

Customer Credit - Taking Sales Orders into Account 
 
 
- 
 
 
 
# How to Treat Sales Orders in Credit Calculations

 

The CreditOrders constant determines whether sales orders are taken into consideration when calculating customer credit and how the system will respond when an order is recorded that exceeds the customer's credit limit. 
 
## To set the constant: 

 

 1 .  Enter the Financial Constants form and move to the CreditOrders constant. 
 

 2 .  Set the value of the constant as follows: 
 

 ·              0 – Sales orders are treated like all other documents. That is, they are taken into account in credit calculations, and the CreditMsg constant determines what kind of message is given (if any) if the credit limit is exceeded when recording an order. 
 

 ·              1 – They are taken into account in credit calculations, but the CreditMsg constant does not apply: a warning is always given if the credit limit is exceeded when recording an order. 
 

 ·              2 – Orders are ignored in credit calculations, but a warning is given when recording an order if the customer's credit limit has already been exceeded (regardless of the value assigned to the CreditMsg constant). 
 

 Note: To approve a sales order for shipment and billing to a customer that has exceeded the defined credit limit, the order needs to receive a status flagged in the Credit Deviatn Authd attribute (in the Statuses for Orders form). This status will have no relevance when the CreditOrders constant is set to 0 , and the CreditMsg constant is set to 2 , in which case an error message prevents an order from being opened.
