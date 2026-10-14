# ord_profit_3_To_set_the_cost_source

- **Source:** `ord_profit_3_To_set_the_cost_source.htm`

Profitability - Setting Cost Source 
 
 
- 
 
 
 
# To set the cost source:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Determine the starting point of the search for a part cost, setting the value of the SPurchPrice constant as follows: 
 

  3  Standard Cost 
 

  0  Vendor Price List 
 

  1  Last Price 
 

   4  Actual Cost (determined during cost analysis), but if that is 0 , start with Standard Cost. 
 
## Notes:

 

 ·        When preparing a sales order based on a price quote, the cost is taken from the quote. 
 

 ·        If you do not maintain vendor price lists, and want to use the part's purchase price, set the value of the PPriceByList constant to 0 . 
 

 ·        When an ordered or a quoted item has a customized bill of materials, the value designated for the constant affects the cost of the child part(s). That, in turn, determines the cost of the parent. 
 

 ·        Click to perform additional setups.
