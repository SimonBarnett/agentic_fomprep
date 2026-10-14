# Prices and Discounts Script

- **Source:** `Prices and Discounts Script.pdf`

Prices and Discounts Script 
Clip Link: http://www.eshbel.com/Movie_Search/Prices_and_Discounts.htm  
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:37) 
This clip demonstrates the tools available in Priority to help set product pricing that 
reflects management policies with regard to sales cycles throughout the year, 
customer-specific deals and quantities sold. The values you define using these tools 
are then applied automatically in sales documents (such as price quotes and orders) 
according to a set hierarchy, where they can be revised as necessary. In this video, 
we will review several such tools – including price lists, special part prices and 
customer discounts – and explain the mechanism by which they are applied in the 
sales documents you record. 
Price Lists (00:38-02:37) 
Price lists are the main tool for determining prices in Priority. The predefined Base 
price list serves as a default for al
l sales documents: the prices you record there are 
applied automatically when no other price source is available. You can also create 
additional price lists for sales to a specific customer or group of customers, or simply 
for internal records. 
We'll begin by showing you how to add parts and prices to the predefined Base price 
list. We'll then demonstrate how to update list prices while maintaining a history of 
previous versions of the price list. Finally, we'll create individual price lists for specific 
customers and sets of customers. 
Let's begin by opening the Price Lists form and move to the line for the Base price 
list. We'll demonstrate two methods of updating this price list: via the Part Catalogue 
form and directly in the Price Lists form. 
To record list prices for given parts, enter the Part Catalogue form and retrieve the 
parts in question. In the Prices & Costs tab, record the price of each part in the List 
Price column, together with its Currency. Since several parts were retrieved, it's 
easier to toggle to multi-record display mode and simply move down the list of parts, 
recording the list price for each one. The parts and their respective prices are 
automatically added to the price list. If your company makes regular use of the Base 
price list, you can set up a business rule using the Business Rule Generator, which 
makes the List Price column mandatory under certain conditions, such as all parts 
with an "active" status, or all parts assigned to a certain user.  
Updating the Base Price List in the Price Lists Form (02:38-03:58) 
The second way to manually add items to the Base price list is to record them 
directly in the Price Lists form
: 
In the Part Prices sub-level form, open the Choose list in the Part Number column 
and select the desired part. The default Unit defined for the part will appear, but can 
Cat.No. LB130381  Ver.1 – Aug 18,’13 1

be revised if the part is generally sold in a different unit. Let's record the Price. The 
default Currency is also filled in automaticallycan be revised. The changes made 
here will update the corresponding columns in the Part Catalogue form.  
You may also want to record different prices for different quantities of the same part, 
if customers are offered a lower price when purchasing a larger quantity. To do so, 
simply record the same part on multiple lines, specifying for each line the minimum 
quantity to which that price applies. The Part Catalogue will display only the List 
Price recorded for one unit.  
We've shown two methods of recording and revising the prices in the Base price list. 
Usually, the former method is useful when recording a new part, and the latter in 
cases where major revisions are made to the prices offered. Now, we'll demonstrate 
how to create customer-specific price lists.  
Adding Customer Price Lists (03:59-05:59) 
A customer price list is a price list that is manually linked to one or more customers. 
The prices of the parts recorded here will ap
pear as the default in various sales 
documents recorded for those customers, overriding the list price in the Base price 
list.  
Let's create a new price list which can be linked to certain types of customers, such 
as educational institutions and NGOs. First, open a new line in the form, and record 
the Price List Code, List Description and Currency. The Valid List Date is filled in 
automatically with today's date. You can add items manually to the Part Prices sub-
level form, just like we did with the Base price list, or automatically, as we'll see in a 
minute. Now, let's link the new price list to a customer.  
In the Customers form, we'll retrieve one of the customers to which we want to link 
the list, and record the new price list in the Customer Price Lists sub-level form.  
Note that there is no need to record the Base price list for any customer, as it is 
linked automatically to all customers. If a certain part is not listed in the customer 
price list, but does have a list price in the Base price list, that price will appear by 
default.  
You can also create a set of related customers and then assign the same price list to 
all those customers via their representative. You do so by assigning them the same 
representative customer, whose prices, discounts and parts are then inherited by 
them. For example, you might sell goods to various branches of a store chain, where 
each store is defined as a separate customer, but the prices for the entire chain are 
identical. Rather than setting prices for each branch separately, you can set them for 
one branch and then define that branch as the representative customer for the other 
branches. 
Adding Items to a Price List Automatically (06:00-07:03) 
Beside adding items to a price list manually, you can also run a program that adds 
them auto
matically. This is useful when you're setting up the system and want to add 
all your parts to the Base price list, or, for instance, when you want to add a new 
range of products to the list.  
Run the Prepare Price Lists program. In the dialog box, choose the desired price 
list. You can leave an asterisk in the Part Number column to add all parts, or press 
Cat.No. LB130381  Ver.1 – Aug 18,’13 2

F6 twice in this column to access the Part Catalogue form. From here, press F11 to 
move to Query mode and retrieve the desired parts; then press Esc to continue 
running the program. Back in the Price Lists form, move to the Part Prices sub-
level form and record the prices for each part added by the program.  
Updating List Prices (07:04-08:52) 
You can update prices in a list by a designat
ed percentage or sum, without having to 
open a new price list. First, copy the existing price list to a new version, so as to 
maintain a record of the older version of prices. We'll demonstrate this on the Base 
price list. Run the Copy Price List program, designating the Base price list in both 
the Source Price List input column and the To Price List column. If older versions 
of this price list exist, select the version you want to copy in the next input screen. 
Also specify the effect date of the new price list version in the To List Date column; 
then click OK. Note that the new list will not go into effect automatically on that date; 
you will need to put it into effect manually, as we'll see.  
Now raise the prices of the new price list version by running the Raise/Lower Prices 
program. Select the Base price list in the Price List Code column, then choose 
either the Percent by which to raise the price, or the absolute Value. You can 
update the price by the original price before tax and Round the new prices. In the 
next dialog box, select the version to update and click OK. 
In the Price Lists form, both versions are displayed in the Price List Dates sub-
level form, with their corresponding Date, and the prices themselves are shown for 
each version in the Part Prices sub-level. For the new version to go into effect, we 
need to flag the Valid column. From this moment onward, this Base price list is the 
valid one.  
Updating Customer Price Lists by Vend or Price Lists (08:53-10:45) 
If your business sells products to customers at prices that are higher by a fixed 
percentage than the price at which you bought them, you can build a new price list or 
update an existing one based on a vendor price list, using the Revise Cust PList by 
Vend Plist program. In the Customer Price List input column, you can choose an 
existing price list, or, as we'll demonstrate, set up a new list as you go along. Press 
F6 twice to enter the Price Lists form, and quickly open a new record. Return to the 
program by pressing F8, which saves the selected line. The red magnifying class 
next to the input column indicates that a selection was made here. Now, select the 
parts for which to raise prices: either in the Part Number column, as you saw earlier, 
or by specifying a Part Family. 
In the next window, select the desired Vendor Price List (which is already recorded 
in the system), and flag Add Vendor Parts, because the customer price list is new 
and has no parts yet. Specify the percentage by which to increase the original 
vendor prices for this customer. In the next input screens, choose whether to add 
shipping expenses and whether the discounts received from the vendor will also 
apply to the customer. As a result, vendor parts are added to the new price list you 
created, and their prices are updated in keeping with your price policy. 
Cat.No. LB130381  Ver.1 – Aug 18,’13 3

Printing a Price List (10:46-11:02) 
Assuming you'll be distributing the new list among your stores, you can print it or 
create an HTML file that can be faxed or sent by email. From the Price Lists menu, 
choose one of the several options for printing the list.  
Discounts (11:03-14:18) 
You've seen how to add parts and update prices in the Base price list; how to build a 
new price list and assign it to customers; how to raise or lower prices by a fixed 
percentage; and how to set up a new price list, or update an existing one, based on 
the prices paid to a vendor. Now we'll briefly demonstrate how dis
counts are defined 
in the system.  
Discounts can be assigned to individual parts and entire part families. You can also 
define an overall discount for a customer that will be applied after all other discounts. 
Or, rather than defining a discount percentage, you can set a special price for a 
specific part. All these discounts will be in effect for a limited period, which you 
define.  
Let's open the Discount Codes form. We've already defined various types of 
discounts, each with a different percentage, valid for different periods. These codes 
will appear in various Choose lists of forms and programs.  
Now, go back to the Customers form to define discounts for a customer. In the 
Overall Discounts sub-level form, you can define a discount that applies to all sales 
for the customer over a designated time period. Select the Discount Code from the 
Choose list. The start and end dates are filled in automatically, according to the 
definitions in the Discount Codes form seen earlier. Or simply record the discount 
directly in the form, instead of selecting a discount code.  
You can define a discount for this customer with respect to individual parts, or entire 
part families, in the Part Discount and Family Discount sub-level forms, 
respectively. Using the Assign Discount to Parts program, you can automatically 
assign a Discount Code to selected parts. 
Or, instead of setting a discount, you can use the Special Part Price sub-level 
formto define a special price for the customer with respect to a specific part. This 
price will also be in effect within a designated period, and will not be affected by any 
price list or discount, except the Overall Discount defined for the customer. It's 
convenient to define a special price when you want to have a sale for a limited period 
of time.  
In the Logistic Constants form, you can determine the way discounts apply in case 
several types, such as a part discount and a family discount, are in effect 
simultaneously. Let's locate the line for the SAddDiscount constant and choose the 
appropriate Value. The default is zero (0), meaning that only the strongest discount 
will be in effect, but you can change this. Read more about the constant in the Help 
Text sub-level form.  
You can view the final price for the customer in the Customer Prices & Discounts 
report, which displays the various prices and discounts defined for selected parts. 
It's important to note that discounts don't apply to price lists flagged in the Special 
Part Prices column of the Part Prices form, with the exception of the Overall 
Discount.  
Cat.No. LB130381  Ver.1 – Aug 18,’13 4

Cat.No. LB130381  Ver.1 – Aug 18,’13 5
Price Hierarchy (14:19-15:33) 
When recording a sales document, the price of the part will be taken from the 
following hierarchy (in descending order):  
 Part prices recorded in the document on which the current document is based 
(for instance, a price quote);  
 If the order is for a pro duct bundle, that is, an assortment of products sold 
together for a fixed price: the price of the entire bundle;  
 The Price List manually recorded in the sales document;  
 The special part price; 
 The price in a valid customer price list;  
 The list price from the Base price list.  
In any case, you can revise the prices manually in the document.  
The documents in the system display the Price Source of all the parts recorded.  
For example, in the Sales Orders form, let's move to the Order Items sub-level form 
and record an order item. A price appears automatically, and the source of the price 
appears in the Price Source column. If a discount appears, you can run the 
Discounts Applying to Item program from the list of Direct Activations for an 
explanation of the discount source.  
Summary (15:34-16:16) 
Let's summarize what we've shown in this video: 
 
An explanation of the Base price list and how to update it 
 How to create and update a customer price list  
 How to assign a price list to a customer or group of customers 
 How to create new versions of existing price lists 
 How to raise or lower prices by a fixed percentage 
 How to update a customer pr ice list based on vendor prices 
 The different types of discounts defi ned for customers, parts and part families 
 And, finally, the hierarchy of prices in the system.  
 
This concludes our explanation of prices and discounts in Priority.  
Related Documentation 
 Prices and Discounts Wizard 
 CRM Wizard 
 CRM for Sales Reps clip 
 Opening a Sales Order clip
