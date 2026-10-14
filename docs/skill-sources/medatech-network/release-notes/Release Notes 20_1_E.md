# Release Notes 20_1_E

- **Source:** `Release Notes 20_1_E.pdf`

www.priority -software.com   
1/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Priority Release Notes v20.1  
TOC 
User Interface ............................................................................................. 2 
Priority Mobile ............................................................................................. 6 
Financials ................................................................................................. 10 
 Revenue Recognition ............................................................... 10 
 Other Enhancements and Features in Financials ..................... 10 
 Priority Payments ..................................................................... 12 
Sales ........................................................................................................ 13 
 Rentals Module......................................................................... 14 
 Dropshipping ............................................................................ 14 
Purchasing ................................................................................................ 15 
 Lists of Authorizers ................................................................... 16 
 Inventory ................................................................................... 18 
Warehouse Management System (WMS) ................................................. 19 
Production ................................................................................................ 21 
Global ....................................................................................................... 22 
 Italy ........................................................................................... 22 
System Maintenance and Others .............................................................. 23 
Integrations ............................................................................................... 24

www.priority -software.com   
2/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
User Interface 
● Using the Favorites menu as the main Priority menu - To provide easy and fast 
access to forms and other entities, customized to the needs of the user and the 
organization, you can now replace the standard Priority menu with your personal 
favorites menu.  
○ Switch to your Favorites menu from the upper right Options ( ) menu.  
 
○ You can design the menu (add and delete entities, change their order, etc.) from 
the Design menu.  
● Changing the system language - To allow easy access to changing the system's 
language, we relocated the language settings to the main menu and added a designated 
icon. This will be especially helpful for new users who begin working with Priority in a 
language that is unfamiliar to them, and wish to change the system language upon first 
entry. 
○ After clicking Change Language, all languages will appear in the target 
language.

www.priority -software.com   
3/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Right-click menu in form fields - When right clicking in form fields, you'll only see 
actions that are relevant to the specific form and field. We adjusted this menu so you can 
easily and quickly identify the actions you need.  
 
○ The Delete Record action was moved to the bottom 
of the menu and colored in red to prevent 
unintentional mistakes. 
 
○ Other actions that are accessible from other menus 
(main menu, help menu, form settings and 
designated icons) were removed. 
 
 
 
 
○ Some of the actions' names in this menu were changed to reflect their 
functionality more accurately:  
Previous Name New Name 
Clear Line (F7) Hide (F7) 
Store into Buffer (Ctrl+F9) Copy & Save to Buffer (Ctrl+F9) 
Retrieve from Buffer (F9) Paste from Buffer (F9) 
Special Paste - Ignore Warning Paste without Warnings 
Find Value in Results (ctrl+f3) Search by Field (ctrl+f3) 
Clear Form/List (Ctrl+F7) Clear All (Ctrl+F7) 
Default Value Smart Fill 
Delete Record (Ctrl+Delete) Delete (Ctrl+Delete) 
 
○ Actions referring to the form's design are now also located under the Form 
Settings menu, which is at the top of the form (under the settings icon). You'll 
find there all of the design settings: organize fields, font size, defining record 
colors, etc.

www.priority -software.com   
4/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
 
 
● Form Settings menu - You can now find design options in the Form Settings menu 
(under the gear icon). We changed the menu layout to make it easier to navigate due to 
the addition of the design options. 
 
 
● Dynamic sorting in part search lists - Search list results in Part Number and Part 
Description fields will be sorted according to the field in which the search is performed. 
For example, when searching for a part in the Part Description field, the results will be 
sorted by name, while when searching for a part in the Part Number field, the results will 
be sorted by number.

www.priority -software.com   
5/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Visibility of search lists - Search lists for which a search category should be chosen 
(for example, a list of sales representatives) open in a newly designed window. Once 
you start typing characters, they will be highlighted in the results list, making it easier to 
locate the desired item.  
 
 
● Selecting companies for multi-company work - When initiating multiple companies 
mode in Priority (Options menu > File > Select Multiple Companies), you can now 
easily add all companies at once. If you have more than 10 companies, you'll be able to 
search for companies in the popup.  
 
● Localization - Belgium - For those who work in the Flemish language, pressing the 
decimal point (.) on the numeric keyboard will produce a comma (,) in numeric fields.

www.priority -software.com   
6/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Priority Mobile 
● Catalogue View - Visual part catalogue view on your Priority Mobile app!  
We understand that certain sales representatives out in the field have different needs 
when it comes to opening sales documents in the system from their mobile device. 
They initially go over the part catalogue with the customer, decide what to order, and 
finally create the order itself. 
In Priority, it is customary to open a new document, select a customer, and then go on 
to filling out the items, quantities and prices.   
So, to better accommodate different needs for different users, we added a new 
catalogue view to Priority Mobile. This view includes the item's picture, price, and stock 
availability, along with additional customizable information. 
This new view is currently available for price quotations, sales orders, shipping 
documents, and invoices.

www.priority -software.com   
7/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
When opening a new document (e.g., price quotation), you can choose whether to view 
the part catalogue based on a customer price list or the system's Base Price List.  
You'll be able to filter results by part families, part numbers, or typing part of the item 
description. After selecting items and quantities for each item, the items will be added to 
the document. 
In Priority, a new Catalog View sub-level form was added to the Price List form. There 
you can see all the items in the price list that can be viewed in the new visual catalogue 
on the app. Items are defined for this view in the Part Families form. 
Read about how to start working with the visual catalog in the Applications Generator 
SOP. 
 
● Identify user location - You can now identify users' location while they are using a 
mobile app (e.g., when delivering a package to a customer). Their location is saved in 
the History of Statuses sub-level form of various documents in Priority as soon as they 
change a document's status on the app.  
Start tracking your users' location by defining specific forms that require tracking location 
in the Applications Generator. Once set up, mobile users will be able to access those 
forms, only if they have enabled location services for the app. 
Working with location ID is supported by the Identify Location system constant 
(GPSLOCATION). 
To complete the settings required to work with location ID follow the Applications 
Generator SOP.

www.priority -software.com   
8/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Save default search directly from your mobile - You can now save a default search 
for a form, using your mobile app as well.  
○ Do it by saving new or 
existing search settings as 
the default search. 
○ Once the default search is set 
up in the app, it will also be 
saved on the Priority 
desktop.  
 
 
 
 
 
 
 
 
 
● Quick access to forms and actions 
- To allow quick identification of unique forms, we replaced the Attachments, Remarks, 
and Internal Dialogue sub-level forms with dedicated icons on the upper right of the 
screen. Clicking on an icon will open the relevant sub-level form.  
The form's Action menu button is now located at the bottom of the screen for easy 
access.

www.priority -software.com   
9/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Sub-level form visibility - We made slight changes in the sub-level form for usability 
reasons. The action (+) button was changed to the Add + button, which is used for 
adding new items, and search 
results filtering options will 
only appear when the sub-
level form has more than 10 
lines.  
 
 
 
 
 
 
 
● See all part numbers in search - You can now 
see all items in choose lists of items in various 
documents (even if they were not linked to the 
specific customer/vendor) by clicking the Show 
More button in the search window (similar to 
Ctrl+F6 in Priority).  
 
 
 
 
 
 
 
● Searching in choose lists - We will now find the sequence of characters searched in 
the middle of a word and not just in the beginning.

www.priority -software.com   
10/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Financials 
Revenue Recognition  
Priority is proud to launch a new module that continues to deepen the tools we offer in the 
areas of accounting management: Revenue Recognition, based on the ACS 606 standard.  
The new module allows you to: 
● Define types of contract obligations by choosing a revenue recognition rule and timing to 
the sold items. 
● Identify contract obligations - They are reflected in the system both as sales orders and 
as sales invoices, for cases where the sales process in the system begins directly from 
the invoice. 
● Determine fair value. Relevant for sold items that have several components with different 
natures of recognition. For example, for software licensing that includes a software 
component and a maintenance component, you'll be able to determine the value of each 
component out of the value of the entire contractual obligation. 
● Create a revenue recognition plan - Any contractual obligation will automatically become 
a revenue recognition planning record as soon as the contractual obligation changes to 
a status that affects revenue recognition. The planning will be updated as events that 
affect it occur, such as billing, delivery, percentage of progress update, etc. 
● Recognize revenue - When running the Recognize Revenue program, the system will 
make a journal entry that will transfer the relevant sums according to the recognition plan 
from a deferred income account to an income account. 
● Produce a revenue recognition forecast and recognized revenue report.  
o Download the module from our site and read more information in the SOP. 
 
Other Enhancements and Features in Financials  
● Closing fiscal periods by subsidiaries - You can now close fiscal periods for one or 
more subsidiaries. Read more information about fiscal periods in the link.  
 
● Extending the functionality of the Meter Billing Module for crediting - Define a 
meter as one whose readings are specifically used for crediting customers, that is, a 
meter whose reading will form the basis for producing a credit memo for the customer. 
When calculating the charge for the meter reading, the result will be a negative sum, 
resulting in customer credit. Red more information in the SOP.

www.priority -software.com   
11/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Charge for the installation day in a service contract – Use the new financial constant 
BillContInstDay to define whether or not to charge the customer for the installation day.  
● The start date for calculating service contract's payments - With the new 
ContBillDate financial constant, you can choose from which date to start calculating 
payments for a service contract - from the contract's start date or the date of the device 
installation. 
● One-sided reconciliations in the ledger and bank accounts worksheets - When 
reconciling entries in an account that do not have matching entries (i.e., reconciling lines 
on only the credit or only the debit side) and defining a target account for the adjustment 
entry -- all the dates and references for the adjustment entry to be created will be taken 
from the original transaction, unless you mark the new Refs from TargetAcct checkbox 
in the program input.  
● Journal entry migration - From now, when importing journal entries, you can import 
two new fields: the target income account number and the activity date. 
● Reconcile invoices based on bank statements - After loading bank statements, you 
can select a paying customer for the bank statement line and manually mark invoices as 
paid. The result is reconciliations, both in the books for the customer account and for the 
bank statement line. 
 
● Localization - Belgium - After loading bank statements in the CODA structure format, 
the new Prep Receipts by Bank Statement program lets you generate receipts 
automatically based on customers' payments, according to the invoice reference 
numbers in the file. The result is reconciliations, both in the books for the customer 
account and for the bank statement line.  
In loading in unstructured format, you can select the paying customer against the bank 
line and mark the invoices as paid manually. The rest of the process of creating the 
receipt will be done automatically, as detailed above 
 
● Localization - UK - We now support sending extended anti-fraud headers according to 
HMRC's requirements. Make sure you download and run the HMRC Anti-Fraud add-on 
from the Downloads folder in Priority's Customer Zone. For further instructions, click 
here.

www.priority -software.com   
12/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Priority Payments 
● Early payment discount - We now support working with early payment discounts for 
your end customers who pay via Click2Pay or in the Payments Portal.  
 
● Generate partial credit for customers - You can partially credit a customer, that is, 
return money directly to the customer's credit card up to the original receipt's sum, when 
linking the original receipt in the Payments Portal. 
 
● Payment by direct debit in the Payments Portal - Your end customers can now 
securely set up a direct debit with your business, without having to provide credit card 
details by phone or email.  
 
● Pro forma invoice clearing support - We now support clearing pro forma invoices from 
your mobile similarly to clearing sales invoices.  
 
● ACH Bank Transfer - US businesses can now receive funds via ACH bank transfer in 
Priority desktop.  
 
● Invite contacts to Priority Payments - You can now send email invitations to contacts 
to use the Payments Portal with the new Invite to Payments Portal program in the 
Contacts form.

www.priority -software.com   
13/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Sales 
● Click2Sign - Approve documents online - Your end customers can now approve 
documents with their signature online. This way, they don't have to print documents, 
hand sign them, scan, and return them by email. The approved documents are 
automatically saved in Priority in the document's attachments sub-level form, and there 
is no need to save them manually. This applies to Price Quotations, Sales Orders, 
Customer Shipments, and Sales Invoices. Read more information in the SOP.  
 
● New quick processes for opening documents - To streamline your workflow, we've 
added more options for opening documents based on other documents. 
○ You can now create a multi-Shipment invoice from a blanket sales order, for 
when the blanket sales order is billed in advance. Read more info here. 
○ Now you can also open an over-the-counter invoice from a sales order, from 
the sales order's list of Actions.  
○ We have also added the option to create a customer return based on an over-
the-counter invoice.  
 
● Identify shipping documents for which returns were made – Use the new Final with 
Return checkbox in the Status for Shipping Documents form to set a new status for 
final documents for which returns were made. This way, you can easily identify shipping 
documents with returns (instead of seeking them in the Return Documents sub-level 
form).  
 
● Changing sales reps. after creating invoices - You can now change the sales 
representative in a sales order even after an invoice was created. The change does not 
affect sales reps' commission and discounts, and it does not change the name of the 
sales rep in the invoice. This change is recorded in the order's History of Changes.   
 
● Price Lists' Valid List Date field - The Valid List Date field's name in the Price Lists 
form was changed to Price List Valid From to more accurately represent its meaning – 
the date from which the price list is valid.

www.priority -software.com   
14/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Rentals Module   
● Bank standing orders for rentals – We now support billing rentals via standing orders 
in a bank as part of our fast billing process (relevant for Israel and the USA).  
 
● Renting unserialized items - You can now rent unserialized items.  
 
● Price lists for rentals - You can create price lists designated for use in rentals. Just 
mark the new Rental Price List checkbox in the Price Lists form.  
 
● Send and receive items collectively for one rental - You can now send and receive 
multiple items for a rental with one click. To do so, use the new programs Ship Items 
and Return Items from the list of Actions in the Rentals form. To ship or return items for 
one rental line, use the Ship/Return Item for Line program from the Rental Items sub-
level form.  
 
● All of these new features are also available for customers in version 20.0 via add-on 
installation. 
 
Dropshipping   
● Recording multiple vendor invoices for the same order - We now support recording 
several vendor invoices for one sales order.  
 
● Marking purchase orders in the dropshipping process - From now on, when you 
open a purchase order from a sales order in the dropshipping process, all those involved 
in the purchase order (for example, order authorizers) will see an indication that this is 
an order in the dropshipping process.  
○ We have added the Dropshipping checkbox to the Purchase Order Types 
form. 
○ When you open a purchase order based on a sales order in the dropshipping 
process, the Purchase Order Type field in the purchase order will be filled in

www.priority -software.com   
15/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
automatically according to the type of order marked for Dropshipping (in the 
Purchase Order Types form).  
 
● Delivery address in the dropshipping process – When opening a purchase order 
from a sales order in the dropshipping process, the shipping address is copied from the 
sales order to the purchase order. From now, if no address is set in the Shipping 
Address sub-level form of the sales order, we will copy the address from the sales 
order's Customer Details sub-level form to the purchase order.  
 
● For more information on working with dropshipping, read our SOP.  
 
Purchasing 
● Creating a multi-GRV invoice from a blanket purchase order - You can now create a 
multi-GRV invoice from a blanket purchase order. Read more information here.  
● Comparing documents - You can now compare prices and quantities of different 
documents of the purchase process using new reports located in the Action menu of 
each document:  
○ From the Multi-GRV Invoices form you can compare the document to a 
purchase invoice and a GRV. 
○ From the Vendor Invoices form you can compare the document to a purchase 
invoice. 
○ From the Goods Receiving Vouchers form you can compare the document to a 
purchase invoice.  
You can also run the Compare Invoice to P.Order&GRV report also from the 
main menu.  
 
● Discrepancies in Multi-GRV Invs. report - This report now also includes lines of 
purchase invoices that do not appear in the linked GRV, the Part Description field, and 
the Unit Price in the invoice and GRV. In the program input, you can set a maximum 
amount below which the report will not treat the amounts as differences between the 
invoice and the GRVs.

www.priority -software.com   
16/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Lists of Authorizers  
● New authorizer lists - You can now work with authorizer lists in the Blanket Purchase 
Orders, Vendor Invoices, and Multi-GRV Invoices forms, similarly to working with 
authorizer lists in the Purchase Demands and the Purchase Orders forms.  
 
● Authorizer lists' currency – You can now define an authorizer list with a currency that 
is not the system's primary currency.  
 
● Authorizers list authorization method - With the new Authorization Method field that 
was added to various authorizer lists forms, you can now choose the authorization 
method of each list:  
○ A list in which all authorizers have to sign, no matter the order of the authorizers. 
○ A list in which all authorizers have to sign according to the order of the 
authorizers. 
○ A list in which once a high-amount authorizer has signed, there is no need for the 
lower-amount authorizers to sign. 
 
● Canceling email notifications to authorizers - You can now cancel the generic messages sent 
to the next authorizer in the authorizer list. Cancel them by marking the Cancel Email to Auth 
checkbox in the relevant authorizer list.  
 
● Preventing double authorization - Use the new Prevent Double Auth checkbox (in 
the Order Authorizers and the Blanket Purchase Ord Authorizers forms), to block 
one user from authorizing a document more than once (for those cases in which one 
authorizer is also defined as an alternate authorizer of another user).  
 
● Notifying authorizers whose authorization was canceled - When changing the status 
of a document to a status marked for Cancel Round of Authorizers, all the 
authorizations that were given will be revoked. The user who made this change and all 
the authorizers whose authorization was canceled will receive an update.

www.priority -software.com   
17/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Replacing a user in an authorizer list of open documents - Use the new program 
Replace User in Docs for Auth to replace a user in authorizer lists of open documents 
awaiting the user's signature. 
○ You can also run this program from the existing Replace User program. 
 
● Locate authorizers in open documents – With the new Locate Authorizer in Open 
Docs report, you can identify open documents that a specific user in an authorizer list 
must sign. Use this report to make sure that users authorize documents awaiting their 
approval, for instance, before going on an extended vacation or leaving altogether.  
 
● History of Changes – This sub-level form was added to the forms: Authorizer List for 
Purchase Orders, Authorizer Lists for Purchase Requisitions, Blanket Purchase 
Orders Authorizer Lists, Purchase Invoice Authorizer Lists.  
 
● Authorizing blanket purchase orders - Similar to authorizing purchase demands and 
purchase orders, you can now authorize Blanket Purchase Orders using the new 
Authorize Blanket Purchase Order program in the form's list of actions. 
 
● Comparing authorizer lists between multiple companies - Use the new Compare 
Authorizer List reports to compare authorizer lists between multiple companies. These 
reports show the lists of Purchase Demands, Purchase Orders, Purchase Blanket 
Orders, and Purchase Invoices.  
 
● Authorizer cycles in printing formats - You can now display the round of 
authorizations in various printing formats. This applies to Purchase Demands, 
Purchase Orders, Blanket Purchase Orders, and Vendor Invoices.  
For more information on working with authorizer lists see the SOP.

www.priority -software.com   
18/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Inventory  
● Label printing - We are excited to introduce a new Priority collaboration with 
NiceLabel - an innovative and advanced cloud solution for label printing.  
You can now print labels without a local installation in all workstations. You only need 
one installation in the company's network. 
In addition, with NiceLabel, you will be able to: 
○ Choose the printer from Priority easily 
○ Set up a printer for each label 
○ Send labels to printers directly from your phone using Priority Mobile app  
○ Inspect in real-time the compatibility of the data sent to the label with the data 
format defined in the label (for example, that a barcode field can only have a 
numeric string of 13 characters) 
○ Get a clear indication within the Priority user interface about the success and 
failure of printing and the reasons for it 
See more information about installing NiceLabel and printing labels in Priority.  
● Transferring warehouse inventory - Transferring warehouse inventory has never been 
easier. You can now transfer the inventory balances of an entire warehouse to another 
warehouse with the new Transfer Warehouse Inventory program. 
 
● Inventory journal for warehouse by bin report – The Inventory Journal for 
Wrhs/Bin new report is similar to the Inventory Journal for Warehouse report, but it is 
detailed by bins.  
 
● Hiding prohibited items for sale or purchase in part search - Items with a status not 
marked as Can be Ordered-Sales or Can be Ordered-Purch on the Statuses for 
Parts form will not appear in the search list of the Item field in the following forms: Price 
Quotations for Customers, Sales Orders, Purchase Demands, and Purchase 
Orders.  
 
● Using the Auto Recording of Serial Nos. form - Customers who work with the 
ISerialTrans logistics constant set to 1 can now use the Auto Recording of Serial Nos. 
form, a sub-sub-level form of various inventory documents.

www.priority -software.com   
19/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
 
● Detailed Check Inventory by Serial Nos. report - You can now generate the Check 
Inventory by Serial Nos. report with a detail of the serial numbers that participate in the 
report. Use the new Level of Detail field in the report's input.  
 
● We added the Lot/Work Order field to the History of Components form (a sub-level of 
the Catalogue of Parts w/Serial Nos. form).  
 
● Registering the same vendor lot number to different items - You can now register 
the same vendor lot number to different items.  
○ Customers who work with the PLotByVendor logistics constant set to 1 or 2, can 
record the vendor lot number as it came from the vendor, and the system will 
automatically generate the internal lot number with a unique suffix if necessary. 
 
● We added the Parent Serial Number field to the Customer Shipments > Shipped 
Items form. 
 
● The Accounting Family field was added to the Interim Table-Parts form.  
 
Warehouse Management System (WMS) 
 
● Recommendation for replenishing/storing items in specific bins - The Put 
Strategies form has a new checkbox called Preferred Bins Only. When running a wave 
and selecting a put strategy that is marked as Preferred Bins Only, the system will 
recommend replenishing/storing an item only in the bins listed in the Preferred 
Warehouse Bins for Part form (formerly called Possible Warehouse Bins for Parts), 
a sub-level of the Part Catalogue form.  
The relevant waves are: Put Wave by Inventory, Put Wave by Document, 
Replenishment Wave for Inventory, Replenishment Wave for Orders, Replenish Wave 
for Order.

www.priority -software.com   
20/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
 
● Create a replenishment wave for sales orders while separating items lines 
according to the order's lines - the Create Replenishment Wave (Ords) and Create 
Replenish Wave for Order programs can open separate warehouse task lines for each 
of the order's item lines (instead of grouping by items). Use this option by marking the 
Sep. Part per Ord Ln checkbox when running the programs. Read more information in 
the SOP.  
 
● We added a new checkbox named Split by Zone-Pick to the Task Splitting Methods 
form. If you run a pick wave and select a splitting method marked in this checkbox and 
select a main zone, the warehouse tasks will be split according to zones belonging to the 
main zone selected in the input.  
 
● Setting up pick waves in TTS - You can now set up pick waves to run in the Tabula 
Task Scheduler using the Definitions for Automatic Waves form (similar to the 
replenishment waves).  
 
● Reset order lines' statuses when canceling warehouse tasks - we added a new 
checkbox named Reset Ord.ItemStatus to the Statuses for Warehouse Tasks form. 
When canceling a warehouse task marked in this checkbox, it deletes the status of the 
order line.  
 
● When using the Create Issues to Kit Wave program, you can now select multiple 
warehouses in the For Floor Warehouse field. This will open several warehouse tasks 
in one run (each warehouse will have a separate warehouse task).

www.priority -software.com   
21/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
Production 
● Recommending issuing inventory when replacing an item in a BOM - Once 
replacing an item in a BOM, you can define that the system will first recommend issuing 
the old item before issuing the inventory of the new item. Set it by marking the Use 
Alternate First checkbox in the Alternate Parts sub-level form of Parts. See more 
information in the link.  
 
● MRP by BOM for order line - From now on, when running MRP, if a BOM is defined for 
the order line, the MRP will refer to the order line's BOM and not to the BOM from the 
Part Catalogue form. The MRP will open the work order according to the BOM in the 
order line (this work order will be reserved for the order line via the Anchor to Orders 
checkbox in the Work Orders form). When releasing the work order, the Kit List sub-
level form will be filled according to the order line's BOM.  
 
● Comparison of BOM Revisions - The name of the report was changed to BOM 
Comparison, and you can now run the report for unapproved BOMs as well.  
 
● Revisions authorizers lists - You can now set up separate authorizers lists for Part 
Revisions and BOM Revisions with the help of the Part Revisions Authorizers and 
BOM Revision Authorizers forms.  
 
● Defining an alternate authorizer in additional authorizer lists - You can now define 
an alternate authorizer in the following authorizer lists: Part Revisions Authorizers, 
BOM Revision Authorizers, and ECO Authorizers.  
 
● Part's last operation - You can now see the last operation (production step) reported 
for a part during the production process in the Operation/Pallet field in the Catalogue 
of Parts w/Serial Nos. form.  
 
● Working with a demand range = 0 in purchased items - When working with 
purchased items (type R), you can set Demand Range = 0 on the Purchase/MRP 
Parameters for Part form. As a result, the MRP's purchase planning program will open

www.priority -software.com   
22/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
separate purchase demand lines for parts from different sales orders for the same 
delivery date.  
 
● Unplanned Work Orders report - Use the new report to see all the work orders the 
MRP program did not plan in its last run.  
 
● Planned Work Orders with Balance report - Use the new report to see all the work 
orders the MRP program planned in its last run in which the work order sum is larger 
than the part's demand sum.  
 
● Closing work orders with rejected parts – Use the new Rejects Dropped checkbox in 
the Operations form if you want the system to take into account rejects in this operation 
when checking whether or not it should close the work order. That is, the work order will 
be closed when the reported quantity (including rejects) reaches the quantity required for 
the work order.  
 
Global 
Italy 
 
 Priority is proud to present our newest localization for Italy. The localization includes: 
o A set of infrastructure data suitable for working in Italy for our customers opening a new 
Italian company in the system. The data includes VAT codes, VAT groups, VAT 
exemption reasons, and withholding VAT codes. 
o Split payment support. 
o VAT report (Registro IVA) in several formats:  
○ Detailed report for sales and purchases 
○ Summarized report for sales and purchases 
○ Accumulated report 
○ A printing format that includes all the previous formats 
o Esterometro file - producing a file of invoices that were not submitted electronically  
o Intrastat file - producing a file for uploading to the customs authorities website

www.priority -software.com   
23/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
o Frequent Exporter regulation support: 
○ Manage plafond for Frequent Exporter  
○ View plafond utilization for Frequent Exporter  
○ Trade with a Frequent Exporter  
o CONAI regulation support:  
○ Defining packaging materials and their prices 
○ Reporting packaging materials of overseas purchases 
○ CONAI report that details the number of packaging materials used and the total 
VAT payable. This report is the basis for reporting to CONAI.  
o In addition to all the above, the Italian localization includes the complete European 
package.  
o Download the localization from our site and read more information in the SOP. 
 
 Italian Dictionary module - The module includes the full translation of the system to Italian. 
Download it from our site to use it with the localization.  
System Maintenance and Others 
● Work without plug-in - You can now work on the Web interface without enabling the 
plug-in, except for the cases listed in the link. 
 
● Copying attachments from one document to another - With the new form Copy 
Attachments to Documents Definitions, you can set whether attachments are copied 
automatically when you open one document from another. For example, you can set that 
when opening a sales order based on a price quotation, the attachments to the quotation 
will be added automatically to the sales order.  
 
● Comparing constants among multiple companies - Use the new Multi-company 
Constants Report to compare the values defined for various constants among multiple 
companies 
 
● Extension of document number - From now on, you can extend document numbers 
even if documents based on a specific numeration template were already created in the 
system. Use the Extend Document No. program in the Document Numeration 
Templates form. The program is especially useful in case you have reached the 
maximum number in the document's numeration template and need to extend the 
number to continue working.

www.priority -software.com   
24/24 Nov. 15, 2020 Ver. 05 Cat.No. LBI2000628 
 
● Separating fields in Word documents: Up until now, in HTML printouts and Word 
templates, the fields Quantity and Unit Price were presented together with the Std 
Unit/Currency. Now, the data is split in several Word formats, and there are separate 
fields for each data: Quantity in Line, Unit, Unit Price, and Currency. These changes 
will now allow you to run different formulas, for example, a formula that calculates the 
total of a Quantity in Line field in the invoice details. This is relevant for printing sales 
documents: Price Quotations, Sales Orders, Customer Shipments and customer 
invoices.  
 
● Documents names in Quick Email - From now on, when sending a document with 
Priority's Quick Email, the name of the email's attached file will be the number of the 
document.  
● We now support SQL Server version 2019 as a database server.  
● MHT format - Priority will no longer send emails with attachments in the MHT format. 
You can continue to use HTML and PDF formats. As a result, the ATTACHHTML 
constant is no longer relevant. 
○ Note that you can define that Tabula Task Scheduler tasks will be sent as PDF 
files by marking the Send as PDF checkbox in the Define TTS Tasks > More 
Parameters form.  
 
Integrations 
 
● Webhooks - We now support webhooks. You can trigger them from business rules and 
BPM charts. Use them to run external functions and applications based on events in 
Priority. See more info here. 
 
● New processes with Zapier - You can now perform more operations in Priority with 
Zapier: 
○ Create a sales order for an existing customer (B2B scenario) 
○ Create a new sales opportunity 
○ Update a sales opportunity status 
○ Create a candidate (HR module) 
More information about the integration with Zapier and a full list of processes is 
available here.
