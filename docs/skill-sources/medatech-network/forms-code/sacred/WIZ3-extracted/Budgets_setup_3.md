# Budgets_setup_3

- **Source:** `Budgets_setup_3.htm`

Budgets - Budgeting Orders and PRs Due the Following Year 
 
 
- 
 
 
 
# Budgeting Open Orders and PRs Due in Another Year

 

You can determine whether or not sales and purchase orders whose due dates fall in the previous or following year are taken into account when calculating budget usage for the current year. The default is 0 (orders due last year are considered part of the current budget, but those due next year are not). 
 
## To include orders due next year in the current budget:

 

 1 .  Move to the BudOrdPeriod constant. 
 

 2 .  Change the value to 1 . 
 
## To restrict the current budget to orders due this year:

 

 ·        Change the constant value to 2 . Open orders due last year will be part of last year’s budget; those due next year will be included in next year’s budget. 
 
## Note:

 

The constant also affects the inclusion of open purchase requisitions in the budget, taking into account their Best On-Hand date.
