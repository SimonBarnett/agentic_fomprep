# 15-17-Cost Allocation

- **Source:** `15-17-Cost Allocation.pdf`

www.priority -software.com   
1/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110529 
 
 SOP: Cost Allocation 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To create profit and cost centers in a variety of cross-sections 
 To define bases of cost allocation and link them to cost centers 
 To link profit/cost centers to inventory and financial transactions 
 To define default profit and cost centers on various levels 
 To run profit/cost center reports and analyses. 
Notes: 
 Profit centers are defined in the system on order to analyze the company's activities from an 
administrative viewpoint that is not necessarily financial or logistical (e.g., revenues and 
expenses from a departmental or regional perspective). All activities based on revenue or 
expense from one or another such perspective is linked to a corresponding profit center.  
 Activities involving indirect costs or revenues that are not related to a specific profit center are 
linked to a cost center, so that sums are distributed among relevant profit centers according to 
pre-defined cost allocation bases. 
Procedure 
Stage I: Creating Profit Centers 
1. Enter the Profit Centers form. 
2. Record a code for the Profit Center and a Description.  
3. Link the profit center to a profit group in the Group column. You can define up to five groups per 
profit center. 
Note: If you do not intend to define multiple cross-sections, specify Group 1.  
4. If you want to group profit centers into larger categories for cost allocation reports, create trees 
in the Profit/Cost Center Trees form. Then link the profit center to a Tree Code.  
Note: Trees are defined as hierarchies (similar to trial balance codes), which can contain up to 
three levels. They can also be assigned to cost centers (see below). 
Stage II: Creating Cost Centers 
1. Enter the Cost Centers form. 
2. Record a code for the Cost Center and a Description. 
Note: You cannot assign a code that has already been given to a profit center.   
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110529 
 
3. Link the cost center to a cost group in the Group column. You can define up to five groups per 
cost center, similar to profit centers. 
4. Link the cost center to a Tree Code, as needed.  
5. Specify the cost center's Allocation Code, which determines the bases of cost allocation. 
6. The system contains ten pre-defined bases of cost allocation, which you can revise as needed. 
To define additional bases: 
 Enter the Bases of Cost Allocation form. 
 For each new base, record an Allocation Code and Allocation Base. 
 Select the relevant Group (out of the 5 possible groups). 
 To distribute costs in the same proportion as direct costs, flag either the By Direct 
Costs/Mnth or By Direct Costs YTD column.  
Note: If neither column is flagged, cost allocation will be calculated by user-defined weighted 
parameters (see below). 
 Flag the In Use column to put the base into effect. 
 Enter the Cost Allocation Dates sub-level form and specify the Date as of which the cost 
allocation will be performed. This must be the first date of a fiscal period (i.e., the first of the 
month). 
 For each date, enter the Allocations per Profit Center sub-level and specify the profit 
centers among which costs are distributed. If costs are distributed by weighted parameter, 
specify the proportional Weight of each center. 
Note: If cost allocation is by direct costs (as defined above), it is not mandatory to assign 
weights; you only need to list the profit centers among which the costs are distributed. 
Stage III: Linking Profit and Cost Centers to Line Items in Inventory and 
Financial Transaction Documents 
The following refers to the sub-level form of any relevant inventory or financial document, where it is 
itemized: 
1. Enter the itemization sub-level form of the document in question. 
2. After recording a part number, quantity and unit price, link any desired line item to the relevant 
profit or cost center. 
Notes:  
 Each line in the document can be linked to a profit or cost center. If the transaction involves a 
direct revenue (e.g., sales order, customer invoice) or a direct expense (e.g., purchase order, 
purchase invoice), the item should be linked to a profit center. If it involves an indirect revenue 
or expense, it should be linked to a cost center. 
 The items in an inventory transaction can only be linked to a single profit/cost center, whereas 
items in financial transactions can be linked to up to five different profit/cost centers. Thus, 
when recording financial transactions, you can complete any additional links to profit/cost 
centers that are required.  
3. Use the Entry Item Revisions form to revise the profit and cost centers in posted journal entries. 
Stage IV: Defining Default Profit and Cost Centers 
For a GL Account: 
1. Enter the Chart of Accounts form, move to the desired account and press F4.

www.priority -software.com   
3/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110529 
 
2. Click the Profit/Cost Ctrs tab. You can link the account to up to five different profit or cost 
centers (one per group). When a journal entry is posted for this account, the relevant centers are 
copied to the entry items. 
3. If desired, assign the account a Profit/Cost Ctr Tree. This requires transactions involving this 
account to be restricted to profit/cost centers from the designated tree. 
Note: If the account is linked to a tree but not to a profit/cost center, journal entries for the 
account cannot be posted until a profit/cost center is assigned to each entry item. 
For a branch: 
 Enter the Branches form, retrieve the desired branch and specify the desired Profit/Cost Center 
in the Financial Data tab. All documents recorded for this branch are automatically linked to this 
profit/cost center. 
For an accounting family: 
 Enter the Accounts for Families form, retrieve the desired Family and specify the Profit/Cost 
Center in the Income & Purchasing Accounts tab. When a part belonging to this family is 
recorded in a document, it is automatically linked to this profit/cost center. 
For a journal entry code: 
1. Enter the Journal Entry Codes form, and retrieve the desired code. 
2. Enter the Entry Patterns sub-level form and link each account/pattern to up to five profit/cost 
centers. 
Note: Default centers defined on this level override any of the other defaults defined above. 
For a customer group: 
 Enter the Accounts for Customer Groups form, retrieve the desired group and select the Profit 
Center. All items in invoices recorded for a customer belonging to this group are automatically 
linked to this center. 
Note: This default only applies to income (customer invoices). 
For a project: 
This is not used very often. It requires purchase of the Project module. 
 Enter the Accounts for Projects form, retrieve the desired project and select the Profit Center. 
All items in transaction documents linked to the project are automatically linked to this center. 
For a warehouse and accounting family: 
This is not used very often. 
1. Enter the Accounts for Warehouses form and retrieve the desired warehouse. 
2. Enter the Acct's for Families in Warehouse sub-level form and retrieve the desired family. 
3. Specify the desired Profit/Cost Center. All items in invoices and journal entries involving 
movements of parts belonging to this accounting family to or from this warehouse are 
automatically linked to this center. 
Stage V: Running Cost Allocation Reports and Analyses 
Before running the following reports, run the Allocate Costs program, which distributes indirect costs 
among the various bases of allocation, as recorded in financial documents.

www.priority -software.com   
4/4 ‏Mar. 11,'15 Ver. 02 Cat.No. LB110529 
 
 Run the P&L Statement per Profit Center report to compare revenues and expenses per profit 
center, including indirect costs. 
Notes:  
 The structure of the report follows the standard structure of the Profit and Loss report in the 
Financial Statements module. 
 If you need to make corrections as a result of viewing the report, revise the relevant journal 
entries and rerun the Allocate Costs program. Then rerun the reports. 
 Run the Bases of Cost Allocation report to view the methods by which indirect costs were 
calculated and distributed by the system. 
 Run the Profit Center Analysis (BI) report to analyze profit center data. 
 Run the Profit/Cost Ctr Analysis (BI) report to analyze profit and cost center data. 
 Run additional reports from the Profit Center Reports and Cost Center Reports menus.
