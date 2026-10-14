# Release Notes Priority 16

- **Source:** `Release Notes Priority 16.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/12 Ver.05 Cat.No. LB130136  
 
 
Release Notes Priority 16 
New Web-based User Interface (Priority Rich) 
 Priority's user interface has been rewritten to be fully HTML5 compliant. 
 The new UI is visually similar to the previous Silverlight interface of version 15, but can 
now be run in Chrome, Firefox and Internet Explorer. 
 The move to HTML5 will allow future versions of Priority to be run on tablets and 
other mobile devices. 
Changes to the Word Template Generator 
 In Word 2013, Microsoft changed the way it handles custom XML tags. Therefore, 
Word templates created in Priority version 16 are created using a different 
technology—Content Controls. 
 New templates can be designed in a very similar fashion to the current method. 
 On workstations where Word 2007 or 2010 is installed, users will continue to be able 
to send form data to existing templates. Existing templates cannot be revised. 
 In order to create new templates on workstations where Word 2007 or 2010 is 
installed, an add-on is required. 
 When using the new web-based interface (Priority Rich), users are no longer required 
to have Office installed on their workstations in order to create (non-revisable) Word 
documents using the new templates.  
Working with Gmail 
 Users can send e-mail from Priority directly via Gmail, without Outlook, even when 
working in Priority Lite. E-mails are sent from the user's individual Gmail account. 
 Priority contacts can be synchronized to Gmail. 
 Bi-directional calendar sync between Priority and Gmail. 
 A new Priority Gmail add-on allows synchronization of e-mail messages to Priority: 
o Messages can generate a task or service call. 
o Users can choose the customer/vendor for the task/service call. 
o Tasks opened via a message can be linked to existing documents in Priority. 
 Priority Lite 
 Users can now report attendance and their geolocation can be saved, based on data 
from their mobile device's GPS.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/12 Ver.05 Cat.No. LB130136  
 
 Addition of many new displayed and updateable columns in the forms in Priority Lite. 
 New and improved graphs on tablets and smartphones. 
 Larger, easier to see icons. 
 The user's signature can be added when recording text. 
Finance 
 Improvements to account and bank reconciliations: 
o Electronic signature is now saved when performing account or bank reconciliations. 
o A log is kept of all cancelled reconciliations, and users can restore reconciliations 
that were inadvertently cancelled. 
o Reconciliation variances can be distributed among several adjustment accounts. 
o Adjustment entry data can be updated while finalizing the reconciliation, rather than 
in the Adjustment Entry Definition sub-level form. 
o Reports displaying bank and account reconciliations can be run by Direct Activation 
from all ledger transaction forms. 
o Bank and account reconciliations can be cancelled by Direct Activation from all 
ledger transaction forms. 
 A wealth of improvements to the financial statement generator: 
o Users can define account trees made up of segments of account numbers and build 
financial statements based on that tree. 
o Support for "reverse" totals in statements, where the total appears before the detail. 
o The maximum number of columns in a column bar was increased to 50 columns. 
o Users can produce a financial statement for a specified date range rather than 
defined fiscal periods. 
o Users can define column bars in which the date range and/or subsidiary is 
designated while running the report. 
o Column bars can be defined for divisions (groups of companies). 
o Details of the user who ran the report are now displayed. 
o Customized financial statements can be produced with your corporate logo. 
 Budget items can be filled in automatically based on the GL account and profit/cost 
center: 
o Settings are defined in the Budget for Profit/Cost Ctr+Acct sub-level of the Profit 
& Cost Centers - Group 1 form. 
o The budget item is recorded in invoices and journal entries. 
o Budget checks are not performed in such cases. 
 A new BudgetPostDate constant determines, when recording pre-paid expenses, 
whether to calculate the entire expense for the budget period as of the invoice date, or 
to distribute the expense equally (monthly) throughout the budget period.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/12 Ver.05 Cat.No. LB130136  
 
 A new ZeroPricePurchOrder constant allows you to assign an entry cost of zero to 
items when costing is run, if the same item has a price of zero in the corresponding 
purchase order. 
 There is a new Prevent Manual Entry column in the Chart of Accounts and Journal 
Entry Codes forms. 
 A new NoChangeBud constant prevents changes to the profit center and budget item 
recorded in journal entries in a closed fiscal period. 
 Users can define separate transfer accounts between any two subsidiaries. 
 Accounts can be automatically opened for subsidiaries when A/R, A/P, or GL accounts 
are created in the main company, based on new flags in the Subsidiaries form 
(previously the Affiliates form). 
 Attachments can be linked to GL, A/R and A/P accounts. 
 New Cash Transactions at Cashier report. 
 Compound interest can be calculated on loans, in keeping with a new form column. 
 Improvements to perpetual standard COGS: 
o Automatic reconciliations of Purchases Not Yet Billed and Unbilled Shipments 
accounts. 
o An expense account can be manually defined for issues of supplies and for non-
billable customer shipments. 
o Automatic recording of the purchase budget item in COGS entries, based on the 
sales budget item defined in the sales invoice. 
 Dual-currency users: Exchange rate adjustments can be based on a high/low currency 
rate, rather than the standard rate: 
o New columns in the Currencies form: Low Rate Currency, High Rate Currency. 
o New Adjustment Rate column in the Exch. Rate Adjustment Definition form. 
o The account's exchange rate adjustment is calculated according to the defined rate. 
Accounts Receivable 
 Users can copy a multi-shipment invoice by Direct Activation from within the invoice 
form. Dual-currency users can do the same for export invoices. 
 Sales invoices can now be itemized on the basis of a price quotation. 
 Receipt of advance payment can be linked to the invoice and displayed on its printout. 
 A new OneInvPerSite constant allows preparation of separate multi-shipment invoices 
per customer site. 
 A new Separate Invoice column in customer shipments affects the Prepare Invoices 
program: shipping documents flagged in this column will generate separate invoices. 
 Sales rep commission payments can be limited to invoices paid in full. 
 Improvements to invoice analysis reports (BI):

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/12 Ver.05 Cat.No. LB130136  
 
o Analysis by sales type. 
o Service contract payments can be displayed per part in the contract. 
 Income accounts, COGS accounts and profit centers can be defined by customer type 
and the part's accounting family. 
 Dual-currency users: 
o A new Taxes Withheld by Customers report displays the total amount of taxes 
withheld from the business by customers based on receipt data. 
o Users can include old undeposited checks that are still at the cashier in calculations 
of customer liability. 
o Customer payment terms can be defined to include multiple installments with 
various percentages of the sum total per date. 
CRM and Sales 
 An Organizational Chart Explorer, based on the organizational chart defined for the 
customer, can be run via Direct Activation from the Customers form. 
 Sales targets can be defined for top-level part families, with the aid of the new Top-
Level Family column in the Part Families form. 
 Check lists can be defined for price quotes based on sales type. 
 Users can create new sales orders based on an existing one, including items, prices 
and discounts, by running the Copy Order program by Direct Activation from the Sales 
Orders form. 
 Dual-currency users: Improvements to sales order exchange rate linkage via the Link 
as of Date, Date of Base Rate and % of Linkage columns. 
 
Customer Service 
 New Unbilled Service Contracts report. 
 New Customers with Few Service Calls report. 
Accounts Payable 
 Payments to vendors can be split into equal monthly payments: 
o Run the Split Payment program via Direct Activation from the Flag Invoices for 
Payment form. 
o The split will occur for all invoices flagged to be paid to the vendor. 
 A new Pro Formas w/o Purchase Invoice report provides control of pro forma invoices 
from vendors.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/12 Ver.05 Cat.No. LB130136  
 
 Purchases accounts and profit/cost centers can be defined per vendor group and the 
part's accounting family. 
Purchasing 
 Items in purchase demands, purchase orders and vendor invoices can be manually 
distributed among profit/cost centers using the new Split Among Profit/Cost Centers 
sub-level form. 
 Vendor invoice details can be designated while recording a GRV, and the invoice can 
be opened on the basis of such data via Direct Activation. 
 There is a new Demand Type column in the Purchase Demands form. 
 There is a new Partially Closed column in the Purchase Orders form. 
Warehouse Management System (WMS) 
 Pick wave options have been expanded to include picking from the Order Work Area.  
 Users now have control over the order in which order items are handled when running 
a pick wave. 
 Users can define the pick algorithm. 
 Picking can be based on packaging types, with separate definitions for items that are 
stored individually, in packs and in master crates. 
 An Inventory Date Code can be defined per raw material lot, indicating the lot's 
production date. The date can be used to restrict picking based on a maximum 
number of inventory months defined per customer or order. 
 Quality levels can be assigned to work orders and lots, and picking can be restricted to 
items at a particular level. 
 Users can now pick kits for orders. Order items marked with the same kit number will 
be picked together. 
 Picking can be based on packaging, primarily of food items, where the package 
weights of the same product are not identical, and sales orders are made for a number 
of packages, not by an exact weight. 
 The status of orders can be automatically updated after a pick wave was run and 
sufficient inventory was found available for the entire order. 
 Users now have the ability to manually move pallets to zones not subject to pallet 
control. 
 The put algorithm was expanded to allow the storage of different pallet types in the 
same bin (not simultaneously). For example, in bin X, you can store either 3 narrow 
pallets or 2 wide ones. 
 Orders from restricted customers are not included in pick waves. 
 Support for parsing specialized healthcare industry bar codes via mobile device. 
 Users can add non-inventory parts to custom warehouse tasks.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
6/12 Ver.05 Cat.No. LB130136  
 
 New History of Changes form, sub-level of the Bins in Warehouse form. 
 New Inventory in Bins Not in Use report. 
 New Uncounted Bins in Warehouse report. 
 A customer can be linked to a warehouse zone. Used for customers that work with a 
single warehouse broken down into multiple zones for consignment sales. 
 MOV tasks with planned quantities can be opened from the mobile device. 
 Mobile device reports can be grouped into a single line in custom and MOV tasks. 
 Additional document types can be printed from the mobile device. 
 When a pallet is transferred to another warehouse via a customer shipment, the 
inventory is saved on the pallet. 
 Users can report pick tasks without reference to a sales order. 
 Users can define, per bin type, the maximum number of different lots that can be 
stored and whether bins of this type hold homogeneous pallets only. These definitions 
affect the put algorithm. 
 Users can define, per order item, the minimum number of days until expiration for 
picking. The pick algorithm will take this definition into account when finding lots that 
meet the specified criteria. 
Inventory Control 
 Part volume in shipping documents is calculated on the basis of volume definitions of 
the included crates. 
 A new IPltSeparate constant affects pallet number generation when the New Pallet 
column is flagged in the Reporting Production Details form. 
 A warning is given when issues to kits reduce inventory below the minimum level 
defined for the warehouse. 
 The Prepare Docs from Packing Slips program can now create documents by 
branch. 
 A warehouse transfer document can now be based on a GRV. 
 In customer return documents, goods can be returned to the pallet from which they 
originally came. 
 All lines in shipping documents and sales invoices can be approved together via Direct 
Activation. 
 The tracking number can now be updated via Direct Activation from sales invoices and 
over-the-counter invoices. 
 Improvements to the program that approves all lines in an inventory count: you can 
now revoke approval across the board as well.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
7/12 Ver.05 Cat.No. LB130136  
 
Fashion 
 New fashion reports: 
o Assortment Report Generator 
o Sales/Inventory Report Generator 
o Available Assortments as of Date 
 Addition of price and discount columns to the List of Styles for purchase orders and 
vendor invoices. 
 Document itemization is based on the assortment, where the line item is linked to the 
style. 
 A new value for the PAutoFindOrder constant allows automatic splitting of GRV items 
and vendor invoice items when the amount received is larger than the amount ordered. 
 Users can define a main color part number, which is then used to set the price of all 
items in the same set. 
 Assortments can be built based on the items in the document. 
 When opening a document based on a sales order, you can now copy the assortment 
from that sales order into the new document. 
 Inventory can be managed by sets, including support for picking and storing in WMS 
and support for assembling and disassembling sets in inventory. 
 A new Parts not Included in Assortment report checks document items against 
assortments. 
 Checks were added during document status update to ensure that assortments match 
the line items. 
 A new IMatrixOnly constant prevents users from updating document items directly if 
the document contains an assortment. 
Human Resources 
 There is no longer a defined HR company: 
o The Personnel Management column has been removed from the Companies 
form. 
o You can now open a personnel file or candidate record from any company. 
o Employee's personal information is now shared and identical in all companies, 
including details of children. This information may be updated in any company. 
o The employee's/candidate's status is managed within the company to which they 
are assigned (Company column, which is now read-only). 
o New programs allow users to reassign an employee/candidate to another company 
via Direct Activation within the form or from the BPM Flow Charts for HR menu. 
o The Info on Position/Company Vehicle sub-level form has been removed. Drivers 
license details have been moved to the Personal Details form. The rest of the 
columns have been moved to the Company-Specific Information form.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
8/12 Ver.05 Cat.No. LB130136  
 
o Organizational charts, positions and jobs are now defined independently for each 
company. 
Payroll/Time and Attendance  
 Pay slips can be printed on special paper that folds into an envelope. 
 Salaries can be calculated for employees whose compensation is based on 
commission. Absence days are calculated based on commission received in previous 
months. 
 Taxes for daily wage employees are calculated based on the number of work 
days/month. 
 Salaries can be transferred to a number of different employee bank accounts. 
 Support for payment by check or bank transfer. 
 Calculation of labor union dues. 
 Calculation of vehicle taxable benefits using the linear method (for vehicles 
manufactured in 2010 or later). 
 Generator to define the loading of time clock data: 
o Definition of time clock file structure. 
o Time data loading from multiple companies. 
o Two magnetic cards can be defined per employee. 
o Various types of time data (e.g., regular hours, on-call hours) can be loaded. 
 Generator to define the loading of payroll report data from external program files (e.g., 
cafeteria time clock). 
 Improvements to the way pay classes are defined: 
o Can define rounded start and end work hours.  
o Can define up to five rates per work day. 
o Can define payment of additional hours for night shifts. 
o Can define separate overtime calculations for night shifts. 
o Can define overtime rates for any payroll component. 
o Can define special hours and rates for holidays. 
o Can define break time throughout the day. 
o Can define payment for a pre-determined number of hours for emergency repairs 
made by technicians. 
o Support for time-limited pay classes (e.g., contractors). 
o Can define allowable deviations in balance of vacation days. 
o Can set the date of the first day of the month (for monthly calculations that are not 
based on a calendar month).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
9/12 Ver.05 Cat.No. LB130136  
 
o Can define overtime hours at the normal rate (100%) for part-time salaried 
employees. 
o A change log documents changes made to all form data. 
o Calculation of hourly and daily premiums paid to employees. 
 Work hours can be reported by department or branch. 
 Automatic recording of the report source (manual/time clock/computer) when reporting 
login/logout. 
 A new payroll manager work area enables corrections to work hours and absences of 
all employees at once. 
 Automatic calculation of deductions for meals and taxable benefits on meals based on 
employee attendance reporting. 
 Mechanism for authorizing attendance reports (work hours and absences). 
 Support for budgeting absences and preventing payment for absences over the allotted 
amount. 
 Definition of collective vacations. 
 User report generators for attendance data. 
 Reports displaying erroneous/missing employee attendance data. 
 Dual-currency users: Salaries can be calculated in a foreign currency. 
Mobile Applications (in partnership with Soft Solutions) 
 New Delivery Tracking module (PODS): 
o A new Delivery Tracking document incorporates shipping documents, sales 
invoices and return documents. 
o During delivery rounds, the driver can report deliveries made, record the receiver's 
name, and document the customer's confirmation or record a reason for non-
delivery. 
o Loading/unloading can be verified by bar code scanning of crates via a mobile 
device. 
o Shipping documents and sales invoices can be generated by assigning packing 
slips (via mobile device) to a delivery tracking document. 
 Improvements to the Field Sales module: 
o Customer tasks can be opened or updated. 
o Support for sales in the field, including the ability to produce shipping documents, 
customer returns and sales invoices. 
o Many new columns added to the sales orders and shipping documents forms on 
mobile devices. 
o Users can save price quotation versions on the mobile device. 
o Users can save geolocation (GPS) data via the mobile device.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
10/12 Ver.05 Cat.No. LB130136  
 
o Customer contact frequencies can be defined in a new sub-level of the Customers 
form. 
o Orders can be opened from price quotations via the mobile device. 
 Improvements to the Field Service module: 
o Many new columns added to the service call form on mobile devices. 
o Users can attach a customer questionnaire to a task opened as part of a service 
call. 
o Priority's BPM flow charts for customer service can be viewed on the mobile 
device. 
o The user's signature is added to the text of malfunction details and description of 
repairs when updated from the mobile device. 
International Tax Authorities 
 U.S.A.: 
o Can load sales tax rate tables from a comprehensive, up-to-date tax file. 
o Can define sales tax rates per customer, based on their zip code. 
 Portugal: 
o Digital signatures on invoices as per Portuguese tax authority requirements. 
o Priority is now approved by the Portuguese tax authorities. 
 Germany: 
o VAT reporting by tax group, based on journal entries. 
 Italy: 
o Addition of an expense account classification based on recognized expenses, 
including expense rates recognized by the Italian tax authorities and the European 
Union. 
o Trial balance distinguishes between recognized and unrecognized expenses. 
 Poland: 
o Sales invoice printouts as per Polish tax authority requirements. 
o Correction invoice printouts as per Polish tax authority requirements. 
 Mexico: 
o Digital signatures, as per Mexican tax authority requirements. 
o XML file generation for reporting sales to tax authorities. 
o Definition of VAT transfer accounts and VAT payments based on cash accounting. 
o Multiple invoice numeration templates, as dictated by tax authorities. 
 Argentina: 
o Invoice printouts as per Argentinean tax authority requirements. 
o Multiple numeration templates for all financial documents.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
11/12 Ver.05 Cat.No. LB130136  
 
o Calculation of additional taxes on an invoice (in addition to VAT). 
o Can transmit invoices to Argentinean tax authorities, and receive confirmation. 
o Can define minimum withholding tax. 
o Numbering of vendor tax withholding authorizations. 
o Definition of withholding tax codes per tax group. 
o Can issue pending receipts and convert them to final receipts after receiving 
payment from the customer. 
System Management 
 A new Demo Version column in the Companies form affects document and report 
printouts. 
 A new form for setting up e-mail servers makes it much easier to set up the system 
using an SMTP server (other than Gmail). 
 New Company Deletion/Addit'n History form. 
 Users not included in the system manager's privilege group can handle certain system 
maintenance tasks: 
o Add users, reset passwords. 
o Add/delete companies. 
o Manage user privileges. 
o Perform system upgrades. 
Miscellaneous 
 Document Tracking: 
o In the Priority Rich interface, start tracking a document by clicking the gray flag at 
the top of the form. 
o In the Windows interface, start tracking a document by selecting Mail > Track 
Document. 
o Users automatically receive e-mail alerts when the status changes in any document 
they are tracking. 
o Users can view a list of all documents they are tracking in the new Tracking List 
form and Tracking List report. 
 Improvements in producing documents/reports in PDF format: 
o Users no longer need to have MS-Office installed. 
o E-documents can now be digitally signed without user interaction. 
 User-defined titles for part spec columns and customer/vendor categories are displayed 
in forms and reports. 
 Support for MS-Office 2013.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
12/12 Ver.05 Cat.No. LB130136  
 
 Support for Internet Explorer 10. 
 Support for Windows 8. 
 The history of statuses can be updated by changes in document text or attachments, 
depending on the value of the new LOGUPDATE system constant. 
 A new Key Performance Indicators web part was added to Dashboards. Users can now 
customize their dashboard to view the KPIs of interest to them.
