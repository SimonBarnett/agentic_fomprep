# Sales Order Script

- **Source:** `Sales Order Script.pdf`

Sales Orders Script 
Clip Link: http://www.eshbel.com/Movie_Search/Sales_Order_Clip.htm 
Note: Yellow highlights indicate action instructions.  
Introduction (00:00-00:51) 
Priority provides you with a variety of tools for handling sales orders. Since they 
are the central link of the sales chain, they can be based on numerous documents, 
such as price quotations, sales opportunities and price lists. Once approved, they 
serve as the basis for shipping documents, customer invoices and purchase orders. 
In this clip, we'll demonstrate how to open a new sales order and base it on various 
documents, assign discounts and follow up on inventory levels of the ordered items. 
Finally, we'
ll briefly consider other documents that can be based on open orders.   
In this clip, we'll be using the Dual-Currency package, so certain columns shown 
here may not appear, or appear differently, in the U.S. package.  
Opening a Sales Order Based on a Price Quote (00:52-03:34) 
To open a new order, open the Sales Orders form and record the number of the 
customer for which the order is placed. The Date is filled in with today's date. An 
Order No. is assigned automatically, based on the numeration template defined for 
sales orders . In the Prices tab, the customer's Currency is also filled in 
automatically. Except for the order number, all these columns may be revised. In 
the same tab, let's record an Overall Discount of 10%.  This discount will be 
calculated in addition to any discount recorded for individual order items. Other 
columns in this tab will be filled in after the order is itemized.  
In the Payment Info tab, you can define Payment Terms for the order. In the 
Linked Curr column, you can choose to link prices in the order to another currency 
or a price index. The chosen currency's exchange rate will appear in the Base Rate 
column, according to the rate in effect on the Date of Base Rate, filled in 
automatically with today's date. Both the base rate and its date can be revised. In 
the Price Linkage column, you can link price adjustments to a specific date, such 
as the date of shipment or of the invoice. Note that even when recording an order in 
a currency other than the local currency, the system will create a journal entry in the 
local currency, while customers will be billed in the second currency.  
In the References tab, you can base the order on any of a variety of documents. In 
this demonstration, we'll show how to base it on a price quote. The Choose List is 
populated with all the quotations in effect for the customer, whose status enables a 
sales order to be opened for the quote. We can see all the open quotations for the 
customer, regardless of status, in the Active Price Quotations sub-level form. As 
you can see, several quotes appear in this form which are not in the Choose List, 
such as quotes with a "Draft" status.  
Choose the quotation on which the order is based. If you wish to base the order on 
several quotations, you can list them in the Price Quotes for Order sub-level form 
instead.  
Cat.No. LB130548  Ver.1 – Dec. 5,’13 1

Instead of using a price quotation, you can base the order on a specific Price List, 
if you wish to override the default list defined for the customer or the base price list.  
You can also link the sales order to a Blanket Order. A blanket order reflects the 
customer's agreement to purchase items of a given total monetary sum or quantity, 
over a limited period, in exchange for lower prices, special payment terms or other 
benefits.  
Sales Order Items (03:35-06:52) 
Let's move to the Order Items sub-level form. The items in the selected quote have 
been copied here, and can be changed. Note that if you only want to use prices 
from the quote, make sure to leave the Copy All column in the quotation blank, in 
which case you will have to record the order items manually while prices will be 
filled in automatically.  
You can also manually add lines that weren't in the original quote or delete existing 
ones. The Quantity and Unit Price columns have been filled in with the values 
recorded in the quote, but can be revised. Note that the prices in the quote are in 
effect as long as the ordered quantities are equal to or larger than the quantities in 
the quote. If we record a smaller amount, the price changes in keeping with the set 
price hierarchy. Customers must order at least the minimum quantity recorded in 
the quote to be entitled to the price recorded there. The Price Source column 
displays where the price was taken from, whether this be a quote, a price list, a 
manually recorded price, and so on.  
You can check your profit for the item in the Cost column. The cost is affected by 
the value of the SPurchPrice constant, and can be revised.  
You can define a rule so that, when new lines are added to the order, the Unit 
Price is based on the part cost. This can be useful when you are itemizing the order 
manually, or adding new lines that didn't appear in the original quote. From the top 
Design menu, select Data Generator. Define the new rule: After Updating the 
Part Number column, set the Unit Price. In the "as" area, press on the function 
key to insert a simple equation: first, choose Add Field to Condition, then select 
the Cost field. Now, multiply the cost by 1.3 to set the unit price to 30 percent 
higher than the cost. Press OK to activate the rule. Note that this definition will 
override the price hierarchy defined in the system, meaning that prices defined in 
customer price lists or the base price list will be overwritten for new lines recorded 
in the order.  
You can record a Discount for any line. Remember that we defined an overall 10% 
discount for the order, which is added to any discount defined for the item. Next, 
record the Due Date of the item. The Balance column displays the number of items 
left to supply; right now, it is equal to the ordered quantity. Note the Profit and 
Profit (%) columns, which display the calculated profit yielded by comparing the 
price and cost of each item. In the upper-level form, you can see the calculated 
profit for the entire order, as we'll soon see.   
You can link the sales item to a Budget Item. When documents such as customer 
shipments and purchase orders are opened based on this order, the system will 
automatically link the budget item to those document, while calculations of budget 
usage will only take the latest document into account.  
Cat.No. LB130548  Ver.1 – Dec. 5,’13 2

You can see changes made to the ordered item in the History of Order Item 
Statuses sub-level form.  
Additional Data (06:53-07:29) 
Additional data relating to the order items are display
ed in the sub-levels of the 
Order Items form. For instance, in the Inventory for Part form, you can see 
inventory levels for this part in each warehouse. The Part Availability form displays 
projected inventory for the part, taking into account available inventory, purchase 
orders and sales orders open for this item, including the current order. In the Order 
Tracing form you can see inventory transactions related to the items in this order, 
useful for future follow-up on delivery and billing.  
Custom Bill of Materials for the Order (07:30-08:19) 
In the Order Items form, you can also customize a bill of materials for an item that 
is assembled or manufactured at your factory or store, based on the standard BOM 
defined for the part in the system. To do so, place the cursor on the relevant line, 
then run the Create BOM for Order Item program from the list of Direct 
Activations. The program displays a message detailing the items added to the BOM 
for Order Item form. Now, you can move to the form and change child parts and 
quantities, as needed. The item cost is recalculated based on the revised bill of 
materials. Back in the Order Items form, you can see that the Unit Price and Cost 
have changed accordingly, as have the Price Source and Cost Source.  
Follow-Up (08:20-09:50) 
After you've finished recording the order items, return to the upper-level form to 
review results in the Price tab. The Final Price column displays the total calculated 
price after taking into account discounts and taxes. On the right hand side of the 
tab, you can see the total cost of the order and your profit.  
In the Scheduling tab, you can assign the order to another employee. You can limit 
the time devoted to working on this order by assigning start and end times. If you 
record times, the system will automatically open a task for the user to whom the 
order is assigned. You can see all the tasks related to this order, and record new 
ones, in the Tasks for Document sub-level form. 
Moving to the Follow-up tab, you can see the order has automatically been 
assigned the "Draft" Status, which is the default for new orders. Statuses and the 
rules that apply to them are defined in the BPM chart, activated from the list of 
Direct Activations. In this example, we'll change the status to "Approved". You can 
learn more about statuses and working with BPM in the relevant clip. Changes to 
the order statuses appear in the History of Statuses sub-level form. 
In the Attachments sub-level form you can upload any type of file related to the 
order, such as scanned order confirmations, product manuals, signed warranties 
and the like. In the Shipment tab, you can elaborate shipping details for this order.  
Basing Other Documents on Orders (09:51-10:42) 
Several documents can be based on approved sales orders. For example, if you'll 
be purchas
ing the items in the order to supply them, you can open a purchase 
order directly from the sales order, by running the relevant program from the list of 
Direct Activations. If you want to purchase individual items from different vendors, 
Cat.No. LB130548  Ver.1 – Dec. 5,’13 3

Cat.No. LB130548  Ver.1 – Dec. 5,’13 4
you can specify the desired vendor for each line item and separate purchase orders 
will be opened accordingly. Invoices, shipping documents, packing slips and other 
inventory documents can also be based on the order. Various sales forecast 
programs take open sales orders, among other things, into account, as do inventory 
planning programs. You can also calculate a Cash Flow Forecast based on 
projected income from sales, allowing you to stay on top of critical financial data.  
Sales Order Reports (10:43-11:29) 
A number of built-in reports help you follow up on sales
 orders. Let's look at a few 
reports from the Sales Order Reports menu. For example, from the Detailed 
Reports > Sales Order Reports menu, you can run the Orders to Carry Out (by 
Cust) report, or the Backlog/Cust. & Inventory Bal. report, to view those orders 
that have not yet been supplied, as well as available inventory to fill them. From the 
Order Supply Reports menu, you can run the Order Delays report, for example, 
to see orders whose due date has passed but which have not yet been supplied.  
This concludes our demonstration of handling sales orders in Priority. You can 
read more about orders in the Sales Orders Wizard.  
Related Documentation 
 Sales Order wizard 
 Price Quotations clip 
 BPM clip
