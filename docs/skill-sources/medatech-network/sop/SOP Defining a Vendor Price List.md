# SOP Defining a Vendor Price List

- **Source:** `SOP Defining a Vendor Price List.pdf`

Cat.No. LB10000174 1 Ver.1 – June 13,’10 
 
SOP: Defining a Vendor Price List* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
You can maintain vendor price lists for items you purchase regularly from the same 
vendors. When vendors change the prices of items, you can update the price list or 
create a new one in order to maintain a price history; the system continues to store 
vendor price lists that are no longer in effect. 
Working Assumptions 
 The value of the PPriceByList constant (in the Logistic Constants form) is 1, causing 
purchase prices to be taken automatically from vendor price lists. 
 Parts have been linked to the vendor in the  Parts per Vendor sub-level of the 
Vendors form. 
Procedure 
Stage I: Defining a Vendor Price List 
Option 1: Manual Itemization 
1. Enter the Vendor Price Lists form. 
2. Record a Price List Code and Price List Description. 
3. Specify the relevant Vendor Number. 
4. Specify the date the price list goes into effect in the  Effect Date column. 
5. Dual-currency users: Make sure the currency appearing in the Curr. column is 
correct. 
6. Enter the Part Prices sub-level form. 
7. For each part, specify the Part Number, Quantity (the minimum quantity that must 
be purchased in order to receive the designated price) and Unit Price.  
8. Specify the Discount% for each part, as needed. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

9. To specify different prices for the purchase of different minimum quantities of the 
same part, open a line for each quantity and specify the relevant Quantity. 
Option 2: Automatic Itemization 
1. Run 
the Prepare Vendor Price Lists program. 
2. In the input screen, specify the Vendor, Price List Code, Effect Date and Currency. 
The program will create the price list and itemize it with the parts listed in the Parts 
per Vendor sub-level of the Vendors form. 
3. Enter the Vendor Price Lists form and retrieve the new price list. 
4. Enter the Part Prices sub-level form. Here you can view the list of prices created by 
the program. 
5. Record a Unit Price  for each part. 
Stage II: Updating a Vendor Price List 
Notes: 
 To cancel a price list, flag the Canceled column in the Vendor Price Lists form. 
 If you want to save the existing price list and create a new one, run the Copy Vendor 
Price Lists program and specify the date the new price list will go into effect. You can 
then retrieve the old price list according to its effect date and view the old part prices. 
Option 1: Manual Update from the Price List 
1. Enter 
the Vendor Price Lists form. 
2. Retrieve the desired price list. 
3. Enter the Part Prices sub-level form. 
4. Record a new Unit Price and/or Discount% for the desired part(s). 
Option 2: Manual Update from the Part Catalogue 
1. Enter 
the Part Catalogue form. 
2. Retrieve the part to be updated. 
3. Enter the Part Price in Vendor Price Lists sub-level form and move to the line for 
the desired price list. 
4. Record a new Unit Price and/or Discount% for the desired part(s). 
Option 3: Automatic Update of Price List Prices 
1. 
To raise or lower all prices in a vendor price list by a specific amount or percentage, 
run the Raise/Lower Vendor Prices program. 
2. In the input screen, specify the Price List Code. 
3. Specify the relevant Part Number, or leave the asterisk (*) to change the prices of all 
parts in the list. 
4. Specify the Percent or Value by which to change the part prices. Use a negative 
value to lower prices. 
Cat.No. LB10000174 2 Ver.1 – June 13,’10

Cat.No. LB10000174 3 Ver.1 – June 13,’10 
5. To obtain vendor prices rounded to the nearest integer, flag the Round column. 
6. Enter the Vendor Price Lists form to view the new prices. 
Option 4: Automatic Update of Price List Discounts 
1. 
To update discounts in a vendor price list, run the Revise Discounts in Price List 
program. 
2. In the input screen, select the desired option: 
 To assign a given discount to one or more parts in the price list, select the Set 
Discounts option. 
 To add to or subtract from the existing part discount by a given percentage, select 
the Raise/Lower Discount option. 
 To copy the discounts assigned in one price list to another price list, select the 
Copy Discounts option. 
Result 
 When vendor prices are recorded automatically (e.g., in a purchase order), they are 
taken from the vendor price list currently in effect.
