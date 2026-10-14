# Customer_Credit_Setup_4

- **Source:** `Customer_Credit_Setup_4.htm`

Customer Credit - Defining How Tax is Handled 
 
 
- 
 
 
 
# Defining How Tax is Handled in Calculating Customer Credit

 

In regard to some transactions (e.g., sales orders and unbilled documents , credit usage calculations normally refer to total price but disregard tax. In regard to other transactions (e.g., unpaid bills), credit usage calculations generally take tax into account. The system enables you to change these defaults, thereby including tax in the first case or disregarding it in the second. 
 
## Including Tax in Credit Calculations

 

The CreditAddTax constant determines whether tax is added when calculating open orders and unbilled documents. Its pre-set value is 0 (tax is not included). 
 
## To include tax:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Change the value of the CreditAddTax constant to 1 . 
 
## Subtracting Tax From Credit Calculations

 

The CreditSubTax constant determines whether tax is subtracted from the sum of open debt (and, in the dual-currency package, of postdated checks) recorded in the ledger, when calculating the customer's credit usage. Its pre-set value is 0 (tax is included). 
 
## To subtract tax:

 

 ·        Move to the line for the CreditSubTax constant and change its value to 1 .
