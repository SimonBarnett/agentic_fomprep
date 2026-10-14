# SOP Packing Slips and Bills of Lading

- **Source:** `SOP Packing Slips and Bills of Lading.pdf`

Cat.No. LB130457 1 Ver.1 – Oct. 21, ’13 
 
SOP: Packing Slips and Bills of Lading* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This procedure describes the recording of a packing slip in the system, when goods are 
packed for shipment to a specific customer (e.g., for shipment abroad). When you open 
a packing slip in the customer's name, the goods recorded in the packing slip are 
"reserved" for that customer. Afterwards, you can record a shipping document for that 
customer on the basis of the packing slip. 
Setups 
Defining Packing Crate Codes 
1. Enter the Packing Crate Types form. 
2. For each type of packing crate, record the following details: 
 Crate Type Code 
 Crate Type Desc. 
 Crate Weight (and weight Unit) 
 Crate Volume (and volume Unit) 
 Capacity (the quantity of parts that fit into that type of crate). 
3. If the crate capacity depends on the part being packed, enter the Crate Capacity 
Per Part sub-level form and specify each part for which the crate type is used and its 
capacity for that part. 
Procedure 
Stage I: Recording a Packing Slip 
1. Enter the Packing Slips form. 
2. Specify the Customer Number. The document Date and Packing Slip No. are filled 
in automatically. 
Note: The inventory status of the packed goods will be replaced with the customer 
number. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. LB130457 2 Ver.1 – Oct. 21, ’13 
3. The warehouse in which the goods were packed appears automatically in the 
General tab, but may be revised. 
4. Select the Crate Type used for these goods from the Choose list.  
5. Specify the Total Weight of the crate. The Net Weight and Volume of the packed 
goods appear automatically, according to the designated crate type. 
6. If necessary, record a brief remark regarding the crate in the Details column. 
7. To link the packing slip to orders, do one of the following: 
 To link the packing slip to a single sales order, click the References tab and select 
the relevant sales order in the For Order column (the Choose list displays all 
orders placed by the customer with the appropriate status). 
 To link the packing slip to more than one sales order, enter the Orders for 
Packing Slip sub-level form and specify the orders in question. 
 To link the packing slip to individual order items that appear in one or more sales 
orders placed by the customer, enter the Choose Order Items sub-level form and 
flag the Choose Item column for the items in question.  
8. Enter the Packed Items sub-level form. The sales order items appear automatically.  
9. The Warehouse from which each item is taken is copied from the Orig. Warehouse 
column in the upper-level form. Revise if necessary. 
10. Do one of the following to specify the packed quantity of each item: 
 Flag the Approve column to copy the full Balance to Pack into the Quantity 
column.  
 Record a quantity manually in the Quantity column. 
Note: Check the Warehouse Balance column to make sure there are enough parts 
in inventory. 
11. Return to the upper-level form and change the packing slip's Status to the next one 
in the defined work flow. 
12. To print the packing slip, select Print Packing Slip from the list of Direct Activations. 
13. To make revisions to the packing slip after it is final, select Reopen Document from 
the list of Direct Activations. The program changes the document's status back to 
"Draft." After making the necessary revisions, change the status to the next status in 
the work flow. 
Note: You can only reopen a packing slip if it has not yet been linked to a shipping 
document. 
Results 
 After the packing slip is finalized, it can be included in a bill of lading or transferred to 
a different warehouse. 
 The inventory balance of unpacked goods is reduced in the warehouse in which the 
goods were packed. 
 The status of the packed goods is replaced by the number of the customer for which 
they were packed (provided that the goods were packed for a specific customer).

Cat.No. LB130457 3 Ver.1 – Oct. 21, ’13 
Stage II: Shipping Goods on the Basis of a Packing Slip (Creating a 
Bill of Lading) 
1. Enter the Customer Shipments form. 
2. Specify the Customer Number. The Date and Doc No. are filled in automatically. 
3. Specify the Sending Warehouse in the General tab. 
4. Enter the Link Packing Slips to Document sub-level form. The form displays all 
packing slips with the appropriate status that have not yet been shipped.  
5. For each packing slip of goods you want to ship, flag the In Document column. The 
parallel Packing Slips in Document and Shipped Items sub-level forms are filled in 
automatically. 
Note: This shipping document will be linked to the selected packing slip(s) and will 
appear in the Documents Including Packing Slip sub-level of the Packing Slip 
form. 
6. Enter the Shipped Items sub-level form. The Quantity of each shipped part appears 
automatically and cannot be changed. Flag the Approve column for each part. 
7. Return to the upper-level form and change the document's Status to the next one in 
the defined work flow. 
8. To print the shipping document, select Print Shipping Document from the list of 
Direct Activations. 
9. To make revisions to the shipping document after it is final, select Reopen 
Document from the list of Direct Activations. The program changes the document's 
status back to "Draft." After making the necessary revisions, change the status to the 
next status in the work flow. 
Note: You can only reopen a shipping document if it has not yet been printed.
