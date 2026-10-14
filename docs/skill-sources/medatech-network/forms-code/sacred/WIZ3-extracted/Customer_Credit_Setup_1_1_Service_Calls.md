# Customer_Credit_Setup_1_1_Service_Calls

- **Source:** `Customer_Credit_Setup_1_1_Service_Calls.htm`

Customer Credit - Taking Service Calls into Account 
 
 
- 
 
 
 
# How to Treat Service Calls in Credit Calculations

 

The CreditServCalls constant determines whether service calls are taken into consideration when calculating customer credit and how the system will respond when a service call is recorded that exceeds the customer's credit limit. 
 
## To set the constant: 

 

 1 .  Enter the Financial Constants form and move to the CreditServCalls constant. 
 

 2 .  Set the value of the constant as follows: 
 

 ·              0 – Service calls are treated like all other documents. That is, they are taken into account in credit calculations, and the CreditMsg constant determines what kind of message is given (if any) if the credit limit is exceeded when recording a service call. 
 

 ·              1 – They are taken into account in credit calculations, but the CreditMsg constant does not apply: a warning is always given if the credit limit is exceeded when recording a service call. 
 

 ·              2 – Service calls are ignored in credit calculations, but a warning is given when recording a service call if the customer's credit limit has already been exceeded (regardless of the value assigned to the CreditMsg constant).
