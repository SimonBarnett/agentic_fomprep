# 15-17-Replenishing Consignment Warehouses

- **Source:** `15-17-Replenishing Consignment Warehouses.pdf`

www.priority -software.com   
1/2 Feb. 19, '15 Ver. 2 Cat.No. LB120135 
 
 SOP: Replenishing Consignment Warehouses1 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To calculate quantities of items needing replenishment in consignment warehouses located on 
the customer's site. 
 To automatically open sales orders to replenish inventory quantities in consignment warehouses. 
Working Assumptions 
 Consignment warehouses have been defined in the Warehouses form, in keeping with the SOP 
on Opening Warehouses. Where necessary, transit warehouses were assigned to them. 
 Minimum and maximum inventory quantities for the warehouse have been defined in the 
Warehouse Inventory Levels form, a sub-level of Warehouses. 
 Replenishment increments for the parts in question have been defined in the Purchase/MRP 
Parameters for Part form. 
Procedure 
Stage I: Calculating Required Replenishment Quantities for Consignment 
Warehouses 
Aim: To view calculations of part quantities needed to replenish inventory in consignment 
warehouses. You can use results to assist you in opening orders manually or to examine quantities 
that will be recorded in automatically opened orders. 
Note: You can skip this stage and proceed directly to Stage II. 
1. Run the Replenish Consignment Warehouses program. 
2. In the input screen, fill in the following details: 
 In the Warehouse column, select the warehouse for which the calculation will be performed. 
 Do not flag the Open Orders column. 
 If you want calculations to also take into account open sales orders from the consignment 
warehouse for end customers, flag Include Consignment Warehouse Orders. Otherwise, 
leave the column blank.  
                                                 
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Feb. 19, '15 Ver. 2 Cat.No. LB120135 
 
Result 
 A detailed report is produced, displaying the following information per part: minimum quantity, 
current balance, balance in transit warehouse, open orders to this warehouse, open orders from 
this warehouse, maximum quantity, quantity to order, and balance after replenishment. 
Stage II: Opening Sales Orders Automatically 
Aim: To open sales orders automatically based on calculated quantities (as viewed in Stage I) for 
the consignment warehouse customer, as defined in the Warehouses form. 
1. Rerun the Replenish Consignment Warehouses program. 
2. In the input screen, fill in the following details: 
 In the Consignment Warehouse column, select the warehouse for which the orders 
will be opened. 
 Flag the Open Orders column. 
 If you want calculations to also take into account open sales orders from the 
consignment warehouse for end customers, flag Include Consignment Warehouse 
Orders. Otherwise, leave the column blank.  
 In the Order Due Date column, select the requested date. 
Note 
Once you leave the input screen, you will receive a message indicating the number of orders that 
were opened. After confirming the messages, a report will open, displaying the new order numbers 
and dates, the customer for which orders were opened (i.e., the company maintaining the 
consignment warehouse), and the consignment warehouse and bin for which the goods are 
destined. If a transit warehouse was assigned to the consignment warehouse, the transit warehouse 
will be displayed instead. 
Result 
 Sales orders were opened for consignment warehouse customers, in Draft status, based on 
calculations for replenishing inventory in such warehouses. Use the standard procedure for 
working with the Sales Orders form. For details, see the Sales Order Wizard. 
Summary 
Running the Replenish Consignment Warehouses program generated a report displaying the 
required quantities for inventory replenishment in the consignment warehouse, based on defined 
Warehouse Inventory Levels for the consignment warehouse and on Replenish Increments for 
each part. Rerunning the program with different settings opened sales orders to replenish the 
inventory.
