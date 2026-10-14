# Customer Shipments Script

- **Source:** `Customer Shipments Script.pdf`

Customer Shipments Script 
Clip Link: http://www.eshbel.com/Movie_Search/Customer_Shipments.htm 
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:23) 
This clip demonstrates how to record a customer shipping document based on 
a sales order in Priority. You can also record a shipping document that is not 
based on a previous document, or base it on a customer return document or a 
previous shipping document. Customer shipments create an inventory 
transaction and are billed in multi-shipment invoices. 
Recording a Shipping Document Based on a Sales Order (00:24-04:03) 
Let's begin by opening the Customer Shipments form. Specify the number of 
the customer to which the goods are sent. The system automatically assigns a 
document number. The Date is filled in with today's date, but can be revised. 
The Sending Warehouse is filled in according to system definitions. If the 
goods are sent from several warehouses, you can specify them later, when 
itemizing the shipment. The Status is also filled in, with the default status 
defined for new shipping documents. 
In the Price tab, the Billable column is flagged by default, so that the 
document will be billed to the customer. There are, however, certain instances 
in which this column is not flagged automatically. To learn more, right-click the 
Customer Shipments form in the menu and select Online Help to access a 
list of frequently asked questions regarding customer shipments, then click on 
the question: "Why isn't a given shipping document flagged as billable?". 
Let's move on the References tab. The Site column displays the main 
customer site to which the goods are sent, but can be revised. In the Shipping 
Address sub-level, the customer address appears automatically, based on the 
defined site. This, too, can be revised per individual document. The Sales Rep 
and Branch appear according to customer definitions. You can designate a 
specific Price List for this document – for example, if special discount prices 
are in effect at this time. Use the Rep's Doc. No. column to record the number 
of the shipping document recorded externally, such as by a sales rep, if there is 
one. If you record a number here, this document will be considered a copy.  
You can also use this tab to define the sales order on which the document is 
based: open the Choose list in the Order column to select from among this 
customer's open orders. Alternatively, you can base the document on several 
orders using the Sales Orders for Shipment sub-level form, selecting one 
order on each line of the form. Another option is to base the shipment on 
individual line items in these orders, using the Choose Order Items sub-level 
form. Select the relevant lines by flagging the Choose Item column for each 
Cat.No. LB140040  Ver.1 – Feb. 24,’14 1

line, on the left-hand side of the form. In this clip, we'll base the shipment on a 
single order, so we'll return to the References tab and select that order.  
Note that you can link packing slips to this shipping document as well, thereby 
creating a bill of lading. Packing slips are issued in the system whenever 
merchandise is packed for a designated customer. In the Link Packing Slips 
to Document sub-level form, you can select slips that were prepared for this 
customer and have not yet been linked to a shipping document. Simply flag the 
In Document column to include any of these slips in the current shipment. 
Once packing slips are linked to the shipping document, the Bill of Lading 
column is flagged in the upper-level form, in the General tab.  
Up until this point, you've seen how to open a new order, link it to a sales order, 
and record details such as the sales rep, customer site and shipping address. 
Let's move on to see the items listed in the shipment.  
Itemizing the Document (04:04-07:19) 
Moving to the Shipped Items sub-level form, you can see a list of the parts 
recorded in the original sales order. If the value of the SOnlyOneLine constant 
is set to 1, one line will be opened for each item; but you can set the value to 0 
if you want the number of lines opened for each item to depend on inventory 
levels. In the latter case, if the inventory balance in a given warehouse and bin 
is insufficient, an additional line will be opened for the remainder to ship, from a 
warehouse and bin that do contain enough inventory. 
Let's take an in-depth look at each line. In the Balance to Ship column, you 
can see the number of parts left to ship, according to the amounts defined in 
the original order. The Warehouse Balance column shows the inventory level 
of this part in the warehouse defined in the upper-level form. If the warehouse 
balance is insufficient, you can move from this line to the Inventory for Part 
sub-level form to see other warehouses that stock the part, and select a 
different one from which to ship; then subsequently record that warehouse in 
the Warehouse column. 
If the warehouse balance is large enough, flag the Approve column to copy the 
Balance to Ship into the Quantity column. If the warehouse balance is 
smaller, the Quantity column will be filled in with the amount stocked in the 
warehouse.  
If you want, you can manually record the Quantity of the item shipped. If the 
Quantity is larger than the warehouse balance, the system will alert you of a 
negative warehouse balance when you leave this line.  
Note that the inventory balance of the part in the warehouse is updated as soon 
as the quantity is recorded.  
The Unit Price is filled in automatically according to the system's price 
hierarchy. Press F1 in the column to read a detailed help text. The Price 
Source column is filled in accordingly. The Discount% column is filled in if a 
part discount is defined for the customer or order item, but can be revised. 
The Bar Code column is filled in with the bar code defined for the part in the 
Part Catalogue form. When you itemize the shipping document manually, you 
can scan the bar code, and the part number and description will be filled in. 
Cat.No. LB140040  Ver.1 – Feb. 24,’14 2

The Billable column is flagged automatically for all line items if it was flagged in 
the upper-level form; it can be cleared for any item which is exempt from 
payment. If the Checking column is flagged, the customer cannot be billed for 
the item in question; this is useful when you need to resolve something about 
this item with the customer. 
If serial numbers are maintained for this part, you can list them for each 
shipped item in a sub-level form. You can also right-click a form name to 
receive more information about it, such as the Latest Part Sales to Customer. 
After itemizing the shipment, recording quantities, reviewing prices and 
discounts, ensuring sufficient inventory levels and recording serial numbers, 
return to the upper-level form to finalize and print the document.  
Finalizing, Printing and Follow-Up (07:20-10:09) 
Before printing the document, enter the Remarks sub-level form, where you 
will see either the set text defined for shipping documents in the Set Text for 
Customer Shipments form, or the text recorded in the sales order on which 
the shipment is based – depending on the value of the SCopyOrdText column. 
In any case, you can revise the remarks for this shipment. This text will appear 
on the printout.  
In the General tab, change the status of the document to "Final". You can run 
the BPM Flow Chart-Shipping Docs from the list of Direct Activations to see 
the attributes of each status. You can then right-click a status to see a list of 
those properties and revise them. You can also use the flow chart to define 
permitted paths between statuses, to define tasks that will open automatically 
for specified users if certain conditions are met, to determine the user to which 
the document will be assigned automatically once it moves to a certain status, 
to define automated mail messages, and so on. Working with BPM flow charts 
is explained in detail in a separate clip. In the document's History of Statuses, 
you can see a record of the statuses and assigned users. 
You can revise final shipping documents which have not yet been printed by 
running the Reopen Document program from the list of Direct Activations. The 
program will revert the status back to "Draft". After making the necessary 
changes, change the status back to "Final".  
Once the document has been printed, you can make certain changes to it via 
the Revision of Final Shipping Doc form. If the customer returns the goods, 
you can record a Customer Return based on this shipping document.  
To print the document, select Print Shipping Document from the list of Direct 
Activations. Also choose the printing format.  
You can display the document on your screen by selecting Display or print it by 
selecting the Print option, in which case the Printed column will be flagged in 
the document. 
You can prepare a multi-shipment invoice for this document by running the 
Prepare Invoice/Credit Memo program from the list of Direct Activations. To 
prepare an invoice for several shipping documents, run the Prepare Invoices 
program from the Multi-Shipment Invoices menu. After billing, the Billed 
column will be flagged in the Price tab. 
Cat.No. LB140040  Ver.1 – Feb. 24,’14 3

Cat.No. LB140040  Ver.1 – Feb. 24,’14 4
Shipping Document Reports (10:10-11:38) 
Once the shipping document is final and printed, you can run several reports 
that will help you keep track of this and other documents. 
Back in the Inventory > Inventory Transactions > Sales Inventory 
Transactions menu, open the Unbilled Shipmt/S. Call Reports menu. Note 
the different options. For example, you can see a list of unbilled documents by 
customer name. Note that you can use the Search for Entity window at any 
time, if you don't remember the menu in which the report is accessed. This 
window can be opened from the tool tray or by using the keyboard shortcut of 
Ctrl and right bracket ]. Write the name of the entity and press Search For to 
see a list of relevant entities.  
From the Inventory Transactions Reports > Detailed Transactions menu, 
you can run several reports related to shipments made. For example, the 
Customer Shipments report displays a list of parts sent within a given date 
range.  
This concludes our demonstration of how to record customer shipments in 
Priority. For additional details, run the Customer Shipment/Return Wizard. 
Related Documentation 
 Customer Shipment/Return Wizard 
 Opening a Customer clip 
 Opening a Sales Order Clip
