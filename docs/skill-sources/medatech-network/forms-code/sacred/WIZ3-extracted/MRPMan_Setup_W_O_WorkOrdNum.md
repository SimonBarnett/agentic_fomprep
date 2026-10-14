# MRPMan_Setup_W_O_WorkOrdNum

- **Source:** `MRPMan_Setup_W_O_WorkOrdNum.htm`

MRP for Manufacturers - Work Order Setup: Automatic Opening.1 
 
 
- 
 
 
 
# Opening Work Orders Automatically

 

The MRP program can be set to open work orders automatically, but only for parts that have been flagged accordingly. 
 

In order to open work orders automatically, you first need to define work order numeration templates. By linking a part to a numeration template, you ensure that each time a work order is opened for that part, the system automatically assigns it the correct number in sequence. 
 
## To define a numeration template:

 

 1 .  Enter the Work Order & Lot No. Templates form. 
 

 2 .  In the Template column, record the code that will identify the template. 
 

 3 .  Record a brief Description of the template (e.g., "Work Order: Chairs"). 
 

 4 .  If you want all numbers assigned to this template to begin or end with a set string, record a Prefix or Suffix . 
 

 5 .  If you want all numbers assigned to this template to have the same width, record in the Place Holders column the number of digits to be used (leading zeros are inserted when necessary). Explanation. 
 

 6 .  If you want to start with a specific number (other than 1 ), record the number preceding it in the Last Value column of the template. The next work order opened with this template will receive the next number in sequence.
 Note: If work orders have already been opened on the basis of this template, the column displays the last number assigned.
