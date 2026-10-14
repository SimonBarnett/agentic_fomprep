# 14-17-Opening POs from Purchase Requisitions

- **Source:** `14-17-Opening POs from Purchase Requisitions.pdf`

www.priority -software.com   
1/2 Mar.03,'15 Ver. 02 Cat.No. LB10000454 
 
 SOP: Opening Purchase Orders Based on 
Purchase Requisitions 
Customer:   Company Inc. 
Assigned to:  Dept./Position 
Aim 
 To open a purchase order on the basis of a purchase requisition (PR). 
Working Assumption 
 One or more PRs have been recorded in the system, either manually or automatically by running 
Purchase Planning. 
Procedure 
Stage I: Preparing Authorized PRs 
1. Enter the Purchase Requisitions form and retrieve open PRs (i.e., those which have not been 
flagged as Closed). The form displays all pending PRs – whether recorded manually or 
automatically. 
Notes: 
 The form displays such information as the Demand Date and the Recom. Ord Date 
(calculated from the Best On-Hand Date and the part's defined shipping days). 
 Various sub-level forms allow you to view a variety of data, such as Projected Balances 
(which displays purchase planning results and inventory balances along a timeline), Vendors 
for Required Part (which displays vendors authorized to sell the part) and Part Price 
Options. 
2. Make sure the Do Not Open Order column is not flagged. 
3. In the Authorized column, make sure that the purchase demand document in which each 
requisition is recorded has been authorized. 
Tip: To enter the purchase demand document, press F6 in the PR Document Number column. 
Stage II: Opening Purchase Orders 
Option A 
 Enter the Purchase Demands form and select Open Purchase Orders for Doc. from the list of 
Direct Activations. In the program's input screen, you can: 
 Restrict the program to those purchase requisitions that are assigned to a specific buyer (or 
not assigned to any buyer). 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Mar.03,'15 Ver. 02 Cat.No. LB10000454 
 
 Specify a Default Vendor for which purchase orders will be opened, in the event that the 
purchase requisition in question (as well as the entire purchase demand document) does not 
have an assigned vendor. 
 Restrict the total number of items and/or monetary sum that can be included in a given order. 
 Purchase orders are opened for each vendor to which purchase requisitions are assigned (in the 
Vendor for PR column of the Itemized Purchase Requisitions sub-level form) or for the 
specified Default Vendor. 
 The order(s) are itemized automatically, based on the corresponding purchase requisitions 
(including part numbers, quantities and demand dates). 
Note: To automatically open purchase orders based on several different purchase demand 
documents, run the Open Purchase Orders for Doc. program directly, and specify the desired 
demand documents in the program's input. 
Option B 
1. In the Purchase Requisitions form, move to the Order column and press F6 to enter the 
Purchase Orders form. 
2. Fill in data in the Purchase Orders form, such as the Vendor No., Type of Order and the 
Payment Info tab.  
Note: The order will be itemized automatically after it is linked to the PR. 
3. To link the order to the PR, do one of the following: 
 Press Esc to return to the Purchase Requisitions form. Move to the Order column, and 
record the number of the purchase order you opened. 
 Move to the Order column in the Purchase Orders form and press F8 to return to the 
Purchase Requisitions form and automatically copy the order number. 
4. Link additional PRs to the purchase order by specifying the same order number in the Order 
column for each one. 
Results 
 The purchase requisitions that have been linked to the order are flagged as Closed, and can no 
longer be revised. 
 The purchase order has been itemized automatically (including part numbers, quantities, due 
dates, on-hand dates, etc.). 
Follow-up 
 Continue the process by checking the itemized purchase order and revising order items as 
necessary. To authorize the order, return to the upper-level Purchase Orders form, click the 
Authorization & Follow-up tab and change its Status accordingly.
