# SOP Standard costing for Manufacturers

- **Source:** `SOP Standard costing for Manufacturers.pdf`

Cat.No.A8000110 1 Ver.1 – Dec.8,’08 
 
SOP: Standard Costing for Manufacturers* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To run costing for manufacturers on the basis of standard costs.  
Note: This document does not describe how the costing mechanism works, only how to 
run it.  
Working Assumptions 
 Basic costing data has been defined, as described in the operating procedure 
Setting Up Costing for Manufacturers. 
 You understand the costing system and its various methods. 
 You understand the process of recording a past balance. 
Procedure 
Stage I: Running Costing for the First Time 
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
5. Run costing again for the new past balance date ( X + 1, i.e., 12/31/07).  
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

6. Begin working on X + 2 (i.e., 1/1/08). 
Stage II: Running Costing for a Past Balance Date 
Aim: Calculating costs for the past balance date, to serve as the basis of inventory 
valuation reports. 
1. Make sure all relevant inventory transactions are finalized up to the desired past 
balance date. 
2. Run the Calculate Balance for Date program for the desired date (e.g., the end of the 
fiscal quarter). 
3. Run the Costing for Past Balance Date program, which uses the costs of inventory 
transactions recorded since the last costing run to calculate the part costs that are in 
turn used to calculate inventory values. 
Result  
 
Costs are assigned to parts, according to the defined costing method, standard data 
and actual costs (for parts defined for actual costing). 
Stage III: Running Costing for the Current Date 
 Run the Costing for Current Date program. You will see a notification message when 
the program finishes running. If the program failed to calculate the cost of certain 
items (e.g., Type R parts that have no standard cost and for which no incoming 
inventory transactions were recorded, or Type P parts with no child part costs), you 
will be referred to the Warning Messages - Costing report. 
Note: The results overwrite the previous run of this program, and do not update costing 
data calculated for the last past balance. 
Stage IV: Analyzing Costing Results 
Aim: To view and analyze the way standard part costs were calculated by the costing 
mechanism. 
There are two ways of viewing costing results: (1) form queries, which allow you to 
dynamically analyze costing data; and (2) reports, for viewing and printouts. 
Form Queries 
 The Material Costing form displays the calculated standard and/or actual cost of raw 
materials in various costing runs. 
 The Product Costing form displays the calculated costs of manufactured parts in 
various costing runs. 
Note: These forms display costing data both for the current date and for the past 
balance date. You can select a range of parts and/or dates as needed. 
Reports 
 Material Costing 
 Product Costing 
Cat.No.A8000110 2 Ver.1 – Dec.8,’08

Cat.No.A8000110 3 Ver.1 – Dec.8,’08 
 Standard Cost Analysis – This report displays the detailed calculation of standard 
cost according to the BOM in effect on the costing date. It displays the cost of the 
parent part and each of its components, and distinguishes between material costs 
and production (operation) costs. 
Note: You can run additional reports from the Costing Reports – Parts menu (menu 
path: Financials > Costing for Manufacturers > Costing Results).  
Stage V: Canceling a Costing Run 
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
