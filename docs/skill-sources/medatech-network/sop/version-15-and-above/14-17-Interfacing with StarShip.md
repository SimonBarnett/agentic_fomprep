# 14-17-Interfacing with StarShip

- **Source:** `14-17-Interfacing with StarShip.pdf`

www.priority -software.com   
1/3 ‏Mar. 02,'15 Ver. 03 Cat.No. LB10000271 
 
 SOP: Interfacing with StarShip 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The interface between Priority and StarShip enables the automatic transmission of data related to 
customer shipments via shipping companies such as UPS, FedEx and more. Data from shipping 
documents and/or customer invoices in Priority are transferred automatically to the shipping 
company via the StarShip software you have installed. The interface also enables you to receive the 
shipment’s tracking number and shipping price from the shipping company and integrate these data 
directly into the shipping document/invoice in Priority. 
This document describes the setups required to work with the interface, as well as the operations 
performed in order to transfer data. 
Setups 
 Ensure that you have received and installed the license for Priority’s EDI for Shippers module. 
 Ensure that your company is registered as a customer of the relevant shipping company or 
companies and that you have your shipping account number. 
 Install StarShip version 9.9.72 or above on the server and on the workstation you will use to run 
this interface. 
 Complete all stages of StarShip's initial Setup Wizard. When setting up the Financial System 
Interface, select the StarShip Server interface to enable communication with Priority. 
Procedure 
Stage I: Recording Data Definitions and Parameters 
Aim: To record preliminary definitions in Priority, which must be set before running the outgoing 
interface from Priority to StarShip. 
1. Enter the Drivers/Shippers form. Define a record for each shipping company (carrier) that you 
work with. 
2. In the Packing Crate Codes form, define packing crates, including Weight, Length, Width, and 
Height. These data will be transferred to StarShip when the interface is run, and serve as a 
basis for shipping prices. 
3. If there are customers whose account with the shipping company should be billed for delivery 
costs, record the customer account data in the Accounts at Shippers form (a sub-level of 
Customers) in the record for the relevant shipping company. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Mar. 02,'15 Ver. 03 Cat.No. LB10000271 
 
4. In the Customers form, and the Customer Sites sub-level, record a Street Address for the 
customer/customer sites. These data will be transmitted automatically via the outgoing interface, 
unless a different shipping address has been defined for the document in question. 
Stage II: Mapping Shipping Codes in StarShip 
Aim: To map Priority shipping codes to the carrier(s) and types of service that you work with in 
StarShip. 
1. In Priority, enter the Shipment Codes form and designate the shipping companies (carriers) and 
modes of shipping (types of service) that are usually used in your company. 
2. Run the Map Shipping Codes for StarShip program. A StarShip window opens, displaying the 
shipment codes you defined in Priority. 
3. Map each code to the corresponding carrier (e.g., UPS, FedEx) and service (e.g., UPS Ground, 
UPS Next Day Air). 
Note: If you record shipments in more than one company in Priority, the above steps must be 
performed for each company. 
Stage III: Running an Interface between Priority and StarShip 
Aim: To import data from a shipping document/customer invoice into StarShip and to update the 
shipping document/ invoice with the tracking number and shipping price generated in StarShip. 
Notes:  
 If a given shipping document is based on packing crates, a separate package will be opened in 
StarShip for each crate. When shipping directly from an invoice, only one package will be 
opened in StarShip for the entire shipment. 
 If the customer’s account was charged by StarShip, the shipping price will not be imported into 
Priority. 
1. In the shipping document/sales invoice/over-the-counter invoice, select the desired carrier in the 
Shipper/Driver No. column and specify a Shipment Code. 
2. When you finish recording the shipping document/invoice, change the document’s status to one 
that is flagged for Shipping. 
3. Select Ship by StarShip from the list of Direct Activations. 
Note: Flag the Upd Shipping Price option to have the program update the shipping price 
automatically in the shipping document/invoice. 
4. The StarShip Shipping window opens, displaying the shipping data you defined in Priority. 
Revise these data as necessary. 
 The following data are taken from the shipping document/invoice and the Shipping Address 
sub-level form. Any missing fields are taken from the corresponding customer record: order 
number, customer number, customer name, contact, street address, city, state, zip code, 
country, phone number, fax number, e-mail address, customer PO number, shipment code, 
customer's account at shipper (if any). 
 If the shipping document is based on packing crates, the following data are taken from the 
packing slip. Otherwise, these data will be taken from the shipping document/invoice: weight, 
length, width, height, details. 
5. In Starship, select Save from the File menu to save the shipment. The tracking number and 
shipping price generated in StarShip are recorded automatically in Priority (in the corresponding 
shipping document/customer invoice).

www.priority -software.com   
3/3 ‏Mar. 02,'15 Ver. 03 Cat.No. LB10000271 
 
Results 
 A line is added to the itemized shipping document/invoice with the predefined “Shipping” part 
number, the quantity “1”, and the imported shipping price (unless shipping costs were charged to 
a customer or third party account). 
 The Tracking Number assigned by the shipping company is updated in the relevant shipping 
document, packing slip or customer invoice. This number will be displayed on printouts of the 
document, thereby facilitating tracking of your shipment.
