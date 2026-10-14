# 18_1 release notes

- **Source:** `18_1 release notes.pdf`

www.priority -software.com   
1/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
 
Release Notes Priority 18.1 
Highlights  
Priority  Talk  
Priority's new internal collaboration tool allows you to communicate with colleagues across 
departments and share information regarding documents that you are tracking. More …  
 
User Interface  
 New! Up-to-date data (e.g., open sales orders, open purchase orders, profit and loss) can now 
be graphically displayed in portlets on your home page, to help you focus on what matters. 
More…

www.priority -software.com   
2/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
 
 To delete a home page tile, hover over the top right corner of the tile, click the three dots, then 
click Delete. This replaces the garbage can. 
 
 The number of characters that can be saved in a buffer (F9) has been increased. Due to this 
change, values saved in a buffer before the system was upgraded to 18.1 must be resaved after 
the upgrade. 
Financial s 
Accounts Payable  
 Do your vendors use cash-based accounting? In the new Link Payments to Invoice form (sub-
level of Multi-GRV Invoices), you can flag payments made to a vendor that works with cash-
based accounting (i.e., sends pro forma invoices) in order to itemize the invoice. Once the 
invoice is finalized, it will be reconciled with the  payments. For more information, see: SOP – 
Cash Based Accounting (Vendors). 
 The new Prepare Payments (No Invoice) program allows you to automatically prepare multiple 
payment documents for equal payment installments to a vendor, unrelated to any invoice. 
Payments will be opened in either the Check Payments or the Payments by Bank 
Transfer form.   
Accounts Receivable   
 Preparing invoices just got easier! From now on, you can open a sales invoice directly from the 
Sales Orders form by running the new Prepare Sales Invoice program by Direct Activation.   
 Improvements to multi-shipment invoices:   
o The new OpenInvPerOrder financial constant allows you to determine which orders will 
be billed together when the Prepare Invoices program is run. More… 
o You can override the above definition for a specific customer in the Prep Invoices by 
Ord column in the Financ. Parameters for Customers form. 
o Columns were added to the Unbilled/Uncredited Documents form (which opens when 
the Prepare Invoices program is run):  
 Billing Cust Number, Billing Cust Name – allows you to bill orders that 
have the same billing customer together.

www.priority -software.com   
3/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
 Customer's Purch Ord – allows you to bill orders from the same original 
purchase order together. 
 US Users: Priority now supports payments via Authorize.Net! You can use the Authorize.Net 
payment gateway to process individual online credit card payments from customers. More…  
General Ledger  
 US Users: Use AmEx for your company expenses? With the new Load American Express 
Statements program, you can import your American Express statements into Priority. 
Statement items will be loaded into the Record Bank/AmEx Statements form, after which they 
can be reconciled with expense accounts.   
For more information, see SOP - American Express Reconciliations. 
 You can now define a fiscal period two weeks from the beginning or end of the month (as 
opposed to one week, which was previously allowed).    
 When running the Restore Canceled Reconciliations program, use the new How to Restore 
column to choose between restoring reconciliations to the ledger (where they will be reconciled 
again), or loading them to the reconciliation worksheet where they can be revised.  
More Improvements to Financials  
 Two new sub-levels were added to the Financial Constants form: 
o In the Financ. Constants per Group/User form you can customize the value of the 
OneInvPerPrj constant for specific groups or individuals when preparing multi-
shipment/pro forma invoices for projects.  
o The History of Changes sub-level form allows you to keep track of changes made to 
constants.   
 Wondering why there's a discrepancy in your cashier balance? Run the new Check Cashier's 
Cash Balance report to view problems that occurred when deposits to the specified cashier 
were made.  
 UK Users: To set up and produce the VAT report for use in the UK, run the new VAT Report – 
UK. For more information, see SOP – UK VAT Report.  
 EU Users: Improvements to the Intrastat report: The Terms of Delivery column was added to 
the Sales Order - Customer Details form (sub-level of Sales Orders) indicating the code of the 
delivery terms used in the shipment of goods. More… 
 French Users: You can use the new Include Opening Bals column, when running the Create 
FEC File, to include the opening balances of all accounts in the system in addition to journal 
entries.

www.priority -software.com   
4/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
Warehouse Management System (WMS)   
 Improvements to the Create Put Wave (by Inventory) program: 
o Use the new Split Task by Pallet input column to split putaway tasks for different pallets 
included in the wave (so that each pallet will appear in a separate task). 
o Use the new Put Priority column in the Flag Inventory form (that opens when the 
program is run) to indicate the relative importance to be assigned to putting away 
inventory of a particular line. 
 When running the Create Pick Wave (by Order) program, you can now pick a group of order 
items together in one pick task. By assigning an identical number to each order item in the group 
in the Group for Picking column in the Order Work Area or Flag Open Order Items form, the 
system will only include lines with the same number in the same pick task. 
 Not sure why a warehouse task was split? The reason for the splitting is now displayed in the 
Task Split-Reason column in the Warehouse Tasks and in the Warehs Tasks That Were 
Created forms.  
 When running the Create Inventory Count Wave program, you can now limit the warehouse 
tasks created to parts not counted from a specific date, as designated in the Not Counted 
Since input column.   
 In the Reasons for Pick/Put Exceptions form, the new No Inventory column allows you to 
indicate that a pick task was not completed due to insufficient inventory. More…  
 New for Fashion module users: The new Split Sets column in the Task Splitting Methods form 
allows you to create separate warehouse tasks for each fashion set (i.e., the same lot + style + 
color) when creating a pick by order wave.  
 The maximum number of tasks that can be included in a wave was increased to 999,999 
(instead of 9,999).  
 Your time is valuable! We've made many behind-the-scenes changes to speed up pick and 
replenishment waves. 
Sales , Purchasing and Inventory  
Customer Shipments  
 US users: Priority now integrates with ShipStation to ship goods via shipping carriers such as 
UPS, FedEx and many others. Data from shipping documents in Priority are transferred to 
carriers via ShipStation. In response, tracking numbers and labels are recorded in the shipping 
document. For more information, see SOP – Interfacing with ShipStation.

www.priority -software.com   
5/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
 It just got easier to open customer shipments. You can run the Prepare Shipping Document 
program by Direct Activation straight from the Sales Orders form.  
 Invoices for Document, a new sub-level of the Customer Shipments form, displays all the 
invoices in which the shipping document was billed. 
Cancelling Documents and Authorizations  
 Many documents can now be cancelled by Direct Activation straight from the form. Run the 
Cancel Document program from the Customer Shipments, Customer Returns, Goods 
Receiving Vouchers, Returns to Vendors and Inventory Count forms. Run the Cancel Sales 
Order program from the Sales Orders form.  
 In the Purchase Orders form, you can now automatically cancel all existing authorizations of an 
order via the Cancel Round of Auth flag added to the Statuses for Purchase Orders form.   
More Improvements to Sales, Purchasing and Inventory  
 Two new sub-levels were added to the Sales Orders form: Documents Opened for the Order 
and Purchase Orders for Sales Order. These forms display the sales, purchasing and financial 
documents opened for the order's items 
 The new Customer Sites form displays the addresses of all customer sites and also allows you 
to record new ones.   
 The new OnLineSnTree logistics constant allows you to determine whether, when recording 
serial numbers for inventory transactions, links between parent and child parts will be updated 
as soon as you leave the form in which they are recorded or only when you enter the Serialized 
Components of Part form (sub-level of the Catalogue of Parts w/Serial Nos. form). 
 Use the new Free Text and Free Text 2 columns in the Serial Numbers in Transaction form to 
record brief details that can be used to retrieve the serialized part in the Catalogue of Parts 
w/Serial Nos. form.  
 Automatic calculations of bonuses were added to the Price Quotations for Customers, Over-
the-Counter Invoices and Sales Invoices forms. You can block automatic calculation of 
bonuses in specific documents via the new Ignore Bonuses flag. For more information, see: 
SOP - Bonuses. 
 You can designate the hours during which a branch operates in the new Work Hours at Branch 
form (sub-level of the Branches form).

www.priority -software.com   
6/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
Payroll, Time and Attendance  
 It's now easier to calculate employee convalescence pay with the new columns added to the 
Payroll Data per Employee and Monthly Salaries forms.   
 The new Tax Credits per Date form (sub-level of Tax Benefits, itself a sub-level of Payroll 
Data per Employee) allows you to view past values of a given tax credit. 
 You can now run the Fund Payments report for employees in a specific Department or for a 
Subsidiary. 
 Use the new Check Salaries report to check for problems with salaries (e.g., missing records).    
 A new Tab-Delimited column was added to the Define Pay Report Load Params form, 
allowing you to indicate that the file loaded from an external program is tab-delimited.   
 Use the new Magnetic Card No. column in the Payroll Reporting Interim Table to record the 
magnetic card number of the employee for which the report was recorded (and the Magnetic 
Card No. 2 if he/she reports to two different companies).   
 An Attachments sub-level form was added to the Payroll Reminders form, allowing you to 
attach documents relevant to the reminder. A check mark in the new Attachments column in 
the upper-level form indicates that attachments have been uploaded.  
 The Additional Reports sub-level form was added to the Batch Payroll Reporting form, 
allowing you to easily record payroll reports for the salary in the upper-level form. You can only 
make payroll reports for payroll components defined as included in the Short Choose List in the 
Payroll Components form.   
 You can now run the Payroll Entries report by department (instead of by employee).  
 Columns were added to the Interim Table-Employees form, along with a new sub-level, 
Employee's Children-Details.  
Customer Service  
Servic e Contracts  
 The Site column was added to the Service Contracts form, allowing you to define a site for a 
specific contract. When invoices are prepared for the contract, the site address will appear as 
the address in the invoice. 
Meters  
 The new Meters module provides full management of serialized parts that include meters (e.g., 
photocopiers). The module enables you to open service contracts for the parts, manage meter

www.priority -software.com   
7/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
readings, bill customers and open payments. The module includes new entities and expanded 
functionality in the Service Contracts and Service Calls menus. More… 
System Maintenance  
 The Recent Processes sub-level form was added to the Define TTS Tasks form, enabling you 
to view information pertaining to recent activations of tasks run by the Tabula Task Scheduler.  
 Data migration: The following columns were added to the Interim Table-Customers form: Cash 
Flow Code, Bk Acc for Cash Flow, Omit From Cash Flow and Customer Category 11-20. 
 You can now define a time zone for a company in the Companies form. Once the time zone has 
been recorded, signatures in the History of Statuses forms will be displayed according to the 
company's time zone. In the web interface, the time displayed will be according to the user's 
time zone. 
Programming  
 Attention Programmers! Priority's new developer portal includes detailed information on how to 
use the new Web SDK that communicates with Priority entities, as well as how to use Priority's 
REST API. Click https://prioritysoftware.github.io. 
 REST now supports the $select and $expand commands, as well as complex queries with 
multiple commands. 
 A new development library, Priority Ionic, makes it easier to build mobile applications using the 
Web SDK. 
 Support was added for JSON.  
 New app generator functionality! You can now add procedures run by Direct Activation from 
forms to the app (available for procedures without input).  For more information, see: Priority 
Application Generator. 
 Improvements to the Priority Master app for smart phones: You can now choose the company 
in which you're working from within the app. 
 When defining an app, in the Form Columns form (sub-level of Forms in Application, itself a 
sub-level of the Application Generator form), use the Type column to choose special 
functionality available in the column. Choose B to fill in the column with a barcode scanner or P 
to call the phone number appearing in the column by pressing the phone icon.

www.priority -software.com   
8/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
More Information  
User Interface  
Priority Talk 
 This new feature keeps you informed about documents that you're tracking. You will receive a 
notification when the document's assigned user or status changes or when a new comment is 
added to its internal dialogue.  
 To add a document to your chat box (i.e., to flag it for tracking), retrieve the document and click 
the
 icon on the list of shortcuts. You can add other users to the conversation by clicking the 
 icon on the row of shortcuts. 
 Click the bell icon (next to the Favorites menu button) to open the chat that displays the 
documents that you're tracking. The number of new notifications waiting for you is displayed on 
the bell 
 . 
 Click the name and number of the document in order to open it. 
 To add a comment to the conversation, click the arrow next to the document in question in the 
Notifications box. The chat box will open, displaying the history of notifications and a text box 
for comments. 
 To see who else is tracking the document, click the 
   icon on the top right. 
 Another way to add users to your chat is by clicking the 
  icon in the Chat details box. 
 To stop tracking the document, click the 
  icon under the list of users. 
Note: The chat does not take into account documents that were marked for tracking before version 
18.1. In order to receive notifications for these records, enter the Tracking List form and move to 
the document(s) in question. Press F6 to access the document. Click the 
 icon on the row of 
shortcuts to remove the tracking and then click it again to restart tracking. 
Back… 
Portlets 
 To add a portlet to the home page, click the 
  icon on the upper-right side of the home page, 
and choose the desired topic in the window that opens.  
Note: For your convenience, the Portlets menu was added under the Executive Reports

www.priority -software.com   
9/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
menu, enabling you to assign user privileges for portlets. Additionally, you must have the BI 
module installed in order to display portlets on your home page. 
 Hover with your mouse over the upper-left corner of the portlet and then click the three dots that 
appear. Choose one of the following options: 
o Select Choose Dates to select the period for which to display the data. 
o Select Open in New Window to open the portlet in a window outside of the home page. 
o Select Delete to delete the portlet from your home page. 
 Run the Prep for Inv. Analysis (BI) program (for customer and for purchase invoices) on a daily 
basis to update the data displayed on portlets for invoices (the programs can be run at fixed 
times via the Tabula Task Scheduler). All other portlets are updated automatically. 
Back… 
Financials  
Accounts Receivable 
 The OpenInvPerOrder constant allows you to prepare one invoice for all the customer's sales 
orders, prepare a separate invoice for each sales order or prepare a separate invoice for all 
sales orders that share the same Cust's PO.   
Back… 
 Authorize.Net: The new Interface with Authorize.Net menu includes the following entities: 
o A Clearing Methods form for recording the clearing methods used to process credit card 
payments via payment gateways such as Authorize.Net. 
o A Setup for Authorize.Net program for setting up definitions. 
o An Approve Authorize.Net Transact'n program, run by Direct Activation from the Other 
Forms of Payment form (sub-level of Over-the-Counter Invoices and Receipts), used 
to send credit card transactions to Authorize.Net. 
For more information, see SOP-Processing Credit Cd Paymts w/Authorize.Net. 
Back… 
More Improvements to Financials 
 Intrastat: The Terms of Delivery in the sales order are filled in automatically with the code 
assigned to the customer in the Financ. Parameters for Customers form, but may be revised. 
Terms of Delivery in the report itself are taken from the customer shipment or sales invoice, 
and when that is unavailable, from the sales order or the customer details. 
Back…

www.priority -software.com   
10/10 Sept 01,'17 Ver. 01 Cat.No. LB17000607 
 
WMS  
 When a pick exception reason flagged for No Inventory is reported on a mobile device, the 
other open tasks that have not yet been reported (that  include inventory from the same 
warehouse, bin, pallet, part, and work order) will also be filled in with the same reason. This is to 
prevent other pickers assigned to these tasks from trying to pick from that bin. 
Back… 
Custome r Service  
Meters 
 The items in the new Meter Readings menu allow you to prepare, record and view meter 
readings for serialized parts. 
o Use the Meter Readings form to view and record meter readings. 
o To calculate the meter count average for a specific period, run the Calculate Average 
Meter Count program.  
o Run the Check Meter Readings by Contract report to view contracts with meter 
readings that have not yet been billed.  
 The View Meter Readings sub-level form was added to the Service Calls, Catalogue of Parts 
w/Serial Nos. and Items in Contract (sub-level of Service Contracts) forms. This form allows 
you to view meter readings for the serialized part in the upper-level form. 
 You can record and view billing details for a given order item or contract item.  
 Printouts of multi-shipment invoices for meters include details of the meter readings for which 
the customer was billed.   
 Columns were added to the Items in Contract form (sub-level of the Service Contracts form): 
Months to Bill, End-Leasing Payments and Active Lease. Use these columns when the 
customer is leasing the part. 
For more information, see SOP - Working with Meters. 
Back…
