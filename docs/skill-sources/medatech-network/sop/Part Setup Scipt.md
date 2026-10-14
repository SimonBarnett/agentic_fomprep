# Part Setup Scipt

- **Source:** `Part Setup Scipt.pdf`

Part Setup Script 
Clip Link: http://www.eshbel.com/Movie_Search/Part_Setup.htm  
Note: Yellow highlights indicate action instructions.  
Introduction (00:00-00:23) 
This clip demonstrates the tools available in Priority for setting up parts in the
 
system and for keeping track of their availability and demand. The main tool for 
managing all your parts is the Part Catalogue, which provides comprehensive 
information about the item, encompassing sales, purchase and inventory data. We'll 
cover this near the end of the clip. Let's begin by setting up a new part in the 
system. 
Setting up a New Part (00:24-04:06) 
Open the Part Catalogue form from the Inventory > Part Catalogue menu. Assign 
the new item a Part Number. You can assign the number according to any 
numbering strategy employed in your business. In this demonstration, I'll use a 
simple number, ABC123. Also write a Description. If the full description is too long 
to fit, write a brief one here and use the Parts – Remarks sub-level form to record 
the full description, which will appear when printing documents in the extended part 
description format.  
Upload an image of the item in question by right-clicking the folder icon and 
selecting Import. This image will appear in printouts of documents containing the 
item, such as price lists, when the appropriate format is selected.  
In the Additional Details tab, define the part Type. Select "P" for a make item, "R" 
for a buy item, or "O" for other. The default for new parts is R, and I'll leave it as is.  
The default unit assigned to new parts, as both their Buy/Sell Unit  and their 
Factory Unit, is "ea," that is, "each". In other words,, whether sold, purchased or 
manufactured, the item is measured in single units. When you first record the part in 
the form, you can change this to units indicating weight, length, or any other 
appropriate unit of measure, as long as you don't leave the record. Press F1 to read 
more in-depth help for this column, or any other.  
Newly defined parts are flagged automatically in the Inventory Control column. 
Remove this flag if the item in question is not subject to inventory control. For 
example, you would do so when defining a "work hour" part used for charging 
customers by the hour. You can also flag the Maintain Serial Nos, often used for 
electronic items. If you want to allow users to change the part description in specific 
documents, flag the Change Desc. column. 
Let's move to the Details tab. The item is automatically assigned to the default Part 
Family. Press F6 and delete the default family to display the full list of defined part 
families, from which you can choose the relevant family.  
Cat.No. LB130082  Ver.1 – May 29,’13 1

The Barcode column is filled in automatically with the Part Number you recorded, 
and can be revised as needed. You can also specify a Pref. Vendor.  
In the Prices & Costs tab, let's record the List Price, that is, the price of the item in 
the Base price list; and its Std.  Cost. The cost recorded here will appear by default 
in sales and purchasing documents containing the item. 
In the Specs and More Specs tabs, you can assign various specifications to the 
part, which you have already defined in the Definition of Part Specs form. For 
example, I have defined Spec 1 as "Material" and populated the Choose list with 
possible values. 
You can define a message that will automatically appear when the part is recorded 
in a document, in the Part Remarks for Internal Use sub-level form.  
If the item is a manufactured or assembled part, use the Child Parts sub-level form 
to create a bill of materials. All the child parts making up the parent part must first 
be defined in the system.   
Financial Parameters (04:07-04:55) 
Now, let's define additional data for the item in other related forms: Move the cursor 
back to the Part Number column, and from the list of Direct Activations, select 
Financial Parameters for Parts. Note that the details of the item have been filled 
in automatically.  
In the Shipping Expenses tab, determine the Shipping Cost Type and cost 
percentages.  
If the item you defined is a virtual part used for calculating shipping expenses, use 
the Burden Type column to determine how shipping costs will be distributed 
among shipped items. 
This form can also be used to revise the Accounting Family to which the part 
belongs, which determines the income account, expense account, and profit center 
to which transactions for this part will be recorded.  
Inventory Parameters (04:56-05:55) 
Let's move back to the Part Catalogue form by pressing Esc or by selecting the 
form name in the Form Navigation box at the top right corner. From the list of 
Direct Activations, choose the Inventory Parameters for Parts form. Here, you 
can choose the Packing Crate Code that will appear by default for this item in all 
sales documents.  
In the Order Tolerance column, define the percentage by which the received or 
shipped amount of this item can exceed the original order quantity. You can also 
record a number or percentage in the Close Order Tolerance columns indicating 
the permitted deviation from the original order quantity that allows it to be closed 
automatically. These definitions apply to both sales and purchase orders.  
In the Service tab, you can select the Warranty Code of the type of warranty 
usually given to customers who buy this item.  
Now let's return to the Part Catalogue form. 
Cat.No. LB130082  Ver.1 – May 29,’13 2

Cat.No. LB130082  Ver.1 – May 29,’13 3
Keeping Track of Items (05:56-07:56) 
After a part has been set up and various transactions have been recorded for it, the 
Part Catalogue form is useful for following up on vital data. Let's see a few useful 
examples for an existing item. For this purpose, I'll retrieve an item prepared in 
advance.  
The Inventory for Part sub-level form displays inventory levels of the item in 
company warehouses. In the Part Availability sub-level form, you can see the 
projected availability of the item, taking into consideration existing inventory levels, 
open purchase orders, and open sales orders. You can see details of the orders in 
question in the next sub-level form. 
Details of the latest inventory transactions involving the item appear in the Recent 
Inventory Transactions and Recent Entries into Inventory sub-level forms. The 
ITransDays constant determines the number of days to be displayed in both forms. 
Additional sub-level forms help you manage the part; you can read a detailed help 
text by right-clicking the name of the form.   
In addition to information found in the sub-level forms of the Part Catalogue, you 
can run a wide variety of reports from the Part Reports menu. You can use the 
Part Catalogue Report Generator , to define customized reports based on almost 
any item attribute, such as price, cost, part specifications, part family and so on. 
From the Inventory Transaction Reports menu, you can run reports displaying 
detailed transactions or summaries of transactions. For example, the Inventory 
Journal for Warehouse report displays a list of inventory transactions involving the 
item, including a link to each document, whether it be a purchase order, a 
warehouse transfer, a shipping document and so on.  
Part Maintenance (07:57-08:33) 
Finally, there are two useful programs that help with par
t maintenance:  
 The Delete Parts program allows you to delete parts, provided they have not 
been linked to other records in the system; 
 and the Change Part Unit program allows you to change buy/sell units, 
factory units, or both for one or more designated parts. This change is 
possible only if the conversion ratio between the original unit and the new 
one is 1.  
This concludes our presentation of setting up and maintaining parts in Priority.  
Related Documentation 
 Part Definition Wizard 
 various Inventory Transaction wizards 
 Shipping Document clip 
 Receipt/Return of Goods clip
