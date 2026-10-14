# 13-15-Opening a Sales Rep

- **Source:** `13-15-Opening a Sales Rep.pdf`

SOP: Opening a Sales Rep 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To define sales representatives in the organization. 
Setups 
 Define warehouses in the system. 
 Define part families in the system.  
 Define customers in the system. 
Procedure 
1. Enter the Sales Representatives form.  
2. In the Sales Rep Number column, specify a code that identifies the sales rep. 
3. Record the Sales Rep Name. 
4. In the Address & Phone tab, record the rep's contact details. 
5. Click the Details tab, and link the rep to the appropriate Warehouse (if any). 
6. Select the Currency in which the rep's commissions are calculated. 
7. In the Maximum Discount (%) column, define the highest percentage of discount 
this rep is permitted to give a customer. You can define different maximum discounts 
for different part families in the Discounts/Commissions by Family sub-level form. 
8. To define the rep as a customer, flag the Defined as Customer column (in the 
upper-level form, Details tab). 
9. Enter the Head Sales Reps sub-level form, and assign the current sales rep to a 
Head Rep. The head sales rep allows you to group sales reps under a single entity 
(e.g., a regional manager) and retrieve reports more easily. 
10. In the From Date and To Date columns, you can define different head reps for 
different time periods. Each period must consist of a full month (i.e., the From and 
To Dates must fall at the beginning and end of the month(s) in question). 
Tip: Run the Sales Rep Hierarchy report to view the entire sales rep hierarchy for 
designated head reps and time periods. 
11. To define the commission percentage awarded to this rep: 
Cat.No.A8000081 1 Ver.1 – Aug. 18,’09

Cat.No.A8000081 2 Ver.1 – Aug. 18,’09 
 If the rep receives the same commissions for all parts, return to the upper-level 
form and specify a percentage in the Commission (%) column (in the Details 
tab). 
 If the commission varies according to part family, define the appropriate 
percentages for each family in the Discounts/Commissions by Family sub-level 
form. 
 If the commission varies according to customer, specify a percentage in the Rep's 
Commission column in the Customers form. 
The hierarchy by which the system chooses the rep's commission is as follows (in 
descending order): by customer, by part family, by sales rep. 
12. To link the sales rep to a customer, enter the Customers form, retrieve the 
customer in question, and specify the Sales Rep Number. This sales rep 
consequently appears as the default in any price quote or order recorded for that 
customer. 
Results 
 All inventory transactions recorded for a given sales rep will display as a default the 
warehouse linked to that rep (provided that the sales rep is linked to the customer in 
question; however, if the sales rep is revised after the document has been itemized, 
the warehouse will not be updated to that rep's warehouse). 
 Any sales document recorded for a given sales rep will add to the accumulated 
commission due to that rep. 
 Discounts that deviate from the defined maximum for that sales rep will cause the 
appropriate system message to appear.
