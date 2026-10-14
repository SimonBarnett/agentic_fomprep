# Delivery_Preparing_Documents_Orders_2

- **Source:** `Delivery_Preparing_Documents_Orders_2.htm`

Delivery Scheduling - Preparing Documents for Deliveries Based on Sales Orders.2 
 
 
- 
 
 
 

 To change the type of shipping document that will accompany an order: 
 

 1 .  Enter the Deliveries by Order form. 
 

 2 .  Retrieve the desired order (e.g., by its Delivery Date ). 
 

 3 .  In the Delivery Doc Type column, select the desired type. 
 
## To prevent automatic itemization of the document:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the SAutoFindOrd constant and change its value to 2 or 4 . 
 
## To always record the total ordered quantity:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the SDelivAll constant and change its value to 1 . 
 
## To allow orders for which sales invoices or shipping documents have been opened to be closed automatically:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the SClsDelivOrd constant and change its value to 1 . 
 
## To prevent automatic updates to ordered goods scheduled for delivery once shipment is recorded:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the SUpdOrdDet constant and change its value to 0 . 
 
## To view scheduled deliveries for which there is currently insufficient warehouse inventory:

 

 1 .  Enter the Delivery Dates form and retrieve the date of the deliveries whose inventory you want to check. 
 

 2 .  Select Insufficient Bal for Deliv Date from the list of Direct Activations .
