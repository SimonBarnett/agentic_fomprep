# SOP Defining a part

- **Source:** `SOP Defining a part.pdf`

Cat.No. LB10000164 1 Ver.1 – June 7,’10 
 
SOP: Defining a Part* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record a purchased part in the system and define its financial, production and 
inventory parameters. 
Setups 
 Enter the Part Families form and define a part family: Record the desired family code 
in the Family column, and the full family name in the Family Description column. 
Note: You can also assign each family a family type and determine whether to block 
inventory transactions that would result in a negative inventory balance for parts in 
this family. 
 Enter the Part Units form and define any part units required to record the part in 
purchasing or manufacturing documents. Record a Unit code and Unit Description 
for each unit. 
Procedure 
Stage I: Defining a Part 
1. Enter the Part Catalogue form. 
2. Specify the Part Number and Description.  
3. Move to the Details tab. The value 0 appears by default in the Family column, 
indicating the general part family. Specify a different part family as needed. 
4. If this part is usually purchased from a specific vendor, indicate this in the Preferred 
Vendor column. 
5. Move to the Additional Details tab. The value R appears by default in the Part Type 
column, indicating a raw material. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

6. The value ea appears by default in the Buy/Sell Unit and Factory Unit columns. 
Specify a different part unit as needed. 
Notes: 
 As the two columns display the same unit, the value of the Conversion Ratio will 
be 1. 
 Flag the Variable Conversion column if you want to be able to record inventory 
transactions for this part in which the quantity in buy/sell units does not correspond 
to the quantity in factory units. This is solely to allow special pricing by buy/sell 
units and does not impact inventory balances, which continue to be maintained by 
factory unit. 
7. The In Use status appears by default in the Status column. 
8. The Inv. Control column is flagged by default. Remove the check mark if you do not 
want to maintain inventory for this part.  
9. Move to the Prices and Costs tab. Define the part price in the base price list in the 
List Price column. 
10. If you want a remark to appear for this part in various printouts, enter the Parts – 
Remarks sub-level form and record the desired text. 
11. Use the parallel Part Remarks for Internal Use sub-level form to record a brief 
message that will pop up whenever the part is specified in an inventory document. 
Stage II: Defining Financial Parameters 
1. Select Financial Parameters for Parts from the list of Direct Activations of the Part 
Catalogue form. 
2. Fill in the relevant details in the General tab (e.g., Tax Group, Accounting Family). 
3. Click the Shipping Expenses tab and specify the part's Weight and Volume, 
together with their respective units. 
Stage III: Defining Production Parameters 
The Parts form is a direct extension of the Part Catalogue. This form is used to view or 
update production parameters, whereas the Part Catalogue is used to view or update 
the part's basic attributes. 
1. Return to the Part Catalogue form. 
2. Select Financial Parameters for Parts from the list of Direct Activations (or press F6 
from the Part Number column). 
3. In the General tab, designate the part's Routing and the current part Revision, if 
necessary. 
4. Click the Additional Details tab. 
 Define the standard issue type for the part: issued to kits, issued in bulk or manual 
issue. 
 Indicate whether BOM Revisions are maintained for the part. 
 Indicate whether you Maintain Serial Nos for the part. 
Cat.No. LB10000164 2 Ver.1 – June 7,’10

Cat.No. LB10000164 3 Ver.1 – June 7,’10 
 If necessary, specify the percentage of Scrap generated during production. 
5. Use the form's sub-levels to view additional production data (e.g., child parts, part 
revisions and manufacturers).   
Stage IV: Defining Inventory Parameters 
The Inventory Parameters for Parts form is a direct extension of the Part Catalogue. 
This form is used to view or update parameters pertaining to part sales, inventory and 
manufacturing. 
1. Return to the Part Catalogue form. 
2. Select Inventory Parameters for Parts from the list of Direct Activations. 
3. In the Inventory tab, specify the part's default Warehouse, Entry Status and Gen 
Location of Part. 
4. Click the Sales tab and define the part's Order Tolerance, Close Order Tolerance 
and default Packing Crate Code, if necessary. 
5. Click the Manufacturing tab and define the Clean Inventory (%), if necessary. 
6. Click the Service tab and define the part's Warranty Code, if necessary. 
Followup 
To record the part's purchasing parameters, affecting MRP and purchase planning, use 
the Purchase/MRP Parameters for Part form; for details, see the appropriate SOP.
