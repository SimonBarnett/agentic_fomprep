# Customer_Credit_Setup_1

- **Source:** `Customer_Credit_Setup_1.htm`

Customer Credit - Recording Customer Credit Limit 
 
 
- 
 
 
 
# Recording Customer Credit Limits

 

 1 .  Enter the Customers or Financ. Parameters for Customers form and retrieve the desired customer.
 Note : If the customer has a billing customer or a customer for credit, retrieve that customer. 
 

 2 .  Click the Credit tab and record the maximum value of credit permitted to this customer in the Credit Limit column. A zero indicates that the customer's credit is unlimited.
 Note to dual-currency users: Also set the customer's Liability Limit . 
 

 3 .  If you work in a multi-company setting, you can also record a multi-company credit (and liability) limit. 
 Note : Once you assign multi-company limits in one company, the system copies this automatically to all other companies in the multi-company setting. 
 

 4 .  To set a different kind of message for this customer than the system-wide one when the limit is exceeded (e.g., generate an error message rather than a warning), choose the desired value in the Credit Message column.
 Note: Leave the column blank to use the default determined by the CreditMsg constant (in the Financial Constants form). 
 

 5 .  The Credit Currency , which determines the currency in which limits are set and credit usage is calculated, is automatically filled in with the customer's billing currency. Change it if necessary. Example. 
 
## Tips:

 

 ·        To view changes to these values, enter the History of Changes sub-level of the Financ. Parameters for Customers form. 
 

 ·        To view the customer's current credit usage, enter the Customer Credit sub-level of the Financ. Parameters for Customers form and its own sub-level, Credit per Company . 
 

 ·        To view credit limits for many customers at once, run the Credit Limits report.
