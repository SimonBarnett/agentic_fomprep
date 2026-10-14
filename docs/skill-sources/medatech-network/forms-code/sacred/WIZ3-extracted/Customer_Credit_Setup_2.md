# Customer_Credit_Setup_2

- **Source:** `Customer_Credit_Setup_2.htm`

Customer Credit - Customizing the System Message 
 
 
- 
 
 
 
# Customizing the System Message

 

The CreditMsg constant determines what type of system message the user receives when the customer exceeds the credit limit defined in the Financ. Parameters for Customers form (e.g., while recording a shipment to the customer). The system default is a warning message for all documents. 
 
## To change the default:

 

 1 .  Enter the Financial Constants form and move to the CreditMsg constant. 
 

 2 .  Set the value of the constant as follows: 
 

 ·              0 – no message is displayed 
 

 ·              1 – the system displays a warning message 
 

 ·              2 – the system displays an error message, which prevents the user from completing the record. 
 
## Notes:

 

 ·        You can override the constant for specific customers when recording credit limits. 
 

 ·        You can have the system always give a warning when a sales order is recorded for a customer that has exceeded the credit limit, by assigning a value of 1 or 2 to the CreditOrders constant (regardless of the value of the CreditMsg constant). 
 

 ·        Similarly, you can have the system always give a warning when a service call is recorded for a customer that has exceeded the credit limit, by assigning a value of 1 or 2 to the CreditServCalls constant (regardless of the value of the CreditMsg constant).
