# 12-17-Delivery Scheduling

- **Source:** `12-17-Delivery Scheduling.pdf`

www.priority -software.com   
1/5 ‏Feb. 03, '15 Ver.02 Cat.No. A8000052 
 
 SOP: The Delivery Scheduling Module 
Customer:   Company Inc. 
 
Assigned to: 
 
Dept./Position 
Aim 
Priority's Delivery Scheduling module allows you to schedule the delivery of goods to customers 
by assigning sales orders to distribution routes and delivery dates. You can schedule deliveries 
manually or use an automatic scheduling mechanism. 
Working Assumptions 
The automatic scheduling program assigns a delivery date, distribution route and distribution round 
to each sales order, when the following conditions are met:  
 The necessary setups have been performed (see below). 
 There are sales orders in the system whose status allows shipment. 
 At least one of the items in each sales order belongs to a part family defined for delivery. 
 The sales orders are open.  
Setups 
Defining Delivery Vehicles and Distribution Routes 
1. Enter the Vehicle Types form. 
2. For each vehicle type, record a Vehicle Type Code, Vehicle Type Desc., Maximum Weight 
and Maximum Volume. 
3. Enter the Drivers/Shippers form. 
4. For each driver and shipping company, record a Shipper/Driver No., Shipper/Driver Name, 
Phone Number and Complete Address. 
5. In the Shipping Costs sub-level form, you can define deliveries in the various vehicles used by 
the shipper. For each vehicle, define the price of shipping in each region. 
6. Enter the Transports form. 
7. For each vehicle, record a license number. Select the relevant Vehicle Type Code and 
Shipper/Driver No.. 
8. Enter the Distribution Routes form. 
9. For each distribution route, record a code in the Code-Distrib. Route column, and a description 
in the Distrib. Route Desc. column. Specify the default Warehouse from which the goods are 
taken for this route, the relevant Truck No. and Driver Code.  
Note: You can also define a default warehouse for each employee in the Personnel File. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 ‏Feb. 03, '15 Ver.02 Cat.No. A8000052 
 
Defining Parts and Part Families for Delivery 
Scheduling deliveries for orders is only possible for parts that belong to a part family defined for 
delivery. 
1. Enter the Part Families form. 
2. For each family whose parts are intended for delivery, flag the Delivery Scheduling column. 
3. Enter the Financial Parameters for Parts form. 
4. For each part, click the Shipping Expenses tab and specify the part's Weight and Volume 
(together with the appropriate units of measure). 
Defining Delivery Parameters for Customers 
For each customer that you want to include in automatic delivery scheduling, you need to define a 
distribution route, unloading time and fixed delivery dates. These parameters will affect the 
scheduling of deliveries to this customer.  
1. Enter the Customers form and retrieve the customers that you want to include in automatic 
delivery scheduling. 
2. Click the Shipments tab, select the appropriate Distribution Route for the customer's address, 
and specify the Delivery Unload Time. 
3. Enter the Delivery Days sub-level form and specify the days of the week the customer receives 
deliveries, each in a separate line. 
4. Enter the parallel Customer Parts sub-level form. For each part, record the Cust. Part Number 
and Customer's Bar Code. 
5. Enter the Financial Parameters for Customers form. 
Tip: You can enter by Direct Activation from the Customers form. 
6. Check the following columns in the Invoices tab: 
 Periodic Invoice – determines whether the customer receives multi-shipment invoices. 
 Delivery with Sales Inv. – determines whether shipments to this customer are recorded in a 
sales invoice or shipping document. 
 Hide Prices in Shipping Docs – determines whether prices appear in shipping documents 
recorded for this customer. 
Defining Statuses for Sales Orders 
In order to schedule deliveries for ordered goods, you need to make sure that the sales order in 
question has a status that permits delivery. 
1. Enter the Statuses for Orders form. 
2. Make sure that at least one status is flagged in the Allow Shipmt/ProjRep column. 
Note: The statuses that permit shipment should be consistent with the company's work flow 
processes. 
Procedure 
Stage I: Automatic Scheduling of Orders 
The automatic scheduling program schedules orders for the appropriate distribution routes and 
delivery rounds, according to the weight and volume constraints of the vehicles assigned to that 
route.

www.priority -software.com   
3/5 ‏Feb. 03, '15 Ver.02 Cat.No. A8000052 
 
1. Run the Schedule Deliveries program.  
2. If the total weight and volume of the orders scheduled for a given delivery route and round 
exceeds the maximum values defined for the vehicle, a warning message will appear when the 
program is finished. To view all delivery routes in which such a deviation has been detected, run 
the Excess Weight & Volume by Route report. 
3. You can run the Insufficient Bal for Deliv Date report to check any missing inventory balances 
needed for scheduled orders (see Stage IX for a detailed explanation). 
Stage II: Viewing and Revising Scheduled Deliveries 
After running the scheduling program, check the following factors in the resulting scheduled 
deliveries: 
 Are the orders scheduled for delivery the ones you in fact wanted to schedule? 
 Are the orders scheduled for the correct distribution routes? 
 Do the weight and volume of any scheduled deliveries exceed the maximum defined for the 
relevant vehicle? 
 Does the total required unloading time exceed the time assigned to the relevant delivery 
rounds? 
 Do the delivery dates fall on the days of the week defined for receipt of delivery by the 
customers? 
1. Enter the Delivery Dates form and retrieve the deliveries scheduled for the desired date. 
2. Enter the Delivery by Distribution Route sub-level form. This form displays distribution routes 
scheduled for the selected date. Make any necessary revisions. Make sure the weight and 
volume in the relevant columns do not exceed the maximum capacity of the vehicle defined for 
each distribution route. 
3. Enter the parallel Orders Scheduled for Delivery sub-level form. This form displays the orders 
scheduled for the various distribution routes. Delete any irrelevant orders, and revise delivery 
dates and distribution routes as needed. 
Note: If the Exception column is flagged, the delivery has been scheduled for a day that is not 
defined for receipt of deliveries by the customer. 
Stage III: Canceling a Scheduled Delivery 
1. Enter the Delivery Dates form and retrieve the deliveries scheduled for the desired date. 
2. To delete a delivery date, make sure that there are no orders scheduled for it, and select Delete 
Delivery Date from the list of Direct Activations. 
3. To delete an order scheduled for delivery on a given date, enter the Orders Scheduled for 
Delivery sub-level form and press Ctrl-Delete on the desired order. 
Stage IV: Rescheduling a Single Order 
1. Enter the Order Delivery form.  
2. Retrieve the order that you want to schedule (e.g., by delivery date). 
3. Revise the delivery date, delivery type, distribution route and/or round, as needed. 
Tip: You can make the same revisions in the Scheduled Orders sub-level of the Delivery 
Dates form. See Stage III above.

www.priority -software.com   
4/5 ‏Feb. 03, '15 Ver.02 Cat.No. A8000052 
 
Stage V: Order Picklist per Delivery Date 
 Run the Delivery Picklist by Order and Print Orders with Picklist reports to facilitate order 
assembly by the warehouse staff. See Stage IX. 
Stage VI: Preparing Documents to Accompany the Shipment 
1. To automatically prepare sales invoices/shipping documents for the scheduled orders, run the 
Prepare Sales Invs+Shipping Docs program. 
Note: This program only opens documents for open orders with a status that allows shipment, 
whose distribution routes and delivery dates match those entered as input. 
2. Sales invoices and customer shipments are opened with the "Draft" status. Enter the relevant 
form (Sales Invoices or Customer Shipments), and retrieve the opened documents (e.g., by 
document date, delivery date, driver or vehicle). 
3. Finalize each document. 
Stage VII: Changing the Scheduled Driver or Vehicle in Final Sales 
Invoices/Customer Shipments 
 Run the Revise Truck No./Driver in Docs program. In the input screen, specify the desired 
delivery date, distribution route and round. Only invoices/shipping documents that meet the 
designated criteria will be affected. 
Stage VIII: Printing Sales Invoices/Customer Shipments by Driver 
1. Run the Print Shipping Document or Print Sales Invoice program. 
2. Press F6 from the Document or Invoice column in the input screen. 
3. In the form that opens, retrieve the relevant documents (using the Delivery Date and Driver 
columns). 
Tip: You can view all the retrieved documents by pressing F4. Press F7 on the line of any 
document you don't want to print. 
4. Exit the form to continue running the program. 
Result: 
 All shipping documents recorded for the designated driver and delivery date are printed out in 
batch. In this manner, you can produce the necessary group of documents for each driver. 
Stage IX: Delivery Reports 
 The Insufficient Bal for Deliv Date report (a Direct Activation from the Delivery Dates form) 
compares current inventory balances with the part balances required by the scheduled 
deliveries. Use this report to decide whether to remove an order from this delivery date, or to 
change its quantities. 
 The Delivery Picklist by Order report includes those orders scheduled for given distribution 
routes and delivery dates. For each distribution route, it displays the delivery date and the 
scheduled orders, together with relevant customer details. It also includes a (blank) column for 
the manual recording of the quantities loaded or supplied for each order. 
Note: This report can serve as a delivery plan for the driver making the deliveries. 
 The Delivery List for Driver report displays information from the documents pertaining to the 
shipments scheduled for each driver on a given delivery date.

www.priority -software.com   
5/5 ‏Feb. 03, '15 Ver.02 Cat.No. A8000052 
 
 The Print Orders with Picklist report provides the list of parts to be assembled for a given 
delivery date, for use by the warehouse staff. A form opens in which you can retrieve (e.g., by 
Delivery Date or Distribution Route) the orders that need to be assembled in the warehouse. 
Tip: View all the retrieved orders by switching to Multi-Record Display mode (press F4). Press 
F7 from the relevant line to remove an order from the list. 
Results: 
 All orders that match the designated parameters are printed. 
 The list of orders is submitted for assembly together with the picklist report (Picklist per Order). 
 The warehouse staff can perform an efficient assembly separately for each distribution route or 
vehicle.
