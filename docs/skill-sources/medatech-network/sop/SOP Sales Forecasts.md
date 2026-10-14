# SOP Sales Forecasts

- **Source:** `SOP Sales Forecasts.pdf`

Cat.No. LB130455 1 Ver.2 – Dec. 08, ’13 
 
SOP: Sales Forecasts* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
Priority allows you to plan and analyze your annual sales cycle per sales rep and 
territory by defining targets for your sales team(s) and generating up-to-date sales 
forecasts based on your existing sales and CRM data. 
There are two types of targets that can be created: sales targets and order targets. 
 Sales targets - meeting targets is evaluated based on customer invoices. 
 Order targets - meeting targets is evaluated based on sales orders. 
Setups 
 Define Sales Representatives and assign them to customers. 
Tip: You can link a number of sales representatives to a head sales rep and thereby 
create a sales rep hierarchy. Sales to a lower-level sales rep are accredited to the 
defined head sales rep. For more information, see the SOP for defining sales 
representatives. 
 Define Territories and link them to customers. 
Tip: You can link a number of territories to a parent territory and create a territory 
hierarchy. Sales to a sub-territory are accredited to the defined parent territory. 
 Assign customers to customer groups. In the Customer Groups form: 
 Flag the Sales/Order Target column to have itemized sales or order targets list a 
given customer group in a separate line. 
 Define a Sample Customer for each group. That customer's price list will be used 
for this customer group when calculating targeted sums automatically based on 
forecasted quantities. 
 Assign parts to part families. In the Part Families form: 
 Flag the Sales/Order Target column to have itemized sales or order targets list a 
given part family in a separate line. 
 Define a Sample Part for each part family. That part's list price will be used for this 
family when calculating targeted sums automatically based on targeted quantities. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. LB130455 2 Ver.2 – Dec. 08, ’13 
 If you plan to define sales targets for a top-level family that incorporates this family 
and others, specify the Top-Level Family to which to link the current part family. 
Do the same for all other families to be included in the group. 
 In the Customers form, flag the Sales/Order Target column to have itemized sales 
or order targets list a given customer in a separate line. 
 In the Inventory Parameters for Parts form, flag the Sales/Order Target column to 
have itemized sales or order targets list a given part in a separate line. 
 Define statuses for sales forecasts. Predefined statuses include "Draft" and "Final". 
Maintaining statuses for sales forecasts enables you to define BPM flow charts for 
the process of authorizing and managing these forecasts. 
 Define statuses for commission agreements. This enables you to define BPM flow 
charts for the process of authorizing and managing these agreements. 
 In the Logistic Constants form, make sure that the SOppClosePct constant is set to 
the desired value. 
Procedure 
You can open sales or order targets manually, or you can have the system open them 
automatically based on past sales data. You can also define commission for each sales 
rep that meets target sales/order levels. 
Stage I: Preparing a Sales or Order Target Manually 
1. Enter the Sales/Order Targets form and indicate the Year of the target. A new target 
is opened. 
2. Record a Target Description. 
3. Select the appropriate target Type ("Orders" or "Invoices"). 
4. Enter the Sales/Order Target Items sub-level form to record the pertinent details for 
each sales rep's target: territories, customer groups, customers, part families, and 
parts. 
5. Specify target quantities. Sums are filled in automatically, as follows, but may be 
revised: 
 For a target that is itemized with specific customers and parts, sums are calculated 
automatically based on customer price lists (including special prices and/or 
discounts, where applicable). 
 For a target that is itemized in more general terms with customer groups and part 
families, sums are calculated automatically based on the price list assigned to the 
sample customer defined for the customer group (in the Customer Groups form). 
 For a target that is itemized with part families only, sums are calculated 
automatically based on the price assigned to the sample part defined for the family 
(in the Part Families form). 
6. When you have finished itemizing the sales or order target, return to the upper-level 
form. Assign the target to the appropriate user and/or revise the status as indicated 
in the BPM flow chart for sales/order targets.

Cat.No. LB130455 3 Ver.2 – Dec. 08, ’13 
7. To save a record of the current version before revising the target, select Save 
Version from the list of Direct Activations. 
Tip: To view previous versions, enter the Sales/Order Target Versions sub-level 
form. 
Stage II: Preparing a Sales or Order Target Automatically 
1. Enter the Sales/Order Targets form and indicate the Year of the target. A new target 
is opened. 
2. Record a Target Description. 
3. Select the appropriate target Type ("Orders" or "Invoices"). 
4. Select Build Target Items from the list of Direct Activations, indicating the date from 
which to retrieve past sales data. This program itemizes the target automatically, 
based on past sales for the designated date, but does not fill in target quantities or 
sums. 
Note: After running this program, you can add or delete target items manually, if 
desired. 
5. When the program is finished running, update target quantities and sums manually, 
as described above (see Stage I) or select Update Target Items from the list of 
Direct Activations to have quantities and sums filled in automatically, based on sales 
made over the past two years, taking into account seasonal and other trends. 
Notes: 
 The program calculates quantities using an industry-standard formula that employs 
level, slope, and seasonal indices. These indices are defined in the Target 
Calculation Constants form. Sums are then calculated based on these quantities, 
as described above (see Stage I). 
 After running this program, you can revise target quantities and sums manually, if 
desired. 
6. To automatically delete any target items for which no quantities have been recorded, 
select Delete Lines Without Values from the list of Direct Activations. 
7. When you have finished itemizing the target, return to the upper-level form. Assign 
the target to the appropriate user and/or revise the status as indicated in the BPM 
flow chart for sales/order targets. 
8. To save a record of the current version before revising the target, select Save 
Version from the list of Direct Activations. 
Tip: To view previous versions, enter the Sales/Order Target Versions sub-level 
form. 
Stage III: Recording Commission Agreements 
1. Enter the Commission Agreements form and indicate the Year of the agreement. A 
new commission agreement is opened. 
2. Select the appropriate target Type ("Orders" or "Sales"). 
3. Specify the sales rep for whom the agreement is being defined. 
4. Record an Agreemt Description.

Cat.No. LB130455 4 Ver.2 – Dec. 08, ’13 
5. Move to the Targets tab and record a High Target Def. (%). If sales reps attain this 
percentage of their target, they will be awarded the predefined high-target 
commission. This column should receive a value greater than 100. 
6. Define one or more of the following commission types: 
 Basic Commission (%) – The percentage paid if the sales rep has not met targets 
(as defined in the relevant sales/order target). 
 Commissn % at Target – The percentage paid if the sales rep has met targets (as 
defined in the relevant sales/order target). 
 Comm% at High Target – The percentage paid if the sales rep has met the high 
target (as defined in the adjacent column). 
Note: Commissions will be calculated at this percentage for all sales (rather than 
just for the excess amount). 
7. When you have finished defining the commission agreement, assign it to the 
appropriate user and/or revise the status as indicated in the relevant BPM flow chart. 
Stage IV: Running Reports 
Priority provides several reports that enable you to track sales progress, evaluate 
actuate sales versus targets and analyze sales forecasts: 
 Actual vs Target-Current/Prev Yr - This report compares actual data with sales/order 
targets for a designated range of dates, and compares this year's performance with 
the previous year's performance during the same period. 
Note: Data for the current year are calculated based on actual sales/order data, as 
well as forecasts for future sales/orders.  
 Sales Rep Commission - For each sales rep, this report displays the following data 
per month, quarter or in summary form: 
 the target amount 
 the actual amount of sales (taking into account the target type) 
 the commission due (based on the percentages defined in the relevant 
commission agreement). 
 BI for Sales/Order Targets - Run the Prep for Actual vs Target (BI) program and then 
run the following reports: 
 Actual vs Target-Orders (BI) 
 Actual vs Target-Sales (BI) 
 BI for Sales Forecasts - Run the Prep for Sales Forecasts (BI) program and then run 
the Sales Forecast Analysis (BI) report. Sales forecasts are prepared based on 
relevant sales opportunities, open order items and unbilled shipped items for which 
you expect to record an invoice during the specified period, as well as actual invoices 
recorded during that period.
