# CommissionSales_2a_setup_constants_1

- **Source:** `CommissionSales_2a_setup_constants_1.htm`

Commission Sales - Setting Up Constants.1 
 
 
- 
 
 
 
# To set up relevant constants:

 

 ·        Enter the Logistic Constants form. 
 
## Working With Vendor Price Lists

 

The PPriceByList constant determines whether vendor price lists will be used as price sources for items in purchase and commission sales documents. 
 

 ·        If vendor price lists are maintained in your system, leave the pre-set value 1 . 
 

 ·        If you do not maintain vendor price lists, specify 0 as the value of this constant. The price of items in commission sales documents will be taken from the Commiss ' n Price column in the Part Catalogue form (in the Prices & Costs tab). 
 
## Calculating Commission

 

The SCommissType constant determines how commission is calculated, taking into account how vendor prices are maintained. 
 

 ·        If commission is already included in the vendor price, leave the pre-set value 0 . 
 

 ·        When commission is added to the vendor`s list price, change the value to 1 . 
 
## Note:

 

If some of the vendors' prices include a commission while others do not, you will have to change the value of this constant occasionally, before recording the quote and the order.
