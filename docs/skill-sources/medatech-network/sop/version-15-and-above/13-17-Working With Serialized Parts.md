# 13-17-Working With Serialized Parts

- **Source:** `13-17-Working With Serialized Parts.pdf`

www.priority -software.com   
1/3 Mar. 02,'15 Ver. 02 Cat.No. LB10000172 
 
 SOP: Working With Serialized Parts 
Customer:   Company Inc. 
Assigned to:  Dept./Position 
Aim 
Assigning serial numbers to parts allows you to determine which specific serialized parts are 
included in each inventory transaction, enabling you to track the part through all its transactions. 
Setups 
1. Make sure serial numbers are assigned to parts: 
 Enter the Service Parameters for Parts form and retrieve the desired parts. 
 For each part, ensure that the Maintain Serial Nos column is flagged. 
Note: You can only assign serial numbers to parts whose buy/sell unit and factory unit are 
both defined as "ea". 
2. Set the maximum quantity of serial numbers that can be opened automatically in a batch: 
 Enter the Logistic Constants form and set the value of the CMaxSernOpen constant.  
3. Set the starting point for warranties of serialized parts: 
 In the Logistic Constants form, set the value of the CAutoWarrant constant. 
Note: By default, the warranty period for a serialized part begins when the part is shipped to 
the customer. You can change the constant so the period begins when the part is installed. 
4. Define sites, facilities and systems for storage of serialized parts: 
 In order to define the physical locations in which serialized parts are stored, you must first 
define Systems, Facilities and Sites in the corresponding forms. The defined locations can 
later be assigned to specific serialized parts. 
Procedure 
Stage I: Opening New Serial Numbers 
Opening Serial Numbers Without an Inventory Transaction 
To open a group of serial numbers: 
 Run the Open Serial Numbers program. You can view the new numbers in the Catalogue of 
Parts w/Serial Nos. form. 
To open a serial number manually: 
1. Enter the Catalogue of Parts w/Serial Nos. form. 
2. Specify the Part Number and record its Serial No. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Mar. 02,'15 Ver. 02 Cat.No. LB10000172 
 
3. Click the Part Location tab and specify the Warehouse in which it is stored. 
Opening and Assigning Serial Numbers in an Inventory Transaction  
The following example refers to a customer shipment. The same process applies to other inventory 
transactions. 
1. Enter the Customer Shipments form and retrieve the desired shipping document. 
2. If the shipment is recorded for a specific customer site, make sure the Site is defined in the 
References tab (this site will subsequently be defined for the serialized parts). 
3. Enter the Shipped Items sub-level form and move to the line for the part in question. 
4. Enter the Auto Recording of Serial Nos. sub-level form. Flag the Open New Serial Nos 
column, and fill in the remaining details. 
5. Enter the parallel Serial Numbers in Transaction sub-level form and check the new serial 
numbers. 
Note: You can also use this form to define the desired serial numbers manually, rather than 
creating a consecutive set automatically. 
Stage II: Recording and Viewing Data Pertaining to the Serialized Part 
1. Enter the Catalogue of Parts w/Serial Nos. form and retrieve the desired serialized part. 
2. Click the Customer Details tab: 
 If the serialized part was already shipped to the customer, you can view the customer's 
details. 
 If the part has already been installed at the customer site, record the Installation Date. 
3. If the serialized part's warranty period has already begun, you can view the warranty details in 
the Warranty tab. 
4. Click the Servicing tab: 
 If the serialized part was already serviced, you can view the details of the last servicing. 
 You can determine the next type of servicing required for the part in the Next Servicing 
column. 
 You can view and revise the types of servicing required for the part in the Servicing 
Requirements for Item sub-level form. 
5. If the serialized part was not yet sent to the customer, you can record its location in the company 
warehouse in the Part Location tab. 
6. In the System Number column, indicate the number of the system in which the part is located. 
The Site and Facility columns are filled in automatically with the site and facility to which the 
system is assigned, but may be revised. 
7. Use the Service Calls for Serial Number and Malfunctions of the Part sub-level forms to view 
the service calls opened for this serialized part. 
8. Use the Service Contracts for Item sub-level form to view the service contracts opened for this 
serialized part. 
9. Use the Extend Warranty sub-level form to extend the warranty period covering this serialized 
part.

www.priority -software.com   
3/3 Mar. 02,'15 Ver. 02 Cat.No. LB10000172 
 
Stage III: Handling Serialized Parts that were Returned for Repair 
Scenario A: The part is repaired in the laboratory and returned to the customer 
1. Enter the Warehouses form and define a repairs warehouse. 
Note: Make sure to remove the check mark from the Inventory Valued column (in the General 
tab). 
2. To record the receipt of a serialized part for repair, enter the Customer Returns form and open a 
new document in the usual manner. 
3. In the Receiving Warehouse column of that form (in the General tab), select the defined 
repairs warehouse. 
4. Record the details of the returned part in the Returned Items sub-level form. 
5. Enter the Serial Numbers in Transaction sub-level form and record the serial number of the 
returned part.  
6. To record the shipment of the repaired part to the customer, enter the Customer Shipments form 
and open a new document in the usual manner. 
7. In the Sending Warehouse column of that form (in the General tab), select the repairs 
warehouse. 
8. Record the details of the repaired part in the Shipped Items sub-level form. 
9. Enter the Serial Numbers in Transaction sub-level form and record the serial number of the 
shipped part.  
Scenario B: The customer receives a replacement part 
1. The serialized part is sent to the regular company warehouse; record a Customer Returns 
document accordingly.  
2. The replacement part is sent to the customer; record a Customer Shipments document. 
3. The defective part is repaired in the company laboratory. Record all replacement parts, 
components and work hours invested in the repair in the Service Calls form for the fictitious 
"Goods" customer.  
4. The repaired part is sold to another customer.
