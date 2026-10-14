# PP_COGS_repprod_burden

- **Source:** `PP_COGS_repprod_burden.htm`

PP_COGS_repprod_burden 
 
 
- 
 
 
 

Burden entails the following: 
 

 ·        Direct machinery costs, calculated by multiplying machine time recorded in production reports by the direct hourly cost of machines. 
 

 ·        Indirect machinery costs, calculated by multiplying machine time recorded in production reports by the indirect hourly cost of machines. 
 

 ·        Indirect labor costs, calculated by multiplying employee time by the percentage defined for the shift (as recorded in production reports), and then multiplying the result by the indirect hourly cost of unskilled labor, as defined per work cell, or the indirect hourly cost of skilled labor, as defined per skill. 
 

 ·        Set-up costs, calculated by multiplying machine time reported for a set-up (i.e., an operation marked "S" in the production report) by the hourly set-up cost as defined per work cell.
 Note: If employee time is reported for a set-up in the production report, this is multiplied by the direct and indirect labor cost and will be added to the set-up cost. 
 

 ·        Non-standard costs, determined by the standard cost of the received parts that are charged to the work order and are not in its kit list (i.e., where a Work Order to Charge is recorded in the GRV). 
 

 ·        Supply costs, determined by the standard cost of issues of supplies charged to the work order. 
 

 ·        Rework costs, calculated by multiplying the set-up cost, direct and indirect labor cost, and direct and indirect machinery cost by the machinery and employee times reported for an operation flagged as R ework in the production report. 
 
## Notes:

 

 ·        If employee or machine time are reported for a break (i.e., an operation marked "B" in the production report), the time is taken into account when calculating burden. 
 

 ·        Journal entries (entry code = FB ) debit the Inventory - Burden account and credit the Burden Offset account. When the Post Cost of Goods Sold program is run, they are recorded in a single entry dated for the end of the COGS period.
