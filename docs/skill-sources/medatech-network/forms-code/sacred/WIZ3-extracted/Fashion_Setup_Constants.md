# Fashion_Setup_Constants

- **Source:** `Fashion_Setup_Constants.htm`

Fashion - Setting Up Order Items 
 
 
- 
 
 
 
# Setting Up Order Items

 

Two parallel constants – SAutoFindOrd for sales transactions and PAutoFindOrd for purchase transactions – determine the method by which shipped items are linked to the orders (and order lines) in which they were originally recorded. 
 

When supplying one large customer (e.g., a wholesaler), where each sales or purchase order may contain hundreds of line items, it is highly recommended to set the PAutoFindOrd constant to the value 1 or 3 and the SAutoFindOrd constant to the value 1 or 3 . In this way, when a shipped part is recorded in the shipping document, the appropriate order and line number will be filled in automatically. 
 
## To set the constants:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Check the values of the PAutoFindOrd and SAutoFindOrd constants and change them, if necessary.
