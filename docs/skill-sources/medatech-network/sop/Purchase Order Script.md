# Purchase Order Script

- **Source:** `Purchase Order Script.pdf`

Purchase Order Script 
Clip Link: http://www.eshbel.com/Movie_Search/Purchase_Order_clip.htm 
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:49) 
In this clip, we demonstrate various options for opening and updating a purchase order in 
Priority. The order can be based on a variety of other documents, such as: 
 a sales order 
 a purchase requisition 
 a vendor price quotation 
 a blanket purchase order. 
In this clip, we'll demonstrate recording a purchase order that is not based on any 
reference document.  
In the Purchase Order form, you can check the expected inventory balance for the part, 
check the availability of the part for sale and define workflows for purchase 
authorizations. We'll also demonstrate how to link the purchase to a budget item and how 
to update due dates for parts once the order has been authorized. 
Before You Begin (00:50-03:12) 
Before you open an order, there are a number of setups that will facilitate your work later 
on. 
First, as purchase orders are opened for a specific vendor, it is helpful to assign each part 
a preferred vendor. When purchase orders are opened automatically, they are often 
opened for the preferred vendor. So let's go to the Inventory > Part Catalogue menu, 
and open the Part Catalogue form, where you can define a preferred vendor for each 
part. 
You can also create a list of vendor parts in the Vendor Parts form. Let's go to the 
Purchasing > Vendors menu and look at the form. 
Now, let's go to the Purchase Orders menu, and to Purchase Order Maintenance. 
Printouts of purchase orders can include remarks; for instance, you may want to include a 
note requesting confirmation that your order was received. Using the Set Text for 
Purchase Orders form, you can record set text that will appear in the remarks of all 
purchase orders. Or you can use the Types of Purchase Orders form to classify types of 
purchase orders and define set text per type in the sub-level form. 
You can define the authorization process for purchase orders in one of two ways: through 
workflow management (BPM) or authorizer lists. In this demonstration, we will be using 
the default authorizer list. In the current menu, open the Authorizer Lists for Purch 
Order form and move to code 00, which serves as the default. Let's define authorization 
as follows: Barbara, the regional manager, needs to authorize purchase orders up to 
$10,000. Purchases in excess of $10,000 require the authorization of Rose, Vice 
President. The definitions recorded for this authorizer list will be applied to all purchase 
orders with the 00 list code. You can also create additional authorizer lists, for example, 
for other departments in the company. 
Cat.No. LB130485  Ver.1 – Nov. 14,’13 1

Now, let's start by recording a purchase order manually. 
Recording a Standard Purchase Order (03:13-04:50) 
In the Purchase Orders menu, open the Purchase Orders form and choose the desired 
vendor. Once you leave the field, the Vendor Name, Date and Order No. are filled in 
automatically. The Contact is filled in with the name of the person defined as the vendor's 
Purchase Ord Contact. If necessary, it can be revised. 
Click the Price tab. This is where the price of the order will be displayed, once it has been 
itemized and all parts are priced. Right now, these columns are empty. As the vendor has 
offered a 10% discount for all ordered items, record an Overall Discount(%) of 10. Now 
click the Payment Info tab. The Tax Code (in the dual-currency package) and Payment 
Terms have been filled in automatically if they were defined in the Financial Parameters 
for Vendors form for this vendor, but can be modified. 
In the current case, all parts are being ordered to a specific company warehouse, so click 
the References tab and select the receiving Warehouse. As a result, the Shipping 
Address sub-level is filled in automatically with the address of the warehouse, although 
this can be revised. This address will appear on the printed order instead of the main 
company address. 
Note that in this tab, you can link the purchase order to existing documents: a purchase 
demand, a vendor price quote, a blanket order, or a sales order, if the ordered goods are 
intended to fill a customer order.  
In the Type of Order column, assign the order the appropriate type, for example, office 
equipment. 
You are now ready to itemize the order. 
Itemizing the Order (04:51-08:32) 
Let's enter the Order Items sub-level form. Because we are recording the order 
manually, the form is blank. Press F6 in the Part Number column to display a Search list 
of parts. Since a vendor part list has been created, only parts recorded for this vendor 
appear. Select the ordered part. Note that you can press Ctrl+F6 if you want to view the 
entire list of parts in the system. 
After recording the Part Number, indicate the desired Due Date. 
Before recording the ordered quantity, you can check inventory for the part using the Part 
Availability and Inventory for Part sub-level forms. The Part Availability form makes it 
easy to calculate exactly how much inventory you need to order by displaying the 
available inventory as well as inventory on order and current sales orders. The Projected 
Inventory column summarizes all of the inventory transactions. The Inventory for Part 
form displays part balances per warehouse. 
Now record the Quantity of the ordered part. The Unit Price is filled in automatically. 
When the purchase order is prepared manually, the source of the price is the vendor 
price list or the price listed for the part in the Part Catalogue form. The Price Source 
column indicates the source of the price used. You can check prices by entering the 
Latest Part Purchases from Vend sub-level, where you can see the latest invoices from 
this vendor in which the part appears, useful for comparison of prices and quantities. In 
the Vendor Price Quotations per Part sub-level, you can compare price quotes 
received from this vendor for the part. 
If you have a standing discount from the vendor for this part, recorded in the vendor price 
list, this will appear automatically. You can also specify a part Discount(%) manually. 
The Extended Price column displays the total part price less the part discount. In the 
Cat.No. LB130485  Ver.1 – Nov. 14,’13 2

dual-currency package, the Price Incl. VAT column displays the extended price plus 
VAT. 
Finally, you can assign a Budget Item to the part being purchased. This budget item will 
roll over into later purchase documents, when the part is received from the vendor, when 
it is billed and when it is paid for. Because budget items are traced throughout the chain 
of purchasing transactions, you can accurately compare budget appropriations with actual 
expenses/income at any point in the purchasing process. That is, you can view not only 
billed transactions, but also unbilled transactions, open orders and open PRs. 
Note that there is a financial constant, called BudOrdPeriod, which determines how the 
system will calculate budget utilization when the purchase order due date falls in the next 
budget year, or when the order was opened in the previous budget year. The default is for 
the current budget to take into account all open orders due by the end of the year 
(including orders from last year), but ignore orders due next year. 
If you wish to record a remark that is pertinent to this particular part, you can use the 
Order Items – Remarks sub-level form. 
Repeat all of the above for each ordered part, moving down to an empty row for each 
one. 
Now, let's open the parallel sub-level form, Purchase Orders – Remarks. Since we have 
assigned a type of order for which set text has been defined, the remarks have been 
recorded automatically. They can be revised as necessary. 
If you want to attach any files to the order, such as a price list file received from the 
vendor, you can do so by using the Attachments sub-level. 
Authorizing the Order (08:33-09:34) 
Let's return to the upper-level form and select the Authorization & Follow-up tab. As 
mentioned earlier, you can define the authorization process via workflow management 
(BPM) or authorizer lists. To define workflow rules for the authorization process, run the 
BPM Flow Chart-Purchase Orders program by Direct Activation.  
In this example, we'll use the default 00 authorizer list instead. This list appears 
automatically in the Auth. List Code column, but can be revised. Consequently, the 
definitions we recorded earlier for this authorizer list will be applied to the current 
purchase order.  
Now we'll change the Status of the order to a status that can be authorized. When an 
order receives this status, an automatic e-mail alert is sent to the first authorizer. Once it 
is authorized by the first authorizer, an automatic e-mail alert is sent to the next 
authorizer, if necessary, and so on, until the order is fully approved. 
Submitting the Order (09:35-09:50) 
Once the order is approved, you can print it and/or send it to the relevant vendor via fax 
or e-mail. In the list of Direct Activations, select Print Purchase Order and then choose 
any of the provided Print/Send Options. 
Revising an Approved Purchase Order (09:51-11:17) 
The authorization process is meant to ensure the proper management of the purchase 
process. Once this process has begun, the order cannot be revised. Still, it's possible that 
after sending the order out, the vendor indicates that only a portion of it can be delivered 
immediately and that the balance will not be available for several months. In this case, 
you will want to update the expected due dates and quantities so that the order reflects 
realistic expectations for the receipt of inventory.  
Cat.No. LB130485  Ver.1 – Nov. 14,’13 3

Cat.No. LB130485  Ver.1 – Nov. 14,’13 4
Let's open the Revisions for Authorized Orders form and retrieve an order that has 
already been authorized. In the Order Items sub-level, move to the item that needs to be 
revised. Let's suppose that quantity A will be supplied on the date indicated in the 
purchase order, but quantity B won't be delivered until the end of next month. From the 
list of Direct Activations, select Split Purchase Order Items. In the Qty – New Item 
column record the amount that will be delivered on the later date; in the Due Date 
column, record the date delivery is expected . When you exit the Order Items sub-level, 
the new line is added. You can return to the Order Items form to view the revision. 
Follow-up & Closing a Purchase Order (11:18-12:06) 
Once a purchase order has been authorized and sent to the vendor, you can continue to 
use the Purchase Orders form and its sub-levels to follow up on the order. A purchase 
order is automatically closed when the receipt of the ordered parts is recorded in a 
Goods Receiving Voucher or a Vendor Invoice. Consequently, the Balance of each 
order item is updated automatically and line items that have been delivered in their 
entirety are flagged as Closed. 
In the Order Tracing sub-level form, you can see all inventory transactions for the current 
part, as well as the number of the document associated with the transaction. You can 
also view full document details. 
When all items in the purchase order have been delivered, it will be flagged as Closed in 
the Authorization & Follow-up tab. 
Purchase Order Reports (12:07-13:00) 
Additionally, a number of useful reports about purchase orders are available from the 
Purchase Order Reports menu. For example, you can track the procurement of parts or 
check all the open orders to a particular vendor. You can also run a report that lists all 
Supply Delays from a given vendor -- this report displays any open order item that is 
overdue for delivery, together with the balance of the part to be received and the number 
of days by which it is late. 
The system also offers several tools for purchase order analysis, including a report 
generator for designing customized purchase order reports and a BI report that can be 
used to analyze purchase orders by quantity and price, in various cross-sections. 
This concludes our demonstration of recording a purchase order in Priority. For more 
information, run the Purchase Order Wizard, which opens from the Purchase Order 
Wizards menu.  
Related Documentation 
 
Purchase Order Wizard 
 BPM clip 
 Report Generators clip 
 Business Intelligence clip
