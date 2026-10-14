# SOP Costing for Businesses

- **Source:** `SOP Costing for Businesses.pdf`

Cat.No.A8000108 1 Ver.1 – Dec.21,’08 
 
SOP: Costing for Businesses* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To run the cost analysis program for businesses. 
Note: This document does not describe how the costing mechanism works, only how to 
run it.  
Working Assumptions 
 Shipping vouchers recorded in the system have been linked to the relevant purchase 
invoices and finalized before running the costing program. 
 You have access to the standard operating procedure for recording past balances. 
Setup 
 Make sure the relevant warehouses defined in the Warehouses form are flagged in 
the Transaction Costing and Inventory Valued columns. 
Procedure 
Stage I: Defining Standard Part Costs 
Aim: To define standard part costs in the system that will be used in costing 
calculations, both for standard costing and actual costing. 
Defining Standard Costs of Purchased Parts 
1. Enter 
the Standard Costs form and retrieve all Type R parts. 
2. Make sure a value appears in the Std Cost  column. 
Notes: 
 You can run the Update Part Costs  program, which automatically copies standard 
part costs from a variety of sources (e.g., actual cost, last price, vendor price). 
 Dual-currency users: You can also record the standard cost in the second 
currency. However, if you do, you are determining the exchange rate for this part 
with respect to costing. Leave that column empty, and costing will calculate data in 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

the second currency based on the exchange rate in effect on the day costing is 
run. 
3. If the standard cost of a single part unit is too low, you can define a Costing Unit. 
For example, you can record a standard cost of 10 dollars for one costing unit 
consisting of 1000 single units. 
4. Make sure to define standard costs for all work hour parts, which are also Type R. 
Defining Standard Shipping Costs 
1. Enter 
the Financial Parameters for Parts form and retrieve the parts that are usually 
shipped to you. 
2. For each part, click the Shipping Expenses tab and specify the Shipping Cost 
Type. Define the relevant cost percentage. For example, if you selected Cost Type 
A, fill in the Air Cost (%) column. 
Result 
 
Standard costs have been defined for purchased parts and for work hours (which are 
also defined as Type R parts). 
Stage II: Initializing the Costing System 
Aim: To define the various parameters required to run costing. This stage is only 
performed once, before the first costing run. 
 Run the Set Costing Parameters program, and define the following parameters in the 
input screen: 
 Costing Method – choose "Moving Average" 
 Standard Part Costs – choose "Std Material Cost" 
 Costing of Materials – choose "Consider Lots" 
 If Costing Option = T – choose "No Costing for WkOrd". 
Stage III: Running Costing for the First Time 
Aim: To define how costing should be run the first time (after the costing initialization 
process is complete). 
The costing initialization date is the cut-off date from which the costing mechanism 
begins (even if work has already been done in the system, costing will only recognize 
those transactions recorded after the initialization date). We will call this Date X. 
1. Record a past balance for Date X (e.g., 12/30/07). 
2. Run costing for the past balance date ( X). 
3. Perform an inventory count (quantities only) for the day following the initialization 
date (X + 1, in this case, 12/31/07). In the absence of additional costs recorded in the 
system, the costing program automatically assigns each part's default cost (the 
defined standard cost) to the incoming inventory transaction created by the inventory 
count. 
4. Record a past balance for the inventory count date ( X + 1, i.e., 12/31/07). 
Cat.No.A8000108 2 Ver.1 – Dec.21,’08

Cat.No.A8000108 3 Ver.1 – Dec.21,’08 
5. Run costing again for the new past balance date ( X + 1, i.e., 12/31/07).  
6. Begin working on X + 2 (i.e., 1/1/08). 
Stage IV: Running Costing on a Regular Basis 
Aim: To define how costing is run on a regular basis (so that results aid in calculating 
inventory valuations for financial reports). 
1. Make sure all relevant inventory transactions are closed up to the desired past 
balance date. 
2. Run the Calculate Balance for Date program for the desired date (e.g., the end of the 
fiscal quarter). 
3. Run the Costing for Past Balance Date program, which uses the costs of inventory 
transactions recorded since the last costing run to calculate the part costs that are in 
turn used to calculate inventory values. 
Result 
 
You can use the reports in the Inventory Valuation Reports menu (menu path: 
Financials > Cost Analysis for Businesses) to display inventory values in various 
cross-sections. 
Stage V: Analyzing Costing Results 
Aim: To determine how the costing system calculated part prices. 
1. Enter the Material Costing form to view the calculated standard and/or actual cost of 
raw materials in various costing runs. 
2. Enter the Product Costing form to view the calculated costs of manufactured parts in 
various costing runs. 
Stage VI: Canceling a Costing Run 
 If you wish to cancel a given costing run (e.g., in order to rerun it), run the Delete 
Costing Results program for the desired costing date.  
Result 
 
All costing runs as of the specified date are deleted from the system and their data 
no longer appear in costing results. 
Process Summary 
Once costing is run, each part is assigned a cost, which is also used to calculate 
inventory values. The data are stored in the costing tables (unless they are deleted by 
the Delete Costing Results program).
