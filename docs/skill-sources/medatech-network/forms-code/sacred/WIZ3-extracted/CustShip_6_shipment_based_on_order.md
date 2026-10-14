# CustShip_6_shipment_based_on_order

- **Source:** `CustShip_6_shipment_based_on_order.htm`

Customer Shipment/Return - Itemizing a Shipping Document Automatically.1 
 
 
- 
 
 
 
# Itemizing a Shipping Document Automatically

 

Before you begin, make sure the SAutoFindOrd constant is set to 0 (in the Logistic Constants form). 
 
## To record a shipping document for one or more orders:

 

 1 .  Enter the Customer Shipments form. 
 Note: At any point in the following process, you can transfer handling of the document to another employee, by specifying his/her username in the Assigned to column (in the General tab). 
 

 2 .  In the Customer No. column, choose the customer for which the shipment is intended. A document number is assigned automatically.
 Notes: 
 

 ·              In the case of a walk-in customer, record the walk-in customer number. Then revise the name in the Customer Name column, and fill in the address and other details in the Customer Details sub-level form. 
 

 ·              If payment for this shipment will be made by a customer other than the usual billing customer (as defined for the current customer in the Financ. Parameters for Customers form), specify the appropriate customer number in the Billing Customer No. column of the Customer Details sub-level form. This customer's account will then appear automatically in the journal entry that opens when an invoice for this shipment is finalized. 
 

 3 .  Check the Contact column to make sure that the relevant shipment contact appears. Change it if necessary.
 Tip: To define new contacts for the customer or to assign a default shipping contact, use the Customer Contacts form, a sub-level of the Customers form. 
 

 4 .  Today's date is filled in automatically as the shipment date. Change it if necessary. 
 Note: If the shipment date falls at the end of the month and the customer is entitled to postpone billing until the next month, the Delay Inv-Next Month column (in the Prices tab) is flagged automatically. As a result, you will not be able to include the shipment in invoices prepared automatically in the current month. Remove the flag if you want to bill this shipment immediately, despite the customer definition. For more information, run the Customer Invoices Wizard .
