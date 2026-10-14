# PP_Add_Expenses_Burden_Proportion_per_Invoice

- **Source:** `PP_Add_Expenses_Burden_Proportion_per_Invoice.htm`

PP_Add_Expenses_Burden_Proportion_per_Invoice 
 
 
- 
 
 
 

When the shipping voucher is closed, the cost added to each purchased part includes both the portion of each expense that is distributed to all parts in the voucher and the portion of each expense that is assigned directly to the invoice in question. 
 
## Example 1

 

Three purchase invoices (A, B, and C), each for 1 unit of part 001, are linked to a shipping voucher. 
 

Two expense invoices (D and E) for shipping expenses are added to the same shipping voucher. Invoice D contains one line for the "Shipmt" part, in the amount of $100. Invoice E contains one line for the "Shipmt-Sea" part, in the amount of $180. 
 

In the Manual Distribution of Expenses sub-level form under invoice D, the expenses in this invoice are linked directly to part 001 in invoice A. 
 

No manual distribution is specified for invoice E, indicating that the expenses should be distributed equally among the shipped parts in invoices A, B and C. 
 

Consequently, when the costing program distributes the expenses in invoices D and E, part 001 in each invoice will be burdened with the following expenses: 
 

 ·        Invoice A: $100 + $180/3 = $160 
 

 ·        Invoice B: $180/3 = $60 
 

 ·        Invoice C: $180/3 = $60 
 
## Example 2

 

Three purchase invoices (A, B, and C), each for 1 unit of part 001, are linked to a shipping voucher. 
 

Two expense invoices (D and E) for shipping expenses are added to the same shipping voucher. Invoice D contains one line for the "Shipmt" part, in the amount of $100. Invoice E contains one line for the "Shipmt-Sea" part, in the amount of $180. 
 

In the Manual Distribution of Expenses sub-level form under invoice D, the expenses in this invoice are linked to part 001 in invoice A and part 001 in invoice B and distributed equally between the two items (i.e., each item is assigned a burden proportion of 1 ). 
 

No manual distribution is specified for invoice E, indicating that the expenses should be distributed equally among the shipped parts in invoices A, B and C. 
 

Consequently, when the costing program distributes the expenses in invoices D and E, part 001 in each invoice will be burdened with the following expenses: 
 

 ·        Invoice A: $100/2 + $180/3 = $110 
 

 ·        Invoice B: $100/2 + $180/3 = $110 
 

 ·        Invoice C: $180/3 = $60
