# SOP Customer Price Lists and Discounts

- **Source:** `SOP Customer Price Lists and Discounts.pdf`

Cat.No. LB120309 1 Ver.1 – Jan. 13, ’13 
 
SOP: Customer Price Lists and Discounts* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To define customer price lists and discounts 
 To update customer price lists (manually or automatically). 
Procedure 
Stage I: Defining a Customer Price List 
1. Enter the Price Lists form. 
2. Record a Price List Code, List Description and Currency. The Valid List Date is 
filled in automatically with the current date, but may be revised in the Date column of 
the Price List Dates sub-level form. 
3. Enter the Part Prices sub-level form. 
4. For each part, specify the Part Number, Quantity (the minimum quantity that must 
be purchased in order to receive the designated price), Price and Currency. 
Tip: To define quantity discounts, record several lines for the part, each with its own 
unit price and minimum quantity. For example, when purchasing a single unit of the 
part, the price is $25 per unit, and when purchasing 10 units of the part, the price is 
$20 per unit. 
Stage II: Linking a Price List to a Customer 
1. Enter the Customers form and retrieve the desired customer. 
2. Enter the Customer Price Lists sub-level form. 
3. Select the desired price list in the Price List Code column. 
4. When a particular part appears in multiple price lists for the same customer, you can 
define from which price list the part’s price will be taken by setting a value in the 
Priority column for each price list. The lower the number, the higher the priority. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Stage III: Defining Customer Discounts for Specific Parts 
1. From the Customers form, enter the Part Discount or Family Discount sub-level 
form. 
2. For each part for which you want to offer this customer a discount, record a line 
specifying its Part Number, Discount(%), Start Date and Expiration Date. 
Result 
 As a result of assigning a price list and defining discounts, the listed prices will 
appear automatically in every sales document opened for the customer, and will be 
discounted as defined in the Part Discount form. Every line item in the document 
will display "Price List" as the price source. 
Stage IV: Creating a New Version of an Existing Price List 
1. Run the Copy Price List program. 
2. Specify the price list you want to copy in the Source Price List input column. 
3. If several versions of the same price list with different effect dates already exist in the 
system (as the result of previous copying of price lists), you can choose which 
version to copy by its effect date. 
4. Specify the source price list again in the To Price List input column, and specify the 
effect date of the new version in the To List Date column. The new list will not go 
into effect automatically on that date; you will need to put it into effect manually. 
Note: The specified list code must already be defined in the Price Lists form without 
any parts or prices (on the list date in question). 
5. To see the new version, enter the Price Lists form, move to the price list in question 
and enter the Price List Dates sub-level form. The new version will appear next to 
its defined effect date. 
6. To put the new version into effect, flag the Valid column. When you leave the line, 
the check mark is automatically removed from the version that was previously in 
effect. 
7. To view the parts and prices listed in a particular version of the price list, enter the 
Part Prices sub-level of the Price List Dates form. In this form you can also change 
part prices in the current version manually. To uniformly change all the part prices in 
a price list, see Stage V. 
Result 
 When a new price list version is put into effect, it serves as the new source for part 
prices in sales documents recorded for those customers that are linked to the price 
list. 
Stage V: Updating Prices in a Price List 
1. Run the Raise/LowerPrices program. 
2. In the input screen, specify the Price List Code. If several versions of the same 
price list with different effect dates already exist in the system (see Stage IV above), 
choose which version to use in the next input screen. 
Cat.No. LB120309 2 Ver.1 – Jan. 13, ’13

Cat.No. LB120309 3 Ver.1 – Jan. 13, ’13 
3. In the Part Number column, record the part or group of parts whose prices you want 
to update. 
Tip: Combine the asterisk with part number code to specify a group of parts (e.g., 
use 3* to specify all parts whose numbers begin with 3). 
4. Specify the Percent or Value by which to change the part prices. Use a negative 
value to lower prices. 
5. Enter the Part Prices sub-level of the current price list version to view the new 
prices. 
Result 
 By copying and updating the price list, you create a new version with updated prices. 
Stage VI: Setting Price Policies for Parts Linked to a Base Product 
Aim: To define the method of setting prices for parts that are linked to a base product: 
whether they are determined by the price of the base product, or if you can define their 
own prices in customer price lists. 
 
1. Open the Part Catalogue form, and retrieve all base products for which you wish to 
define price policies. 
2. In the Price Policy column, verify that the value is 01 (one price for all parts linked to 
the base product). 
3. Open the Logistic Constants form, move to the IPricePolicy constant and set the 
value as follows: 
 To enable the management of price lists for parts linked to a base product 
independent of the base product, leave the default value of 0. When you add the 
base product to a price list, all of the parts linked to it will be added to the price 
list, and their prices will be identical to that of the base product, but you may 
revise an individual part’s price manually. When the price of the base product is 
changed, the price of all parts linked to it will change accordingly, except for 
those products for which prices were manually revised. 
 Change the value to 1 so that the parts linked to a base product will not be 
included in price lists. Rather, their prices will always be determined by the price 
of the base product.
