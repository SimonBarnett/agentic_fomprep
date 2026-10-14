# Price_Adjustment_Currency_Basket

- **Source:** `Price_Adjustment_Currency_Basket.htm`

Price Adjustment Wizard - Creating Currency Baskets 
 
 
- 
 
 
 
# Defining Currency Baskets

 

A currency basket allows you to link transactions (e.g., sales orders, purchase orders, service contracts) to multiple currencies (or price indexes), according to defined percentages of the transaction sum. Example. 
 
## To define a currency basket:

 

 1 .  Enter the Currencies form. 
 

 2 .  Open a new line and record a code and name for the currency basket (for example, CB1 / Curr. Basket 1 ). 
 

 3 .  Enter the Currency Basket sub-level form. 
 

 4 .  In the Curr column, select the code of the first currency (or price index) in the basket. 
 

 5 .  In the Percentage of Composite column, specify the percentage of the transaction sum to be linked to this currency. 
 

 6 .  Do one of the following: 
 

 ·      If there is an agreement to stop linkage of this currency a certain number of months prior to an order item's delivery or due date, indicate the number of months in the Latest Linkage-mnths column. Explanation. 
 

 ·      To use the Exchange Rate Date defined for this currency in the upper-level form, flag the Linkage from Header column. The Latest Linkage-mnths column will be set automatically to 0 and will not affect linkage. 
 

 7 .  Define the remaining currencies in the basket.
 Note: The sum of percentages for all currencies must equal 100 . 
 
## Note:

 

You can also link orders or individual line items to multiple currencies in the same manner in the Linkage Details sub-level form, without pre-defining a currency basket.
